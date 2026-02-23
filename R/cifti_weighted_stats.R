#' Compute weighted statistics on a CIFTI file
#'
#' Wraps `wb_command -cifti-weighted-stats` to compute spatially-weighted
#' statistics along CIFTI columns.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param operation One of `"MEAN"`, `"STDEV"`, `"SAMPSTDEV"`, `"SUM"`.
#' @param percentile Numeric percentile (alternative to `operation`).
#' @param spatial_weights Logical; use vertex areas and voxel volumes as
#'   weights?
#' @param cifti_weights Path to a CIFTI file to use as weights.
#' @param column Integer; compute for a single column only (1-indexed).
#' @param roi Path to a CIFTI ROI file.
#' @param show_map_name Logical; print map name before each result?
#' @param verbose Logical; print command output?
#'
#' @return Character vector of output lines (stats values).
#'
#' @examples
#' \dontrun{
#' cifti_weighted_stats("data.dscalar.nii", operation = "MEAN",
#'                      spatial_weights = TRUE)
#' }
#'
#' @wbHelp -cifti-weighted-stats
#' @export
cifti_weighted_stats <- function(
  cifti_in,
  operation = NULL,
  percentile = NULL,
  spatial_weights = FALSE,
  cifti_weights = NULL,
  column = NULL,
  roi = NULL,
  show_map_name = FALSE,
  verbose = get_wb_verbosity()
) {
  check_path(cifti_in, arg = "cifti_in")

  args <- cifti_in

  if (spatial_weights) {
    args <- c(args, "-spatial-weights")
  }
  if (!is.null(cifti_weights)) {
    check_path(cifti_weights, arg = "cifti_weights")
    args <- c(args, "-cifti-weights", cifti_weights)
  }
  if (!is.null(column)) {
    args <- c(args, "-column", column)
  }
  if (!is.null(roi)) {
    check_path(roi, arg = "roi")
    args <- c(args, "-roi", roi)
  }

  if (!is.null(operation)) {
    operation <- match.arg(operation, c("MEAN", "STDEV", "SAMPSTDEV", "SUM"))
    op_flag <- switch(
      operation,
      MEAN = "-mean",
      STDEV = "-stdev",
      SAMPSTDEV = "-sampstdev",
      SUM = "-sum"
    )
    args <- c(args, op_flag)
  } else if (!is.null(percentile)) {
    args <- c(args, "-percentile", percentile)
  }

  if (show_map_name) {
    args <- c(args, "-show-map-name")
  }

  wb_cmd("-cifti-weighted-stats", args, verbose = verbose, intern = TRUE)
}
