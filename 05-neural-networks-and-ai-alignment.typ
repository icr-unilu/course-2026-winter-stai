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
    subtitle: [Neural Networks and AI Alignment],
    author: author_list(
      (
        ("Matteo Magnini", "matteo.magnini@uni.lu"),
        (first_author("Davide Liga"), "davide.liga@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ),
      logo: "images/logo_unilu_fr.svg",
      width: 20%,
    ),
    date: datetime(year: 2026, month: 10, day: 8).display("[day] [month repr:long] [year]"),
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

// ---------------------------------------------------------------------------
// Class 5 helpers
// ---------------------------------------------------------------------------
#let teal = rgb("#40BAD2")
#let lime = rgb("#E2EFD9")
#let sand = rgb("#FFF2CC")
#let muted = luma(120)
#set list(spacing: 0.9em)

/// bold + underlined emphasis (as in the original slides)
#let hl(body) = underline(strong(body))
/// grey subtitle used in section headings
#let subtitle(body) = text(size: 0.6em, weight: "regular", fill: muted)[#body]
/// small reference / source line
#let ref-note(body) = align(bottom + left, text(size: 0.6em, fill: muted)[#body])
/// filled callout box
#let callout(body, fill: sand, width: 100%) = block(
  width: width, fill: fill, inset: (x: 0.8em, y: 0.6em), radius: 0.3em, body,
)

/// Animation states of a diagram rendered from the original PowerPoint.
/// `states` lists the file suffixes (images/05/<name>-step<N>.pdf); each state
/// occupies one subslide, the last one stays visible afterwards.
#let steps(name, states, start: 1, height: 10.5cm, width: auto) = {
  let n = states.len()
  for (i, s) in states.enumerate() {
    let k = start + i
    let when = if i == n - 1 { str(k) + "-" } else { k }
    only(when, align(center, image(
      "images/05/" + name + "-step" + str(s) + ".pdf", height: height, width: width,
    )))
  }
}

#title-slide()

== Layout

#set enum(spacing: 1em)
#align(horizon)[
  + *Recap*
  + *ANN and LLMs' inner workings*
  + *AI Alignment via RL*
  + *Mechanistic Interpretability*
  + *[Speculative Bonus]*
]

// ---------------------------------------------------------------------------
// PART 1
// ---------------------------------------------------------------------------

= Part 1 \ #subtitle[Recap]

== Sparse BoW

#steps("s04", (0, 1), height: 10.5cm)

== Sparse Vector Representations

#steps("s05", (0, 1), width: 100%, height: auto)

== Embeddings: Word2vec

#steps("s06", (0, 1), width: 100%, height: auto)
#ref-note[Reference: Mikolov 2013, "Efficient Estimation of Word Representations in Vector Space"]

== Dense Vector Representations [learnt from data]

#steps("s07", (0, 1, 2, 3, 4, 5), height: 10.5cm)

== Embeddings: Word2vec

#steps("s08", (0, 1), height: 10.5cm)

== Fixed Embeddings: Word2vec

#steps("s09", (0, 1), height: 10.5cm)

== LLMs' Embeddings

#steps("s10", (0,), height: 10.5cm)

== Contextual Embeddings: LLMs

#grid(
  columns: (1276fr, 1033fr),
  gutter: 0.4cm,
  align: top,
  image("images/05/contextual-embeddings-code-a.png", width: 100%),
  image("images/05/contextual-embeddings-code-b.png", width: 100%),
)

== Contextual Embeddings: LLMs

```python
sentence1 = "The language is evolving"

sentence2 = "He studies programming language"
```

#v(0.5em)
#text(fill: muted)[
  'language' in sentence 1: \
  `[-0.7310,  0.6581, -0.5506, -0.2642, -0.4083]`

  'language' in sentence 2: \
  `[-0.2023,  0.0763, -1.9387, -0.5188, -0.7275]`
]

== Contextual Embeddings: LLMs

#only(1, grid(
  columns: (1267fr, 1290fr),
  gutter: 0.4cm,
  align: top,
  image("images/05/one-a.png", width: 100%),
  image("images/05/one-b.png", width: 100%),
))
#only("2-", align(center + horizon, image("images/05/two.png", width: 100%)))

== Contextual Embeddings: LLMs

#steps("s14", (0, 1, 2), height: 10.5cm)

== Contextual Embeddings: LLMs

#steps("s15", (0, 1, 2), height: 10.5cm)

== Contextual Embeddings: LLMs

#steps("s16", (0, 1, 2), height: 10.5cm)

== Contextual Embeddings: LLMs

#steps("s17", (0, 1), height: 10.5cm)

