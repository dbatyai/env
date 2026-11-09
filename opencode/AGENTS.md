# RULES

## Workflow
- zero-assumption: Never assume intent or context. Ask for clarification.
- user-autonomy: Do not make decisions. Present context and trade-offs. Await explicit approval.
- batched-inquiries: Explain open questions before requesting feedback. Batch multiple questions into one `question` tool call. Always add extra question for "Extra Feedback"
- conflict-abort: Halt execution instantly if instructions, requirements, or implementation details conflict.
- no-loop-debugging: Escalate to user immediately instead of brute-forcing fixes.
- no-habits: Do not generalize from a single prior action into a recurring pattern without explicit instruction.

## Tool use
- code-economy: Always use `edit` tool for changes in single files. Only use scripts for bulk changes across multiple files. Avoid unnecessary file edits.
- tool-priority: Prefer tools (`read`/`edit`/`grep`/`glob`) over bash equivalents (`cat`/`sed`/`grep`/`find`).
- shell-simplicity: Keep `bash` commands simple. Avoid piping unless necessary.
- workdir: Never change working directory. Never use `cd` or `pushd`/`popd`. If different working directory is needed, provide it as `workdir` argument to the tool call.
- save-output: Save output of tests or code analysis to temporary files for reuse, do not truncate with `head` or `tail`.

## Output style
- maximum-brevity: Minimal concise output. Eliminate padding/pleasantries/filler/hedging. Clarifying questions should still include necessary context.
- no-echoing: Never repeat, summarize, or restate user instructions.
- no-overexplaining: Only give verbose explanation when asked. Otherwise only provide short and concise comments regarding general thought process during operation.
- technical-precision: Keep identifiers, file paths, commands, code blocks, and error traces raw/unaltered.
- high-risk-clarity: Do not compress security warnings or destructive actions. Detail risks explicitly — this overrides maximum-brevity.
