#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "@preview/board-n-pieces:0.9.0": *
#import "@preview/fontawesome:0.6.2": *
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


= The Raise of Artificial Intelligence (1950s - 1970s)

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

== Search (Part I)

*Searching for solution(s)*

- from the current stato to a _desired_ one (*goal*)
- based on a _repertoire_ of possible actions
- modelled with
    - _pre-condtions_ (a.k.a., states in which an action can be applied)
    - _effects_ (a.k.a., states resulting from applying an action)
- construction of a _search tree_
    - from the initial state as its root (*forward search*)
    - from the final state as its root (*backward search*)

== Search (Part II)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Explosion of the search space*

    - combinatorial explosion
    - e.g., in the game of chess:
      - 20 legal moves in the first semi-move (w)
      - 20 legal moves in the first semi-move (b)
      - we already have 400 possible states after the first full move
    - heuristic as rule of thumb to guide the search
  ],

  [
    #let starting_moves = (
      "a2a3", "b2b3", "c2c3", "d2d3", "e2e3", "f2f3", "g2g3", "h2h3",

      "a2a4", "b2b4", "c2c4", "d2d4", "e2e4", "f2f4", "g2g4", "h2h4",

      "b1a3", "b1c3", "g1f3", "g1h3"
    )

    #board(
      starting-position,
      arrows: starting_moves,
      arrow-fill: rgb("ff0000").transparentize(30%),
      arrow-thickness: 0.12cm,
      square-size: 1.2cm
    )
  ]
)

== Search (Part III)

*Deep Blue#cite(label("CAMPBELL200257")) vs. Garry Kasparov (1996)*

#align(center)[
    #image("images/01/deep-blue-vs-kasparov-1996.jpg", height: 60%)
]


== Planning (Part I)

*SHRDLU#cite(label("doi:https://doi.org/10.1002/0470018860.s00056"))*

- the Block Word is a _virtual environment_ where objects are arramged on a table
- SHRDLU was aimed at arranging the objects based on user's instructions
- interaction via natural language commands
- the system was using a simulated robot arm to manipulate the objects
- practical reasoning (reasoning towards action)

== Planning (Part II)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *SHAKEY with STRIPS#cite(label("doi:https://doi.org/10.1002/0470018860.s00003"))*

    - remote controlled mobile robot
    - moving objects in a room
    - planning with STRIPS

  ],

    [
        #image("images/01/shakey-with-strips.png")
    ]
)


= The AI Winter (1970s – 1990s)

== Complexity (Part I)

*Microworld does not scale up to the real world*

- solutions workin in oversimplified environments do notwork in the real world
- qualitative or quantitative issue?

#v(0.6em)

*NP-complete problems*

- non-deterministic Polynomial-time complete problems are
  - easy to check (verify) a solution
  - but hard to find a solution in reasonable time
  - e.g., the Travelling Salesman Problem (TSP)#cite(label("PAPADIMITRIOU1977237"))

== Complexity (Part II)

*Disillusionment*

- Too much hype at the beginning
- in few decades, nothing was accomplished in the real world
- e.g., the General Problem Solver (GPS)#cite(label("newell1959report")) never worked in real-world scenarios
- cut in funding and interest in AI research

== Knowledge (Part I)

*A way out*

- humans do not explore all the possibilities to find solutions
- they us _domain knowledge_ to cut down the search space
  - e.g., in chess, a player can play the whole opening by heart
  - #alert("knowledge is not the only way") (e.g., _subconscious pattern recognition_)
- exploiting explicit domain knowledge representation

== Knowledge (Part II)

*Expert systems*

  - no longer General AI, but tailored to _specific domains_
  - finally facing real-world problems successfully
  - _eliciting knowledge_ from human experts in terms of _rules_
  - able to answer to human questions (with _explanations_)
  - coping with _uncertainty_

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *MYCIN#cite(label("shortliffe1976computer"))*

    - ~200 rules about blood diseases
    - meant to be a doctor's assistant
  ],

  [
    *CYC#cite(label("DBLP:journals/aim/LenatPS86"))*

    - a large knowledge base of common sense
    - wanted to cover everything, too ambitious
  ]

)

== Computational Logic

*Logic Programming*

- knowledge representation and inference based on logic
- computing with logic, e.g., Prolog#cite(label("10.1145/234286.1057820"))
    - based on _Horn clauses_
    - #alert("logic theory") against which _goals_ are proved
    - computation as goal demonstration
