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

#slide[
= Paper List

#let paper(title, authors, year, abstract) = [
#block(
inset: (x: 0.8em, y: 0.55em),
radius: 0.4em,
fill: luma(245),
width: 100%,
)[
#text(weight: "bold", size: 1.05em)[#title] 
#text(size: 0.75em, fill: gray)[#authors · #year] 
#v(0.25em)
#text(size: 0.8em)[#abstract]
]
#v(0.6em)
]

#paper(
[Efficient Estimation of Word Representations in Vector Space],
[Tomas Mikolov, Kai Chen, Greg Corrado, Jeffrey Dean],
2013,
[Introduces word2vec, a simple and efficient method for learning dense vector representations of words from large text corpora. The resulting embeddings capture useful semantic and syntactic relationships between words.]
)

#paper(
[Attention Is All You Need],
[Ashish Vaswani et al.],
2017,
[Introduces the Transformer, an architecture based on the so-called “attention mechanisms”, removing the need for recurrent or convolutional layers. It achieves strong results in machine translation while allowing much more parallel training. This opened the way for the development of modern LLMs.]
)
]
