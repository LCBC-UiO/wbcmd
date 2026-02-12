describe("cifti_weighted_stats()", {
  it("constructs command with spatial weights", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_weighted_stats(f, operation = "MEAN",
                         spatial_weights = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-cifti-weighted-stats")
    expect_match(captured$cmd, "-spatial-weights")
    expect_match(captured$cmd, "-mean")
  })

  it("constructs command with cifti weights", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    w <- tempfile(fileext = ".dscalar.nii")
    file.create(f, w)
    withr::defer(unlink(c(f, w)))

    cifti_weighted_stats(f, operation = "SUM",
                         cifti_weights = w, verbose = FALSE)

    expect_match(captured$cmd, "-cifti-weights")
    expect_match(captured$cmd, "-sum")
  })

  it("constructs command with percentile", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dscalar.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_weighted_stats(f, percentile = 50,
                         spatial_weights = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-percentile 50")
  })
})
