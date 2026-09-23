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
    subtitle: [Neural Representations and Meaning],
    author: author_list(
      (
        ("Matteo Magnini", "matteo.magnini@uni.lu"),
        (first_author("Davide Liga"), "davide.liga@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ),
      logo: "images/logo_unilu_fr.svg",
      width: 20%,
    ),
    date: datetime(year: 2026, month: 9, day: 24).display("[day] [month repr:long] [year]"),
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
// Class 2 helpers
// ---------------------------------------------------------------------------
#let teal = rgb("#40BAD2")
#let dteal = rgb("#1AB39F")
#let amber = rgb("#F9B200")
#let peach = rgb("#FDE9D9")
#let sand = rgb("#FFF2CC")
#let lime = rgb("#E2EFD9")
#let muted = luma(120)
#set list(spacing: 0.9em)
#let tfc = amber.darken(10%)
#let idfc = teal
#let tfidfc = rgb("#C0392B")

/// bold + underlined emphasis (as in the original slides)
#let hl(body) = underline(strong(body))
/// grey subtitle used in section headings
#let subtitle(body) = text(size: 0.6em, weight: "regular", fill: muted)[#body]
/// small reference line
#let ref-note(body) = align(bottom + left, text(size: 0.6em, fill: muted)[#body])
/// filled callout box
#let callout(body, fill: sand, width: 100%) = block(
  width: width, fill: fill, inset: (x: 0.8em, y: 0.6em), radius: 0.3em, body,
)

/// 道 as a vector glyph, so it renders even where no CJK font is installed
/// (e.g. the GitHub build). `light: true` for dark backgrounds.
#let dao(light: false) = box(baseline: 9%, image(
  if light { "images/02/dao-light.svg" } else { "images/02/dao-dark.svg" }, height: 1em,
))

/// Animation states of a diagram rendered from the original PowerPoint.
/// `states` lists the file suffixes (images/02/<name>-step<N>.pdf); each state
/// occupies one subslide, the last one stays visible afterwards.
#let steps(name, states, start: 1, height: 10.5cm, width: auto) = {
  let n = states.len()
  for (i, s) in states.enumerate() {
    let k = start + i
    let when = if i == n - 1 { str(k) + "-" } else { k }
    only(when, align(center, image(
      "images/02/" + name + "-step" + str(s) + ".pdf", height: height, width: width,
    )))
  }
}

/// Orange-header table used for the Bag-of-words / TF-IDF examples.
#let word-table(rows, size: 1em) = {
  set text(size: size)
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    align: center + horizon,
    stroke: (x, y) => if x > 0 and y > 0 { (paint: white, thickness: 1.5pt) } else { none },
    fill: (x, y) => if y == 0 and x > 0 { amber } else if x == 0 and y > 0 { amber } else if y > 0 { peach } else { none },
    inset: (x: 0.6em, y: 0.5em),
    table.header([], ..("the", "reported", "judge", "court").map(w => text(fill: white, weight: "bold", w))),
    ..rows.enumerate().map(((i, r)) => (
      text(fill: white, weight: "bold")[SENTENCE S#sub[#(i + 1)]],
      ..r,
    )).flatten(),
  )
}

#title-slide()


// ---------------------------------------------------------------------------
// About me & overview
// ---------------------------------------------------------------------------

== About me

#grid(
  columns: (1.35fr, 1fr),
  gutter: 1.2cm,
  align: horizon,
  [
    #set text(size: 0.85em)
    #uncover("2-")[In few words:]

    #uncover("3-")[
    - I am a postdoctoral researcher at the University of Luxembourg, working with the *CLAiM* (*Computational Law and Machine Ethics*) group and the *ICR* (*Individual and Collective Reasoning*) group.
    ]

    #uncover("4-")[
    - I work at the intersection of #underline[symbolic and subsymbolic reasoning], and I have been working at the intersection of *Computational Linguistics*, *AI & Law*, *Argument Mining*, and, more recently, *Mechanistic Interpretability*.
    ]
  ],
  [
    #align(center)[
      #image("images/02/about-me.png", width: 75%)
      #text(fill: muted)[Nice to meet you!]
    ]
  ],
)

== Overview

#let ov-line = line(length: 100%, stroke: 1.5pt + luma(60))

#pause
*Definitions*
#pause
- AI/ML/DL
#pause
- Symbolic vs Subsymbolic dichotomy

#pause
#ov-line
*Numerical representation*
#pause
- NLP and how we go from numbers to #underline[meaning]

