#import "../colors.typ": colors-rgb, tint
#import "../get-logo.typ": get-logo

#let frontpage-1(primary-color: colors-rgb.at("corporate red")) = {
  // Setup variables
  let top-contrast-color = if primary-color != colors-rgb.at("white") {
    colors-rgb.at("white")
  } else {
    primary-color
  }

  set page(margin: 15mm)

  // Primary color background
  set page(background:
    box(width: 100%, height: 100%)[
      #box(width: 100%, height: 40%, fill: primary-color)
      #box(width: 100%, height: 100%-40%)

    ]
  )

  pagebreak(weak: true)

  // Header
  let logo = get-logo(top-contrast-color, width: 20mm)
  let affiliation = [
    #set text(fill: top-contrast-color, font: "Arial", size: 14pt)
    #set par(spacing: 0.8em)
    #set par(leading: 0.5em)
    *DTU Compute*

    Department of Computer Science\
    and Applied Mathematics
  ]
  box(
    height: 40mm,
    width: 100%,
  )[
    #place(top + left, logo)
    #place(top + right, affiliation)
  ]

  [
    #set text(fill: top-contrast-color, font: "Arial", size: 24pt, weight: "bold")
    #title()
  ]

  pagebreak(weak: true)
}

#set page(paper: "a4")
#set document(
  title: "Dutten Report Demo",
  author: ("Jeppe Klitgaard")
)
#frontpage-1()

// Hello