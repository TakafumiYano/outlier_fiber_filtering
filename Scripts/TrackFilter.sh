#!/bin/bash 


StudyFolder="/media/takafumi/media_bk/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
Subjlist=$1 #Space delimited list of subject IDs
ScriptDir=$StudyFolder/Scripts



for Subject in $Subjlist ; do
  echo $Subject

  #Input Variables
  SubjectID="$Subject" #Subject ID Name
  WorkingDir=$StudyFolder/$SubjectID/Diffusion
  
  cd ${WorkingDir}
  echo ${WorkingDir}
  mkdir tckconnectome
  cd tckconnectome/
  connectome2tck ../10M_SIFT.tck ../${SubjectID}_no_cellebrum_assignments.txt ${SubjectID}_
  cd ../
  python ${ScriptDir}/DeleateExtraTCk.py ${WorkingDir}/tckconnectome/ ${SubjectID}
  python ${ScriptDir}/OutlierFiberFilter.py ${WorkingDir}/tckconnectome/
  tckedit ${WorkingDir}/tckconnectome/f*.tck filterd${SubjectID}.tck
  tck2connectome filterd${SubjectID}.tck subj_AAL_fix_no_cellebrum.nii.gz ${SubjectID}_no_cellebrum_filterd.csv -zero_diagonal -out_assignments ${SubjectID}_no_cellebrum_assignments_filterd.txt -force

done
