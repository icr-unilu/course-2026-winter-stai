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

- *First lecture:* \
  16 September 2026, 15:45–17:15, room MSA‑3.170

- *Regular weekly slot (from 2nd lecture onwards):* \
  Every Thursday, 08:30–10:00, from 24 September 2026 to 17 December 2026, \
  room MSA‑4.080 (Belval campus)

- *Teaching staff rotation:* \
  The three of us will alternate
  as lecturers across the lectures.

== Course structure

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Part I – Introductory lectures \
     (6 lectures)*

    The first 6 lectures are classical frontal lectures.
    Covered topics:

    - Artificial Intelligence 101
    - Current Trends in AI
    - About Academic Research
    - How to Recognise a Good Paper
    - Systematic Literature Review
    - Neuro‑Symbolic AI
  ],

  [
    *Part II – Student seminar presentations (8 lectures)*

    The remaining 8 lectures are dedicated to student presentations of research papers.

    - If more than 8 students are enrolled:
      30 minutes presentation + 15 minutes discussion.

    - otherwise:
      60 minutes presentation + 30 minutes discussion.
  ],
)

== Where to find the material

- *Moodle (official channel)* \
  Use the university Moodle to access all course resources: \
  #link("https://moodle.uni.lu/course/view.php?id=81")[
    moodle.uni.lu/course/view.php?id=81
  ]

- *GitHub page* \
  Overview of the course and additional material (this slide only): \
  #link("https://icr-unilu.github.io/course-2026-winter-stai")[
    icr-unilu.github.io/course-2026-winter-stai
  ]

- *GitHub releases (PDF slides)* \
  The PDF versions of the slides are available in the latest release: \
  #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest")[
    github.com/icr-unilu/course-2026-winter-stai/releases/latest
  ]

== Assessment

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *30% – Participation in lectures*

    Students are expected to attend all the lectures.

    Moreover, the following aspects will be taken into account:

    - active contribution to discussions
    - asking questions and commenting on presentations
  ],

  [
    *70% – Paper presentation*

    Individual presentation of a selected research paper.

    Among other aspects, we will primarily evaluate:

    - clarity of the presentation
    - depth of understanding of the paper’s content
  ],
)

== Table of contents

Lecture slides and materials are available in the “Latest release” of the course repository:
#link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest")[
  github.com/icr-unilu/course-2026-winter-stai/releases/latest
]

#v(0.8em)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Lecture slides*

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/01-artificial-intelligence-101.pdf")[
        01 – Artificial Intelligence 101
      ]

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/02-current-trends-in-ai.pdf")[
        02 – Current Trends in AI
      ]

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/03-about-academic-research.pdf")[
        03 – About Academic Research
      ]

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/04-how-to-recognise-a-good-paper.pdf")[
        04 – How to Recognise a Good Paper
      ]

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/05-systematic-literature-review.pdf")[
        05 – Systematic Literature Review
      ]

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/06-neuro-symbolic-ai.pdf")[
        06 – Neuro‑Symbolic AI
      ]
  ],

  [
    *Other material*

    - #fa-icon("file-pdf")
      #link("https://github.com/icr-unilu/course-2026-winter-stai/releases/latest/download/paper-list.pdf")[
        Paper list
      ]

    - #fa-icon("graduation-cap")
      #link("https://scholar.google.com")[
        Google Scholar
      ]

    - #fa-icon("database")
      #link("https://dblp.org")[
        DBLP
      ]

    - #fa-icon("chart-line")
      #link("https://www.scimagojr.com")[
        Scimago Journal & Country Rank
      ]

    - #fa-icon("layer-group")
      #link("http://portal.core.edu.au/conf-ranks/")[
        CORE Conference Rankings
      ]

    - #fa-icon("globe")
        #link("https://www.scopus.com")[
        Scopus
    ]
  ],
)



// #slide[
//   #bibliography("bibliography.bib")
// ]