#' Measure distortion between surfaces
#'
#' Wraps `wb_command -surface-distortion` to compute distortion between
#' two surfaces on the same mesh.
#'
#' @param surface_reference Path to the reference surface.
#' @param surface_distorted Path to the distorted surface.
#' @param metric_out Path for the output distortion metric file.
#' @param smooth Smoothing sigma for area distortion (mm). Only used
#'   with the default area-based method.
#' @param caret5_method Logical; use the Caret5 method?
#' @param edge_method Logical; use edge-based distortion?
#' @param local_affine_method Logical; use local affine method?
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' surface_distortion(
#'   "lh.sphere.surf.gii",
#'   "lh.sphere.reg.surf.gii",
#'   "lh.distortion.func.gii"
#' )
#' }
#'
#' @wbHelp -surface-distortion
#' @export
surface_distortion <- function(
  surface_reference,
  surface_distorted,
  metric_out,
  smooth = NULL,
  caret5_method = FALSE,
  edge_method = FALSE,
  local_affine_method = FALSE,
  verbose = get_wb_verbosity()
) {
  check_path(surface_reference, arg = "surface_reference")
  check_path(surface_distorted, arg = "surface_distorted")
  metric_out <- validate_outfile(metric_out, ext = ".func.gii")

  args <- c(
    shQuote(surface_reference),
    shQuote(surface_distorted),
    shQuote(metric_out)
  )

  if (!is.null(smooth)) {
    args <- c(args, "-smooth", smooth)
  }
  if (caret5_method) {
    args <- c(args, "-caret5-method")
  }
  if (edge_method) {
    args <- c(args, "-edge-method")
  }
  if (local_affine_method) {
    args <- c(args, "-local-affine-method")
  }

  wb_cmd("-surface-distortion", args, verbose = verbose)
}
