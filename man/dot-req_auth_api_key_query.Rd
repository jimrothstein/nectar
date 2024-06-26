% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auth.R
\name{.req_auth_api_key_query}
\alias{.req_auth_api_key_query}
\title{Authenticate with an API key in the query of the request}
\usage{
.req_auth_api_key_query(req, ..., parameter_name, api_key)
}
\arguments{
\item{req}{A \code{\link[httr2:request]{httr2::request()}} object.}

\item{parameter_name}{The name to use for the API key.}

\item{api_key}{The API key to use.}
}
\value{
A \code{\link[httr2:request]{httr2::request()}} object.
}
\description{
Authenticate with an API key in the query of the request
}
\keyword{internal}
