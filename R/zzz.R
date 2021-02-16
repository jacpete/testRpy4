.onLoad <- function(libname, pkgname) {
  # reticulate::configure_environment(pkgname)

  # #check for miniconda
  # if (interactive()) {
  #   if (!reticulate_miniconda_exists()) {
  #
  #     promptResp <- readline(prompt = "No installation of miniconda found. Would you like to install it? y/n: ")
  #     promptResp <- tolower(promptResp)
  #
  #     if (identical(promptResp, 'y')) {
  #       reticulate::install_miniconda()
  #     }
  #   }
  #
  #   #install python dependencies
  #   if (reticulate_miniconda_exists()) {
  #     pyPackages <- c('numpy', 'pandas')
  #     reticulate_check_dependencies(pyPackages)
  #   }
  # }

  # reticulate_check_miniconda_setup(pyPackages = c('numpy', 'pandas'))

}

# pyPackages <- c('numpy', 'pandas')
reticulate_check_miniconda_setup <- function(pyPackages = NULL) {

  #check for miniconda
  if (interactive()) {
    if (!reticulate_miniconda_exists()) {

      promptResp <- readline(prompt = "No installation of miniconda found. Would you like to install it? y/n: ")
      promptResp <- tolower(promptResp)

      if (identical(promptResp, 'y')) {
        reticulate::install_miniconda()
      }
    }

    #install python dependencies
    if (reticulate_miniconda_exists()) {
      reticulate_check_dependencies(pyPackages)
      setupComplete <- TRUE
    } else {
      message("You will need to install miniconda to use this function. You can either run this funciton again and select 'y' at the prompt to install or call `reticulate::install_miniconda()`.")
      setupComplete <- FALSE
    }

  } else {

    if (reticulate_miniconda_exists()) {
        reticulate_check_dependencies(pyPackages)
        setupComplete <- TRUE


    } else {
      message("You will need to install miniconda to use this function. You can either run this funciton again and select 'y' at the prompt to install or call `reticulate::install_miniconda()`.")
      setupComplete <- FALSE
    }

  }

  return(setupComplete)


}

