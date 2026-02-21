#' Compute statistics on a CIFTI file
#'
#' Wraps `wb_command -cifti-stats` to compute statistics along CIFTI columns.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param operation Reduction operation. One of `"MAX"`, `"MIN"`, `"INDEXMAX"`,
#'   `"INDEXMIN"`, `"SUM"`, `"PRODUCT"`, `"MEAN"`, `"STDEV"`, `"SAMPSTDEV"`,
#'   `"VARIANCE"`, `"TSNR"`, `"COV"`, `"L2NORM"`, `"MEDIAN"`, `"MODE"`,
#'   `"COUNT_NONZERO"`.
#' @param percentile Numeric percentile to compute (alternative to `operation`).
#' @param column Integer; compute for a single column only (1-indexed).
#' @param roi Path to a CIFTI ROI file.
#' @param show_map_name Logical; print map name before each result?
#' @param verbose Logical; print command output?
#'
#' @return Character vector of output lines (stats values).
#'
#' @examples
#' \dontrun{
#' cifti_stats("data.dscalar.nii", operation = "MEAN")
#' cifti_stats("data.dscalar.nii", percentile = 95)
#' }
#'
#' @wbHelp -cifti-stats
#' @export
cifti_stats <- function(
  cifti_in,
  operation = NULL,
  percentile = NULL,
  column = NULL,
  roi = NULL,
  show_map_name = FALSE,
  verbose = get_wb_verbosity()
) {
  check_path(cifti_in, arg = "cifti_in")

  args <- shQuote(cifti_in)

  if (!is.null(operation)) {
    args <- c(args, "-reduce", operation)
  } else if (!is.null(percentile)) {
    args <- c(args, "-percentile", percentile)
  }

  if (!is.null(column)) {
    args <- c(args, "-column", column)
  }
  if (!is.null(roi)) {
    check_path(roi, arg = "roi")
    args <- c(args, "-roi", shQuote(roi))
  }
  if (show_map_name) {
    args <- c(args, "-show-map-name")
  }

  wb_cmd("-cifti-stats", args, verbose = verbose, intern = TRUE)
}
