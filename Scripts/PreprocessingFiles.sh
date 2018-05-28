#!/bin/bash 

# 実行時に指定された引数の数、つまり変数 $# の値が 3 でなければエラー終了。
# if [ $# -ne 1 ]; then
#   echo "指定された引数は$#個です。" 1>&2
#   echo "実行するには1個の引数が必要です。" 1>&2
#   exit 1
# fi

# 環境変数

StudyFolder="/Volumes/Samsung_T3/projects/TokyoUniversity" #Location of Subject folders (named by subjectID)
EnvironmentScript="/Volumes/Samsung_T3/projects/TokyoUniversity/Scripts/SetUpHCPPipeline.sh" #Pipeline environment script
PatientID=$1
source ${EnvironmentScript}

cd ${StudyFolder}/${PatientID}

echo $PatientID

# mkdir unprocessed
# mkdir unprocessed/3T
# mkdir unprocessed/3T/Diffusion/
# mkdir unprocessed/3T/T1w_MPR1

fslmerge -a ./unprocessed/3T/Diffusion/${PatientID}_DWI.nii.gz ./unprocessed_orig/DTI/*.nii
# gzip ./T1/*.nii
# mv ./T1/*.nii.gz ./unprocessed/3T/T1w_MPR1/${PatientID}_3T_T1w_MPR1.nii.gz


# 元のファイルをorigに格納する
# mkdir unprocessed_orig
# mv ./DTI ./unprocessed_orig/DTI
# mv ./T1 ./unprocessed_orig/T1