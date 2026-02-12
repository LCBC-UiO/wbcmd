describe("cifti_average()", {
  it("constructs command with multiple inputs", {
    captured <- capture_wb_cmd()
    files <- replicate(3, tempfile(fileext = ".dscalar.nii"))
    file.create(files)
    withr::defer(unlink(files))

    cifti_average(tempfile(fileext = ".dscalar.nii"), files,
                  verbose = FALSE)

    expect_match(captured$cmd, "-cifti-average")
    for (f in files) {
      expect_match(captured$cmd, basename(f), fixed = TRUE)
    }
  })

  it("includes weights per file", {
    captured <- capture_wb_cmd()
    files <- replicate(2, tempfile(fileext = ".dscalar.nii"))
    file.create(files)
    withr::defer(unlink(files))

    cifti_average(tempfile(fileext = ".dscalar.nii"), files,
                  weights = c(0.6, 0.4), verbose = FALSE)

    expect_match(captured$cmd, "-weight 0.6")
    expect_match(captured$cmd, "-weight 0.4")
  })

  it("errors on missing input files", {
    expect_error(
      cifti_average(tempfile(), c("/no/file1.nii", "/no/file2.nii")),
      class = "wbcmd_error"
    )
  })
})
