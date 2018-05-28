#!/bin/bash 


StudyFolder="/media/takafumi/DATA/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
Subjlist=$1 #Space delimited list of subject IDs
ScriptDir=$StudyFolder/Scripts



for Subject in $Subjlist ; do
  echo $Subject

  #Input Variables
  SubjectID="$Subject" #Subject ID Name

  PosData="${SubjectID}_DWI.nii.gz"
  WorkingDir=$StudyFolder/$SubjectID/T1w
  StructualDir=$StudyFolder/$SubjectID/T1w
  FreeSurferDir=$StudyFolder/$SubjectID/T1w/${SubjectID}
  
  cd ${WorkingDir}
  echo ${WorkingDir}

recon-all -s ${SubjectID} -i ./T1w_acpc_brain.nii.gz -all -sd ./


done
