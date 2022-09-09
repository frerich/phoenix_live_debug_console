import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import TerminalHook from "../../deps/underthehood/lib/hook"

let Hooks = {}
Hooks.Terminal = TerminalHook

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

liveSocket.connect()
