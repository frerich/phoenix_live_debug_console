defmodule PhoenixLiveDebugConsole do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  import Phoenix.HTML, only: [javascript_escape: 1]
  import Phoenix.HTML.Tag, only: [csrf_meta_tag: 0]

  import Underthehood

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        js_code_path: session["js_code_path"],
        css_path: session["css_path"]
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <body>
        <%= csrf_meta_tag() %>
        <script defer phx-track-static type="text/javascript" src={@js_code_path}></script>
        <link type="text/css" rel="stylesheet" href={@css_path}>
        <style>
          .container { padding: 0 }
          body { margin: 0 }
        </style>
        <.terminal/>
      </body>
    """
  end

  def render_console(conn, _status, _kind, _reason, _stack) do
    js_code_path = "/assets/app.js"
    css_path = "/assets/app.css"

    session = %{
      "js_code_path" => js_code_path,
      "css_path" => css_path
    }

    markup =
      conn
      |> live_render(__MODULE__, session: session, container: {:html, []})
      |> Phoenix.HTML.safe_to_string()

    """
    <details class="meta">
      <summary>IEx Terminal</summary>
      <iframe frameborder="0" scrolling="no" id="terminal_frame" src="about:blank"></iframe>
    </details>
    <script>
      let frame = document.getElementById("terminal_frame");

      let doc = frame.contentWindow.document;
      doc.open();
      doc.write("#{javascript_escape(markup)}")
      doc.close();

      frame.width = "720px";
      frame.height = "450px";
    </script>
    """
  end
end
