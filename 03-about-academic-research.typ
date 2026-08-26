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
    subtitle: [About Academic Research],
    author: author_list(
      (
        (first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
        ("Davide Liga", "davide.liga@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ),
      logo: "images/logo_unilu_fr.svg",
      width: 20%,
    ),
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [University of Luxembourg],
    logo: context {
     if utils.slide-counter.get().first() > 1 [
        #align(right)[#image("images/logo_unilu_short.svg", height: 1cm)]
      ] else [
        #none
      ]
    },
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

== Authorship & Disclaimer

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Authorship note*

    Parts of these slides are adapted from lecture material originally
    developed by *_Prof. Andrea Omicini_*.

    The current version has been updated, restructured, and extended
    for this course.
  ],

  [
    *Disclaimer*

    Possible errors, omissions, or inaccuracies may be present in this material.

    I take full responsibility for any mistakes, and I welcome corrections if you spot any.
  ],
)

= Scientific Literature

== Process (Part 1)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    * A complex social process *

    - involving _millions_ of skilled people world-wide
    - _constantly growing_ in numbers and areas of knowledge in the last decades
    - _individuals_, _social_, _organisational_, _economical_, and _political factors_ are involved
  ],
  [
    * The four stages *

    - _production_
    - _publication_
    - _dissemination_
    - _access_

    Only when all four stages are well performed, a scientific result becomes successfull.
  ]
)


== Process (Part 2)

#align(center)[
    #image("images/03/researchers-in-rd-per-million-people-map.svg", height: 95%)
]

== Process (Part 3)

#align(center)[
    #image("images/03/researchers-in-rd-per-million-people-lines.svg", height: 95%)
]

== Actors

#grid(
  columns: 2,
  gutter: 2cm,

  [
    * Who is involved *
    - _researchers_
    - _reseach centers_ & _universities_
    - _funding agencies_
    - _publishers_
  ],

  [
    They participate in the process with different _aims_ and _roles_.
    Abstracting away from _motivations_ of actors in the research process would make it difficult to understand the process and its results.
  ]
)

== Producers

#grid(
  columns: 2,
  gutter: 2cm,

  [
    * Researchers *

    - from academia, industry and research centers
    - individually or in teams
    - mainly involved in the _production_ stage
  ],

  [
    * Production means nothing _per se_ *

    - expert researchers are involved in:
      - scientific meetings
      - scientific projects
      - pubblication of books and journals
      - dissemination
  ]
)


== Promoters

* Universities & research centers *

    - some actors have the promotion of scientific sesearch among their main goals
    - universities have to produce and transmit knowledge
    - research institutes have to make their own results visible and possibly transfer them to industry
    - industrial reseach centers have to produce competitive advantage and long-term profit


== Sponsors

* Funding bodies *

- investing in research
- funding theoretical & applied research
- examples:
    - European Commission (Horizon Europe)
    - National Research Fund (FNR)
    - Regional & local funding agencies
    - big industrial companies (Google, Microsoft, Ferrari, SpaceX, etc.)

* Modes of funding *

- projects, involving individuals & groups from either the same or different institutions
- grants, typically individual


== Artefacts

