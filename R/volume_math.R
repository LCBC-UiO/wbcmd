#' Evaluate expression on volume files
#'
#' Wraps `wb_command -volume-math` to perform element-wise mathematical
#' operations on volume files at each voxel.
#'
#' @param expression Math expression string (e.g. `"(x - y) / y * 100"`).
#' @param volume_out Path for the output volume file.
#' @param var Named list of input volume file paths. Names correspond to
#'   variable names used in `expression`.
#' @param fixnan Logical; replace NaN results with 0?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' volume_math(
#'   "clamp(x, 0, 100)",
#'   volume_out = "clamped.nii.gz",
#'   var = list(x = "input.nii.gz")
#' )
#' }
#'
#' @export
volume_math <- function(expression,
                        volume_out,
                        var,
                        fixnan = FALSE,
                        verbose = get_wb_verbosity()) {
  volume_out <- validate_outfile(volume_out, ext = ".nii.gz")

  args <- c(shQuote(expression), shQuote(volume_out))

  for (nm in names(var)) {
    check_path(var[[nm]], arg = nm)
    args <- c(args, "-var", shQuote(nm), shQuote(var[[nm]]))
  }

  if (fixnan) args <- c(args, "-fixnan", "0")

  wb_cmd("-volume-math", args, verbose = verbose)
}
