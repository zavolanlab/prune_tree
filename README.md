# prune_tree

Prune nh files based on a list of organisms

Input: phylogenetic tree build based on multiz alignments at UCSC reference species
Output: prunned tree containing only the species specified in the input


# Installation

Install the following dependencies
- optparse
- phytools

# Run

```bash
Rscript prune_tree.R --help
```

```
prune_tree.R [OPTIONS] --input_tree [FILE] --reference_organism [string] --organisms [FILE] --output_tree [FILE]

 Prune nh files based on a list of organisms

Options:
	--input_tree=FILE
		Input tree in nh format

	--output_tree=FILE
		Output tree in nh format

	--reference_organism=STRING
		Reference organism (e.g. hg38, hg19)

	--organisms=FILE
		Comma-separated organisms as text file

	--help
		Show this information and die

	--verbose
		Be Verbose
```

# Docker 

Pull image
```bash
docker pull zavolab/prune_tree
```

Run
```bash
docker run -it zavolab/prune_tree prune_tree.R --help
```

# Singularity

Pull image
```bash
singularity pull docker://zavolab/prune_tree
```

Run
```bash
singularity exec prune_trees_latest.sif prune_tree.R --help
```