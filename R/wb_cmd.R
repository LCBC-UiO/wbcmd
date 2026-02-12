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
wb_cmd <- function(cmd, args = character(), ..., verbose = get_wb_verbosity(),
                   intern = verbose) {
  validate_wb_env()

  wb_path <- get_wb_path()
  all_args <- c(cmd, args)
  full_cmd <- paste(c(shQuote(wb_path), all_args), collapse = " ")

  if (verbose) {
    wb_inform("Running: {.code {full_cmd}}")
  }

  res <- try_wb_cmd(
    full_cmd,
    intern = intern,
    verbose = verbose
  )

  res
}

#' Execute a workbench system command
#'
#' @param cmd Full command string to execute.
#' @param intern Capture output?
#' @param verbose Show output?
#' @param ... Additional arguments passed to [system()].
#'
#' @return Command output or exit status.
#' @noRd
try_wb_cmd <- function(cmd, intern = TRUE, verbose = TRUE, ...) {
  res <- system(
    cmd,
    intern = intern,
    ignore.stdout = !verbose && !intern,
    ignore.stderr = !verbose,
    ...
  )
  res
}