- heavy computational cost
- if you want to try yourself #link("https://github.com/tuProlog")

== Bayesian Reasoning

*Coping with uncertainty*

- humans do not deal well with uncertainty and probabilities#cite(label("doi:10.1126/science.185.4157.1124"))
- _rational decisions_ are better than human decisions in most fields
- Thomas Bayes developed the mathematical theory in the 18th century
- a couple of centuries later, it was applied to AI to make #alert("Bayesian reasoning"):
  - Bayesian networks
  - Naive Bayes classifier

== Nouvelle AI and Robots (Part I)

*Against reasoning, against representation#cite(label("DBLP:conf/ijcai/Brooks91"))#cite(label("DBLP:journals/ai/Brooks91"))*

- against knowledge-based and logic-based AI
- #alert("perceive and react") as the main cycle for robots in the real world
- focus on the expected specific _intelligent behaviours_
- _subsumption architecture_#cite(label("DBLP:journals/trob/Brooks86")), a.k.a., who has the priority

== Nouvelle AI and Robots (Part II)

*Valentino Braitenberg's Vehicles#cite(label("DBLP:journals/ai/Stefik85a"))*

If you want to try yourself: #link("https://www.braitenberg.world/")[braitenberg.world]

#align(center)[
    #grid(
      columns: 4,
      gutter: 0.5cm,

      [
        #image("images/01/braitenberg_vehicle_2a.png", height: 10em)
        #v(0.6em)
        Fear
      ],

      [
        #image("images/01/braitenberg_vehicle_2b.png", height: 10em)
        #v(0.6em)
        Aggression
      ],

      [
          #image("images/01/braitenberg_vehicle_3a.png", height: 10em)
          #v(0.6em)
          Love
      ],

      [
          #image("images/01/braitenberg_vehicle_3b.png", height: 10em)
          #v(0.6em)
          Exploration
      ]
    )
]

== Nouvelle AI and Robots (Part III)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    #image("images/01/reinforcement_learning_diagram.svg", height: 15em)
    #v(0.6em)
    Reinforcement learning loop
  ],

  [
    #image("images/01/subsumption_architecture.png", height: 15em)
    #v(0.6em)
    Example of a subsumption architecture
  ]
)

= The Modern Era of AI (2000s – present)

== Machine Learning (Part I)

*Machine learning (ML)*

- ML aims at computers that learn knowledge they have not be explicitly told#cite(label("DBLP:books/lib/MichalskiA84"))
- how they learn? Tipically through _training_

#v(0.6em)

#grid(
  columns: 3,
  gutter: 0.5cm,

  [
    *Supervised learning*

    - from labelled data
    - classification
    - regression
  ],

  [
    *Unsupervised learning*

    - from unlabelled data
    - clustering
    - dimensionality reduction
  ],

  [
    *Reinforcement learning*

    - interacting with the environment
    - games
    - robotics
  ]
)

== Machine Learning (Part II)

*Success factors of ML*

- _scientific breakthroughs_ in algorithms and models, #alert("deep learning")
- _availability of data_ (e.g., from the web, social media, sensors)
- _availability of computing power_ (e.g., GPUs, TPUs, cloud computing)

== Machine Learning (Part III)

*Neural networks*

- inspired by the human brain but with _notable differences_
- set of interconnected layers of artificial *neurons*
- learning by adjusting the _weights_ of the connections between neurons and _biases_
- many kinds of neural networks
  - feedforward
  - recurrent
  - convolutional
  - transformers

== Machine Learning (Part IV)

*Triumph of ML*

- in 2014 DeepMind demonstrated a system learning to play Atari games from the pixels and accessing the scores, using the same controls as humans#cite(label("DBLP:journals/corr/MnihKSGAWR13"))
- acquired by Google, DeepMind developed AlphaGo, a system that defeated the Go world champion Lee Sedol in 2016#cite(label("DBLP:journals/nature/SilverHMGSDSAPL16"))
  - _deep neural networks_ with #alert("self-training")
  - Go search space is much larger than chess, so brute-force based search is not enough to beat a human champion
  - this made everyone know that there were _no known limits_ to the ability that machine learning could achieve


== AI today

*AI everywhere#cite(label("wooldridge2018artificial"))*

- digital assistants like Siri, Alexa and Cortana
- face recognition software in social media
- car satellite navigation systems
- recommendations systems in online stores
- _unmanned aerial vehicles (UAV)_ guided by AI algorithms
- large language models (LLMs) pervading any application
- agentic AI
