import decode
import gleam/option.{Some}
import gleam/pgo.{type QueryError, type Returned}
import opus_classical/env
import opus_classical/models.{type Country, Country}

pub fn db_connect(env_vars: env.EnvVars) -> pgo.Connection {
  pgo.connect(
    pgo.Config(
      ..pgo.default_config(),
      user: env_vars.postgres_user,
      password: Some(env_vars.postgres_password),
      host: env_vars.postgres_host,
      database: env_vars.postgres_database,
      port: env_vars.postgres_port,
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
