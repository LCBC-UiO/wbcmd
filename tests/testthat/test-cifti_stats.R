describe("cifti_stats()", {
  it("constructs command with reduce operation", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_stats(f, operation = "MEAN", verbose = FALSE)

    expect_match(captured$cmd, "-cifti-stats")
    expect_match(captured$cmd, "-reduce MEAN")
  })

  it("constructs command with percentile", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_stats(f, percentile = 95, verbose = FALSE)

    expect_match(captured$cmd, "-percentile 95")
  })

  it("includes column and roi options", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    roi <- tempfile(fileext = ".dscalar.nii")
    file.create(f, roi)
    withr::defer(unlink(c(f, roi)))

    cifti_stats(f, operation = "MEAN", column = 1, roi = roi,
                verbose = FALSE)

    expect_match(captured$cmd, "-column 1")
    expect_match(captured$cmd, "-roi")
  })
})
