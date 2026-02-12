#' Access wb_command help text
#'
#' Retrieves the help text for a given `wb_command` subcommand.
#'
#' @param cmd The subcommand to get help for (e.g. `"-cifti-separate"`).
#'   If `NULL`, shows the top-level help listing all subcommands.
#'
#' @return Character vector of help text lines, invisibly.
#'
#' @examples
#' \dontrun{
#' wb_help()
#' wb_help("-cifti-separate")
#' }
#'
#' @export
wb_help <- function(cmd = NULL) {
  validate_wb_env()

  wb_path <- get_wb_path()
  args <- if (is.null(cmd)) character() else cmd
  full_cmd <- paste(c(shQuote(wb_path), args), collapse = " ")

  res <- try_wb_cmd(full_cmd, intern = TRUE, verbose = FALSE)
  cat(res, sep = "\n")
  invisible(res)
}
