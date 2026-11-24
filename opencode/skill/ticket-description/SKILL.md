---
name: ticket-description
description: Use when writing or revising a ticket, bug, task, story, or issue description, or when the user asks for a "ticket description" or "ticket writeup". Produces a concise three-section layout (Description, Tasks, Acceptance Criteria) focused on what needs to be done. Do NOT use for epics; use the epic-description skill instead.
---

# Ticket Description Writing

Tickets (bugs, tasks, stories) describe a single, implementable unit of work. Focus on what needs to be done. Broader context and justification belong in the parent epic, not here.

## Layout

Use exactly these sections, in this order, for every ticket type. No metadata table, no other sections.

```markdown
# <Ticket Title>

## Description

<prose>

## Tasks

- <bullet>

## Acceptance Criteria

- <bullet>
```

### Description

Short prose, no bullets, usually a single paragraph. State what needs to happen and briefly why. For bugs, state the faulty behavior and the expected behavior. Do not repeat the broader context of the parent epic.

### Tasks

Bullet list. The framing and approach: how the work should be done. Name the components, directories, files, classes, or functions involved, and record decisions already made. If making a decision is part of the work, list it as a task.

### Acceptance Criteria

Bullet list. The required scope, stated positively as outcomes that must be true when the ticket is done. A reader must be able to tell exactly what is required from this list alone.

### Tasks vs. Acceptance Criteria

Tasks and Acceptance Criteria must not restate each other. Tasks describe the approach. Acceptance Criteria describe the outcome. If a bullet fits both, keep it in Acceptance Criteria only.

### No open questions

Do not add an Open Questions section. A ticket must be ready to implement. If a decision is part of the work, it is a task. If something is genuinely unclear while writing the description, ask the user to resolve it instead of writing it into the ticket.

## Language rules

- Concise and on point. No filler, no hedging ("might", "could potentially", "it's worth considering"), no over-explaining.
- One piece of information per sentence. No mid-sentence clarifying asides, no parenthetical lists, no em-dash digressions. If a sentence needs a parenthetical to add a distinct fact, split it into two sentences.
- Bullets are short, ideally a single sentence. If a bullet needs two sentences, reconsider whether it is really one bullet.
- Files, classes, functions, directories, components, and libraries may be referenced by name where it helps define what needs to change or where new work should live. Paths to new files that need to be created may be named.
- Never reference code by location: no file+line (e.g. `foo.cpp:123`), no line ranges.
- Never add notes about what is out of scope, deferred, or excluded. If something is excluded, do not mention it.
- No links or cross-references to other documents, tickets, or epics. The document must stand alone since it is copy-pasted elsewhere.
- Do not wrap lines manually. Write each paragraph and each bullet as a single line; let the renderer wrap it.

## Self-check before finishing

Re-read the draft and verify:

- Only the Description, Tasks, and Acceptance Criteria sections exist; there is no Open Questions section.
- Description is prose, with no bullets.
- Every bullet is one sentence.
- No Tasks bullet and Acceptance Criteria bullet say the same thing.
- No reference uses file+line or line ranges.
- No sentence says something is "out of scope", "deferred", "not covered", or similar.
- No links to other documents appear anywhere.
- No paragraph or bullet contains a manual line break.
