#' Compute vertex areas of a surface
#'
#' Wraps `wb_command -surface-vertex-areas` to measure the surface area
#' (in mm^2) that each vertex is responsible for.
#'
#' @param surface_in Path to the input surface file.
#' @param metric_out Path for the output metric file.
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' surface_vertex_areas(
#'   "lh.midthickness.surf.gii",
#'   "lh.vertex_areas.func.gii"
#' )
#' }
#'
#' @export
surface_vertex_areas <- function(surface_in,
                                 metric_out,
                                 verbose = get_wb_verbosity()) {
  check_path(surface_in, arg = "surface_in")
  metric_out <- validate_outfile(metric_out, ext = ".func.gii")

  args <- c(shQuote(surface_in), shQuote(metric_out))

  wb_cmd("-surface-vertex-areas", args, verbose = verbose)
}
