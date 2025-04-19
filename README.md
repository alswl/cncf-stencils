# cncf-stencils

Graffles stencils for CNCF projects.

All icons comes from [cncf/landscape](https://github.com/cncf/landscape/)

![snapshot](https://github.com/alswl/cncf-stencils/blob/master/snapshot.jpg?raw=true)

## Downloads

Latest artifacts in [Releases](https://github.com/alswl/cncf-stencils/releases).

## Build Required

Python 3.9+

## Build

```
make install patch vendor build
```

## Change Logs

- 2024-01-20
  - refactor for `cncf/landscape` l2
  - pyyaml version update
- 2022-11-18
  - update CI for ubuntu 22.04 and python 3.10
- 2022-01-28
  - resize all SVG images with height 96px limit(`96 = 12\*8`).
- 2021-12-23
  - gropu logos with categories
  - add missing logos from `hosted_logos`, eg `dockerswarm.svg`
  - resize all SVG images with height 80px limit
- 2021-12-21
  - resize all SVG images with height 120px limit
- 2021-12-16
  - init this projects
  - it works
