describe("cifti_math()", {
  it("constructs correct command with variables", {
    captured <- capture_wb_cmd()

    f1 <- tempfile(fileext = ".dscalar.nii")
    f2 <- tempfile(fileext = ".dscalar.nii")
    file.create(f1, f2)
    withr::defer(unlink(c(f1, f2)))

    cifti_math(
      "(x + y) / 2",
      cifti_out = tempfile(fileext = ".dscalar.nii"),
      var = list(x = f1, y = f2),
      verbose = FALSE
    )

    expect_match(captured$cmd, "-cifti-math")
    expect_match(captured$cmd, "\\(x \\+ y\\) / 2")
    expect_match(captured$cmd, "-var 'x'")
    expect_match(captured$cmd, "-var 'y'")
  })

  it("adds fixnan flag", {
    captured <- capture_wb_cmd()
    f1 <- tempfile(fileext = ".dscalar.nii")
    file.create(f1)
    withr::defer(unlink(f1))

    cifti_math("x * 2", tempfile(fileext = ".dscalar.nii"),
               var = list(x = f1), fixnan = TRUE, verbose = FALSE)

    expect_match(captured$cmd, "-fixnan")
  })

  it("errors on missing input file", {
    expect_error(
      cifti_math("x", tempfile(), var = list(x = "/nonexistent.nii")),
      class = "wbcmd_error"
    )
  })
})
