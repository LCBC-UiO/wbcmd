#' Check that a file exists
#'
#' @param path File path to check.
#' @param arg Argument name for error messages.
#' @param call Calling environment.
#'
#' @return The normalized path, invisibly.
#' @noRd
check_path <- function(path, arg = "file", call = rlang::caller_env()) {
  if (is.null(path) || !file.exists(path)) {
    wb_abort(
      "File not found: {.path {path}} ({.arg {arg}}).",
      call = call
    )
  }
  invisible(normalizePath(path, mustWork = FALSE))
}

#' Check multiple files exist
#'
#' @param paths Character vector of file paths.
#' @param arg Argument name for error messages.
#' @param call Calling environment.
#'
#' @return The paths, invisibly.
#' @noRd
batch_file_exists <- function(paths, arg = "files", call = rlang::caller_env()) {
  missing <- !file.exists(paths)
  if (any(missing)) {
    wb_abort(
      c(
        "Missing {arg} file{?s}:",
        "x" = "{.path {paths[missing]}}"
      ),
      call = call
    )
  }
  invisible(paths)
}

#' Validate and prepare output file path
#'
#' @param outfile Output file path, or `NULL` for temp file.
#' @param ext Default extension for temp files.
#'
#' @return Normalized output file path.
#' @noRd
validate_outfile <- function(outfile = NULL, ext = ".nii") {
  if (is.null(outfile)) {
    outfile <- temp_file(ext = ext)
  }
  outdir <- dirname(outfile)
  if (!dir.exists(outdir)) {
    mkdir(outdir)
  }
  normalizePath(outfile, mustWork = FALSE)
}

#' Validate file extension
#'
#' @param path File path.
#' @param valid_extensions Character vector of valid extensions.
#' @param arg Argument name for messages.
#'
#' @return `TRUE` invisibly.
#' @noRd
validate_extension <- function(path, valid_extensions, arg = "file") {
  ext <- tools::file_ext(path)
  if (grepl("\\.nii\\.gz$", path)) ext <- "nii.gz"
  if (grepl("\\.dscalar\\.nii$", path)) ext <- "dscalar.nii"
  if (grepl("\\.dtseries\\.nii$", path)) ext <- "dtseries.nii"
  if (grepl("\\.dlabel\\.nii$", path)) ext <- "dlabel.nii"
  if (grepl("\\.pscalar\\.nii$", path)) ext <- "pscalar.nii"
  if (grepl("\\.ptseries\\.nii$", path)) ext <- "ptseries.nii"
  if (grepl("\\.plabel\\.nii$", path)) ext <- "plabel.nii"

  if (nzchar(ext) && !ext %in% valid_extensions) {
    wb_warn(
      "Unexpected extension {.val {ext}} for {.arg {arg}}. Expected one of: {.val {valid_extensions}}."
    )
  }
  invisible(TRUE)
}
