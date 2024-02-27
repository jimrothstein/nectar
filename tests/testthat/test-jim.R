##  FROM httr2
##  Test nectar::call_api()  by reproducing examples from httr2:: vignettes

# -----------------------------------------------------------
#         httr2
# We start by creating a request that uses the base API url
# -----------------------------------------------------------
library(httr2)
req <- request("https://fakerapi.it/api/v1")
resp <- req |>
  # Then we add on the images path
  req_url_path_append("images") |>
  # Add query parameters _width and _quantity
  req_url_query(`_width` = 380, `_quantity` = 1) |>
  req_perform()

# The result comes back as JSON
resp |>
  resp_body_json() |>
  str()
# --------------------------------------
#       nectar
# -----------------------------------------------------------
library(nectar)
nectar::call_api(
  base_url = "https://fakerapi.it/api/v1",
  path = "images",
  # query = "`_width` = 380, `_quantity` = 1",  # error
  body = NULL,
  mime_type = NULL,
  method = NULL,
  security_fn = NULL,
  security_args = list(),
  response_parser = httr2::resp_body_json,
  response_parser_args = list(),
  user_agent = "nectar (https://nectar.api2r.org)"
)


# -----------------
#   example_url()
# -----------------

req <- httr2::request(example_url())
req

nectar::call_api(
  base_url = example_url(),
  response_parser = NULL # see Ref
)


# ------------
#    headers?
# ------------
req |>
  req_headers(
    Name = "Hadley",
    `Shoe-Size` = "11",
    Accept = "application/json"
  ) |>
  req_dry_run()

nectar::call_api(
  base_url = example_url(),
  #  header = "name: hadley",   error !

  response_parser = NULL
)
