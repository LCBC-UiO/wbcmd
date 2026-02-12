describe("check_wb_result()", {
  it("errors on failed command with no output", {
    expect_error(
      check_wb_result(
        res = 1L,
        fe_before = FALSE,
        fe_after = FALSE,
        outfile = "/fake/out.nii",
        cmd_name = "test-cmd"
      ),
      class = "wbcmd_error"
    )
  })

  it("warns on success with missing output", {
    expect_warning(
      check_wb_result(
        res = 0L,
        fe_before = FALSE,
        fe_after = FALSE,
        outfile = "/fake/out.nii",
        cmd_name = "test-cmd"
      ),
      class = "wbcmd_warning"
    )
  })

  it("warns on failure with stale output", {
    expect_warning(
      check_wb_result(
        res = 1L,
        fe_before = TRUE,
        fe_after = TRUE,
        outfile = "/fake/out.nii",
        cmd_name = "test-cmd"
      ),
      class = "wbcmd_warning"
    )
  })

  it("warns on failure with possibly incomplete output", {
    expect_warning(
      check_wb_result(
        res = 1L,
        fe_before = FALSE,
        fe_after = TRUE,
        outfile = "/fake/out.nii",
        cmd_name = "test-cmd"
      ),
      class = "wbcmd_warning"
    )
  })

  it("returns silently on success with output", {
    expect_silent(
      result <- check_wb_result(
        res = 0L,
        fe_before = FALSE,
        fe_after = TRUE,
        outfile = "/fake/out.nii",
        cmd_name = "test-cmd"
      )
    )
    expect_equal(result, 0L)
  })

  it("returns result invisibly", {
    res <- check_wb_result(res = 0L, fe_before = NA, fe_after = NA)
    expect_equal(res, 0L)
  })
})

describe("extract_exit_status()", {
  it("extracts status attribute from intern=TRUE result", {
    res <- "some output"
    attr(res, "status") <- 1L
    expect_equal(extract_exit_status(res), 1L)
  })

  it("returns numeric value directly", {
    expect_equal(extract_exit_status(0L), 0L)
    expect_equal(extract_exit_status(1L), 1L)
  })

  it("defaults to 0 for character output without status", {
    expect_equal(extract_exit_status("some output"), 0L)
  })
})
