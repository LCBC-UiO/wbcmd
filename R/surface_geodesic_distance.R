#' Compute geodesic distance from a vertex
#'
#' Wraps `wb_command -surface-geodesic-distance` to compute the geodesic
#' distance from a single vertex to all other vertices on a surface.
#'
#' @param surface_in Path to the input surface file.
#' @param vertex Index of the source vertex (0-indexed).
#' @param metric_out Path for the output metric file.
#' @param limit Maximum geodesic distance in mm. Vertices beyond this
#'   distance get value `-1`.
#' @param corrected_areas Path to a metric file of corrected vertex areas
#'   (for group-average surfaces).
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' surface_geodesic_distance(
#'   "lh.midthickness.surf.gii",
#'   vertex = 0,
#'   metric_out = "geodesic.func.gii",
#'   limit = 100
#' )
#' }
#'
#' @wbHelp -surface-geodesic-distance
#' @export
surface_geodesic_distance <- function(
  surface_in,
  vertex,
  metric_out,
  limit = NULL,
  corrected_areas = NULL,
  verbose = get_wb_verbosity()
) {
  check_path(surface_in, arg = "surface_in")
  metric_out <- validate_outfile(metric_out, ext = ".func.gii")

  args <- c(shQuote(surface_in), vertex, shQuote(metric_out))

  if (!is.null(limit)) {
    args <- c(args, "-limit", limit)
  }
  if (!is.null(corrected_areas)) {
    check_path(corrected_areas, arg = "corrected_areas")
    args <- c(args, "-corrected-areas", shQuote(corrected_areas))
  }

  wb_cmd("-surface-geodesic-distance", args, verbose = verbose)
}
