#import "@preview/markly:0.3.0"
#import "@local/dutten-common:0.1.0": colors-rgb, get-logo

// Based on https://overleaf.com/latex/templates/dtu-poster/nfchvswyhcnq
#let template(authors, doc) = [
#let A0 = (x: 841mm, y: 1189mm)

// #let size-title = 100pt
// #let size-authors = 60pt
// #let size-affiliations = 48pt
#let size-title = 80pt
#let size-authors = 48pt
#let size-affiliations = 40pt
#let size-body = 29pt
#let size-caption = 22pt

#let markly-context = markly.setup(
  stock-width: A0.x,
  stock-height: A0.y,

  bleed: 0mm,
  bleed-marks: false,

  content-width: A0.x - 2*15mm,
  content-height: A0.y - 2*20mm,
)

#show: markly.page-setup.with(markly-context)

// Hack: markly does not support different margins on top and bottom
#let target-margin-top = 20mm
#let target-margin-bottom = 15mm
#let markly-y-cut = (markly-context.at("stock-height") - markly-context.at("content-height")) / 2
#set page(
  margin: (
    top: markly-y-cut + target-margin-top,
    bottom: markly-y-cut + target-margin-bottom,
  ),
)

// Colors
#let dtu-red = color.cmyk(0%, 91%, 72%, 23%)
#let dtu-black = color.cmyk(20%, 20%, 0%, 100%)

#block([
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
  height: 65mm,
  width: 100%,
)

#line(length: 100%, stroke: 5pt + dtu-red)

#set text(font: "Liberation Sans", size: size-body)
#set heading(numbering: "1.a ")
#show heading: set text(fill: dtu-red, size: 35pt, weight: "bold")
#show heading: set block(above: 0.8em)
#show title: set text(size: size-title, fill: dtu-red)
#set columns(gutter: 20mm)
#show figure.caption: set text(size-caption)
#set figure(gap: 20pt)
// #show figure.caption: set block(below: 0pt)

#block(
  above: 30mm,
  height: 1fr,
  inset: (x: 20mm),
)[

  #title() <element:title>

  #block()[
    #text(
      size: size-authors,
      weight: "bold",
    )[
      #authors.enumerate().map(((i, l)) => [#l.name#super(str(i+1) + "†")]).join(", ")
    ]
  ] <element:authors>

  #block()[
    #text(
      size: size-affiliations
    )[
      Email: #authors.map(l => [#l.email]).enumerate().map(((i, e)) => [#super(str(i+1)) #raw(e.text)]).join(", ")
      \
      #super("†") Technical University of Denmark, Department of Applied Mathematics and Computer Science,
      Kgs. Lyngby, Denmark
    ]
  ] <element:affiliations>

  #block(above: 20mm)[
    #set par(justify: true, leading: 0.55em)
    #columns(3)[#doc]
  ] <element:body>
] <element:content>

#line(length: 100%, stroke: 5pt + dtu-red)
// #block(above: 30mm)[
//   #align(center)[
//     #block(
//       inset: (x: 20mm),
//       width: 100%,
//     )[
//       #repeat(image("assets/tex_dtu_compute_b_uk.pdf", width: 30%))
//     ]
//   ]
// ] <element:footer>

]
