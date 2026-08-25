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
    subtitle: [Paper List],
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


#let paper(title, authors, year, abstract, url) = [
#block(
inset: (x: 0.8em, y: 0.55em),
radius: 0.4em,
fill: luma(245),
width: 100%,
)[
#text(weight: "bold", size: 1.05em)[#title]
#v(-0.5em)
#text(size: 0.75em, fill: gray)[#authors · #year] 
#v(0.2em)
#text(size: 0.8em)[#abstract]
#v(0.2em)
#link(url)[#text(size: 0.75em, fill: blue)[#url]]
]
#v(0.6em)
]

= Paper List

== Generative AI (Part 1)

#slide[
  #paper(
    [Efficient Estimation of Word Representations in Vector Space],
    [Tomas Mikolov et al.],
    2013,
    [Introduces word2vec, a simple and efficient method for learning dense vector representations of words from large text corpora. The resulting embeddings capture useful semantic and syntactic relationships between words.],
    "https://arxiv.org/pdf/1301.3781",
  )

  #paper(
    [Attention Is All You Need],
    [Ashish Vaswani et al.],
    2017,
    [Introduces the Transformer, an architecture based on attention mechanisms, removing the need for recurrent or convolutional layers. It achieves strong results in machine translation while allowing much more parallel training, opening the way for modern large language models.],
    "https://arxiv.org/abs/1706.03762",
  )
]

== Generative AI (Part 2)

#slide[
  #paper(
    [Language Models are Unsupervised Multitask Learners (GPT‑2)],
    [Alec Radford et al.],
    2019,
    [Shows that large Transformer language models trained with a simple next‑token objective can perform a wide range of NLP tasks in a zero‑shot setting, without task‑specific supervision.],
    "https://cdn.openai.com/better-language-models/language_models_are_unsupervised_multitask_learners.pdf",
  )

  #paper(
    [Language Models are Few‑Shot Learners (GPT‑3)],
    [Tom B. Brown et al.],
    2020,
    [Demonstrates that scaling up Transformer language models to hundreds of billions of parameters leads to strong few‑shot performance on many NLP benchmarks using only in‑context examples as prompts.],
    "https://arxiv.org/abs/2005.14165",
  )
]

== Deep Learning (Part 1)

#slide[
  #paper(
    [Gradient‑Based Learning Applied to Document Recognition],
    [Yann LeCun et al.],
    1998,
    [Introduces convolutional neural networks for handwritten digit recognition (LeNet‑5), showing how gradient‑based learning and weight sharing enable robust visual pattern recognition.],
    "http://yann.lecun.com/exdb/publis/pdf/lecun-98.pdf",
  )

  #paper(
    [ImageNet Classification with Deep Convolutional Neural Networks],
    [Alex Krizhevsky et al.],
    2012,
    [Shows that large convolutional networks trained on GPUs can dramatically outperform previous methods on ImageNet, marking the breakthrough of deep learning in large‑scale computer vision.],
    "https://proceedings.neurips.cc/paper_files/paper/2012/file/c399862d3b9d6b76c8436e924a68c45b-Paper.pdf",
  )
]

== Deep Learning (Part 2)

#slide[
  #paper(
    [Deep Residual Learning for Image Recognition],
    [Kaiming He et al.],
    2016,
    [Introduces residual networks with skip connections, allowing training of very deep architectures and achieving state‑of‑the‑art results on ImageNet and other benchmarks.],
    "https://arxiv.org/abs/1512.03385",
  )

  #paper(
    [BERT: Pre‑training of Deep Bidirectional Transformers for Language Understanding],
    [Jacob Devlin et al.],
    2019,
    [Proposes BERT, a bidirectional Transformer pre‑trained with masked language modeling and next‑sentence prediction, setting new SOTA on a wide range of NLP tasks.],
    "https://arxiv.org/abs/1810.04805",
  )
]

== Deep Reinforcement Learning (Part 1)

#slide[
  #paper(
    [Human‑level Control through Deep Reinforcement Learning],
    [Volodymyr Mnih et al.],
    2015,
    [Combines Q‑learning with deep convolutional networks to play Atari 2600 games directly from pixels, achieving human‑level performance on many titles and introducing the Deep Q‑Network (DQN) architecture.],
    "https://www.nature.com/articles/nature14236",
  )

  #paper(
    [Mastering the Game of Go with Deep Neural Networks and Tree Search],
    [David Silver et al.],
    2016,
    [Presents AlphaGo, which combines deep neural networks and Monte Carlo tree search to defeat a top professional Go player, solving a long‑standing challenge in AI game playing.],
    "https://www.nature.com/articles/nature16961",
  )
]

== Deep Reinforcement Learning (Part 2)

#slide[
  #paper(
    [Mastering Chess and Shogi by Self‑Play with a General Reinforcement Learning Algorithm],
    [David Silver et al.],
    2017,
    [Shows that a single reinforcement learning algorithm, AlphaZero, can master chess, shogi and Go from scratch using self‑play and deep neural networks without human expert data.],
    "https://arxiv.org/abs/1712.01815",
  )

  #paper(
    [Proximal Policy Optimization Algorithms],
    [John Schulman et al.],
    2017,
    [Introduces PPO, a simple and robust policy gradient method that clips policy updates, becoming a widely used baseline for deep reinforcement learning in continuous and discrete control tasks.],
    "https://arxiv.org/abs/1707.06347",
  )
]

== Neuro‑Symbolic AI (Part 1)

#slide[
  #paper(
    [Robust Logics],
    [Leslie G. Valiant],
    2000,
    [Develops a framework in which logical rules can be learned and applied robustly in the presence of noise, providing early theoretical foundations for combining symbolic logic and statistical learning.],
    "https://doi.org/10.1016/S0004-3702(99)00069-0",
  )

  #paper(
    [Probabilistic (Logic) Programming Concepts],
    [Luc De Raedt, Angelika Kimmig],
    2015,
    [Surveys the key ideas behind probabilistic logic programming, showing how logical and probabilistic reasoning can be combined within a unified programming framework.],
    "https://doi.org/10.1007/s10994-015-5494-z",
  )
]

== Neuro‑Symbolic AI (Part 2)

#slide[
  #paper(
    [Learning Explanatory Rules from Noisy Data],
    [Richard Evans, Edward Grefenstette],
    2018,
    [Proposes a differentiable inductive logic programming approach that can learn human‑readable logical rules from noisy data using gradient‑based optimisation, bridging ILP and deep learning.],
    "https://jair.org/index.php/jair/article/view/11196",
  )

  #paper(
    [The Neuro‑Symbolic Concept Learner: Interpreting Scenes, Words, and Sentences from Natural Supervision],
    [Jiayuan Mao et al.],
    2019,
    [Combines neural perception modules with a symbolic reasoning core to learn visual concepts and answer complex questions about scenes from weak, natural supervision signals.],
    "https://openreview.net/forum?id=rJgMlhRctm",
  )
]