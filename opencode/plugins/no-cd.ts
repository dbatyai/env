import type { Plugin } from "@opencode-ai/plugin"

export default (async () => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash" || typeof output.args.command !== "string")
        return

      if (/^\s*cd\s+/.test(output.args.command)) {
        throw new Error("Do not chain commands with 'cd <dir> && ...'. Use the 'workdir' parameter for the tool instead.")
      }

      if (/^\s*git -C\s+/.test(output.args.command)) {
        throw new Error("Do not use -C argument. Use the 'workdir' parameter for the tool instead.")
      }
    },
  }
}) satisfies Plugin
