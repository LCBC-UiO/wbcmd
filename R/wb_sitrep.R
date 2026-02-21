#' Situation report for Connectome Workbench
#'
#' Prints a diagnostic summary of the workbench environment, including
#' path detection, version, and system information.
#'
#' @return A list of diagnostic information, invisibly.
#'
#' @examples
#' wb_sitrep()
#'
#' @export
wb_sitrep <- function() {
  cli::cli_h1("Connectome Workbench situation report")

  path_info <- get_wb_path(simplify = FALSE)
  verbose <- get_wb_verbosity()

  cli::cli_h2("Settings")
  alert_info(path_info, "wb_command path")
  cli::cli_alert_info("Verbose: {.val {verbose}}")

  cli::cli_h2("System")
  si <- sys_info()
  cli::cli_alert_info("Platform: {.val {si$platform}}")
  cli::cli_alert_info("OS: {.val {si$os}}")
  cli::cli_alert_info("R: {.val {si$r_version}}")

  cli::cli_h2("Diagnostics")
  available <- have_wb()
  if (available) {
    cli::cli_alert_success("wb_command found")
    version <- wb_version()
    if (nzchar(version)) {
      cli::cli_alert_info("Version: {.val {version}}")
    }
  } else {
    cli::cli_alert_danger("wb_command not found")
  }

  cli::cli_h2("Recommendations")
  if (!available) {
    cli::cli_alert_warning(
      "Install Connectome Workbench from {.url https://www.humanconnectome.org/software/connectome-workbench}"
    )
    cli::cli_alert_info(
      "Set the path with {.fn set_wb_path} or the {.envvar WB_PATH} environment variable."
    )
  } else {
    cli::cli_alert_success("Everything looks good!")
  }

  invisible(list(
    path = path_info,
    verbose = verbose,
    available = available,
    system = si
  ))
}

#' Print setting information
#'
#' @param setting Settings list from [get_wb_setting()].
#' @param header Display header.
#'
#' @return `NULL` invisibly.
#' @noRd
alert_info <- function(setting, header) {
  if (is.null(setting$value)) {
    cli::cli_alert_danger("{header}: not set")
    return(invisible(NULL))
  }

  status <- if (setting$exists) "success" else "warning"
  fn <- switch(
    status,
    success = cli::cli_alert_success,
    warning = cli::cli_alert_warning
  )

  fn("{header}: {.path {setting$value}}")
  cli::cli_alert_info("Source: {.val {setting$source}}")
  invisible(NULL)
}
