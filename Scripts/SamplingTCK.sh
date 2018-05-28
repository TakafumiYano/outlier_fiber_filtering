#!/bin/bash 


StudyFolder="/media/takafumi/DATA/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
Subjlist=$1 #Space delimited list of subject IDs
ScriptDir=$StudyFolder/Scripts



for Subject in $Subjlist ; do
  echo $Subject

  #Input Variables
  SubjectID="$Subject" #Subject ID Name

  PosData="${SubjectID}_DWI.nii.gz"
  WorkingDir=$StudyFolder/$SubjectID/Diffusion
  StructualDir=$StudyFolder/$SubjectID/T1w
  FreeSurferDir=$StudyFolder/$SubjectID/T1w/${SubjectID}
  
  cd ${WorkingDir}
  echo ${WorkingDir}

dwi2tensor DWI.mif DT.mif
tensor2metric -adc MD.mif DT.mif
tensor2metric -fa FA.mif DT.mif
mkdir tck_sample
cd tck_sample
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}3-42.tck ${WorkingDir}/MD.mif ${SubjectID}_3-42_MD.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}6-42.tck ${WorkingDir}/MD.mif ${SubjectID}_6-42_MD.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}7-42.tck ${WorkingDir}/MD.mif ${SubjectID}_7-42_MD.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}9-42.tck ${WorkingDir}/MD.mif ${SubjectID}_9-42_MD.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}7-43.tck ${WorkingDir}/MD.mif ${SubjectID}_7-43_MD.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}6-44.tck ${WorkingDir}/MD.mif ${SubjectID}_6-44_MD.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}7-44.tck ${WorkingDir}/MD.mif ${SubjectID}_7-44_MD.txt

tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}3-42.tck ${WorkingDir}/FA.mif ${SubjectID}_3-42_FA.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}6-42.tck ${WorkingDir}/FA.mif ${SubjectID}_6-42_FA.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}7-42.tck ${WorkingDir}/FA.mif ${SubjectID}_7-42_FA.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}9-42.tck ${WorkingDir}/FA.mif ${SubjectID}_9-42_FA.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}7-43.tck ${WorkingDir}/FA.mif ${SubjectID}_7-43_FA.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}6-44.tck ${WorkingDir}/FA.mif ${SubjectID}_6-44_FA.txt
tcksample ${WorkingDir}/${SubjectID}_connetome/${SubjectID}7-44.tck ${WorkingDir}/FA.mif ${SubjectID}_7-44_FA.txt

done