#pause
#ov-line
*LLMs*
#pause
- What they are and how they work
#pause
- How come they "reason"?

// ---------------------------------------------------------------------------
// PART 1
// ---------------------------------------------------------------------------

= Intro \ #subtitle[Brief intro]

#speaker-note[max 2m]

= AI \ #subtitle[Artificial Intelligence]

== AI, ML, DL

#steps("s06", (0, 1, 2), height: auto, width: 100%)

== AI, ML, DL

#steps("s07", (0, 2, 4, 6, 7))

= AI \ #subtitle[Symbolic vs Sub-symbolic]

#speaker-note[Max 18m]

== Symbolic vs Subsymbolic AI

We can say that AI is largely divided into *symbolic* (or rule-based) and *sub-symbolic* (or connectionist/data-driven) methods.

#pause
#v(0.6em)
#hl[Symbolic AI] focuses on using #hl[symbols, logic and explicit rules] to represent knowledge, solve problems and make decisions.

#pause
#v(0.6em)
#hl[Sub-symbolic AI] employs techniques like neural networks and deep learning to #hl[model complex patterns and learn from data].

== System 1 _vs_ System 2

#grid(
  columns: (1.6fr, 1fr),
  gutter: 1.2cm,
  align: horizon,
  [
    The "System 1" and "System 2" describe two ways of thinking.

    #v(0.8em)
    It is a theory from cognitive psychology proposed in the famous book by Daniel Kahneman.
  ],
  image("images/02/thinking-fast-and-slow.jpg", height: 10cm),
)

== System 1 thinking

#grid(
  columns: (1.6fr, 1fr),
  gutter: 1.2cm,
  align: horizon,
  [
    Fast, automatic, intuitive, effortless, and emotional thinking.

    It is responsible for #underline[quick decision-making] and #underline[pattern recognition], often relying on #underline[heuristics and biases].

    #pause
    #v(0.5em)
    #feature-block[System 1 #sym.approx Sub-symbolic AI][
      _This system is *similar to sub-symbolic AI*, as it deals with #underline[learning (and generalising) from data]._
    ]
  ],
  image("images/02/thinking-fast-and-slow.jpg", height: 10cm),
)

== System 2 thinking

#grid(
  columns: (1.6fr, 1fr),
  gutter: 1.2cm,
  align: horizon,
  [
    Slow, deliberate, logical, and analytical thinking.

    It is responsible for complex problem-solving, planning, and reasoning based on rules and explicit knowledge.

    #pause
    #v(0.5em)
    #feature-block[System 2 #sym.approx Symbolic AI][
      _This system is *#underline[analogous to symbolic AI]*, which focuses on using symbols and logic to represent knowledge and solve problems._
    ]
  ],
  image("images/02/thinking-fast-and-slow.jpg", height: 10cm),
)

#focus-slide[
  #uncover(2)[#text(size: 3em, weight: "regular")[Dào]]
  #v(-0.3em)
  #text(size: 4em)[#dao(light: true)]
]

== #dao(light: true)

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  align: horizon + center,
  [
    #text(size: 5em)[#dao()]
    #v(-0.5em)
    #uncover("2-")[#text(size: 1.5em, fill: muted)[The way]]
  ],
  uncover("3-", image("images/02/yin-yang.png", height: 9cm)),
)

== Dào (#dao(light: true)) is "the way"

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  align: horizon + center,
  image("images/02/thinking-fast-and-slow.jpg", height: 7cm),
  uncover("2-")[
    #text(size: 1.5em)[#dao()]
    #image("images/02/yin-yang.png", height: 6cm)
  ],
)

#uncover("3-")[
  #hl[Integrating] both types of AI methods can lead to more effective and #hl[human-like AI] systems, just as human cognition benefits from the #hl[interplay between System 1 and System 2] thinking.
]

== Symbolic vs Subsymbolic AI

#grid(
  columns: (1.3fr, 1fr),
  gutter: 1cm,
  align: horizon,
  [
    #uncover("2-")[Both approaches have their strengths and limitations.]

    #v(1em)
    #uncover("3-")[Many systems try to #underline[combine both] to get the most out of these two worlds.]
  ],
  image("images/02/yin-yang.png", height: 9.5cm),
)

== Hybrid AI -- the "AI Dào"

#steps("s21", (0, 1))

== Hybrid AI -- the "AI Dào"

#speaker-note[Max 50m]
#steps("s22", (0, 1, 2, 3, 4))

== Hybrid AI -- the "AI Dào"

