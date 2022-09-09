# Phoenix LiveDebugConsole

This package implements an extension to the error view shown in Phoenix
applications, adding a fully-interactive IEx shell.

## Installation

1.  Install the package by adding `phoenix_live_debug_console` to your list of
    dependencies in `mix.exs`:
```elixir
def deps do
  [
    {:phoenix_live_debug_console, "~> 0.1.0"}
  ]
end
```

2. Configure the endpoint of your application such that `debug_errors` and
   `debug_error_handlers` are set as follows:
```elixir
config :my_app, MyAppWeb.Endpoint,
  debug_errors: true,
  debug_banner_hooks: [{PhoenixLiveDebugConsole, :render_console, []}]
```

## Credits

This library was written by [Frerich Raabe](mailto:frerich.raabe@gmail.com), however it
is really just standing on the shoulders of giants:

* [Underthehood](https://github.com/frerich/underthehood) is what implements the IEx terminal
* [Phoenix LiveDashboard](https://github.com/phoenixframework/phoenix_live_dashboard) served
  as an inspiration for developing an extension package which comes with its own assets.