== Multimodality

#steps("s18", (0, 1, 2, 3, 4), height: 10.5cm)

// ---------------------------------------------------------------------------
// PART 2
// ---------------------------------------------------------------------------

= Part 2 \ #subtitle[Artificial Neural Networks and LLMs' inner workings]

== Perceptron, the foundation block of any ANN

#steps("s20", (0,), height: 10.5cm)

== NLP

#align(center + horizon)[
  How can #hl[NEURAL NETWORKS] learn these \
  "meaningful" numerical representations?
]

== Perceptron, the foundation block of ANN

#steps("s22", (0,), height: 10.5cm)

== Perceptron, the foundation block of ANN

#steps("s23", (0,), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#steps("s24", (0,), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#steps("s25", (0,), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#steps("s26", (0, 1), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#speaker-note[Adjusting biases can help the network to better fit the data by allowing the (non-linear) activation functions to operate in their most sensitive and dynamic ranges.]
#steps("s27", (0, 1), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#steps("s28", (0,), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#steps("s29", (0, 1, 2), width: 100%, height: auto)

== Perceptron, the foundation block of ANN

#steps("s30", (0, 1, 2, 3, 4, 5), height: 10.5cm)

== The importance of non-linearity

#steps("s31", (0, 1, 2, 3, 4, 5, 6, 7, 8), height: 10.5cm)

== Perceptron, the foundation block of ANN

#steps("s32", (0,), width: 100%, height: auto)

== From one perceptron to many

#steps("s33", (0, 1, 2), width: 100%, height: auto)

== From one layer to deep neural networks

#steps("s34", (0, 1, 2), width: 100%, height: auto)

== How does the network "learn"?

#steps("s35", (0,), height: 10.5cm)

== Example

#steps("s36", (0,), height: 10.5cm)

== Example

#steps("s37", (0,), height: 10.5cm)

== Feed forward phase

#steps("s38", (0, 1, 2, 3), width: 100%, height: auto)

== Backpropagation and "Loss"

#steps("s39", (0,), width: 100%, height: auto)

== Test phase (after training)

#steps("s40", (0,), width: 100%, height: auto)

== Underfitting and overfitting

#steps("s41", (0, 1, 2), width: 100%, height: auto)

== Recurrence-based Neural Networks

#steps("s42", (0, 1, 2, 3, 4, 5, 6), height: 10.5cm)

== Recurrence-based Neural Networks

#speaker-note[While sigmoid outputs values between 0 and 1, tanh outputs values between −1 and 1:

It can produce both negative and positive activations.

Its output range is symmetric around zero, although the actual activations do not necessarily have a mean of zero.

Near an input of zero, tanh has a steeper slope than standard sigmoid: its derivative at zero is 1, compared with 0.25 for sigmoid. Therefore, in this region, tanh is more sensitive to small input changes and attenuates the backpropagated signal less.

Tanh still suffers from saturation, where its derivative approaches zero. RNNs using tanh can therefore still experience vanishing gradients; recurrent weights can also cause exploding gradients.]

#only(1, align(center, image("images/05/s43-step0.pdf", height: 10.5cm)))
#only("2-", align(center, image("images/05/s43-step1_new.png", height: 10.5cm)))

== Recurrence-based Neural Networks

#steps("s45", (0,), width: 100%, height: auto)

== Attention-based Neural Networks

#steps("s46", (0, 1, 2, 3, 4), width: 100%, height: auto)

== Attention-based Neural Networks

#steps("s47", (0, 1, 2, 3, 4, 5, 6, 7), width: 100%, height: auto)

== Attention-based Neural Networks

#steps("s48", (0, 1, 2, 3), height: 10.5cm)

== Attention-based Neural Networks

#steps("s49", (0, 1), height: 10.5cm)

== Attention-based Neural Networks

#steps("s50", (0, 1, 2), height: 10.5cm)

== Attention-based Neural Networks

#steps("s51", (0, 1, 2), height: 10.5cm)

// ---------------------------------------------------------------------------
// PART 3
// ---------------------------------------------------------------------------

= Part 3 \ #subtitle[AI Alignment (RL post-training)]

== Pre-training and post-training

#steps("s53", (0,), height: 10.5cm)

== Alignment as a reinforcement-learning loop

#steps("s54", (0,), width: 100%, height: auto)

== Four types of RL methods (all share the same goal)

#steps("s55", (0,), width: 100%, height: auto)

// ---------------------------------------------------------------------------
// PART 4
// ---------------------------------------------------------------------------

= Part 4 \ #subtitle[Mechanistic Interpretability]

