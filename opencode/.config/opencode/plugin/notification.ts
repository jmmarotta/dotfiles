import type { Plugin } from "@opencode-ai/plugin";

export const NotificationPlugin: Plugin = async ({ $ }) => {
  // const isGhosttyFocused = async (): Promise<boolean> => {
  //   const result =
  //     await $`osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true'`.text();
  //   return result.trim().toLowerCase() === "ghostty";
  // };
  //

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        // const focused = await isGhosttyFocused();
        const focused = false;
        if (!focused) {
          // Alternative: Use terminal-notifier for custom icons and to avoid ScriptEditor appearing
          // Install: brew install terminal-notifier
          // Usage: await $`terminal-notifier -title "OpenCode" -message "Agent finished..." -sound Pop -appIcon /path/to/icon.png`;
          //
          // For now, using osascript (shows as ScriptEditor in notification):
          await $`osascript -e 'display notification "Agent finished..." with title "OpenCode" sound name "Pop"'`;
        }
      }
    },
  };
};
