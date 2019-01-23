#!/bin/bash
#SBATCH --time=3:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=__EMAIL__
#SBATCH --mail-type=__EMAIL_TYPE__
#SBATCH --workdir=__WORK_DIR__/__JOBID__/scripts/
#SBATCH --output=__WORK_DIR__/__JOBID__/results/_logs/metaphlan_slurm-%j.out
#SBATCH --error=__WORK_DIR__/__JOBID__/results/_logs/metaphlan-%j.err



# All job recive a different number, from 1 to 18, that number is
# stored in  $SLURM_ARRAY_TASK_ID

module load bowtie2/2.2.9
inputFiles=../data/_all_fq.txt
f1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $inputFiles)

tar xjf $f1 --to-stdout | metaphlan --bowtie2db bowtie2db/mpa --bt2_ps very-sensitive --input_type multifastq --bowtie2out ../results/BM_${s}.bt2out > ../results/profiled_samples/BM_${s}.txt
