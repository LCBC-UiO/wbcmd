describe("cifti_parcellate()", {
  it("constructs correct command", {
    captured <- capture_wb_cmd()

    f_in <- tempfile(fileext = ".dtseries.nii")
    f_label <- tempfile(fileext = ".dlabel.nii")
    file.create(f_in, f_label)
    withr::defer(unlink(c(f_in, f_label)))

    cifti_parcellate(
      f_in, f_label,
      direction = "COLUMN",
      cifti_out = tempfile(fileext = ".ptseries.nii"),
      verbose = FALSE
    )

    expect_match(captured$cmd, "-cifti-parcellate")
    expect_match(captured$cmd, "COLUMN")
  })

  it("includes method argument", {
    captured <- capture_wb_cmd()

    f_in <- tempfile(fileext = ".dtseries.nii")
    f_label <- tempfile(fileext = ".dlabel.nii")
    file.create(f_in, f_label)
    withr::defer(unlink(c(f_in, f_label)))

    cifti_parcellate(
      f_in, f_label,
      direction = "COLUMN",
      cifti_out = tempfile(fileext = ".ptseries.nii"),
      method = "MEDIAN",
      verbose = FALSE
    )

    expect_match(captured$cmd, "-method MEDIAN")
  })

  it("errors on missing input", {
    expect_error(
      cifti_parcellate("/no/such/file.nii", "/no/label.nii",
                       cifti_out = tempfile()),
      class = "wbcmd_error"
    )
  })
})
