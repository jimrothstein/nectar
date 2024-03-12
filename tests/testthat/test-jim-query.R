# PURPOSE:  Given a query as  a list, how does nectar process it?

# returns httr2_request object, with query parmams correct


.req_query_flatten <- function(req, query) {
  query <- purrr::map_chr(query, .prepare_query_element)
  return(httr2::req_url_query(req, !!!query))
}

.prepare_query_element <- function(query_element) {
  return(paste(unlist(query_element), collapse = ","))
}

## try it out

q <- list(width = "100", quantity = "1")
req <- httr2::request("https:://example.com")
.req_query_flatten(req, q)
