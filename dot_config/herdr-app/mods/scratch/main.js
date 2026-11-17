// Floating scratch terminal (tmux-floax replacement). Bound to a key as
// `mod.open:scratch`; this copy is a throwaway launcher that toggles an 80% x 80%
// dialog showing one persistent, unlabeled (so hidden from spaces/tabs) shell.
// Closing the dialog keeps the shell; `exit` in it ends the shell and the dialog.
import { View, div } from "gpui-kit";
import { exec, hc, terminals, focused, home, shared, setShared, openOverlay, closeOverlay, props, checking } from "herdr";

const NAME = "scratch";

export default class Scratch extends View {
  init(_props, cx) {
    if (checking()) return;
    cx.spawn(async () => {
      try { await this.toggle(); } finally { closeOverlay(props().overlay); }
    });
  }

  async toggle() {
    // The dialog can also close by itself (click beside it, shell `exit`), so ask the
    // window what's really open instead of trusting the stored id.
    const open = shared("scratch.overlay");
    setShared("scratch.overlay", null);
    if (open) {
      const status = JSON.parse((await exec("herdr-app", ["status"])).stdout);
      // ponytail: status lists overlay kinds, not ids; any open "layout" overlay counts as ours.
      if (status.overlays?.includes("layout")) return void closeOverlay(open);
    }
    let address = terminals().find((t) => t.name === NAME && t.state !== "exited")?.address;
    if (!address) {
      const r = await hc(["run", "--json", "--bg", "--keep", "--no-parent", "--name", NAME,
                          "--cwd", focused()?.cwd ?? home()]);
      address = JSON.parse(r.stdout).address;
    }
    const id = openOverlay({ kind: "dialog", width: 0.8, height: 0.8,
                             layout: { type: "block", content: { terminal: address } } });
    setShared("scratch.overlay", id);
  }

  render() {
    return div();
  }
}
