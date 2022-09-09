defmodule PhoenixLiveDebugConsole do
  @moduledoc false

  use Phoenix.LiveView

  import Phoenix.LiveView.Helpers

  import Phoenix.HTML, only: [javascript_escape: 1, raw: 1]
  import Phoenix.HTML.Tag, only: [csrf_meta_tag: 0]

  import Underthehood

  js_path = Path.join(__DIR__, "../dist/static/assets/app.js")
  css_path = Path.join(__DIR__, "../dist/static/assets/app.css")

  @external_resource js_path
  @external_resource css_path

  @app_js File.read!(js_path)
  @app_css File.read!(css_path)

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        js_code_path: session["js_code_path"],
        css_path: session["css_path"]
      )

    {:ok, socket}
  end

  def render(assigns) do
    assigns =
      assigns
      |> Map.put(:app_js, @app_js)
      |> Map.put(:app_css, @app_css)

    ~H"""
      <body>
        <%= csrf_meta_tag() %>
        <script><%= raw(@app_js) %></script>
        <style><%= raw(@app_css) %></style>
        <style>
          .container { padding: 0 }
          body { margin: 0 }
        </style>
        <.terminal/>
      </body>
    """
  end

  def render_console(conn, _status, _kind, _reason, _stack) do
    markup =
      conn
      |> live_render(__MODULE__, session: %{}, container: {:html, []})
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
