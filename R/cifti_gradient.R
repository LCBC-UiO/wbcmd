#' Compute gradient of a CIFTI file
#'
#' Wraps `wb_command -cifti-gradient` to compute the spatial gradient
#' of each column in a CIFTI file.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param direction Direction to take gradient. One of `"COLUMN"` or `"ROW"`.
#' @param cifti_out Path for the output gradient CIFTI file.
#' @param left_surface Path to the left hemisphere surface.
#' @param right_surface Path to the right hemisphere surface.
#' @param surface_presmooth Surface pre-smoothing sigma in mm.
#' @param volume_presmooth Volume pre-smoothing sigma in mm.
#' @param average_output Logical; average the gradient across all maps?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_gradient(
#'   "data.dscalar.nii",
#'   direction = "COLUMN",
#'   cifti_out = "gradient.dscalar.nii",
#'   left_surface = "left.midthickness.surf.gii",
#'   right_surface = "right.midthickness.surf.gii"
#' )
#' }
#'
#' @export
cifti_gradient <- function(cifti_in,
                           direction = c("COLUMN", "ROW"),
                           cifti_out,
                           left_surface = NULL,
                           right_surface = NULL,
                           surface_presmooth = NULL,
                           volume_presmooth = NULL,
                           average_output = FALSE,
                           verbose = get_wb_verbosity()) {
  check_path(cifti_in, arg = "cifti_in")
  direction <- match.arg(direction)
  cifti_out <- validate_outfile(cifti_out, ext = ".dscalar.nii")

  args <- c(shQuote(cifti_in), direction, shQuote(cifti_out))

  if (!is.null(left_surface)) {
    check_path(left_surface, arg = "left_surface")
    args <- c(args, "-left-surface", shQuote(left_surface))
  }
  if (!is.null(right_surface)) {
    check_path(right_surface, arg = "right_surface")
    args <- c(args, "-right-surface", shQuote(right_surface))
  }
  if (!is.null(surface_presmooth)) {
    args <- c(args, "-surface-presmooth", surface_presmooth)
  }
  if (!is.null(volume_presmooth)) {
    args <- c(args, "-volume-presmooth", volume_presmooth)
  }
  if (average_output) args <- c(args, "-average-output")

  wb_cmd("-cifti-gradient", args, verbose = verbose)
}
