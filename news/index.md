# Changelog

## wbcmd 0.0.0.9000

- Initial package scaffold with core dispatcher architecture.
- Added
  [`wb_cmd()`](https://drmowinckels.github.io/wbcmd/reference/wb_cmd.md)
  central dispatcher for all `wb_command` operations.
- Added environment detection:
  [`get_wb_path()`](https://drmowinckels.github.io/wbcmd/reference/get_wb_path.md),
  [`have_wb()`](https://drmowinckels.github.io/wbcmd/reference/have_wb.md),
  [`wb_version()`](https://drmowinckels.github.io/wbcmd/reference/wb_version.md),
  [`set_wb_path()`](https://drmowinckels.github.io/wbcmd/reference/set_wb_path.md).
- Added hierarchical settings lookup via
  [`get_wb_setting()`](https://drmowinckels.github.io/wbcmd/reference/get_wb_setting.md).
- Added
  [`wb_sitrep()`](https://drmowinckels.github.io/wbcmd/reference/wb_sitrep.md)
  situation report for diagnostics.
- Added
  [`wb_help()`](https://drmowinckels.github.io/wbcmd/reference/wb_help.md)
  to access `wb_command` help text.
- Added CIFTI wrappers:
  [`cifti_parcellate()`](https://drmowinckels.github.io/wbcmd/reference/cifti_parcellate.md),
  [`cifti_math()`](https://drmowinckels.github.io/wbcmd/reference/cifti_math.md),
  [`cifti_correlation()`](https://drmowinckels.github.io/wbcmd/reference/cifti_correlation.md),
  [`cifti_reduce()`](https://drmowinckels.github.io/wbcmd/reference/cifti_reduce.md),
  [`cifti_average()`](https://drmowinckels.github.io/wbcmd/reference/cifti_average.md),
  [`cifti_find_clusters()`](https://drmowinckels.github.io/wbcmd/reference/cifti_find_clusters.md),
  [`cifti_stats()`](https://drmowinckels.github.io/wbcmd/reference/cifti_stats.md),
  [`cifti_weighted_stats()`](https://drmowinckels.github.io/wbcmd/reference/cifti_weighted_stats.md),
  [`cifti_dilate()`](https://drmowinckels.github.io/wbcmd/reference/cifti_dilate.md),
  [`cifti_gradient()`](https://drmowinckels.github.io/wbcmd/reference/cifti_gradient.md).
- Added surface wrappers:
  [`surface_generate_inflated()`](https://drmowinckels.github.io/wbcmd/reference/surface_generate_inflated.md),
  [`surface_geodesic_distance()`](https://drmowinckels.github.io/wbcmd/reference/surface_geodesic_distance.md),
  [`surface_vertex_areas()`](https://drmowinckels.github.io/wbcmd/reference/surface_vertex_areas.md),
  [`surface_curvature()`](https://drmowinckels.github.io/wbcmd/reference/surface_curvature.md),
  [`surface_distortion()`](https://drmowinckels.github.io/wbcmd/reference/surface_distortion.md),
  [`surface_information()`](https://drmowinckels.github.io/wbcmd/reference/surface_information.md).
- Added metric wrappers:
  [`metric_math()`](https://drmowinckels.github.io/wbcmd/reference/metric_math.md),
  [`metric_stats()`](https://drmowinckels.github.io/wbcmd/reference/metric_stats.md).
- Added volume wrappers:
  [`volume_math()`](https://drmowinckels.github.io/wbcmd/reference/volume_math.md),
  [`volume_to_surface_mapping()`](https://drmowinckels.github.io/wbcmd/reference/volume_to_surface_mapping.md).
- Added
  [`file_information()`](https://drmowinckels.github.io/wbcmd/reference/file_information.md)
  for inspecting any workbench file.