== Golden Gate Bridge feature

#align(center, image("images/05/golden-gate-feature.png", height: 9.5cm))
#ref-note[Source: https://www.anthropic.com/research/mapping-mind-language-model]

== Golden Gate Bridge feature

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8cm,
  align: horizon,
  image("images/05/golden-gate-default.png", width: 100%),
  uncover("2-", image("images/05/golden-gate-clamped.png", width: 100%)),
)
#ref-note[Source: https://www.anthropic.com/research/mapping-mind-language-model]

== Why important?

#let tag(body) = box(fill: lime, inset: (x: 0.5em, y: 0.3em), radius: 0.2em, text(size: 0.85em, body))

#[
#set text(size: 0.9em)
"The fact that manipulating these features causes corresponding changes to behavior validates that they aren't just correlated with the presence of concepts in input text, but also #hl[causally shape the model's behavior].

#pause
In other words, the features are likely to be a faithful part of #hl[how the model internally represents the world], and how it uses these representations in its behavior."

#v(0.8em)
#align(center)[
  #uncover("3-")[#tag[Causality]]
  #h(2em)
  #uncover("4-")[#tag[Representation of the world]]
]
#ref-note[Source: https://www.anthropic.com/research/mapping-mind-language-model]
]

== Detachment between #underline[saying] and #underline[doing] (internally)

#only(1, align(center, image("images/05/mental-math-pathways.png", height: 9.5cm)))
#only("2-", align(center, image("images/05/mental-math-answer.png", height: 9.5cm)))
#ref-note[https://www.anthropic.com/research/tracing-thoughts-language-model]

== Some MechInt techniques

#[
#set text(size: 0.9em)
#grid(
  columns: (1fr, 1.6fr),
  gutter: 1.5cm,
  [
    #callout(fill: rgb("#FCE4D6"))[OBSERVING (Read, don't touch)]
    - Logit lens
    - attention patterns
    - Probes
    - SAE feature reading
  ],
  [
    #callout(fill: rgb("#DDE3EE"))[INTERVENING (change, then watch the output)]
    - Activation patching (swap in activations from another run)
      - Residual-stream patching
      - MLP patching
      - Attention-head patching
      - Path patching
    #v(0.4em)
    - Activation steering (add a direction)
  ],
)
]

== Intervening

#[
#set text(size: 0.72em)
#callout(fill: rgb("#DDE3EE"))[
  *Activation patching* is the interpretability version of a controlled experiment. A "clean" and "corrupted" prompts are identical except for one target element, so the model's answer flips.
  If copying a single clean activation into the corrupted run brings the answer back, that activation carries the information the model needs. The task is Indirect Object Identification (Wang et al., 2022).

  #pad(left: 1.5em)[
    *Residual-stream patching* localises where (which layer, which token position) the information that drives the behaviour is carried.

    *MLP patching* measures how much each layer's MLP block contributes.

    *Attention-head patching* identifies the few heads whose outputs carry the effect.

    *Path patching* tests whether the effect flows along a specific route between components (e.g. from an MLP into later heads), rather than acting directly.
  ]

  *Activation steering* adds a direction to the residual stream and checks that the behaviour moves: a causal test that the direction is sufficient.
]
]

== Activation patching: a controlled experiment

#steps("s63", (0,), height: 10.5cm)

== Steering

#steps("s64", (0,), height: 10.5cm)

== Some MechInt techniques

#[
#set text(size: 0.78em)
#pause
#callout(fill: rgb("#FCE4D6"))[
  #text(fill: rgb("#C55A11"))[*SAEs*] are small networks trained, without labels, to rewrite a model's activations as a sparse combination of many more directions than the model has dimensions, e.g. 24,576 directions for GPT-2's 768. Each activation is rebuilt from just a few active "features", and each feature tends to match a single human-interpretable concept, such as "wedding", "dog" or code syntax. An SAE is an open-ended survey: it discovers what the model represents, including concepts we didn't think to look for. Its features are then interpreted from the texts that activate them most, and tested causally by steering or ablating them.

  #text(fill: rgb("#C55A11"))[*Probes*] are small classifiers, usually linear (e.g. logistic regression), trained on a frozen model's internal activations to predict a property we already have in mind, such as sentiment, part of speech, "is this statement true?", "is this {whatever}?". If the probe predicts it well at a given layer, the information is present there and can be read out with a linear rule. Running the probe layer by layer shows where the information appears and fades. A probe is supervised and targeted: you need labelled examples, and you test one concept at a time.
]
]

== Superposition and sparse autoencoders

