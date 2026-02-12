describe("file_information()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    file_information(f, verbose = FALSE)

    expect_match(captured$cmd, "-file-information")
  })

  it("includes only-map-names flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    file_information(f, only_map_names = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-only-map-names")
  })

  it("includes only-number-of-maps flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    file_information(f, only_number_of_maps = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-only-number-of-maps")
  })

  it("returns info for a real file", {
    skip_if_no_wb()
    sphere <- create_test_sphere()
    withr::defer(unlink(sphere))

    info <- file_information(sphere, verbose = FALSE)

    expect_type(info, "character")
    expect_true(length(info) > 0)
  })

  it("errors on missing file", {
    expect_error(
      file_information("/nonexistent/file.nii"),
      class = "wbcmd_error"
    )
  })
})
