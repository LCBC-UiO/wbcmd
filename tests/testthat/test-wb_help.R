describe("wb_help_rd()", {
  it("returns fallback when workbench not available", {
    local_mocked_bindings(have_wb = function(...) FALSE)
    result <- wb_help_rd("-cifti-average")
    expect_match(result, "Connectome Workbench is not installed")
    expect_match(result, "-cifti-average")
  })

  it("includes cmd in fallback message", {
    local_mocked_bindings(have_wb = function(...) FALSE)
    result <- wb_help_rd("-surface-curvature")
    expect_match(result, "-surface-curvature")
  })

  it("returns 'not available' when command errors", {
    local_mocked_bindings(
      have_wb = function(...) TRUE,
      get_wb_path = function(...) stop("no wb_command")
    )
    result <- wb_help_rd("-cifti-average")
    expect_match(result, "Help not available")
    expect_match(result, "-cifti-average")
  })

  it("rejects invalid cmd values", {
    result <- wb_help_rd("'; rm -rf /; echo '")
    expect_match(result, "Invalid command")
  })

  it("escapes special Rd characters in output", {
    local_mocked_bindings(
      have_wb = function(...) TRUE,
      get_wb_path = function(...) "/fake/wb_command",
      try_wb_cmd = function(...) c("Usage: {cmd} [options]", "100%", "# comment")
    )
    result <- wb_help_rd("-cifti-average")
    expect_match(result, "\\\\\\{cmd\\\\\\}")
    expect_match(result, "100\\\\%")
    expect_match(result, "\\\\#")
    expect_match(result, "^\\\\preformatted\\{")
  })
})

describe("roxy_tag_parse.roxy_tag_wbHelp", {
  skip_if_not_installed("roxygen2")

  make_tag <- function(raw) {
    structure(list(raw = raw), class = c("roxy_tag_wbHelp", "roxy_tag"))
  }

  it("parses subcommand name", {
    tag <- make_tag("-cifti-average")
    result <- roxygen2::roxy_tag_parse(tag)
    expect_equal(result$val$cmd, "-cifti-average")
  })

  it("trims whitespace from raw input", {
    tag <- make_tag("  -surface-curvature  ")
    result <- roxygen2::roxy_tag_parse(tag)
    expect_equal(result$val$cmd, "-surface-curvature")
  })
})

describe("format.rd_section_wbHelp", {
  make_section <- function(cmd) {
    structure(
      list(value = list(cmd = cmd)),
      class = "rd_section_wbHelp"
    )
  }

  it("generates Sexpr with correct cmd", {
    section <- make_section("-cifti-average")
    result <- format(section)
    expect_match(result, "Connectome Workbench Help")
    expect_match(result, 'wbcmd::wb_help_rd\\("-cifti-average"\\)')
    expect_match(result, "Sexpr\\[results=rd,stage=render\\]")
  })

  it("generates Sexpr for surface commands", {
    section <- make_section("-surface-curvature")
    result <- format(section)
    expect_match(result, 'wbcmd::wb_help_rd\\("-surface-curvature"\\)')
  })
})
