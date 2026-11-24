import { Plugin } from "@opencode/plugin"

export default Plugin.define({
  id: "no-cd",
  async setup(ctx) {
    await ctx.tool.hook("execute.before", (event) => {
      const command = (event.input as { command?: unknown }).command
      if (event.tool !== "shell" || typeof command !== "string") return

      if (/^\s*cd\s+/.test(command)) {
        throw new Error("Do not chain commands with 'cd <dir> && ...'. Use the 'workdir' parameter for the tool instead.")
      }

      if (/^\s*git -C\s+/.test(command)) {
        throw new Error("Do not use -C argument. Use the 'workdir' parameter for the tool instead.")
      }
    })
  },
})