#speaker-note[Max 50m]
#align(center, image("images/02/hybrid-ai-dao.png", height: 10.5cm))

== Symbolic vs Subsymbolic AI

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5cm,
  [
    *Symbolic examples:*
    #pause
    - Rule-based systems (e.g. Expert systems)
    #pause
    - Decision trees
    #pause
    - Logic programming
    #pause
    - Ontologies
    - …
  ],
  [
    #pause
    *Sub-symbolic examples:*
    #pause
    - Artificial Neural Networks
    #pause
    - Reinforcement Learning
    - …
  ],
)

== Symbolic AI (rule-based): strengths

*Strengths:*
#pause
- *Clear and interpretable* representation of knowledge, making it easier to understand and debug
#pause
- *Effective in well-defined domains* with structured and explicit knowledge.
#pause
- Can perform *deductive reasoning* and #underline[handle complex rule-based systems].
#pause
- Can be *less data-intensive* since rules can be provided by domain experts.

== Symbolic AI (rule-based): limitations

*Limitations:*
#pause
- *Difficult to scale* to more complex, real-world problems with ambiguous or noisy data.
#pause
- Requires *manual effort* to create and maintain rules, which can be time-consuming and error-prone.
#pause
- Can *struggle to adapt* to new or changing situations, as it relies on predefined rules.
#pause
- Often *lacks the ability to learn from data*, generalize, or handle uncertainty.

== Sub-Symbolic AI (connectionist, data-driven): strengths

*Strengths:*
#pause
- Can learn from data, *generalize, and adapt* to new situations.
#pause
- Effective in dealing with *noisy*, incomplete, or ambiguous information.
#pause
- Can capture complex patterns and relationships in *large* datasets.
#pause
- *Scalable* and suited for many real-world problems, such as image recognition, sentiment classification, speech recognition, and much more.

== Sub-Symbolic AI (connectionist, data-driven): limitations

#speaker-note[MAX 55m]
#[
#set text(size: 0.9em)

*Limitations:*
#pause
- Require non-trivial amount of *data* and *computational resources*
#pause
- The learned models (e.g., neural networks) can be difficult to interpret and understand, we call them "*black boxes*"
#pause
- *Not-deterministic results.* They may not provide guarantees on performance, robustness, or safety, which can be critical in some applications (e.g., medical, autonomous vehicles).
#pause
- Can be *sensitive to the quality of data*, leading to issues like overfitting or bias.
#pause
- Symbolic/hierarchical knowledge is somehow *missing*
]

#focus-slide[
  #speaker-note[STOP HERE]
  END PART 1
]

// ---------------------------------------------------------------------------
// PART 2
// ---------------------------------------------------------------------------

= Part 2 \ #subtitle["Meaningful" numbers]

#speaker-note[MAX 60m]

#focus-slide[
  #speaker-note[MAX 60m ---- 9:00]
  From numbers to meaning…

  … Let's see the foundations

  #v(1em)
  #uncover(2)[Questions so far?]
]

== NLP

#align(center, image("images/02/s32-step0.pdf", height: 10.5cm))

== NLP

The key element in NLP and #underline[computational] linguistics:

#pause
#v(0.5em)
#align(center, text(size: 1.3em)[#hl[We want to turn text into numbers]])

#pause
#v(1.5em)
Let's see some ways to turn language into numbers

= Tree Kernels \ #subtitle[Leveraging the linguistic structure of text]

#speaker-note[max 3m]

== NLP

In this case, numbers come from a #hl[similarity measure] calculation

#v(0.5em)
#align(center, image("images/02/tree-kernel-formula.png", height: 7.5cm))

== Tree Kernels

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  align: horizon,
  [
    *TKs need:*

    #pause
    + Tree-structured #hl[data representations] \ (e.g. GRCT)

    #pause
    #pause
    + #hl[Fragment] definition \ (e.g. Partial Trees)
  ],
  uncover("3-", image("images/02/tree-grct.png", width: 100%)),
)

= Sparse vector representations \ #subtitle[Statistical numerical representations]

#speaker-note[MAX 1h:20.

Sparse vector representations use high-dimensional vectors where most elements are zero, explicitly encoding features in distinct dimensions (e.g., one-hot encoding or term frequency vectors). In contrast, dense vector representations use lower-dimensional vectors with mostly nonzero values, capturing distributed semantics by encoding meaning through learned patterns (e.g., word embeddings like Word2Vec or BERT).]

== Sparse vectors

