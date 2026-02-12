#' Create temporary file with directory
#'
#' @param ext File extension (including dot).
#'
#' @return Path to a temporary file.
#' @noRd
temp_file <- function(ext = "") {
  tempfile(tmpdir = tempdir(), fileext = ext)
}

#' Silently create directories
#'
#' @param path Directory path to create.
#'
#' @return `TRUE` if directory was created or already exists.
#' @noRd
mkdir <- function(path) {
  dir.create(path, showWarnings = FALSE, recursive = TRUE)
}

#' Gather system information
#'
#' @return Named list with platform, r_version, and shell.
#' @noRd
sys_info <- function() {
  list(
    platform = R.version$platform,
    r_version = paste0(R.version$major, ".", R.version$minor),
    os = utils::sessionInfo()$running %||% "Unknown",
    shell = Sys.getenv("SHELL", "Unknown")
  )
}

#' Validate workbench environment
#'
#' @param call Calling environment for error reporting.
#'
#' @return `TRUE` invisibly if workbench is available.
#' @noRd
validate_wb_env <- function(call = rlang::caller_env()) {
  if (!have_wb()) {
    wb_abort(
      c(
        "Connectome Workbench not found.",
        "i" = "Set the path with {.fn set_wb_path} or {.envvar WB_PATH}.",
        "i" = "Run {.fn wb_sitrep} for diagnostics."
      ),
      call = call
    )
  }
  invisible(TRUE)
}
