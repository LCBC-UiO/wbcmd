describe("cifti_reduce()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dtseries.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_reduce(f, direction = "ROW", operation = "MEAN",
                 cifti_out = tempfile(fileext = ".dscalar.nii"),
                 verbose = FALSE)

    expect_match(captured$cmd, "-cifti-reduce")
    expect_match(captured$cmd, "MEAN ROW")
  })

  it("includes only-numeric flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dtseries.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_reduce(f, direction = "COLUMN", operation = "STDEV",
                 cifti_out = tempfile(fileext = ".dscalar.nii"),
                 only_numeric = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-only-numeric")
    expect_match(captured$cmd, "STDEV COLUMN")
  })
})
