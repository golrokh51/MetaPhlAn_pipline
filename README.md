# MetaPhlAn_pipline

Warning: This pipline is under development, use with caution in make_call_pipe replace ```__WORKDIR__``` with your path to your working directory

In your working directory (```__WORKDIR__```) create a folder named by the unique job id (```__JOB_ID__```). In side, create 3 folders: data, results and scripts put all your input files in it. My files are ```*tar.bz2``` so the ```make_call_pipe.sh``` should be changed accordingly if yours are different

I put all the scripts provided by MetaPhlAn in my path without .py extention. 
You should put both database folders (*bowtie2db* and *blastdb*) in your *scripts* folder
