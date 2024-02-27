# DO ONCE
if (!require("beekeeper")) {
  pak::pak("jonthegeek/beekeeper")
  pak::pak("jonthegeek/rapid")
  pak::pak("jonthegeek/nectar")
}

library(beekeeper)
library(nectar) # 1st practice nectar
library(rapid)
library(testthat)

test_that("call_api() calls an API", {
  #  local_mocked_bindings(
  #    .resp_get = function(req) {
  #      structure(req, class = c("performed", class(req)))
  #    }
  #  )
  expect_no_error({
    test_result <- call_api(
      base_url = "https://example.com",
      response_parser = NULL,
      user_agent = NULL
    )
  })
  expect_identical(
    test_result$url,
    "https://example.com/"
  )
})


curl \
  'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&forUsername=GoogleDevelopers&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed

#test_that("call_api() can call youtube api, {

#          expect_no_error({
#test_result = call_api(
                       base_url = 'https://youtube.googleapis.com/youtube/v3/'
                       response_parser=NULL,
                       user_agent = NULL
#                       )
#})

#}
#)
                       #
#channels?part=snippet%2CcontentDetails%2Cstatistics&forUsername=GoogleDevelopers&key=[YOUR_API_KEY]' \
#                       

expect_no_error({ ans = 2+2})
expect_no_error({ 4 == 2+2})
expect_no_error({ 4 != 2+2})

expect_no_error({ 4 == 3} )
