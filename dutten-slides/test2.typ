#import "@preview/touying:0.6.1": *
#import "@local/dutten-common:0.1.0": colors-rgb, get-logo
#import "src/lib.typ": dutten-theme, progress-marker-upper, progress-marker-lower, progress-marker-both

#show: dutten-theme.with(
    title: [02687 Advanced Numerical Methods],
    subtitle: [Lecture 2: Spectral Methods],
    author: [Jeppe Klitgaard],
    date: [2025-12-16],
    institution: [Technical University of Denmark],

    footer-style: "thick",
    // footer-left: [2025-12-16],
    // footer-progress: true
)

#[
    #show heading: none
    #components.adaptive-columns(outline(indent: 1em))
]

= From Periodic to Non-periodic Domains

The periodicity requirement in Fourier Methods destroys fast convergence for representation of smooth non-periodic functions.

The idea of the Fourier Series representation of the form
$
  f(x) = sum_(n=-∞)^∞ c_n e^(i n x)
$
can be generalised into a representation of the form
$
  f(x) = sum_(n=0)^∞ hat(f)_n ϕ_n (x)
$

Thus, to represent a function $f(x)$ we need to
- Choose a set of global basis functions ${ϕ_n (x)}^∞_(n=0)$
- Find ways to determine the coefficients ${hat(f)_n}^∞_(n=0)$

Can we still get fast spectral convergence without periodicity?

#box(fill: black, width: 100%)[#v(1fr)]

#progress-marker-both

== Properties of Fourier Methods This is becoming very very very very long dddd

#progress-marker-upper

#figure(
    box(
        grid(
            columns: 2,
            image("image.png"),
            image("image.png"),
        ),
        height: 60%,
    )
)

Properties of Fourier Methods

- Spectral convergence if both solution and it's derivatives are periodic and smooth (accuracy) and otherwise (some times slow) algebraic convergence similar to finite difference methods
- Fast $O (n log n)$ evaluation of DFT via FFT (efficiency)

= Heading 3 <aa>
#progress-marker-lower

Slide 3

This is an alert #alert[Hello] in the middle of the text

= Heading 4

asd

#touying-recall("aa")

// #components.knob-marker(primary: colors-rgb.at("corporate red"))