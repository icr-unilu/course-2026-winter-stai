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
      - _probabilistic logic programming_, logic combined with probabilities
      - _fuzzy logic_, logic with degrees of truth
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


== Common properties of Symbolic approaches (Part 1)

*What do symbolic approaches have in common?*

- _structured representation_
  - knowledge is represented in a structured and formal way

- _algorithmic manipulation of representations_
  - each approach relies on algorithms that manipulate these structured representations following well-defined rules

- _crisp semantics_
  - the meaning of the representation is well-defined
  - algorithms produce exact results

== Common properties of Symbolic approaches (Part 2)

*What do symbolic approaches have in common?*

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

== Common properties of Sub-symbolic approaches (Part 1)

*What do sub-symbolic approaches have in common?*

- _numerical representation_
  - knowledge is represented in a less structured way (vectors or matrices)

- _differentiable manipulation of representations_
  - algorithms rely on mathematical operations, most commonly undergoing some optimization process

- _fuzzy/continuous semantics_
  - representations are from continuous spaces
  - algorithms may yield fuzzy results

== Common properties of Sub-symbolic approaches (Part 2)

*What do sub-symbolic approaches have in common?*

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

    - New energy in the field due to large language models (LLMs).
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
+ `Neuro-Symbolic` #sym.arrow `Neuro`: symbolic knowledge (influences) #sym.arrow NN
+ `Neuro`#sub(`Symbolic`): symbolic knowledge (constrains) #sym.arrow NN
+ `Neuro[Symbolic]`: symbolic module (embedded in) #sym.arrow NN

Following figures are taken from a survey by Bhuyan et al.#cite(label("DBLP:journals/nca/BhuyanRTS24"))

== Type 1 - Symbolic Neuro-Symbolic

#align(center)[#image("images/06/type-01.jpeg", width: 100%)]
#v(2cm)
Symbols are translated into vector representations,
processed through NNs to capture intricate patterns,
and then converted back into symbolic outputs.

== Type 2 - Symbolic[Neuro]

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    #align(center)[#image("images/06/type-02.jpeg", width: 100%)]
  ],
  [
    A NN acting as an intermediary between input/output flows and a symbolic AI system
    The neural components provide insight-driven inputs to the symbolic problem solver,
    characterizing the loosely coupled but predominantly symbolic nature of these systems.
  ]
)

== Type 3 - Neuro | Symbolic
#grid(
  columns: (6fr, 4fr),
  gutter: 1.5cm,

  [
    #align(center)[#image("images/06/type-03.jpeg", width: 100%)]
  ],
  [
    A cyclical interaction where a NN and a symbolic AI system operate in a feedback loop,
    allowing for both procedural learning and logical inference.
  ]
)

== Type 4 - Neuro-Symbolic #sym.arrow Neuro

#grid(
  columns: (4fr, 6fr),
  gutter: 1.5cm,

  [
    A distinct mapping layer explicitly connects the symbolic AI component with the NN.
    This setup allows for direct translation of symbolic reasoning into neural operations and vice versa
  ],
  [
    #align(center)[#image("images/06/type-04.jpeg", width: 100%)]
  ]
)

== Type 5 - Neuro #sub("Symbolic")

#align(center)[#image("images/06/type-05.jpeg", width: 100%)]
#v(2cm)
Conversion of symbolic first-order logic (FOL) into tensors,
processed by a NN, and then reconverted into symbolic FOL.

== Type 6 - Neuro[Symbolic]

#align(center)[#image("images/06/type-06.jpeg", width: 80%)]
#v(0.5cm)
The process begins with a neural unit that feeds into a series of logical units,
symbolizing the transition from sub-symbolic neural processing to higher-level logical reasoning. 
This represents an advanced form of integration where the NN output is not just interpreted but also informs and shapes logical unit operations.


= Symbolic Knowledge Injection & Extraction

== Symbolic Knowledge Injection (SKI)

Use _symbolic knowledge_ to influence how a _sub-symbolic_ predictor learns/draws inferences.

#v(0.4cm)
#align(center)[*Symbolic knowledge* #sym.arrow *Injector* #sym.arrow *Predictor*]

#v(0.4cm)
- prior knowledge can complement _scarce_ or _noisy_ data

- rules can express relationships under-represented in the training set

- the injection may affect the _architecture_, the _learning process_, or the _representations_

== SKI - Structuring

