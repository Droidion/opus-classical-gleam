import gleam/http.{Get}
import gleam/list
import nakai
import nakai/html
import opus_classical/db
import opus_classical/web.{type Context}
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use req <- web.middleware(req)

  // Wisp doesn't have a special router abstraction, instead we recommend using
  // regular old pattern matching. This is faster than a router, is type safe,
  // and means you don't have to learn or be limited by a special DSL.
  //
  case wisp.path_segments(req) {
    // This matches `/`.
    [] -> home_page(req, ctx)

    // This matches all other paths.
    _ -> wisp.not_found()
  }
}

fn home_page(req: Request, ctx: Context) -> Response {
  // The home page can only be accessed via GET requests, so this middleware is
  // used to return a 405: Method Not Allowed response for all other methods.
  use <- wisp.require_method(req, Get)

  case db.get_countries(ctx.conn) {
    Ok(countries) -> {
      let html =
        countries.rows
        |> list.map(fn(country) { html.div_text([], country.name) })
        |> html.div([], _)
        |> nakai.to_string_builder()
      wisp.ok()
      |> wisp.html_body(html)
    }
    Error(_) -> {
      wisp.internal_server_error()
    }
  }
}
