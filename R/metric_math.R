#' Evaluate expression on metric files
#'
#' Wraps `wb_command -metric-math` to perform element-wise mathematical
#' operations on metric files at each surface vertex.
#'
#' @param expression Math expression string (e.g. `"(x - mean) / stdev"`).
#' @param metric_out Path for the output metric file.
#' @param var Named list of input metric file paths. Names correspond to
#'   variable names used in `expression`.
#' @param fixnan Logical; replace NaN results with 0?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' metric_math(
#'   "abs(x - y)",
#'   metric_out = "diff.func.gii",
#'   var = list(x = "post.func.gii", y = "pre.func.gii")
#' )
#' }
#'
#' @export
metric_math <- function(expression,
                        metric_out,
                        var,
                        fixnan = FALSE,
                        verbose = get_wb_verbosity()) {
  metric_out <- validate_outfile(metric_out, ext = ".func.gii")

  args <- c(shQuote(expression), shQuote(metric_out))

  for (nm in names(var)) {
    check_path(var[[nm]], arg = nm)
    args <- c(args, "-var", shQuote(nm), shQuote(var[[nm]]))
  }

  if (fixnan) args <- c(args, "-fixnan", "0")

  wb_cmd("-metric-math", args, verbose = verbose)
}
