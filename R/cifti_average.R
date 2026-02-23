#' Average multiple CIFTI files
#'
#' Wraps `wb_command -cifti-average` to compute the element-wise average
#' across multiple CIFTI files.
#'
#' @param cifti_out Path for the output averaged CIFTI file.
#' @param cifti_in Character vector of input CIFTI file paths.
#' @param weights Optional numeric vector of weights (same length as
#'   `cifti_in`).
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_average(
#'   "group_mean.dscalar.nii",
#'   c("subj01.dscalar.nii", "subj02.dscalar.nii", "subj03.dscalar.nii")
#' )
#' }
#'
#' @wbHelp -cifti-average
#' @export
cifti_average <- function(
  cifti_out,
  cifti_in,
  weights = NULL,
  verbose = get_wb_verbosity()
) {
  batch_file_exists(cifti_in, arg = "cifti_in")
  cifti_out <- validate_outfile(cifti_out, ext = ".dscalar.nii")

  args <- cifti_out

  for (i in seq_along(cifti_in)) {
    args <- c(args, "-cifti", cifti_in[[i]])
    if (!is.null(weights)) {
      args <- c(args, "-weight", weights[[i]])
    }
  }

  wb_cmd("-cifti-average", args, verbose = verbose)
}
