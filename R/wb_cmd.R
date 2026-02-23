#' Execute a Connectome Workbench command
#'
#' Central dispatcher for all `wb_command` operations. Command wrappers
#' call this function to construct, execute, and validate workbench
#' commands.
#'
#' @param cmd The wb_command subcommand (e.g. `"-cifti-separate"`).
#' @param args Character vector of arguments to pass after `cmd`.
#' @param ... Additional arguments, currently unused.
#' @param verbose Logical; print command output? Defaults to
#'   [get_wb_verbosity()].
#' @param intern Logical; capture output as character vector?
#'   Defaults to the value of `verbose`.
#'
#' @return If `intern = TRUE`, a character vector of command output.
#'   Otherwise the exit status (integer).
#'
#' @examples
#' \dontrun{
#' wb_cmd("-version")
#' wb_cmd("-cifti-separate", c("input.dscalar.nii", "COLUMN"))
#' }
#'
#' @export
wb_cmd <- function(
  cmd,
  args = character(),
  ...,
  verbose = get_wb_verbosity(),
  intern = verbose
) {
  validate_wb_env()

  wb_path <- get_wb_path()
  all_args <- c(cmd, args)

  if (verbose) {
    full_cmd <- paste(c(shQuote(wb_path), shQuote(all_args)), collapse = " ")
    wb_inform("Running: {.code {full_cmd}}")
  }

  try_wb_cmd(
    wb_path,
    all_args,
    intern = intern,
    verbose = verbose
  )
}

#' Execute a workbench system command
#'
#' @param command Path to the wb_command executable.
#' @param args Character vector of arguments.
#' @param intern Capture output?
#' @param verbose Show output?
#'
#' @return Command output or exit status.
#' @noRd
try_wb_cmd <- function(command, args = character(), intern = TRUE,
                       verbose = TRUE) {
  result <- system2(
    command,
    args = shQuote(args),
    stdout = if (intern) TRUE else if (verbose) "" else FALSE,
    stderr = if (verbose) "" else FALSE
  )

  # wb_command creates a WbViewMovie directory as a side effect
  wb_movie <- file.path(dirname(tempdir()), "WbViewMovie")
  if (dir.exists(wb_movie)) unlink(wb_movie, recursive = TRUE)

  result
}
