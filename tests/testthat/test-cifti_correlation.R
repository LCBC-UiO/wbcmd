describe("cifti_correlation()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dtseries.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_correlation(f, tempfile(fileext = ".dconn.nii"), verbose = FALSE)

    expect_match(captured$cmd, "-cifti-correlation")
  })

  it("includes fisher-z flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dtseries.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_correlation(f, tempfile(fileext = ".dconn.nii"),
                      fisher_z = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-fisher-z")
  })

  it("includes covariance flag", {
    captured <- capture_wb_cmd()
    f <- tempfile(fileext = ".dtseries.nii")
    file.create(f)
    withr::defer(unlink(f))

    cifti_correlation(f, tempfile(fileext = ".dconn.nii"),
                      covariance = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-covariance")
  })
})
