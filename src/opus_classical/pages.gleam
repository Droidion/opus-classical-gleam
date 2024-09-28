import opus_classical/models
import opus_classical/pages/home

pub fn home(countries: List(models.Country)) {
  home.root(countries)
}
