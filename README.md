# Chocolatey Packages



[![](https://ci.appveyor.com/api/projects/status/github/hapnan/chocolatey-packages?svg=true)](https://ci.appveyor.com/project/hapnan/chocolatey-packages)
[![Update status](https://img.shields.io/badge/Update-Status-blue.svg)](https://gist.github.com/hapnan/0338df12db1d63afb2dea8fea2b0dd93)
[![chocolatey/hapnan](https://img.shields.io/badge/chocolatey-hapnan-de1d1d?logo=chocolatey
)](https://chocolatey.org/profiles/hapnan)


## Chocolatey Packages Template

This contains Chocolatey packages, both manually and automatically maintained.

### Folder Structure

* automatic - where automatic packaging and packages are kept. These are packages that are automatically maintained using [chocolatey-au](https://github.com/chocolatey-community/chocolatey-au).
* icons - Where you keep icon files for the packages. This is done to reduce issues when packages themselves move around.
* manual - where packages that are not automatic are kept.

### Requirements

* Chocolatey (choco.exe)

#### AU

* PowerShell v5+.
* The [chocolatey-au module](https://github.com/chocolatey-community/chocolatey-au).

### Getting started

1. Click "Use this template" then "Create a new repository". Name it `chocolatey-packages`
1. Clone the repository locally.
1. Head into the `setup` folder and perform the steps in the README there.
1. Edit this README. Update the badges at the top.

### Adapting your current source repository to this source repository template

You want to bring in all of your packages into the proper folders. We suggest using some sort of diffing tool to look at the differences between your current solution and this solution and then making adjustments to it. Pay special attention to the setup folder.

1. Bring over the following files to your package source repository:
 * `automatic\README.md`
 * `icons\README.md`
 * `manual\README.md`
 * `setup\*.*`
 * `.appveyor.yml`
1. Inspect the following file and add the differences:
 * `.gitignore`

