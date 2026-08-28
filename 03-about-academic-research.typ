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


== Artefacts (Part 1)

* Shareable resources *

- an idea is not a scientific result per se
- a scientific result is something that
  - is understandable by other researchers
  - sharaeble and accessible by members of the scientific community
  - has enough information upon its results and therefore _can be *REPRODUCED*_ and _possibly *CONFUTED*_ by other researchers#cite(label("popper2002"))

== Artefacts (Part 2)

* Articles & Books*

- articles (a.k.a. papers) sre the primary sharable form of scientific results, collected and published:
  - in scientific journals
  - in proceedings of scientific conferences and workshops
  - as chapter of collections in books
- when _stable_, results are often presented in extended form in scientific monographies


== Publication Process

* Public control *
- before something is published:
  - an article is _submitted_ to a _*review process*_
  - review is conducted by experts in the field (a.k.a. _peers_)
  - in case the article is considered worth for publication, it might anyway be revised according to the reviewer’s indications, and finally accepted for publication
- when published, the article represents a piece of _scientific literature_
- public presentation is essential in case of conferences or workshops


== Publishers (Part 1)

* Scientific literature is published by publishers *

- once survived the peer review step, proceedings, journal issues, collections and monographies are ready as scientific products
  - _but not immiediately as *typographic* ones_
- often, publishers intervene on the form of the scientific material before it is published
  - language, formatting, cover, illustrations, ...
  - with the consent of authors / editors

== Publishers (Part 2)

* The role of publishers *

- Goals
  - earn money
  - earning reputation through high-quality publications (to earn more money)
- publishers dictate the timing and pace of publication, the total number og pages
  - provide suggestions on the general goals of a published volume / journal
- Publishers also
    - take care of organisational issues, and govern social & economical factors
    - take care of dissemination
    - rule _access_ to scientific litterature

// Skip dissemination

== Citations (Part 1)

* The role of citations *

- the main measure of dissemination is _*citation*_
  - paper A cites paper B in its _bibliography_ or _reference_ section
- bibliography is important to understand the paper
  - context, background, and related work (we do not want to reinvent the wheel)
- citations are a measure of scientific _*impact*_
  - citation is not necessarily a sign od approval!
  - it is a good measure of the _relevance_ of a scientific result

== Citations (Part 2)


#grid(
  columns: 2,
  gutter: 2cm,

  [
    * Web resources for paper and citations *

    - _Google Scholar_
      - #link("https://scholar.google.com")[https://scholar.google.com]
    - _DBLP_
      - #link("https://dblp.org")[https://dblp.org]
    - _Web of Science_
      - #link("https://www.webofscience.com")[https://www.webofscience.com]
    - _Scopus_
       - #link("https://www.scopus.com")[https://www.scopus.com]
  ],
  [
    #align(center)[
        #image("images/03/citation-stonks.jpg", width: 95%)
    ]
  ]
)

== Access (Part 1)

* Online access to sceintific literature *

- traditional means are still widespread
  - participation to scientific events
  - access to printed materials
- _online_ access has gained more and more ground
- Internet has obviously a key role
  - it allows an unprecedented flow of dissemination and access to technical results (publised or yet unpublished)
  - and sometimes it is the only way to access them, especially after COVID-19
- all international publishers have online publication sites
- most of the relevant material is accessible online (but not always for free)

== Access (Part 2)

#grid(
  columns: 2,
  gutter: 2cm,

  [
    * Open Access *

    - responds to the fundamental need of science to be shared
    - institutions can become publishers
    - publishers can make it part of their business model making authors & institutions pay for public access
    - Budapest Open Access Initiative#cite(label("BOAI2002"))
    - Berlin Declaration on Open Access#cite(label("MaxPlanck2003"))
  ],
  [
    * Paywall *

    - imposed by publishers as part of their business model
    - institutions mostly pay huge money to access some
    - most scientific literature is probuced by publicly-funded institutions
    - yet they have to pay in order to access their own products behind paywalls
  ]
)

== Digital Repositories

#grid(
  columns: 2,
  gutter: 2cm,

  [
    * What for *

    - share results before any form of scientific publications
    - make publicly shareable versions of scientific papers behind paywall
    - some examples:
      - arXiv #link("https://arxiv.org")[https://arxiv.org]
      - Zenodo #link("https://zenodo.org")[https://zenodo.org]
  ],
  [
    * Limitations *

    - in general just _technical reports_ or _preprints_
    - without validation by the scientific community, they are not scientific papers
    - unless the paper has been published properly elsewhere
  ]
)

= Dealing with papers

== Common structures

* Typical paper in AI / CS *

- _Abstract_ - brief summary of the paper
- _Introduction_ - context and motivation
- _Related Work / Background_ - full description of related work
- _Methodology_ - description of the proposed approach
- _Experiments / Results_ - description of the experimental setup and results
- _Discussion_ - analysis of the results and possible limitations
- _Conclusion_ - summary of the contributions and future work

== How to read a paper

#grid(
  columns: 2,
  gutter: 2cm,

  [
    * My personal suggestion *

    - start from title and abstract
    - jump to the conclusion
    - go back to introduction
    - read until the end
    - supplementary materials?
    - if needed, read a second time

  ],
  [
    * What to do while reading *

    - understand asap the context of the paper
    - understand authors' claims / contribution(s)
    - check if the claims are later confirmed
    - take notes of the crucial points
    - if you do not understand something, check if there is a reference with more details
  ]
)


== How to recognise a good paper (Part 1)

* Rules of thumb *

- positive correlation between _number of citations_ and _quality_ of the paper
  - in doing so, have a look at the _year_ of publication!
- you should be able to grasp everything at the first reading
- if there are experiments
  - they should be reproducible
  - datasets and code should be public
  - there must be statistical tests
- comparison with other approaches in the literature
- the paper is in a _top-tier_ conference or journal in the field

== How to recognise a good paper (Part 2)

* Scimago Journal & Country Rank (SJR) *

#grid(
  columns: 2,
  gutter: 2cm,

  [
    #align(center)[
        #image("images/03/scimago-ranking-example-1.png", width: 90%)
    ]
  ],
  [
    #align(center)[
        #image("images/03/scimago-ranking-example-2.png", width: 95%)
    ]
  ]
)

== How to recognise a good paper (Part 3)

* ICORE Conference Ranking *

#align(center)[
    #image("images/03/icore-ranking-example.png", width: 95%)
]


== Presenting a paper (Part 1)

* Objectives *

- you must transmit in a clear way:
  - the _context_ where the paper is set
  - the _problem addressed_ by the paper
  - the proposed solution
  - how the solution is _validated_
  - results and findings
- the audience is composed of your peers
- they are supposed to understand you
- you can use slides to support your presentation

== Presenting a paper (Part 2)

* Slides *

- you are presenting, the slides are just a support!
- consider around 1 slide per minute of presentation
  - of course, there are exeptions and you can go for 2-3 minutes per slide
- avoide dense slides and huge wall of text
  - no one reads wall of text!
  - these slides are for teaching, so here you can find more text
- prefer figures, diagrams, tables

