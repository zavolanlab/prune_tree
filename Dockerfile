##### BASE IMAGE #####
FROM r-base:3.6.3

##### METADATA #####
LABEL base.image="r-base:3.6.3"
LABEL software="prune_tree"
LABEL software.description="Prune nh files based on a list of organisms"
LABEL software.website="https://github.com/zavolanlab/prune_tree"
LABEL software.documentation="https://github.com/zavolanlab/prune_tree"
LABEL software.license="https://github.com/zavolanlab/prune_tree/blob/master/LICENSE"
LABEL software.tags="Genomics,Transcriptomics,Phylogenetics"
LABEL maintainer="foivos.gypas@unibas.ch"
LABEL maintainer.organisation="Biozentrum, University of Basel"
LABEL maintainer.location="Klingelbergstrasse 50/70, CH-4056 Basel, Switzerland"
LABEL maintainer.lab="Zavolan Lab"
LABEL maintainer.license="https://spdx.org/licenses/Apache-2.0"

COPY R/prune_tree.R /usr/local/bin/prune_tree.R

##### INSTALL #####
RUN apt-get update -y \
  && apt-get install -y build-essential gcc curl libxml2-dev libssl-dev r-cran-devtools libmagick++-dev
RUN Rscript -e 'require("devtools"); install_version("phytools", version ="0.7-20", repos = "http://cran.us.r-project.org")'
RUN Rscript -e 'require("devtools"); install_version("optparse", version ="1.6.4", repos = "http://cran.us.r-project.org")'
