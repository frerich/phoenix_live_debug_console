# Phoenix LiveDebugConsole

This package implements an extension to the error view shown in Phoenix
applications, adding a fully-interactive IEx shell. Here's a video of me
triggering an error in a Phoenix application and then poking around a
little bit using the live debug console:

https://user-images.githubusercontent.com/533425/189327007-a3fc4bda-8519-4a02-9a7c-f8b1331e19a9.mov

## Installation

1.  This package currently requires that your application uses a bleeding
    edge development build of Phoenix which has
    https://github.com/phoenixframework/phoenix/pull/4938 applied.

2.  Install the package by adding `phoenix_live_debug_console` to your list of
    dependencies in `mix.exs`:
```elixir
def deps do
  [
    {:phoenix_live_debug_console, "~> 0.1"}
  ]
end
```

3. Configure the endpoint of your application such that `debug_errors` and
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
