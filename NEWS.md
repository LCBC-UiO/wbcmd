# wbcmd 0.0.0.9000

* Initial package scaffold with core dispatcher architecture.
* Added `wb_cmd()` central dispatcher for all `wb_command` operations.
* Added environment detection: `get_wb_path()`, `have_wb()`, `wb_version()`,
  `set_wb_path()`.
* Added hierarchical settings lookup via `get_wb_setting()`.
* Added `wb_sitrep()` situation report for diagnostics.
* Added `wb_help()` to access `wb_command` help text.
* Added CIFTI wrappers: `cifti_parcellate()`, `cifti_math()`,
  `cifti_correlation()`, `cifti_reduce()`, `cifti_average()`,
  `cifti_find_clusters()`, `cifti_stats()`, `cifti_weighted_stats()`,
  `cifti_dilate()`, `cifti_gradient()`.
* Added surface wrappers: `surface_generate_inflated()`,
  `surface_geodesic_distance()`, `surface_vertex_areas()`,
  `surface_curvature()`, `surface_distortion()`, `surface_information()`.
* Added metric wrappers: `metric_math()`, `metric_stats()`.
* Added volume wrappers: `volume_math()`, `volume_to_surface_mapping()`.
* Added `file_information()` for inspecting any workbench file.
