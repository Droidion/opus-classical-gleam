import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element, text}
import lustre/element/html.{div, h1}
import opus_classical/models

pub fn root(countries: List(models.Country)) -> Element(t) {
  div([], [
    h1([class("text-4xl font-bold")], [text("Homepage")]),
    ..countries
    |> list.map(fn(country) { div([], [text(country.name)]) })
  ])
}
