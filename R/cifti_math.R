#' Evaluate expression on CIFTI files
#'
#' Wraps `wb_command -cifti-math` to perform element-wise mathematical
#' operations on CIFTI files using an expression language.
#'
#' @param expression Math expression string (e.g. `"(x - mean) / stdev"`).
#' @param cifti_out Path for the output CIFTI file.
#' @param var Named list of input CIFTI file paths. Names correspond to
#'   variable names used in `expression`.
#' @param fixnan Logical; replace NaN results with 0?
#' @param override_mapping_check Logical; skip map count check?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_math(
#'   "(x - y) / y",
#'   cifti_out = "pct_change.dscalar.nii",
#'   var = list(x = "post.dscalar.nii", y = "pre.dscalar.nii")
#' )
#' }
#'
#' @wbHelp -cifti-math
#' @export
cifti_math <- function(
  expression,
  cifti_out,
  var,
  fixnan = FALSE,
  override_mapping_check = FALSE,
  verbose = get_wb_verbosity()
) {
  cifti_out <- validate_outfile(cifti_out, ext = ".dscalar.nii")

  args <- c(shQuote(expression), shQuote(cifti_out))

  for (nm in names(var)) {
    check_path(var[[nm]], arg = nm)
    args <- c(args, "-var", shQuote(nm), shQuote(var[[nm]]))
  }

  if (fixnan) {
    args <- c(args, "-fixnan", "0")
  }
  if (override_mapping_check) {
    args <- c(args, "-override-mapping-check")
  }

  wb_cmd("-cifti-math", args, verbose = verbose)
}