#only(1)[
  #set text(size: 0.9em)
  Problem: individual neurons are hard to interpret. One neuron fires for "French", "DNA" and "commas" (it is *polysemantic*).

  Why? Because a model wants to represent MANY more concepts ("features") than it has dimensions.

  If features are sparse (rarely active at the same time) it can pack them into a smaller space as almost-orthogonal directions: this is SUPERPOSITION (Elhage et al., 2022, "Toy Models of Superposition").
]
#only("2-", align(center, image("images/05/s66-step2.pdf", width: 100%)))

// ---------------------------------------------------------------------------
// PART 5
// ---------------------------------------------------------------------------

= Part 5 (bonus) \ #subtitle[The emergence of symbolic from subsymbolic]

== Emergence

#grid(
  columns: (1.3fr, 1fr),
  gutter: 1cm,
  [
    Symbolic "knowledge" #underline[emerges] from subsymbolic patterns

    #v(1fr)
    #uncover("2-")[
      #set text(size: 0.7em)
      *"Sparks of Artificial General Intelligence: Early experiments with GPT-4"* (Bubeck et al. 2023)

      *"Emergent Abilities of Large Language Models"* \
      (Wei et al. 2022)
    ]
  ],
  [
    #image("images/05/hierarchical-features.jpg", width: 100%)
    #text(size: 0.6em)["Unsupervised Learning of Hierarchical Representations with Convolutional Deep Belief Networks" (Lee et al. 2011)]
  ],
)

== Emergence

#grid(
  columns: (1fr, 1.4fr),
  gutter: 1cm,
  [
    #uncover("2-")[Emerging abilities \
      #text(size: 0.8em)[(Capabilities on which the model has not been explicitly trained on)]]

    #uncover("3-")[- Style transfer]
    #uncover("4-")[- Translation]
    #uncover("5-")[- Mathematical skills]
  ],
  uncover("6-")[
    #image("images/05/emergent-abilities.png", width: 100%)
    #text(size: 0.7em)[*"Emergent Abilities of Large Language Models"* (Wei et al. 2022)]
  ],
)

#focus-slide[
  Consciousness?

  #v(0.5em)
  #uncover(2)[
    #text(size: 2em, weight: "bold")[NO] \
    #text(size: 1.4em, weight: "bold")[NOT YET #fa-face-smile(solid: true)]
  ]
]

== Consciousness is #underline[not] easy…

#[
#set text(weight: "bold")
#pause
- Perception of the Self and perception of the Other
  #pause
  - Creation of an internal model, and an external model
#v(0.6em)
#pause
- Having aboutness (Thoughts/Beliefs/Desires are about/directed to/referred to something)
  #pause
  - #underline[Goal-oriented behaviours] can give some interesting clues…
]

== Consciousness is #underline[not] easy…

#align(center + horizon)[
  #pause
  LLMs have a strong #hl[detachment] between \
  #pause
  what they #hl[say] and what they actually #hl[do].
]

== Tic-Tac-Toe

#align(center)[
  #text(size: 0.8em, weight: "bold", fill: muted)[TIC-TAC-TOE]
  #image("images/05/tic-tac-toe.jpg", height: 9.5cm)
]

== Tic-Tac-Toe

#grid(
  columns: (1fr, 1.3fr),
  gutter: 1cm,
  align: horizon,
  image("images/05/minimax.png", width: 100%),
  uncover("2-")[
    #set text(size: 0.75em)
    #callout(fill: luma(225))[
      Minimax is an AI algorithm that works by determining the best possible move for a player in a two-player zero-sum game (one player's win = to the other player's loss).

      It looks at all possible moves in the game and figures out the best move for the current player, considering the best response from the opponent at each step.
      The algorithm seeks to maximize the player's gains while minimizing potential losses.

      It assumes the opponent is also playing optimally, and it aims to minimize the maximum potential loss.
    ]
  ],
)

== Tic-Tac-Toe

#align(center, image("images/05/tic-tac-toe-run.png", height: 10.5cm))

== Evaluation metrics

*We evaluated LLMs considering 2 aspects*

#v(0.5em)
- Capacity of identifying the #underline[correct available winning sequences] (both for the opponent and for itself)
- Duration of the match (#underline[number of moves])

== Evaluation metrics

#align(center + horizon)[*Shall we expect a positive correlation?*]

== F1 + moves

#steps("s78", (1, 2, 3, 4), height: 10.5cm)

#focus-slide[
  THANKS

  #v(0.5em)
  #text(size: 0.7em)[Let's grab a coffee #fa-mug-hot()]

  #v(1em)
  #text(size: 0.5em)[#raw("davide.liga@uni.lu")]
]
