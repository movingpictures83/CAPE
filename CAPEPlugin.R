set.seed(1234)

library(cape)


dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


#results_path <- here::here("demo", "demo_PLINK")
#data_path <- here::here("tests", "testthat", "testdata", "demo_PLINK_data")


input <- function(inputfile) {
        pfix <<- prefix()
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
}

run <- function() {}

output <- function(outputfile) {
	pdf(outputfile)

	ped <- paste(pfix, parameters["ped", 2], sep="/")
	map <- paste(pfix, parameters["map", 2], sep="/")
	pheno <- paste(pfix, parameters["pheno", 2], sep="/")
	out <- paste(pfix, parameters["out", 2], sep="/")
        param_file <- paste(pfix, parameters["param_file", 2], sep="/")

#ped <- file.path(data_path, "test.ped")
#map <- file.path(data_path, "test.map")
#pheno <- file.path(data_path, "test.pheno")
#out <- file.path(data_path, "test.csv")
#param_file <- file.path(results_path, "plink.parameters.yml")

cross_obj <- plink2cape(ped, map, pheno, out, overwrite = TRUE)

data_obj <- cross_obj$data_obj
geno_obj <- cross_obj$geno_obj$geno

final_cross <- run_cape(pheno_obj = data_obj, geno_obj, 
	p_or_q = 0.05, verbose = TRUE, param_file = param_file, 
	results_path = ".")

plot_variant_influences(final_cross)
}