#grid(
  columns: (4fr, 6fr),
  gutter: 1.5cm,
  [
    - the symbolic theory determines part of the _network architecture_
    - formulas are translated into units and connections
    - knowledge supplies an _inductive bias_ before learning
    - trainable components adapt the predictor to the data
  ],
  [
    #image("images/06/workflow-structuring.svg", width: 100%)
  ],
)
#v(1cm)
The architecture reflects the theory, but trainable components may change its behaviour.

== SKI - Constraining

#grid(
  columns: (4fr, 6fr),
  gutter: 1.5cm,
  [
    - rules into a _violation cost_
    - combine data fit with knowledge compliance during learning
    - continuous interpretations make logical constraints usable in optimisation

    $ L = L_"data" + lambda L_"knowledge" $
  ],
  [
    #image("images/06/workflow-constraining.svg", width: 100%)
  ],
)

A _soft penalty_ encourages compliance. Hard guarantees require explicit enforcement.

== SKI - Embedding

#grid(
  columns: (4fr, 6fr),
  gutter: 1.5cm,
  [
    - encode symbols and relations as _numerical arrays_
    - supply the representations to the predictor's computation
    - preserve relevant relationships through the encoding
  ],
  [
    #image("images/06/workflow-embedding.svg", width: 100%)
  ],
)

An embedding does not, by itself, guarantee that every symbolic constraint holds.

== SKI - Discussion

- *Knowledge quality*
  - incorrect or conflicting rules may harm learning

- *Integration strategy*
  - structuring changes the architecture, constraining guides learning, embedding changes representations
  - the strategies can be combined

- *Evaluation*
  - compare against the same predictor without injection
  - assess predictive performance, rule compliance and robustness to degraded data

== Symbolic Knowledge Extraction (SKE)

Derive _symbolic knowledge_ from a trained sub-symbolic predictor,
so that it reflects the predictor's behaviour with high _fidelity_.

#v(0.4cm)
#align(center)[*Trained predictor* #sym.arrow *Extractor* #sym.arrow *Symbolic knowledge*]

#v(0.4cm)
- _post-hoc explanations_: local predictions or global behaviour
- _knowledge discovery_: explicit patterns to inspect as domain hypotheses
- _model compression_: a smaller symbolic surrogate for the original predictor

== SKE - Decompositional approaches

- inspect the predictor's _internal structure_

- analyse weights, biases or activations

- derive symbolic conditions from internal components and combine them

- require access to the model and assumptions about its architecture

#v(0.5cm)
Meaningful internal components can help interpretation. Large models make extraction harder.

== SKE - Pedagogical approaches

- treat the predictor as a _black box_

- select inputs and query its predictions

- learn a symbolic surrogate from the input/output pairs

- require no access to weights or architecture

#v(0.5cm)
The sampled inputs determine which parts of the predictor's behaviour can be recovered.

== SKE - Fidelity and interpretability

#grid(
  columns: 2,
  gutter: 1.5cm,
  [
    *Fidelity vs. accuracy*

    - _fidelity_: agreement with the predictor
    - _accuracy_: agreement with ground truth
    - a faithful surrogate can reproduce the predictor's errors and biases
  ],
  [
    *Quality of the explanation*

    - coverage of the input space
    - number and length of rules
    - meaningful input features
    - stability across samples and runs
  ],
)

Higher fidelity may require a more complex, less interpretable symbolic representation.

== SKI and SKE - Two directions

#grid(
  columns: 2,
  gutter: 1.5cm,
  [
    *SKI*

    Symbolic knowledge #sym.arrow predictor

    - start from an explicit theory
    - influence learning or inference
    - assess compliance with the theory
  ],
  [
    *SKE*

    Predictor #sym.arrow symbolic knowledge

    - start from a trained predictor
    - derive an explicit approximation
    - assess fidelity to the predictor
  ],
)

Extracted rules may be _reviewed_ and _injected again_, closing the loop.

= Automatic Knowledge Discovery

== Case study - LLMs as ontology oracles

*Large language models as oracles for instantiating ontologies with domain-specific knowledge*#cite(label("DBLP:journals/kbs/CiattoAMO25"))

#v(0.5cm)
_KGFiller_: query a pretrained LLM to populate a given ontology schema
with _individuals_ and _relations_.

// Source for the following case-study slides: paper, Sections 3-5.
// Values below are from the published experiments, not a current LLM ranking.

== Ontology population - What is given?

#grid(
  columns: 2,
  gutter: 1.5cm,
  [
    *Input*

    - an ontology _schema_ (_TBox_): class and property definitions
    - a class hierarchy
    - natural-language _query templates_
    - a trained LLM acting as an _oracle_
  ],
  [
    *Output*

    - instances assigned to classes
    - relations connecting instances
    - an enriched _ABox_ (assertions about individuals) under the given TBox
    - assertions for experts to keep, adjust or discard
  ],
)

