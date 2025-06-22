check_libraries <- function() {
    required_packages <- c(
        "rjson", 
        "dplyr", 
        "tidyverse", 
        "plotrix", 
        "ggplot2", 
        "gridExtra", 
        "grid",
        "purrr"
    )

    for (pkg in required_packages) {
        if (!requireNamespace(pkg, quietly = TRUE)) {
            message("Installing missing package: ", pkg)
            install.packages(pkg, dependencies = TRUE)
        } else {
            message(pkg, " is already installed")
        }
    }
}

