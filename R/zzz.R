.onLoad <- function(libname, pkgname) {
  # reticulate::configure_environment(pkgname)

  #check for miniconda
  if (!reticulate_miniconda_exists()) {

    promptResp <- readline(prompt = "No installation of miniconda found. Would you like to install it? y/n: ")
    promptResp <- tolower(promptResp)

    if (identical(promptResp, 'y')) {
      reticulate::install_miniconda()
    }
  }

  #install python dependencies
  if (reticulate_miniconda_exists()) {
    pyPackages <- c('numpy', 'pandas')
    reticulate_check_dependencies(pyPackages)
  }

}
