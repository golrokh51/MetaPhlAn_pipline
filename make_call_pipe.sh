#!/bin/bash



temp_path=/project/def-banire/Labobioinfo/Jobs/MetaPhlAn_pipline
fld=$(ls -1  $temp_path/template_*.sh |awk -F"/" '{print NF}' | uniq)
fld=$((fld+0))
WORK_DIR=/project/def-banire/Labobioinfo/Jobs

for i in `ls -1  $temp_path/template_*.sh | cut -f$fld -d"/"`;  do  sed "s/__JOBID__/$1/g"  | sed "s/__EMAIL__/$2/g" | sed "s/__EMAIL_TYPE__/$3/g" $temp_path/$i > $WORK_DIR/$1/scripts/$i; done	

mkdir ../results/profiled_samples ../results/_logs

inputFiles=$WORK_DIR/$1/data/_all_fq.txt
labels=$WORK_DIR/$1/results/_labels.txt

ls -1  $WORK_DIR/$1/data/*tar.bz2 |sed "s/JOBID/$1/g" > $inputFiles
fld=$(ls $WORK_DIR/$1/data/*tar.bz2 |awk -F"/" '{print NF}' | uniq)
fld=$((fld+0))

ls $WORK_DIR/$1/data/*_1.fq.gz | cut -f$fld -d"/" | cut -f1 -d"." | sed 's/.$//g' | sed 's/.$//g' | uniq  > $labels

N_SUBJECT=$(wc -l $inputFiles | cut -f1 -d" ")
N_SUBJECT=$((N_SUBJECT + 0))

out1=$(sbatch --job-name=$1_metaphlan_array --array=1-${N_SUBJECT} --account=def-banire ${WORK_DIR}/${1}/scripts/template_metaphlan.sh)
JOB_ID1=$(echo $out1 | cut -d" " -f4)
echo $JOB_ID1

out2=$(sbatch --depend=afterok:$JOB_ID1 --job-name=$1_visual --array=1-${N_SUBJECT} --account=def-banire ${WORK_DIR}/${1}/scripts/template_visual.sh)
JOB_ID2=$(echo $out2 | cut -d" " -f4)
echo $JOB_ID2

