#!/usr/bin/env Rscript

#==================#
#   HEADER START   #
#==================#
### Created: Oct 18, 2018
### Author: Foivos Gypas
### Modified by: Mihaela Zavolan
### Company: Zavolan Group, Biozentrum, University of Basel
### Version: v1.0
### Requirements: optparse, phytools
### R version used:
#==================#
### Description: Prune nh files based on a list of organisms
### Input: phylogenetic tree build based on multiz alignments at UCSC
### 	   reference species
###	   list of species to keep (comma-separated), provided as text file
### Output: prunned tree containing only the species specified in the input
#==================#
#    HEADER END    #
#==================#

# suppress warnings
options(warn=-1)

#==========================#
#   PRE-REQUISITES START   #
#==========================#
#---> LOAD LIBRARIES <---#
suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("phytools"))

#---> COMMAND-LINE ARGUMENTS <---#
## List of allowed/recognized arguments
option_list <- list(
	make_option(c("--input_tree"), action="store", type="character", default="", help="Input tree in nh format", metavar="file"),
	make_option(c("--output_tree"), action="store", type="character", default="", help="Output tree in nh format", metavar="file"),
	make_option(c("--reference_organism"), action="store", type="character", default="", help="Reference organism (e.g. hg38, hg19)", metavar="string"),
	make_option(c("--organisms"), action="store", type="character", default="", help="Comma-separated organisms as text file", metavar="file"),
	make_option(c("--help"), action="store_true", default=FALSE, help="Show this information and die"),
	make_option(c("--verbose"), action="store_true", default=FALSE, help="Be Verbose")
)

#type="character", default="hg38", help="REQUIRED: Genome Assembly Version. Example hg38, hg19, mm10"))
## Parse command-line arguments
opt_parser <- OptionParser(usage="Usage: %prog [OPTIONS] --input_tree [FILE] --reference_organism [string] --organisms [FILE] --output_tree [FILE]", option_list = option_list, add_help_option=FALSE, description="\n Prune nh files based on a list of organisms")
opt <- parse_args(opt_parser)

## Die if any required arguments are missing...
if ( opt$input_tree== "" ) {
	write("[ERROR] Required argument: input_tree missing!\n\n", stderr())
	stop(print_help(opt_parser))
}
if ( opt$reference_organism=="" ) {
	write("[ERROR] Required argument: reference_organism missing!\n\n", stderr())
	stop(print_help(opt_parser))

}

if ( opt$organisms=="" ) {
	write("[ERROR] Required argument: file with list of species missing!\n\n", stderr())
	stop(print_help(opt_parser))
}

if ( opt$output_tree=="") {
	write("[ERROR] Required argument: output_tree missing!\n\n", stderr())
	stop(print_help(opt_parser))
}

#==========================#
#    PRE-REQUISITES END    #
#==========================#

if ( opt$verbose ){
	options(warn=0)
}

#================#
#   MAIN START   #
#================#

# Start script
if ( opt$verbose  ) cat("\nStarting script... \n\n")

# Reading input tree file
if ( opt$verbose  ) cat("Reading input tree file '", basename(opt$input_tree), "'...\n\n", sep="")
tree <- read.tree(file=opt$input_tree)

# Reading organisms as string
if ( opt$verbose  ) cat("Reading organisms file '", basename(opt$organisms), "'...\n\n", sep="")
organisms <- readLines(opt$organisms)

# Concatenating organisms
if ( opt$verbose  ) cat("Concatenating '", opt$reference_organism, " and ", organisms, "'...\n\n", sep="")
# split comma separated organisms
organisms <- unlist(strsplit(organisms, ","))
# concatenate them with reference_organism
all_organims <- c(opt$reference_organism, organisms)

# Prune tree
if ( opt$verbose  ) cat("Pruning tree... \n\n")
pruned.tree<-drop.tip(tree,tree$tip.label[-match(all_organims, tree$tip.label)])

# Write out prunned tree
if ( opt$verbose  ) cat("Writing output tree file '", basename(opt$output_tree), "'...\n\n", sep="")
write(write.tree(pruned.tree), opt$output_tree)

# Finish script
if ( opt$verbose  ) cat("Finish script... \n\n")

#================#
#   MAIN END     #
#================#
