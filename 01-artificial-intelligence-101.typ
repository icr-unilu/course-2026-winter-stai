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
    subtitle: [Artificial Intelligence 101],
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

= The Raise of Artificial Intelligence

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

//──────────────────────────────────────────────────────────────
// THE RISE OF AI
//──────────────────────────────────────────────────────────────

== Golden Age

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Historical context*

    - The idea of *thinking machines* predates digital computers.
    - Modern AI emerges in the *1950s*, when electronic computers
      become programmable and (slowly) more accessible.
    - Researchers start asking a concrete question:

      _"If a computer can calculate, can it also *think*?"_
  ],

  [
    *Key intuition*

    Instead of just doing numerical calculations, computers can:

    - manipulate symbols,
    - follow logical rules,
    - search through spaces of possibilities,
    - learn patterns from data.

     The term *"Artificial Intelligence"* is coined in this context to name the new research area.
  ],
)

//──────────────────────────────────────────────────────────────
// DARTMOUTH WORKSHOP
//──────────────────────────────────────────────────────────────

== The Dartmouth Summer Research Project (1956)

*Dartmouth College, New Hampshire – Summer 1956*

- Organised by *John McCarthy*.
- A small group of researchers meets for a _"Summer Research Project
  on Artificial Intelligence"_.
- Aim: _"… to find how to make machines use language, form abstractions,
  and concepts, solve kinds of problems now reserved for humans…"_

- Participants included:
  - *Marvin Minsky* – later co‑founder of the MIT AI Lab.
  - *Allen Newell & Herbert A. Simon* – authors of the
    *Logic Theorist*, often considered the first AI program
    (an automatic theorem prover, 1956).
  - *John McCarthy* – later inventor of *LISP*, one of the
    earliest programming languages designed for AI.

//──────────────────────────────────────────────────────────────
// General AI
//──────────────────────────────────────────────────────────────

== General AI (Part I)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *General AI*

    - Ultimate goal: create _general-purpose_ intelligence machines
    - but _poor understanding_ of (human) intelligence
    - so, AI focussed then on _intelligent components_

  ],

  [
    *Components of intelligence*

    - Perception
    - Learning
    - Problem solving & Planning
    - Reasoning
    - Natural language understanding
  ]
)

== General AI (Part II)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Perception*

    - understanding the _environment_
    - through _sensors_ of various kind
    - _interpreting_ the overall situation

    #v(0.6em)

    *(Machine) Learning*

    - learning from _data_
    - building _models_
    - making _predictions_

  ],

  [
    #image("images/01/all-models-are-wrong-but-some-are-useful.jpeg", width: 80%)
  ]
)

== General AI (Part III)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Problem solving & Planning*

    - finding a sequence of actions to reach a _goal_
    - based on a _repertoire_ of possible actions

    #v(0.6em)

    *Reasoning*

    - _representing knowledge_
    - _inferring_ new knowledge from existing knowledge
    - following predefined _rules_

  ],

  [
    *Natural Language Understanding*

    - understanding human language
    - in written or spoken form
    - engage in a _dialogue_ with humans
  ]
)

= Main Themes in Early AI