#callout[
  Sparse vectors: high-dimensional and with many zeros ("empty" features).

  The information is "sparse" and very much "discrete"

  #v(0.3em)
  #raw("[ 0.  0.  0.  1.  1.  0.  0.  0.  0.  0.  1.  0.  0.  0. ]")
]

== NLP

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: horizon,
  [Corpus:],
  block(stroke: 1pt + rgb("#90BB23"), inset: 0.8em, width: 100%)[
    S#sub[1] #sym.arrow.r The Judge reported \
    S#sub[2] #sym.arrow.r The Court reported
  ],
)

== NLP: Bag-of-words

#align(center)[
  #block(width: 80%, word-table((
    ("1", "1", "1", "0"),
    ("1", "1", "0", "1"),
  )))
  #v(0.5em)
  *"One-hot" (sparse) vectors*
]

== Bag-of-words with sklearn

#grid(
  columns: (1.5fr, 1fr),
  gutter: 1em,
  [
    #text(size: 0.75em, fill: muted)[`sklearn`]
    #set text(size: 0.8em)
    ```python
    import CountVectorizer

    # My dataset
    corpus = ["The Judge reported", "The Court reported"]

    # My BoW model vectorizer
    vectorizer = CountVectorizer()

    # Convert text to BoW representation
    bow_matrix = vectorizer.fit_transform(corpus)
    ```
  ],
  align(horizon)[
    #pause
    *You can do it in 4 lines of code*
    #v(1em)
    #pause
    #callout[
      If you print this, it will look like a 2D array/matrix:
      #v(0.2em)
      *`[ [1 1 1 0]`* \
      *`  [1 1 0 1] ]`*
    ]
  ],
)

== NLP: Bag-of-words

#steps("s42", (1, 2), height: 7cm)

#uncover("3-")[
  #set text(size: 0.9em)
  For example:
  - #underline[k-nearest neighbors (k-NN)], #underline[k-means clustering] #sym.arrow.r *points*
  - #underline[Cosine similarity] #sym.arrow.r *directions*
]

== Term Frequency-Inverse Document Frequency

#[
#set text(size: 0.9em)
Statistical measure to calculate the relevance of a word (*w*) in a collection of documents (e.g., sentences *s#sub[1], s#sub[2], …, s#sub[n]*)

The #underline[easiest way] to calculate it:


#grid(
  columns: (1.4fr, 1fr),
  row-gutter: 1em,
  align: horizon,
  text(fill: tfc, $display("tf"_(s_n)(w) = ("frequency of word" w "within sentence" s_n)/("total number of words within sentence" s_n))$),
  uncover("2-", text(fill: tfc, weight: "bold")[LOCAL: importance (within the sentence)]),
  text(fill: idfc, $display("idf"(w) = ln(("total n. of sentences")/("n. of sentences containing" w)))$),
  uncover("3-", text(fill: idfc, weight: "bold")[GLOBAL: rarity in the corpus]),
)

#v(0.5em)
#align(center, callout(fill: lime, width: auto)[
  $#text(fill: tfidfc, $"tfidf"_(s_n)(w)$) = #text(fill: tfc, $"tf"_(s_n)(w)$) dot #text(fill: idfc, $"idf"(w)$)$
])
]

== Normalized TF-IDF (using l2 norm)

#speaker-note[Euclidean normalization is good because it will give us values between 0 and 1.

The L2 norm formula is the square root of the sum of the squares of each value]

#[
#set text(size: 0.85em)
#underline[Scikit-learn uses this method:]

#align(center)[
  #text(fill: tfc, $"tf"_(s_n)(w) = "frequency of word" bold(w) "within sentence" bold(s_n)$)

  #text(fill: idfc, $display("idf"(w) = ln((1 + "total n. of sentences")/(1 + "n. of sentences containing" w)) + 1)$)
]

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: horizon,
  callout(fill: peach, width: auto)[_#underline[Step 1]_ #h(0.5em) $"tfidf"_(s_n)(w)$ _(non normalized)_],
  $#text(fill: tfidfc, $"tfidf"_(s_n)(w)$) = #text(fill: tfc, $"tf"_(s_n)(w)$) dot #text(fill: idfc, $"idf"(w)$)$,
)

*We then apply the l2 normalization (Euclidean normalization):*

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: horizon,
  callout(fill: lime, width: auto)[_#underline[Step 2]_ #h(0.5em) $"TFIDF"_(s_n)(w)$ _(normalized)_],
  $display("TFIDF"_(s_n)(w) = #text(fill: tfidfc, $"tfidf"_(s_n)(w)$) / sqrt(sum_(w = w_0)^(w_j) #text(fill: tfidfc, $"tfidf"_(s_n)(w_j)$)^2))$,
)
]

