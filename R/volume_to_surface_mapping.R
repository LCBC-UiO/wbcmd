#' Map volume data to a surface
#'
#' Wraps `wb_command -volume-to-surface-mapping` to project volume data
#' onto a surface mesh.
#'
#' @param volume_in Path to the input volume file.
#' @param surface Path to the surface to map onto.
#' @param metric_out Path for the output metric file.
#' @param method Mapping method. One of `"trilinear"`, `"enclosing"`,
#'   `"cubic"`, `"ribbon-constrained"`, `"myelin-style"`.
#' @param inner_surface Path to the inner surface (required for
#'   `"ribbon-constrained"` and `"myelin-style"`).
#' @param outer_surface Path to the outer surface (required for
#'   `"ribbon-constrained"` and `"myelin-style"`).
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' volume_to_surface_mapping(
#'   "bold.nii.gz",
#'   "lh.midthickness.surf.gii",
#'   "lh.bold.func.gii",
#'   method = "ribbon-constrained",
#'   inner_surface = "lh.white.surf.gii",
#'   outer_surface = "lh.pial.surf.gii"
#' )
#' }
#'
#' @wbHelp -volume-to-surface-mapping
#' @export
volume_to_surface_mapping <- function(
  volume_in,
  surface,
  metric_out,
  method = c(
    "trilinear",
    "enclosing",
    "cubic",
    "ribbon-constrained",
    "myelin-style"
  ),
  inner_surface = NULL,
  outer_surface = NULL,
  verbose = get_wb_verbosity()
) {
  check_path(volume_in, arg = "volume_in")
  check_path(surface, arg = "surface")
  method <- match.arg(method)
  metric_out <- validate_outfile(metric_out, ext = ".func.gii")

  args <- c(shQuote(volume_in), shQuote(surface), shQuote(metric_out))

  if (method %in% c("ribbon-constrained", "myelin-style")) {
    check_path(inner_surface, arg = "inner_surface")
    check_path(outer_surface, arg = "outer_surface")
    args <- c(
      args,
      paste0("-", method),
      shQuote(inner_surface),
      shQuote(outer_surface)
    )
  } else {
    args <- c(args, paste0("-", method))
  }

  wb_cmd("-volume-to-surface-mapping", args, verbose = verbose)
}
