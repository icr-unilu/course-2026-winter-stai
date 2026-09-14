#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
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
  aspect-ratio: "4-3",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [STAI],
    subtitle: [Generative AI],
    author: author_list(
      (
        (text(fill: rgb("#eb811b"), weight: "bold")[Souvick Das], "souvick.das@uni.lu"),
        ("Matteo Magnini", "matteo.magnini@uni.lu"),
        ("Davide Liga", "davide.liga@uni.lu"),
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


#set text(font: "Fira Sans", weight: "light", size: 24pt)
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

// Slide 01 - Text only
== GenAI: Generative Artificial Intelligence

- *Definition:* AI algorithms that automatically generate new content, learned from large datasets of existing material.
- *Generated content types:* text, images, audio, video, and source code.
- *Purpose:* Automate content creation across multiple media formats.
- *Ethical & responsible use:* A formal policy governs the use of GenAI in teaching and research activities.
- *Key consideration:* Responsible use requires awareness of accuracy, bias, copyright, and academic integrity.

// Slide 02 - Image only
== GenAI through Foundation Models (FM)

#align(center)[#image("images/genai/Slide02.png", width: 100%)]

// Slide 03 - Image + Text
== Foundation Models vs. Large Language Models

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    - *Pretrained:* Learn general representations from broad data.
    - *Adaptable:* Can be specialized with prompts, fine-tuning, or tools.
    - *LLMs:* A language-focused subset of foundation models.
  ],

  [#align(center)[#image("images/genai/slide03.png", width: 100%)]],
)

// Slide 04 - Image only
== Basic Operation of LLMs

#align(center)[#image("images/genai/slide04.png", width: 100%)]

// Slide 05 - Image only
== Combining LLMs and Symbolic AI for Robust Reasoning

#align(center)[#image("images/genai/slide05.png", width: 100%)]

// Slide 06 - Image only
== GenAI with an As-a-Service Consumption Model

#align(center)[#image("images/genai/slide06.png", width: 100%)]

// Slide 07 - Image only
== GenAI-as-a-Service (GenAIaaS) Framework

#align(center)[#image("images/genai/slide07.png", width: 100%)]

// Slide 08 - Image only
== Our Thinking Operates in Two Systems

#align(center)[#image("images/genai/page08.png", width: 100%)]

// Slide 09 - Image only
== GenAI Learning Cycle: Online Illusion vs. Offline Reality

#align(center)[#image("images/genai/page09.png", width: 100%)]

// Slide 10 - Image only
== GenAI Learning Cycle

#align(center)[#image("images/genai/page10.png", width: 100%)]

// Slide 11 - Image + Text
== GenAI Learning Cycle: Data Flows & Consequences

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    - *Sampling bias:* Rare or niche information may be underrepresented or omitted.
    - *Privacy:* Do not submit sensitive or confidential information without authorization.
    - *Purpose:* Automate content creation across multiple media formats.
    - *Copyright and IP:* Review data rights and generated content before reuse or publication.
  ],

  [#align(center)[#image("images/genai/page11.png", width: 100%)]],
)

// Slide 12 - Image only
== AI Research & Developer Toolkit

#align(center)[#image("images/genai/page12.png", width: 100%)]

// Slide 13 - Image only
== Engineering with Generative AI: Governance & Applications

#align(center)[#image("images/genai/page13.png", width: 100%)]

// Slide 14 - Image only
== LLM Agent Orchestration Architecture

#align(center)[#image("images/genai/page14.png", width: 100%)]

// Slide 15 - Image + Text
== Concept: Prompt Engineering

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    - *Definition:* Designing, testing, and refining inputs to LLMs to reliably elicit accurate and useful outputs.
    - *Core techniques:*
      - Zero-shot
      - Few-shot
      - Chain-of-thought (CoT)
      - ReAct
      - Tree-of-thoughts
      - Role-based prompting
  ],

  [#align(center)[#image("images/genai/page15.png", width: 100%)]],
)

// Slide 16 - Image only
== Concept: Agents Calling External Tools

#align(center)[#image("images/genai/page16.png", width: 100%)]

// Slide 17 - Image only
== Model-Context Protocol (MCP) Architecture

#align(center)[#image("images/genai/page17.png", width: 100%)]

// Slide 18 - Image only
== Concept: Retrieval-Augmented Generation (RAG)

#align(center)[#image("images/genai/page18.png", width: 100%)]

// Slide 19 - Image only
== LLM-as-a-Judge Evaluation Workflow

#align(center)[#image("images/genai/page19.png", width: 100%)]

// Slide 20 - Image only
== Corrective RAG Agentic Workflow

#align(center)[#image("images/genai/page20.png", width: 100%)]

// Slide 21 - Image only
== RAG Evaluation: What Should We Measure?

#align(center)[#image("images/genai/page21.png", width: 100%)]

// Slide 22 - Image only
== RAG Evaluation Metrics: RAGChecker and Ragas

#align(center)[#image("images/genai/page22.png", width: 100%)]

// Slide 23 - Image only
== RAG Pipeline Failure Points and Remedies

#align(center)[#image("images/genai/page23.png", width: 100%)]

// Slide 24 - Image only
== Multi-Agent Research and Writing Workflow

#align(center)[#image("images/genai/page24.png", width: 100%)]

// Slide 25 - Image only
== How Can LLM Systems Be Attacked?

#align(center)[#image("images/genai/page25.png", width: 100%)]

// Slide 26 - Text only
== Secure the Entire AI System — Not Only the Model

- *Prompt-Injection Prevention*
  - Prompt classification: detect unsafe, malicious, off-topic, or sensitive prompts
  - Filter and sanitize suspicious inputs
  - Test direct and indirect prompt-injection attacks in sandbox
- *Guardrails*
  - Fine-tune base model for safety policies and refusal behavior
  - Enforce structured output formats
  - Use dedicated models for content safety, jailbreak detection, topic control, PII detection, or fact checking
  - Ground answers in authorized evidence
  - Require human approval for high-impact actions

// Slide 27 - Text only
== Secure the Entire AI System — Access & Monitoring

- *Access and Data Security*
  - Apply least-privilege access to tools and data
  - Use scoped, short-lived credentials
  - Enforce document-level access control in RAG
  - Protect secrets, PII, and confidential information
- *Monitoring*
  - Log prompts, retrievals, tool calls, and outputs
  - Detect abnormal access or tool-use patterns
  - Rate-limit requests and sensitive actions
  - Maintain audit trails and emergency stop controls

// Slide 28 - Text only
== Do it Yourself — Hands-on Projects

- *1. Self-Correcting RAG Assistant*
  - Retrieves relevant documents for a question
  - Checks whether the retrieved context is sufficient
  - Reformulates the query or searches again when evidence is weak
- *2. Research Assistant*
  - Orchestrator agent organizes research problems into multiple steps
  - Researcher and reviewer agent accumulate content, figure out research questions, produce detailed methodology
  - Human can brainstorm with the team
  - Experiment planner agent prepares experiment plan and evaluation direction
  - A detailed workplan is prepared

// Slide 29 - Text only
== Do it Yourself — Agentic RAG Evaluation Assistant

- Generates test questions from a document collection
- Runs retrieval and generation experiments
- Evaluates results with Ragas or RAGChecker-style metrics
- Reports retrieval misses, hallucinations, and citation failures

// Final Slide - Thank You
== Thank You

#align(center + horizon)[
  #text(size: 36pt, weight: "bold", fill: rgb("#eb811b"))[Thank You!]
  #v(1em)
  #text(size: 20pt)[Questions & Discussion]
]
