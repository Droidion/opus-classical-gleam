import decode
import gleam/option.{Some}
import gleam/pgo.{type QueryError, type Returned}
import opus_classical/env
import opus_classical/models.{type Country, Country}

pub fn db_connect(postgres_config: env.PostgresConfig) -> pgo.Connection {
  pgo.connect(
    pgo.Config(
      ..pgo.default_config(),
      user: postgres_config.user,
      password: Some(postgres_config.password),
      host: postgres_config.host,
      database: postgres_config.database,
      port: postgres_config.port,
    ),
  )
}

pub fn get_countries(
  conn: pgo.Connection,
) -> Result(Returned(Country), QueryError) {
  let country_row_decoder =
    decode.into({
      use id <- decode.parameter
      use name <- decode.parameter
      Country(id: id, name: name)
    })
    |> decode.field(0, decode.int)
    |> decode.field(1, decode.string)

  "SELECT id, name from countries"
  |> pgo.execute(conn, [], fn(row) { country_row_decoder |> decode.from(row) })
}
