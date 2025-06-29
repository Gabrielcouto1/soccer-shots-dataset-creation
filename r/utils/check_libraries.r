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
            # print("Installing missing package: ", pkg)
            install.packages(pkg, dependencies = TRUE)
        } else {
            # print(pkg, " is already installed")
            suppressPackageStartupMessages(library(pkg,character.only = TRUE, quietly=TRUE, warn.conflicts=FALSE))
        }
    }
    print("Done loading all necessary packages!")
}