The method populates an existing schema. Schema construction remains a separate task.

== KGFiller - Overview

#align(center)[#image("images/06/kgfiller-roadmap.svg", height: 10.5cm)]

#align(center)[_Population_ #sym.arrow _Relation_ #sym.arrow _Redistribution_ #sym.arrow _Merge_]

// Uploaded roadmap.svg, matching the running example in paper, Fig. 2.

== Population and Relation

#grid(
  columns: 2,
  gutter: 1.5cm,
  [
    *Population*

    Ask for examples belonging to a class.

    Parse the answer and add candidate individuals to the ontology.

    _Illustrative query:_\
    Give names of Italian recipes.
  ],
  [
    *Relation*

    Ask for related entities for each relevant individual.

    Add assertions following the property's domain and range.

    _Illustrative query:_\
    Give the ingredients of margherita pizza.
  ],
)

Replies need parsing and validation before becoming useful assertions.

== Redistribution and Merge

#grid(
  columns: 2,
  gutter: 1.5cm,
  [
    *Redistribution*

    - relation queries may introduce individuals in broad classes
    - ask the oracle for the best matching _subclass_
    - repeat down the hierarchy

    E.g., place an ingredient in the most specific available food category.
  ],
  [
    *Merge*

    - shortlist _syntactically similar_ individuals
    - ask whether they denote the same entity
    - merge the assertions if the answer is positive

    E.g., alternative names may denote the same ingredient.
  ],
)

== Nutritional ontology

#text(size: 0.75em)[
  54 classes, rooted in _Edible_, initially no individuals. `ingredientOf` connects ingredients to recipes.\
  Schema designed from the authors' common sense, without clinical validation.
]

#align(center)[#image("images/06/kgfiller-food-ontology.svg", height: 9.3cm)]

// Exported ontology_skeleton.svg from gciatto/presentation-llm4kg.

== How to evaluate the generated knowledge?

*Manual assessment* of generated individuals and relations.

- individual errors: misplaced, incorrect, meaningless, class-like or duplicate
- relation errors: assertions linking entities in an incorrect way
- the authors assess independently and resolve disagreement by majority vote

#v(0.3cm)
$ Q = (T_I - T_E + T_R - E_"wr") / (T_I + T_R) $

#text(size: 0.8em)[
  $T_I$: individuals, $T_E$: individuals affected by errors,\
  $T_R$: relations, $E_"wr"$: wrong relations.
]

== Results - Quality and quantity

#text(size: 0.85em)[
  #table(
    columns: (2fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    inset: 0.5em,
    [*LLM oracle*], [*Individuals*], [*Relations*], [*$Q$*],
    [GPT 3.5 Turbo], [511], [736], [0.924],
    [GPT 4 Turbo], [735], [1,061], [0.896],
    [Nous Hermes], [1,121], [1,222], [0.851],
    [Mistral], [1,176], [1,211], [0.774],
  )
]

- more generated knowledge does not necessarily mean _higher quality_
- GPT 3.5 Turbo yields the highest $Q$ among the eight tested models
- the evaluation concerns this _ontology_ and these _experimental settings_

#text(size: 0.7em)[Source: paper, Table 2. Selected rows from the published experiments.]

== Comparison with Harvest

#grid(
  columns: (4fr, 6fr),
  gutter: 1cm,
  [
    - same _food ontology schema_
    - Harvest's best reported $Q$: _0.2646_
    - KGFiller with GPT 3.5 Turbo: _0.924_

    Results support the approach on this case study.

    #v(0.4cm)
    #text(size: 0.8em)[
      *RIE*: relative individual error.\
      *RRE*: relative relation error.\
      Lower errors and higher $Q$ are better.
    ]
  ],
  [
    #image("images/06/kgfiller-vs-harvest.pdf", width: 100%)
  ],
)

#text(size: 0.7em)[Source: paper, Section 4.6, Tables 2 and 5.]

== Automatic discovery - Discussion

#grid(
  columns: 2,
  gutter: 1.5cm,
  [
    *What we gain*

    - faster initial ontology population
    - explicit knowledge from a neural oracle
    - incremental enrichment of existing ontologies
    - a starting point for expert revision
  ],
  [
    *What remains open*

    - hallucinated entities, wrong relations and model biases
    - dependence on prompts and model versions
    - factual provenance and independent validation
    - generalisation beyond the tested domain
  ],
)

Knowledge elicited from a model is not automatically a _new scientific discovery_.