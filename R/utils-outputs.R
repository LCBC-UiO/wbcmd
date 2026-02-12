#' Abort with workbench context
#'
#' @param message Message passed to [cli::cli_abort()].
#' @param ... Additional arguments passed to [cli::cli_abort()].
#' @param call The calling environment.
#' @param .envir Environment for cli glue evaluation.
#'
#' @return Nothing, throws an error.
#' @noRd
wb_abort <- function(message, ..., call = rlang::caller_env(),
                     .envir = rlang::caller_env()) {
  cli::cli_abort(
    message,
    ...,
    call = call,
    .envir = .envir,
    class = "wbcmd_error"
  )
}

#' Warn with workbench context
#'
#' @param message Message passed to [cli::cli_warn()].
#' @param ... Additional arguments passed to [cli::cli_warn()].
#' @param .envir Environment for cli glue evaluation.
#'
#' @return `NULL` invisibly.
#' @noRd
wb_warn <- function(message, ..., .envir = rlang::caller_env()) {
  cli::cli_warn(
    message,
    ...,
    .envir = .envir,
    class = "wbcmd_warning"
  )
}

#' Inform with workbench context
#'
#' @param message Message passed to [cli::cli_inform()].
#' @param ... Additional arguments passed to [cli::cli_inform()].
#' @param .envir Environment for cli glue evaluation.
#'
#' @return `NULL` invisibly.
#' @noRd
wb_inform <- function(message, ..., .envir = rlang::caller_env()) {
  cli::cli_inform(
    message,
    ...,
    .envir = .envir,
    class = "wbcmd_message"
  )
}