== TF-IDF

#callout(fill: lime, width: auto)[
  _#underline[Step 1]_ #h(0.5em)
  $#text(fill: tfidfc, $"tfidf"_(s_n)(w)$) = #text(fill: tfc, $"tf"_(s_n)(w)$) dot #text(fill: idfc, $"idf"(w)$)$
]

#let c1 = $1 dot (ln(3/3) + 1) = 1$
#let c14 = $1 dot (ln(3/2) + 1) = 1.4$
#let c0 = $0 dot (ln(3/2) + 1) = 0$

#word-table(size: 0.8em, (
  (c1, c1, c14, c0),
  (c1, c1, c0, c14),
))

#pause
#grid(
  columns: (1fr, auto),
  gutter: 0.6em,
  align: horizon,
  callout(fill: lime, width: auto)[
    #set text(size: 0.85em)
    _#underline[Step 2]_ #h(0.5em)
    $"TFIDF"_(s_n)(w) = ("tfidf"_(s_n)(w)) / sqrt(sum_(w = w_0)^(w_j) "tfidf"_(s_n)(w_j)^2) = ("tfidf"_(s_n)(w)) / bold("SQRT"_(s_n))$
  ],
  block(stroke: 1pt, inset: 0.4em, text(size: 0.65em)[
    $bold("SQRT"_(s_1)) = sqrt(1^2 + 1^2 + 1.4^2 + 0^2) = sqrt(3.96) = 1.98$ \
    $bold("SQRT"_(s_2)) = sqrt(1^2 + 1^2 + 0^2 + 1.4^2) = sqrt(3.96) = 1.98$
  ]),
)

#word-table(size: 0.8em, (
  ($1 \/ "SQRT"_(s_1) = 0.50$, $1 \/ "SQRT"_(s_1) = 0.50$, $1.4 \/ "SQRT"_(s_1) = 0.70$, $0 \/ "SQRT"_(s_1) = 0$),
  ($1 \/ "SQRT"_(s_2) = 0.50$, $1 \/ "SQRT"_(s_2) = 0.50$, $0 \/ "SQRT"_(s_2) = 0$, $1.4 \/ "SQRT"_(s_2) = 0.70$),
))

== From Bag-of-words to TF-IDF

#align(center)[
  #block(width: 70%, word-table((
    ("1", "1", "1", "0"),
    ("1", "1", "0", "1"),
  )))
  #pause
  #text(size: 2em, fill: teal)[#sym.arrow.b.double]
  #block(width: 70%, word-table((
    ([*0.50*], [*0.50*], [*0.70*], [*0*]),
    ([*0.50*], [*0.50*], [*0*], [*0.70*]),
  )))
]

== TF-IDF with sklearn

#speaker-note[MAX 1h 50m

STOP HERE !!!]

#grid(
  columns: (1.5fr, 1fr),
  gutter: 1em,
  [
    #text(size: 0.75em, fill: muted)[`sklearn`]
    #set text(size: 0.8em)
    ```python
    import TfidfVectorizer

    # my data
    corpus = ["I hate pizza", "I love pizza"]

    # my super handy vectorizer
    vectorizer = TfidfVectorizer()

    # my super meaningful vectors
    vectors = vectorizer.fit_transform(corpus)
    ```
  ],
  align(horizon)[
    #pause
    *You can do it in 4 lines of code*
    #v(1em)
    #pause
    #callout[
      If you print this, it will look like a 2D array/matrix:
      #v(0.2em)
      *`[ [`*`0.5  0.5  `*`0.7`*`  0.  `*`]`* \
      *`  [`*`0.5  0.5  0.   `*`0.7 ] ]`*
    ]
  ],
)

= Dense Vector Representations ("Embeddings") \ #subtitle[Learning numerical representations from data]

== Sparse vs dense vectors

#speaker-note[MAX 1h 50m

STOP HERE !!!]

#[
#set text(size: 0.9em)
#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align: horizon,
  [
    #uncover("1-")[
      #callout[
        Sparse vectors: high-dimensional and with many zeros ("empty" features).

        The *information is "sparse"* and very much *"discrete"*

        #raw("[ 0.  0.  0.  1.  1.  0.  0.  0.  0.  0.  1.  0.  0.  0. ]")
      ]
    ]
    #uncover("2-")[
      #callout(fill: lime)[
        Dense vectors: #hl[distributed semantics] (the information is more *"continuous"*)

        #raw("[ 0.23  0.12  0.21  0.14  0.17  0.03 ]")
      ]
    ]
  ],
  [
    #uncover("3-", image("images/02/discrete.png", height: 3.8cm))
    #uncover("4-", image("images/02/continuous.png", height: 3.8cm))
  ],
)
]

