#' @importFrom roxygen2 roxy_tag_parse roxy_tag_rd rd_section
#' @export
roxy_tag_parse.roxy_tag_wbHelp <- function(x) {
  x$val <- list(cmd = trimws(x$raw))
  x
}

#' @export
roxy_tag_rd.roxy_tag_wbHelp <- function(x, base_path, env) {
  roxygen2::rd_section("wbHelp", x$val)
}

#' @export
format.rd_section_wbHelp <- function(x, ...) {
  paste0(
    "\\section{Connectome Workbench Help}{\n",
    "\\Sexpr[results=rd,stage=render]{wbcmd::wb_help_rd(\"",
    x$value$cmd, "\")}\n",
    "}\n"
  )
}
