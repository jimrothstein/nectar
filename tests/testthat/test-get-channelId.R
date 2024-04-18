## PLACEHOLDER ... eventually use nectar:: to call youtube apis


# DO ONCE
if (!require("beekeeper")) {
  pak::pak("jonthegeek/beekeeper")
  pak::pak("jonthegeek/rapid")
  pak::pak("jonthegeek/nectar")
}

library(beekeeper)
library(nectar) # 1st practice nectar
library(rapid)
# --------------

# --------------
# LEGACY
# --------------
#'  Given a handle (Youtube name), return the channel_id

#'
#' @param handle Youtube account name.
#' @param max_results The maximum number of results to return.
#' @inheritParams yt_call_api
#'
#' @return A channel_id
#' @export
#'
#' @examplesIf yt_has_client_envvars() && interactive()
#' get_channel_id("SFIScience")
#' get_channel_id("@GoogleDevelopers")
#' @export
get_channel_id <- function(handle,
                           max_results = 100,
                           client = yt_construct_client(),
                           cache_disk = getOption("yt_cache_disk", FALSE),
                           cache_key = getOption("yt_cache_key", NULL),
                           token = NULL) {
  res <- call_api(
    endpoint = "channels",
    query = list(
      part = "id",
      forHandle = handle
    ),
    client = client,
    cache_disk = cache_disk,
    cache_key = cache_key,
    token = token
  )

  if (length(res$items)) {
    return(purrr::pluck(res, "items", 1, "id"))
    return(res)
  } else {
    return(NULL) # nocov
  }
}