== Embeddings: Word2vec

#align(center, image("images/02/word2vec-space.png", height: 9cm))
#ref-note[Reference: Mikolov 2013, "Efficient Estimation of Word Representations in Vector Space"]

== Embeddings: Word2vec

Word2vec

#v(1em)
#align(center, image("images/02/king-man-woman-queen.png", width: 85%))

== Embeddings: Word2vec

Word2vec

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align: horizon,
  [
    #set text(size: 0.9em)
    `vector("King")  = [0.8, 0.2, 0.5]` \
    #pause
    `vector("Man")   = [0.7, 0.1, 0.4]` \
    #pause
    `vector("Woman") = [0.6, 0.3, 0.6]`

    #v(0.5em)
    #pause
    `vector("King") - vector("Man") + vector("Woman")`

    #pause
    ```
    [0.8 - 0.7 + 0.6,
     0.2 - 0.1 + 0.3,
     0.5 - 0.4 + 0.6]   =   [0.7, 0.4, 0.7]
    ```
  ],
  uncover("6-", image("images/02/queen.png", height: 6cm)),
)

== Embeddings: Word2vec

#steps("s53", (2, 4, 5, 7, 8, 9, 10))

== Embeddings: Word2vec

#grid(
  columns: (1fr, 1fr),
  gutter: 2cm,
  align: center + horizon,
  image("images/02/cbow.png", height: 8cm),
  image("images/02/skip-gram.png", height: 8cm),
)

== Embeddings: Word2vec

In the *CBOW model*, the goal is to predict the target word given the context words within a certain window.

The context words are combined and used as input to the neural network, which then predicts the target word.

#v(0.8em)
In the *Skip-Gram model*, the goal is reversed.

The target word is used as input to the neural network, which then predicts the context words within a certain window.

#ref-note[Reference: Mikolov 2013, "Efficient Estimation of Word Representations in Vector Space"]

== Embeddings: Word2vec

#align(center, image("images/02/word2vec-space.png", height: 9cm))
#ref-note[Reference: Mikolov 2013, "Efficient Estimation of Word Representations in Vector Space"]

#focus-slide[
  #speaker-note[STOP HERE]
  END PART 2
]

// ---------------------------------------------------------------------------
// PART 3
// ---------------------------------------------------------------------------

= Part 3 \ #subtitle[LLMs]

#speaker-note[STOP HERE]

= LLMs \ #subtitle[A first glance]

== LLMs

#steps("s60", (0, 1, 2, 3, 4, 5, 6), width: 100%, height: auto)

== LLMs: pre-training and post-training

#speaker-note[MAX 25m]
#steps("s61", (1, 2, 3, 4, 5, 6, 7, 8))

== What we can do with LLMs

#speaker-note[MAX 25m]
#steps("s62", (0, 1, 2, 3, 4, 5, 6, 7, 8))

== LLMs: model sizes

#speaker-note[NO / max 22m]
#steps("s63", (0, 1))

== LLMs: model sizes

#speaker-note[NO / max 22m]
#steps("s64", (0, 1), width: 100%, height: auto)

== LLMs

#speaker-note[max 22m]
#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  align: center + horizon,
  uncover("3-", image("images/02/swiss-knife.png", width: 100%)),
  [
    #hl[WHY THIS EXPLOSIVE IMPACT?]

    #v(1em)
    #uncover("2-")[because LLMs are #underline[reusable]]
  ],
)

== Reusable and multipurpose

#align(center, image("images/02/reusable-1.png", height: 10cm))

== Reusable and multipurpose

#align(center, image("images/02/reusable-2.png", width: 100%))

== RLHF/DPO/GPRO/ORPO

#speaker-note[60 m]
#steps("s68", (1,))

== LLMs

#steps("s69", (0, 1, 2, 3, 4, 5))

== LLMs

*But we will see this (and more things) together on October 8*

#v(2em)
#align(center, text(size: 1.5em)[*Questions?*])

#focus-slide[
  THANKS

  #v(0.5em)
  #text(size: 0.7em)[Let's grab a coffee #fa-mug-hot()]

  #v(1em)
  #text(size: 0.5em)[#raw("davide.liga@uni.lu")]
]
