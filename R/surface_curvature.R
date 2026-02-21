#' Compute surface curvature
#'
#' Wraps `wb_command -surface-curvature` to compute mean and/or
#' Gaussian curvature of a surface.
#'
#' @param surface_in Path to the input surface file.
#' @param mean_out Path for the output mean curvature metric file.
#' @param gauss_out Path for the output Gaussian curvature metric file.
#' @param verbose Logical; print command output?
#'
#' @return The result of the underlying [wb_cmd()] call.
#'
#' @examples
#' \dontrun{
#' surface_curvature(
#'   "lh.midthickness.surf.gii",
#'   mean_out = "lh.mean_curv.func.gii"
#' )
#' }
#'
#' @wbHelp -surface-curvature
#' @export
surface_curvature <- function(
  surface_in,
  mean_out = NULL,
  gauss_out = NULL,
  verbose = get_wb_verbosity()
) {
  check_path(surface_in, arg = "surface_in")

  args <- shQuote(surface_in)

  if (!is.null(mean_out)) {
    mean_out <- validate_outfile(mean_out, ext = ".func.gii")
    args <- c(args, "-mean", shQuote(mean_out))
  }
  if (!is.null(gauss_out)) {
    gauss_out <- validate_outfile(gauss_out, ext = ".func.gii")
    args <- c(args, "-gauss", shQuote(gauss_out))
  }

  wb_cmd("-surface-curvature", args, verbose = verbose)
}
