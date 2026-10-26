// Re-export these such that downstream can access correct versions of dependencies
// For example, get the correct version of touying
#import "deps.typ"

// We additionally import touying here explicitly since it is a particularly important
// dependency
#import "deps.typ": touying
#import touying: *


#import "@local/dutten-common:0.1.0": colors-rgb, get-logo, tint, _utils
#import _utils: _resolve-4-sides

// Very small amount to move things by to prevent anti-aliasing weirdness
#let _EPS = 0.05mm

/// Progress Markers
#let _PROGRESS-MARKER-LABEL-UPPER = "dutten-progress-marker-upper"
#let _PROGRESS-MARKER-LABEL-LOWER = "dutten-progress-marker-lower"

/// Put these marker inside the slide content to show progress markers in the footer.
#let progress-marker-upper = [#metadata("dutten-progress-marker-upper")#label(_PROGRESS-MARKER-LABEL-UPPER)]
#let progress-marker-lower = [#metadata("dutten-progress-marker-lower")#label(_PROGRESS-MARKER-LABEL-LOWER)]
#let progress-marker-both = progress-marker-upper + progress-marker-lower

#let left-right(
  left,
  right,
  column-gutter: 0mm,
  vertical-align: horizon,
) = grid(
  columns: (auto, 1fr, auto),
  column-gutter: column-gutter / 2,
  align: (std.left + vertical-align, auto, std.right + vertical-align),
  left, none, right,
)

#let left-center-right(
  left,
  center,
  right,
  column-gutter: 1cm,
  vertical-align: horizon,
) = grid(
  columns: (1fr, auto, 1fr),
  column-gutter: column-gutter,
  align: (std.left + vertical-align, std.center + vertical-align, std.right + vertical-align),
  left, center, right,
)

#let left-left-right-right(
  left1,
  left2,
  right1,
  right2,
  column-gutter: 2cm,
) = grid(
  columns: (auto, auto, 1fr, auto, auto),
  column-gutter: column-gutter,
  align: (
    std.left + horizon,
    std.left + horizon,
    auto,
    std.right + horizon,
    std.right + horizon,
  ),
  left1, left2, none, right1, right2,
)

/// Default slide function for the presentation.
///
/// - title (string): The title of the slide. Default is `auto`.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - repeat (int, string): The number of subslides. Default is `auto`, which means touying will automatically calculate the number of subslides.
///
///   The `repeat` argument is necessary when you use `#slide(repeat: 3, self => [ .. ])` style code to create a slide. The callback-style `uncover` and `only` cannot be detected by touying automatically.
///
/// - setting (function): The setting of the slide. You can use it to add some set/show rules for the slide.
///
/// - composer (function, array): The composer of the slide. You can use it to set the layout of the slide.
///
///   For example, `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` to split the slide into three parts. The first and the last parts will take 1/4 of the slide, and the second part will take 1/2 of the slide.
///
///   If you pass a non-function value like `(1fr, 2fr, 1fr)`, it will be assumed to be the first argument of the `components.side-by-side` function.
///
///   The `components.side-by-side` function is a simple wrapper of the `grid` function. It means you can use the `grid.cell(colspan: 2, ..)` to make the cell take 2 columns.
///
///   For example, `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` will make the `Footer` cell take 2 columns.
///
///   If you want to customize the composer, you can pass a function to the `composer` argument. The function should receive the contents of the slide and return the content of the slide, like `#slide(composer: grid.with(columns: 2))[A][B]`.
///
/// - bodies (array): The contents of the slide. You can call the `slide` function with syntax like `#slide[A][B][C]` to create a slide.
#let slide(
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    line(length: 100%, stroke: (thickness: 1.4mm, paint: self.colors.primary))
    place(top + right, self.info.logo, dx: -7mm, dy: 7mm)

    let page-margin = _resolve-4-sides(self.page.margin)
    show: components.cell.with(inset:
      (
        left: page-margin.left,
        right: page-margin.right,
        top: 8mm,
      ))

    set text(..self.store.header-text-styling)
    left-right(
      {
        if title != auto {
          utils.fit-to-width(grow: false, 100%, title)
        } else {
          utils.call-or-display(self, self.store.header)
        }
      },
      utils.call-or-display(self, self.store.header-right),
      column-gutter: 1cm,
    )
  }

  let footer-thin(self, footer-component) = {
    if self.store.footer-progress {
      place(bottom, components.progress-bar(
        height: 1mm,
        self.colors.primary,
        tint(self.colors.primary, self.store.footer-progress-tint),
      ))
    }

    set text(..self.store.footer-text-styling)
    footer-component
  }

  let footer-thick(self, footer-component) = {
    show: components.cell.with(fill: self.colors.primary)

    if self.store.footer-progress {
      place(bottom, components.progress-bar(
        height: auto,
        self.colors.primary,
        tint(self.colors.primary, self.store.footer-progress-tint),
      ))

      if self.store.footer-markers {
        let marker-tick-top = move(
          dy: -_EPS,  // Prevents gaps
          polygon(
            fill: self.page.fill,
            (+1mm, 0mm),
            (-1mm, 0mm),
            (0mm, +1mm),
          )
        )
        let marker-tick-bottom = move(
          dy: +_EPS,  // Prevents gaps
          polygon(
            fill: self.page.fill,
            (+1mm, 0mm),
            (-1mm, 0mm),
            (0mm, -1mm),
          )
        )

        context {
          let get-slide-counter-ratio(location) = {
            let total-slides = utils.last-slide-counter.final().first()
            let current-slide = utils.slide-counter.at(location).first()
            100% * (current-slide / total-slides)
          }

          for marker in query(label(_PROGRESS-MARKER-LABEL-UPPER)){
            place(top, marker-tick-top, dx: get-slide-counter-ratio(marker.location()))
          }
          for marker in query(label(_PROGRESS-MARKER-LABEL-LOWER)) {
            place(bottom, marker-tick-bottom, dx: get-slide-counter-ratio(marker.location()))
          }
        }
      }
    }

    set text(fill: white)
    set text(..self.store.footer-text-styling)
    footer-component
  }

  let footer(self) = {
    let footer-component = pad(
      x: 1cm,
      y: 0.5em,
      {
        let num-footers = self.store.footers.len()
            if num-footers == 0 {
              return
            } else if num-footers == 1 {
              std.align(horizon + center, utils.call-or-display(self, self.store.footers.at(0)))
            } else if num-footers == 2 {
              left-right(
                utils.call-or-display(self, self.store.footers.at(0)),
                utils.call-or-display(self, self.store.footers.at(1)),
                column-gutter: 2cm,
              )
            } else if num-footers == 3 {
              left-center-right(
                utils.call-or-display(self, self.store.footers.at(0)),
                utils.call-or-display(self, self.store.footers.at(1)),
                utils.call-or-display(self, self.store.footers.at(2)),
                column-gutter: 1cm,
              )
            } else if num-footers == 4 {
              left-left-right-right(
                utils.call-or-display(self, self.store.footers.at(0)),
                utils.call-or-display(self, self.store.footers.at(1)),
                utils.call-or-display(self, self.store.footers.at(num-footers - 2)),
                utils.call-or-display(self, self.store.footers.at(num-footers - 1)),
                column-gutter: 1cm,
              )
            } else {
              panic("Too many footers specified in dutten-theme: maximum is 4.")
            }
      }
    )

    if self.store.footer-style == "thin" {
      footer-thin(self, footer-component)
    } else if self.store.footer-style == "thick" {
      footer-thick(self, footer-component)
    } else {
      panic("Unknown footer style: " + repr(self.store.footer-style) + ". Allowed styles are: thin, thick.")
    }
  }

  let self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.neutral-lightest,
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

