#' Compute correlation of CIFTI rows
#'
#' Wraps `wb_command -cifti-correlation` to generate a row-wise
#' correlation matrix from a CIFTI file.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param cifti_out Path for the output correlation CIFTI file.
#' @param roi_override Path to a CIFTI ROI file to restrict computation.
#' @param weights Path to a text file of column weights.
#' @param fisher_z Logical; apply Fisher z-transform to correlations?
#' @param no_demean Logical; skip demeaning before correlation?
#' @param covariance Logical; compute covariance instead of correlation?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_correlation(
#'   "data.dtseries.nii",
#'   "corr.dconn.nii",
#'   fisher_z = TRUE
#' )
#' }
#'
#' @wbHelp -cifti-correlation
#' @export
cifti_correlation <- function(
  cifti_in,
  cifti_out,
  roi_override = NULL,
  weights = NULL,
  fisher_z = FALSE,
  no_demean = FALSE,
  covariance = FALSE,
  verbose = get_wb_verbosity()
) {
  check_path(cifti_in, arg = "cifti_in")
  cifti_out <- validate_outfile(cifti_out, ext = ".dconn.nii")

  args <- c(shQuote(cifti_in), shQuote(cifti_out))

  if (!is.null(roi_override)) {
    check_path(roi_override, arg = "roi_override")
    args <- c(args, "-roi-override", shQuote(roi_override))
  }
  if (!is.null(weights)) {
    check_path(weights, arg = "weights")
    args <- c(args, "-weights", shQuote(weights))
  }
  if (fisher_z) {
    args <- c(args, "-fisher-z")
  }
  if (no_demean) {
    args <- c(args, "-no-demean")
  }
  if (covariance) {
    args <- c(args, "-covariance")
  }

  wb_cmd("-cifti-correlation", args, verbose = verbose)
}
