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

# warping subject's structual data into MNI cordinate
  flirt -in ./T1w_acpc_brain_1mm.nii.gz -ref /usr/share/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz -out ./nT1w_acpc_brain_1mm.nii.gz -omat ./nT1w_acpc_brain_1mm.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp nearestneighbour

  convert_xfm -omat ./inT1w_acpc_brain_1mm.mat -inverse ./nT1w_acpc_brain_1mm.mat

  flirt -in $ScriptDir/AAL.nii -applyxfm -init ./inT1w_acpc_brain_1mm.mat -out ./subj_AAL.nii -paddingsize 0.0 -interp nearestneighbour -ref ./T1w_acpc_brain_1mm.nii.gz

  labelconvert ./subj_AAL.nii.gz $ScriptDir/AAL_mapping.txt $ScriptDir/aal.txt ./subj_AAL_fix.nii.gz
  
  tck2connectome 10M_SIFT.tck subj_AAL_fix.nii.gz $SubjectID.csv -zero_diagonal -assignment_radial_search 3

done
