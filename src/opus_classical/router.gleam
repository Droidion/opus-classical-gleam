import gleam/http.{Get}
import gleam/list
import nakai
import nakai/html
import opus_classical/db
import opus_classical/web.{type Context}
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use req <- web.middleware(req, ctx)

  case wisp.path_segments(req) {
    // This matches `/`.
    [] -> home_page(req, ctx)

    ["internal-server-error"] -> wisp.internal_server_error()
    ["unprocessable-entity"] -> wisp.unprocessable_entity()
    ["method-not-allowed"] -> wisp.method_not_allowed([])
    ["entity-too-large"] -> wisp.entity_too_large()
    ["bad-request"] -> wisp.bad_request()
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
