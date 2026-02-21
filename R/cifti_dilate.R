#' Dilate a CIFTI file
#'
#' Wraps `wb_command -cifti-dilate` to fill in zeros or missing data
#' with values from nearby brainordinates.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param direction Direction to dilate. One of `"COLUMN"` or `"ROW"`.
#' @param surface_distance Surface dilation distance in mm.
#' @param volume_distance Volume dilation distance in mm.
#' @param cifti_out Path for the output CIFTI file.
#' @param left_surface Path to the left hemisphere surface.
#' @param right_surface Path to the right hemisphere surface.
#' @param nearest Logical; use nearest good value instead of weighted average?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_dilate(
#'   "data.dscalar.nii",
#'   direction = "COLUMN",
#'   surface_distance = 10,
#'   volume_distance = 10,
#'   cifti_out = "dilated.dscalar.nii",
#'   left_surface = "left.midthickness.surf.gii",
#'   right_surface = "right.midthickness.surf.gii"
#' )
#' }
#'
#' @wbHelp -cifti-dilate
#' @export
cifti_dilate <- function(
  cifti_in,
  direction = c("COLUMN", "ROW"),
  surface_distance,
  volume_distance,
  cifti_out,
  left_surface = NULL,
  right_surface = NULL,
  nearest = FALSE,
  verbose = get_wb_verbosity()
) {
  check_path(cifti_in, arg = "cifti_in")
  direction <- match.arg(direction)
  cifti_out <- validate_outfile(cifti_out, ext = ".dscalar.nii")

  args <- c(
    shQuote(cifti_in),
    direction,
    surface_distance,
    volume_distance,
    shQuote(cifti_out)
  )

  if (!is.null(left_surface)) {
    check_path(left_surface, arg = "left_surface")
    args <- c(args, "-left-surface", shQuote(left_surface))
  }
  if (!is.null(right_surface)) {
    check_path(right_surface, arg = "right_surface")
    args <- c(args, "-right-surface", shQuote(right_surface))
  }
  if (nearest) {
    args <- c(args, "-nearest")
  }

  wb_cmd("-cifti-dilate", args, verbose = verbose)
}
