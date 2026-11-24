---
name: epic-description
description: Use when writing or revising an epic description document, or when the user asks for an "epic description", "epic writeup", or to summarize/plan work as an epic. Produces a concise, scannable four-section layout (Background, Approach, Open Questions, Acceptance Criteria) instead of verbose prose with code references.
---

# Epic Description Writing

Epics describe a body of development work for a human reader who must understand the problem and scope
quickly. Optimize for a reader scanning the document, not for exhaustive justification.

## Layout

Use exactly these sections, in this order. No metadata table, no other sections.

```markdown
# <Epic Title>

## Background

<prose>

## Approach

- <bullet>

## Open Questions

- <bullet>

## Acceptance Criteria

- <bullet>
```

### Background

Prose only, no bullets. Cover three things, each as its own paragraph so a reader can tell them apart at a
glance, without adding subheadings:

- The problem statement: what is wrong or missing today, and why it matters.
- The high-level goal: what this epic sets out to achieve.
- The justification: why this direction is the right one.

One paragraph per topic is the default. Split a topic into two paragraphs only if it is too long to read
comfortably as one block; never merge two topics into a single paragraph. Keep each paragraph to the minimum
needed to convey its topic. Do not describe the current implementation in detail, do not narrate code paths,
do not list file names, class names, or function names.

### Approach

Bullet list. Action items, suggested approach, and decisions already made about how the work will be done.
Each bullet is one sentence, one decision or one action item. If a decision is genuinely undecided, it
belongs in Open Questions instead, not hedged here.

### Open Questions

Bullet list. Design decisions that still need to be made before or during implementation. Each bullet states
one open decision. Do not use this section to restate scope exclusions — that is not an open question, it is
scope, and scope is handled by Acceptance Criteria (see below).

### Acceptance Criteria

Bullet list. The concrete, required scope of the development work, stated positively. A reader must be able
to tell exactly what needs to be built/changed from this list alone.

Never add notes about what is out of scope, deferred, or explicitly excluded, anywhere in the document. If
something is excluded, simply do not mention it. Out-of-scope notes invite scope creep in review and add
noise without adding requirements.

## Language rules

- Concise and on point. No filler, no hedging ("might", "could potentially", "it's worth considering"), no
  over-explaining.
- One piece of information per sentence. No mid-sentence clarifying asides, no parenthetical lists, no
  em-dash digressions that bolt a second thought onto a sentence already making a point. If a sentence needs
  a parenthetical to add a distinct fact, split it into two sentences instead.
- Bullets are short, ideally a single sentence. If a bullet needs two sentences, reconsider whether it is
  really one bullet.
- No references into code: no class names, function names, variable names, D-Bus interface names, or line
  numbers. High-level components may be named generically (e.g. "the measurement service", "the
  configuration loader") but never by their literal identifier in source. If a component has no good generic
  name, a directory path may be used to identify it (e.g. `src/modules/payments/`), but avoid pointing at
  specific files, classes, or functions within it. Directory paths and component/library names may also be
  used prescriptively, to state how the new work should be organized (e.g. which directory or component a
  new piece of functionality should live in), not only to refer to existing code. Specific file paths may be
  named when the epic requires a new file to be created (e.g. a new config schema file, a new resource
  definition), since there is no existing identifier to abstract away.
- No links or cross-references to other documents, epics, or files. The document must stand alone since it
  is copy-pasted elsewhere.
- Do not wrap lines manually. Write each paragraph and each bullet as a single long line; let the renderer
  wrap it. Do not insert manual line breaks mid-sentence or mid-bullet.

## Self-check before finishing

Re-read the draft and verify:

- Background has no bullets and is pure prose.
- Every bullet in Approach/Open Questions/Acceptance Criteria is one sentence.
- No sentence anywhere names a specific existing file, class, function, or other code identifier (directory
  paths for otherwise-unnamed components, and paths to new files that need to be created, are acceptable).
- No sentence anywhere says something is "out of scope", "deferred", "not covered", or similar.
- No links to other files or documents appear anywhere.
- No paragraph or bullet contains a manual line break in the middle of a sentence.
</content>
