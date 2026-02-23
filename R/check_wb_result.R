#' Check the result of a workbench command
#'
#' Validates the outcome of a `wb_command` execution by inspecting the
#' exit status and whether the expected output file was produced.
#'
#' @param res The return value from [system()].
#' @param fe_before Logical; did the output file exist before execution?
#' @param fe_after Logical; does the output file exist after execution?
#' @param outfile Path to the expected output file.
#' @param cmd_name The command name, for diagnostic messages.
#'
#' @return `res`, invisibly.
#'
#' @examples
#' check_wb_result(0L, fe_before = FALSE, fe_after = TRUE,
#'                 outfile = "out.nii", cmd_name = "test")
#'
#' @export
check_wb_result <- function(res,
                            fe_before = NA,
                            fe_after = NA,
                            outfile = NULL,
                            cmd_name = NULL) {
  exit_status <- extract_exit_status(res)
  failed <- exit_status != 0

  label <- cmd_name %||% "wb_command"

  if (failed && !isTRUE(fe_after)) {
    wb_abort(c(
      "{.fn {label}} failed (status {exit_status}).",
      if (!is.null(outfile)) c("x" = "Output file not created: {.path {outfile}}")
    ))
  }

  if (!failed && !is.na(fe_after) && !fe_after) {
    wb_warn(c(
      "{.fn {label}} returned success but output file is missing.",
      "x" = "{.path {outfile}}"
    ))
  }

  if (failed && isTRUE(fe_after) && isTRUE(fe_before)) {
    wb_warn(c(
      "{.fn {label}} failed (status {exit_status}).",
      "!" = "Output file {.path {outfile}} exists but may be stale."
    ))
  }

  if (failed && isTRUE(fe_after) && !isTRUE(fe_before)) {
    wb_warn(c(
      "{.fn {label}} failed (status {exit_status}).",
      "!" = "Output file {.path {outfile}} was created but may be incomplete."
    ))
  }

  invisible(res)
}

#' Extract exit status from system result
#'
#' @param res Result from [system()].
#'
#' @return Integer exit status.
#' @noRd
extract_exit_status <- function(res) {
  if (!is.null(attr(res, "status"))) {
    return(attr(res, "status"))
  }
  if (is.numeric(res) && length(res) == 1) {
    return(as.integer(res))
  }
  0L
}
