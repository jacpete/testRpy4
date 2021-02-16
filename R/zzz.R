.onLoad <- function(libname, pkgname) {
  reticulate::configure_environment(pkgname)

  pyPackages <- c('numpy', 'pandas')
  reticulate_check_dependencies(pyPackages)
}
