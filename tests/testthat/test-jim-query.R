# PURPOSE:  Given a query as  a list, how does nectar process it?
# nectar?   where?
# returns httr2_request object, with query parmams correct


##  want:   "https://example.com?width=100 quantity=1)" ??

# ----------
## helpers
# ----------
.req_query_flatten <- function(req, query) {
  query <- purrr::map_chr(query, .prepare_query_element)
  return(httr2::req_url_query(req, !!!query))
}

.prepare_query_element <- function(query_element) {
  return(paste(unlist(query_element), collapse = ","))
}

## try it out
# ----------------------------------------------------------
##  want:   "https://example.com?width=100 quantity=1)"
# ----------------------------------------------------------

q <- list(width = "100", quantity = "1")
req <- httr2::request("https://example.com")
.req_query_flatten(req, q)

# ----------------
# two other ways (if q is NOT list)
# ----------------
req |>
  req_url_query(width = 100) |>
  req_url_query(quantity = 1)

req |> req_url_query(width = 100, quantity = 1, .multi = "explode")

# --------------
## req_perform
## NOTE: returns text/html
# --------------

req |>
  req_url_query(width = 100, quantity = 1, .multi = "explode") |>
  req_perform()




# -----------------------------
##  now, use nectar::api_call
# -----------------------------
call_api(
  base_url,
  path = NULL,
  query = NULL,
  body = NULL,
  mime_type = NULL,
  method = NULL,
  security_fn = NULL,
  security_args = list(),
  response_parser = httr2::resp_body_json,
  response_parser_args = list(),
  next_req = NULL,
  max_reqs = Inf,
  user_agent = "nectar (https://nectar.api2r.org)"
)

testthat::test_that("call_api() uses NULL as response_parser", {
                     expect_no_error( message= "You passed", 
nectar::call_api(
  base_url = "https://example.com",
  path = NULL,
  query = list(width = "100", quantity = "1"),
  body = NULL,
  # response_parser = httr2::resp_body_json,
  response_parser = NULL,
  user_agent = "nectar (https://nectar.api2r.org)"
)
)
}
)

test_that("call_api() uses response_parser", {
  local_mocked_bindings(
    req_perform = function(req) {
      structure(req, class = "httr2_response")
    },
    .resp_parse_apply = function(resp, response_parser, response_parser_args) {
      rlang::expr(response_parser(resp, !!!response_parser_args))
    }
  )
  expect_snapshot({
    test_result <- call_api(
      base_url = "https://example.com",
      response_parser_args = list(simplifyVector = TRUE),
      user_agent = NULL
    )
    test_result
  })
