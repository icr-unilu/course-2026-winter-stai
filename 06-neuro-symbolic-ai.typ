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
    subtitle: [Neuro-Symbolic AI],
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

= Background

== Overview on AI (Part 1)

#align(center)[#image("images/06/ai-map.svg", width: 100%)]

== Overview on AI (Part 2)

#align(center)[#image("images/06/ai-map2.pdf", width: 100%)]

== Local vs. Distributed Representation

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    #align(center)[#image("images/06/local-distributed-representations.png", width: 100%)]
  ],
  [
      - *Local* \~ _symbolic_:
        - each symbol has a clear, distinct meaning
        - e.g., "_bear_" is a symbol denoting a crisp category

      - *Distributed* \~ _sub-symbolic_ #cite(label("gelder1990")):
        - symbols do not have a clear meaning per se, but the whole representation does
        - e.g., "swim" is a fuzzy capability
  ]
)

== Naming Conventions

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    *Symbolic KR*

      - involves a _set of symbols_
      - which can be _combined_ in possibly infinitely many ways
      - following precise _syntactical rules_
      - elementary symbols and any admissible combination of them can be _assigned with meaning_
  ],
  [
    *Sub-symbolic KR*

      - _numeric representation_, but also
      - _probabilistic logic programming_, logic statements combined with probabilities
      - _fuzzy logic_, logic statements combined with degrees of truth
      - _Bayesian networks_, graphical models, nodes are symbols and edges are conditional dependencies with probabilities
  ]
)

== What is what

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    *Symbolic AI*

    - _logic programming_
      - SLD resolution (e.g., Prolog)
    - _knowledge representation_
      - semantic web (e.g., OWL)
      - description logic (e.g., EL, ALC)
    - _automated reasoning_
      - theorem proving (e.g., Vampire, E Prover)
      - model checking (e.g., NuSMV, SPIN)
    - _planning_:
      - STRIPS, PDDL
  ],
  [
    *Sub-symbolic AI*

    - _machine learning_
      - supervised
      - unsupervised
      - reinforcement learning
    - _probabilistic reasoning_
      - Bayesian networks
      - Markov networks
    - _evolutionary algorithms_
      - genetic algorithms
  ]
)

== SLD resolution

#align(center)[#image("images/06/proof-tree.png", height: 100%)]

== Ontology

#align(center)[#image("images/06/ontology-example.png", height: 100%)]

== Planning

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    #align(center)[#image("images/06/planning.png", height: 100%)]
  ],
  [
    Available actions

    - `grab(X)`: grab block X from the table
    - `put(X)`: put block X on the table
    - `stack(X, Y)`: stacks block X on top of block Y
    - `unstack(X, Y)`: un-stacks block X from the top of block Y
  ]
)


== Common properties of Symbolic approaches

*What do symbolic approaches have in common?*

- _structured representation_
  - knowledge is represented in a structured and formal way
- _algorithmic manipulation of representations_
  - each approach relies on algorithms that manipulate these structured representations following well-defined rules
- _crisp semantics_
  - the meaning of the representation is well-defined
  - algorithms produce exact results
- _model driven_
  - algorithms may work in zero- or few-shot settings
  - humand model and encode knowlesge in the target representation
- _clear computational complexity_
  - decidability, complexity and tractability are well understood


== Classification & Regression

#align(center)[#image("images/06/classification-vs-regression.png", height: 100%)]

== Clustering

#align(center)[#image("images/06/clustering.png", height: 100%)]

== Reinforcement Learning

#align(center)[#image("images/01/reinforcement_learning_diagram.svg", height: 100%)]

== Common properties of Sub-symbolic approaches

*What do sub-symbolic approaches have in common?*

- _numerical representation_
  - knowledge is represented in a less structured way (vectors or matrices)
- _differentiable manipulation of representations_
  - algorithms rely on mathematical operations, most commonly undergoing some optimization process
- _fuzzy/continuous semantics_
  - representations are from continuous spaces
  - algorithms may yield fuzzy results
- _data-driven_
  - algorithms require large amounts of data to learn the target representation
- _unclear computational complexity_
  - strong reliance on greedy / time-limited optimisation methods
  - lack of theoretical guarantees on the quality of the results

== Long-standing dualism

#align(center)[
  *Intuition vs. reasoning*

  Esprit de _finess_ vs. Esprit de _géométrie_ #cite(label("pascal_pensees"))\
  _Cognitive_ vs. _Behavioral_ Psychology #cite(label("Skinner1985"))\
  _System 1_ (fast, intuitive) vs. _System 2_ (slow, deliberative) #cite(label("kahneman2011"))
]

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    *Sub-symbolic AI*

    - provides mechanisms emulating human-like _intuition_
    - _quick_, _error-prone_, _effective_
    - requires learning from data
    - _opaque_, hard to interpret and explain
  ],
  [
    *Symbolic AI*

    - provides mechanisms emulating human-like _reasoning_
    - _slow_, _precise_, _verifiable_
    - requires _modeling_ and _encoding_
    - _transparent_, easy to interpret
  ]
)

= Neuro-Symbolic AI

== Need for integration

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    *What is it about?*

    - The Neuro-Symbolic AI (NeSy) community has long recognised the _complementarity_ among symbolic and sub-symbolic approaches.
    - Focus on _neural networks_ (NN) based sub-symbolic methods, as they are very _flexible_.
  ],
  [
    *Research questions*

    - What is the best way to _integrate_ neural and symbolic architectures?
    - How should symbolic structures be _represented_ within neural networks and _extracted_ from them?
    - How should common-sense knowledge be learned and reasoned about?
    - How can abstract knowledge that is hard to encode logically be handled?
  ]
)

== Kautz's taxonomy

*Patterns of _integration_ or _combination_*#cite(label("kautz2022"))

+ `Symbolic Neuro-Symbolic`: symbols #sym.arrow vectors #sym.arrow NNs #sym.arrow vectors #sym.arrow symbols
+ `Symbolic[Neuro]`: symbolic module (invokes) #sym.arrow NN #sym.arrow output
+ `Neuro | Symbolic`: NN (cooperates) #sym.arrow symbolic module (cooperates) #sym.arrow NN ...
+ `Neuro-Symbolic #sym.arrow Neuro`: symbolic knowledge (influences) #sym.arrow NN
+ `Neuro #sub(Symbolic)`: symbolic knowledge (constrains) #sym.arrow NN
+ `Neuro[Symbolic]`: symbolic module (embedded in) #sym.arrow NN