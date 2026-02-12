#' Reduce a CIFTI file along a dimension
#'
#' Wraps `wb_command -cifti-reduce` to perform a reduction operation
#' (e.g. mean, stdev) along a specified direction.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param direction Direction to reduce. One of `"ROW"` or `"COLUMN"`.
#' @param operation Reduction operation. One of `"MAX"`, `"MIN"`, `"INDEXMAX"`,
#'   `"INDEXMIN"`, `"SUM"`, `"PRODUCT"`, `"MEAN"`, `"STDEV"`, `"SAMPSTDEV"`,
#'   `"VARIANCE"`, `"TSNR"`, `"COV"`, `"L2NORM"`, `"MEDIAN"`, `"MODE"`,
#'   `"COUNT_NONZERO"`.
#' @param cifti_out Path for the output CIFTI file.
#' @param only_numeric Logical; exclude non-numeric values?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_reduce(
#'   "data.dtseries.nii",
#'   direction = "ROW",
#'   operation = "MEAN",
#'   cifti_out = "mean.dscalar.nii"
#' )
#' }
#'
#' @export
cifti_reduce <- function(cifti_in,
                         direction = c("ROW", "COLUMN"),
                         operation = "MEAN",
                         cifti_out,
                         only_numeric = FALSE,
                         verbose = get_wb_verbosity()) {
  check_path(cifti_in, arg = "cifti_in")
  direction <- match.arg(direction)
  cifti_out <- validate_outfile(cifti_out, ext = ".dscalar.nii")

  args <- c(shQuote(cifti_in), operation, direction, shQuote(cifti_out))

  if (only_numeric) args <- c(args, "-only-numeric")

  wb_cmd("-cifti-reduce", args, verbose = verbose)
}
