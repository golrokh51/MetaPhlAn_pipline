#!/bin/bash
#SBATCH --time=5:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --workdir=/project/def-banire/Labobioinfo/Jobs/__JOBID__/scripts/
#SBATCH --output=/project/def-banire/Labobioinfo/Jobs/__JOBID__/results/_logs/visual_slurm-%j.out
#SBATCH --error=/project/def-banire/Labobioinfo/Jobs/__JOBID__/results/_logs/visual-%j.err

merge_metaphlan_tables ../results/profiled_samples/*.txt > ../results/merged_abundance_table.txt

module load mugqic/python/2.7.13
metaphlan_hclust_heatmap -c bbcry --top 25 --minv 0.1 -s log --in ../results/merged_abundance_table.txt --out ../results/abundance_heatmap.png

metaphlan2graphlan ../results/merged_abundance_table.txt --tree_file ../results/merged_abundance.tree.txt --annot_file ../results/merged_abundance.annot.txt

graphlan_annotate --annot ../results/merged_abundance.annot.txt ../results/merged_abundance.tree.txt ../results/merged_abundance.xml

##The second one (graphlan.py) is used to generate the output images in several different formats: png, pdf, ps, eps, svg. You can also set their resolution with --dpi (default value is 72) and their size with --size (default value is 7.0, expressed in inches).
graphlan --dpi 200 ../results/merged_abundance.xml ../results/merged_abundance.png
