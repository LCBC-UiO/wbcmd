#' Find clusters in a CIFTI file
#'
#' Wraps `wb_command -cifti-find-clusters` to threshold a CIFTI file and
#' filter clusters by surface area and volume size.
#'
#' @param cifti_in Path to the input CIFTI file.
#' @param surface_value_threshold Minimum value for surface vertices.
#' @param surface_minimum_area Minimum cluster surface area (mm^2).
#' @param volume_value_threshold Minimum value for volume voxels.
#' @param volume_minimum_size Minimum cluster volume size (mm^3).
#' @param direction Direction to use. One of `"ROW"` or `"COLUMN"`.
#' @param cifti_out Path for the output CIFTI file.
#' @param left_surface Path to the left hemisphere surface.
#' @param right_surface Path to the right hemisphere surface.
#' @param less_than Logical; find clusters below threshold instead of above?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' cifti_find_clusters(
#'   "zstats.dscalar.nii",
#'   surface_value_threshold = 2.3,
#'   surface_minimum_area = 100,
#'   volume_value_threshold = 2.3,
#'   volume_minimum_size = 200,
#'   direction = "COLUMN",
#'   cifti_out = "clusters.dscalar.nii",
#'   left_surface = "left.midthickness.surf.gii",
#'   right_surface = "right.midthickness.surf.gii"
#' )
#' }
#'
#' @export
cifti_find_clusters <- function(cifti_in,
                                surface_value_threshold,
                                surface_minimum_area,
                                volume_value_threshold,
                                volume_minimum_size,
                                direction = c("COLUMN", "ROW"),
                                cifti_out,
                                left_surface = NULL,
                                right_surface = NULL,
                                less_than = FALSE,
                                verbose = get_wb_verbosity()) {
  check_path(cifti_in, arg = "cifti_in")
  direction <- match.arg(direction)
  cifti_out <- validate_outfile(cifti_out, ext = ".dscalar.nii")

  args <- c(
    shQuote(cifti_in),
    surface_value_threshold,
    surface_minimum_area,
    volume_value_threshold,
    volume_minimum_size,
    direction,
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
  if (less_than) args <- c(args, "-less-than")

  wb_cmd("-cifti-find-clusters", args, verbose = verbose)
}
