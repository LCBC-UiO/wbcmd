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

  res <- try_wb_cmd(wb_path, args, intern = TRUE, verbose = FALSE)
  cat(res, sep = "\n")
  invisible(res)
}

#' Render wb_command CLI help as Rd markup
#'
#' Called at render time by `\Sexpr` in generated .Rd files.
#' Returns valid Rd markup showing CLI help or a fallback message.
#'
#' @param cmd The wb_command subcommand (e.g. `"-cifti-average"`).
#'
#' @return Character string of Rd markup.
#'
#' @export
wb_help_rd <- function(cmd) {
  if (!grepl("^-[a-z][a-z-]*$", cmd)) {
    return(paste0("Invalid command: \\code{", cmd, "}."))
  }

  if (!have_wb()) {
    return(paste0(
      "Connectome Workbench is not installed. Run \\code{wb_help(\"",
      cmd,
      "\")} in a session with wb_command available."
    ))
  }

  help_text <- tryCatch(
    {
      wb_path <- get_wb_path()
      suppressWarnings(try_wb_cmd(wb_path, cmd, intern = TRUE, verbose = FALSE))
    },
    error = function(e) NULL
  )

  if (is.null(help_text) || length(help_text) == 0) {
    return(paste0("Help not available for \\code{", cmd, "}."))
  }

  escaped <- help_text
  escaped <- gsub("\\", "\\\\", escaped, fixed = TRUE)
  escaped <- gsub("{", "\\{", escaped, fixed = TRUE)
  escaped <- gsub("}", "\\}", escaped, fixed = TRUE)
  escaped <- gsub("%", "\\%", escaped, fixed = TRUE)
  escaped <- gsub("#", "\\#", escaped, fixed = TRUE)

  paste0("\\preformatted{", paste(escaped, collapse = "\n"), "}")
}
