#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [STAI],
    subtitle: [Selected Topics in Artificial Intelligence],
    author: author_list(
      (
        (first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
        ("Davide Liga", "davide.liga@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      )
    ),
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [University of Luxembourg],
    logo: align(right)[#image("images/logo_unilu_fr.svg", width: 55%)],
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#set raw(tab-size: 4)
#show raw: set text(size: 1em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.75em)
#show footnote.entry: set text(size: 0.75em)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// == Outline <touying:hidden>

// #components.adaptive-columns(outline(title: none, indent: 1em))

= About the course

== Teachers

#grid(
  columns: 3,
  gutter: 1.5cm,

  [
    #box(
      inset: (x: 0.8em, y: 0.8em),
      radius: 0.6em,
      height: 6cm,
      [
        #align(center)[
          #image("images/matteo_magnini.jpeg", width: 80%)

          #v(0.6em)
          // Stile simile al first_author sulla title slide
          #first_author("Matteo Magnini")

          #v(0.3em)
          Postdoctoral Researcher

          #v(0.5em)
          #fa-icon("github")
          #v(0.1em)
          matteomagnini.github.io
        ]
      ],
    )
  ],

  [
    #box(
      inset: (x: 0.8em, y: 0.8em),
      radius: 0.6em,
      height: 6cm,
      [
        #align(center)[
          #image("images/davide_liga.jpeg", width: 80%)

          #v(0.6em)
          // Stile standard (no first_author)
          Davide Liga

          #v(0.3em)
          Postdoctoral Researcher

          #v(0.5em)
          #fa-icon("github")
          #v(0.1em)
          daviligade.github.io
        ]
      ],
    )
  ],

  [
    #box(
      inset: (x: 0.8em, y: 0.8em),
      radius: 0.6em,
      height: 6cm,
      [
        //Remove the vertical space below if the link is on one line.
        #v(1.2em)
        #align(center)[
          #image("images/souvick_das.jpeg", width: 80%)

          #v(0.6em)
          Souvick Das

          #v(0.3em)
          Postdoctoral Researcher

          #v(0.5em)
          #fa-icon("user-graduate")
          #v(0.1em)
          www.uni.lu/fstm-en/people/souvick-das
        ]
      ],
    )
  ],
)

== Time schedule

- *First session:* \
  16 September 2026, 15:45–17:15, room MSA‑3.170

- *Regular weekly slot (from 2nd session onwards):* \
  Every Thursday, 08:30–10:00, from 24 September 2026 to 17 December 2026, \
  room MSA‑4.080 (Belval campus)

- *Teaching staff rotation:* \
  The three of us will alternate
  as lecturers across the sessions.

== Slide
*Bold* and _italic_ text.

This is a citation #cite(label("DBLP:journals/fgcs/FarabegoliPCV24")).
This another citation #cite(label("DBLP:journals/iot/FarabegoliPCV24"))

#alert[This is an alert.]

== Code slide

```kotlin
fun main() {
    println("Hello, world!")
    for (i in 0..9) {
        println(i)
    }
    println("Goodbye, world!")
}
```

== Title and subtitle slide

=== This is a subtitle

#lorem(24)

=== This is a subtitle

#lorem(34)

== FontAwesome icons

=== Icon in a title #fa-java()

#fa-icon("github") -- Github icon \
#fa-icon("github", fill: blue) -- Github icon blue fill

// #slide[
//   #bibliography("bibliography.bib")
// ]