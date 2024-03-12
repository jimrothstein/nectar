##  FROM httr2
##  Test nectar::call_api()  by reproducing examples from httr2:: vignettes

# -----------------------------------------------------------
#         httr2
# We start by creating a request that uses the base API url
# -----------------------------------------------------------
library(httr2)
req <- request("https://fakerapi.it/api/v1")
req <- req |>
  # Then we add on the images path
  req_url_path_append("images") |>
  # Add query parameters _width and _quantity
  req_url_query(`_width` = 380, `_quantity` = 1)

resp <- req |> req_perform()

# The result comes back as JSON
resp |>
  resp_body_json()
# --------------------------------------
#       now try with nectar
#       Result:  different below has list of 10, similar but not same structure of return
# -----------------------------------------------------------
library(nectar)
debug(call_api)
resp1 <- nectar::call_api(
  base_url = "https://fakerapi.it/api/v1",
  path = "images",
  # query = "`_width` = 380, `_quantity` = 1",  # error
  query = list(width = "380", quantity = "1"),
  body = NULL,
  mime_type = NULL,
  method = NULL,
  security_fn = NULL,
  security_args = list(),
  response_parser = httr2::resp_body_json,
  response_parser_args = list(),
  user_agent = "nectar (https://nectar.api2r.org)"
)

resp1
resp1$data[[1]]