#let default-footers = (
  utils.display-info-date,
  self => self.info.title,
  context [#utils.slide-counter.display() / #utils.last-slide-number],

)


#let dutten-theme(
  title: none,
  short-title: none,
  subtitle: none,
  short-subtitle: none,
  author: none,
  date: none,
  institution: none,
  color: colors-rgb.at("corporate red"),
  background-color: white,
  aspect-ratio: "16-9",
  align: top,
  header: self => utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    depth: self.slide-level,
  ),
  header-right: none,
  header-text-styling: (size: 30pt, weight: "bold", font: "Liberation Sans"),
  footers: default-footers,
  footer-style: "thick",
  footer-text-styling: (size: 0.8em),
  footer-progress: true,
  footer-progress-tint: 70%,
  footer-markers: true,
  logo: auto,
  show-logo: true,
  ..args,
  body,
) = {
  if logo == none {
    // Do nothing
  }
  if logo != none {
    if logo == auto {
      logo = get-logo(color)
    } else {
    // Assume logo was some content
    // Do nothing
    }
    logo = box(
      logo,
      height: 1.7cm,
      width: 1.17cm,
    )
  }

  show: touying-slides.with(
    config-page(paper: "presentation-" + aspect-ratio, margin: (left: 1.2cm, right: logo.width + 2*7mm, top: 2.2cm, bottom: 1cm)),
    config-common(slide-fn: slide),
    config-colors(
      primary: color,
      secondary: color,
      neutral-darkest: color,
      neutral-lightest: background-color,
    ),
    config-info(
      title: title,
      short-title: short-title,
      subtitle: subtitle,
      short-subtitle: short-subtitle,
      author: author,
      date: date,
      institution: institution,
      logo: logo,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "Liberation Sans", size: 18pt)
        body
      },
      alert: (self: none, body) => text(fill: self.colors.primary, weight: "semibold", body),
    ),
    // save the variables for later use
    config-store(
      align: align,
      header: header,
      header-right: header-right,
      header-text-styling: header-text-styling,
      footers: footers,
      footer-style: footer-style,
      footer-text-styling: footer-text-styling,
      footer-progress: footer-progress,
      footer-progress-tint: footer-progress-tint,
      footer-markers: footer-markers,
    ),
    ..args,
  )

  body
}