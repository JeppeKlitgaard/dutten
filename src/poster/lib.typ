#import "../colors.typ": colors-cmyk, colors-rgb
#import "../get-logo.typ": get-logo

#let poster(
  /// ### Metadata

  /// The authors of the poster.
  /// -> string
  authors: none,

  /// ### Layout

  /// Paper size
  paper: "a0",

  /// Whether flipped into landscape orientation.
  flipped: false,

  /// Number of columns in the poster.
  columns: 2,

  /// Margins for the page.
  margin: (
    x: 30mm,
    y: 35mm,
    // x: 15mm,
    // y: 20mm,
  ),

  /// Size of the title text.
  size-title: 80pt,

  /// Size of the authors text.
  size-authors: 48pt,

  /// Size of the headings text.
  size-heading: 40pt,

  /// Size of the affiliations text.
  size-body: 32pt,

  /// Size of the caption text.
  size-caption: 24pt,

  /// ### Style

  /// Font to use for the title text.
  font-title: "Liberation Sans",

  /// Font to use for the heading text.
  font-heading: "Liberation Sans",

  /// Font to use for the body text.
  font-body: "Liberation Sans",

  /// Font to ues for the caption text.
  font-caption: "Liberation Sans",

  /// Primary color
  color-primary: colors-rgb.at("corporate red"),

  /// ### Elements

  /// The header block of the poster.
  /// Does not include the title, authors, or institutions.
  header-block: none,

  /// The title block of the poster.
  title-block: none,

  /// The authors block of the poster.
  authors-block: none,

  /// The body block of the poster.
  body-block: none,

  /// The footer block of the poster.
  footer-block: none,

  /// The content of the poster.
  /// -> document
  doc,
) = {
  pagebreak(weak: true)

  set page(
    paper: paper,
    flipped: flipped,
    margin: margin,
  )

  set text(size: size-body, font: font-body)
  show figure.caption: set text(size: size-caption, font: font-caption)
  show title: set text(size: size-title, font: font-title, fill: color-primary)
  show title: set par(leading: 0.45em)
  show heading: set text(size: size-heading, font: font-heading, fill: color-primary)
  set heading(numbering: "1.a ")
  show figure.caption: set align(left)
  set figure(gap: 0.3em)

  // Render overridable blocks
  header-block = if header-block != none { header-block } else {
    block(
      [
        #place(
          top + right,
          dx: -20mm,
          get-logo(colors-rgb.at("corporate red"), width: 44.5mm),
        )
        // #place(
        //   horizon + left,
        //   dx: 20mm,
        //   image("assets/tex_dtu_compute_b_uk.pdf", height: 43.25mm),
        //   // image("Compute_en_full_tint100.svg", height: 50.25mm),
        // )
      ],
      // height: 65mm,
      width: 100%,
    )

    block(
      above: 20mm,
      below: 20mm,
      line(length: 100%, stroke: 5pt + color-primary)
    )
  }

  authors-block = if authors-block != none { authors-block } else {
    block[
      #set text(size: size-authors)
      #authors <element:authors>
    ]
  }

  title-block = if title-block != none { title-block } else {
    block(title())
  }

  body-block = if body-block != none { body-block } else {
    block(clip: true)[
      #set par(justify: true)
      #std.columns(columns)[#doc]
    ]
  }

  footer-block = if footer-block != none { footer-block } else {
    [THIS IS A FOOTER]
  }

  grid(
    columns: 1,
    rows: (auto, auto, auto, 1fr, auto),
    row-gutter: 20mm,
    [#header-block <element:header>],
    [#title-block <element:title>],
    [#authors-block <element:authors>],
    [#body-block <element:body>],
    [#footer-block <element:footer>],
  )
}
