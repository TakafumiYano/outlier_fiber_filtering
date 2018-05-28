#!/bin/bash 


StudyFolder="/media/takafumi/DATA/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
Subjlist=$1 #Space delimited list of subject IDs



for Subject in $Subjlist ; do
  echo $Subject

  #Input Variables
  SubjectID="$Subject" #Subject ID Name
  # RawDataDir="$StudyFolder/$SubjectID/unprocessed/3T/Diffusion" #Folder where unprocessed diffusion data are

  PosData="${SubjectID}_DWI.nii.gz"
  WorkingDir=$StudyFolder/$SubjectID/Diffusion
  StructualDir=$StudyFolder/$SubjectID/T1w
  FreeSurferDir=$StudyFolder/$SubjectID/T1w/${SubjectID}
  #mkdir $WorkingDir

  # Structual image processing by mrtrix
  #cp ${StudyFolder}/Scripts/FreeSurferColorLUT.txt ${WorkingDir}/FreeSurferColorLUT.txt
  #cp ${StudyFolder}/Scripts/fs_default.txt ${WorkingDir}/fs_default.txt
  #cp ${FreeSurferDir}/mri/aparc+aseg.mgz ${WorkingDir}/aparc+aseg.mgz
  cp ${StructualDir}/T1w_acpc_brain_1mm.nii.gz ${WorkingDir}/T1w_acpc_brain_1mm.nii.gz
  cp ${StructualDir}/T1w_acpc_brain_mask.nii.gz ${WorkingDir}/T1w_acpc_brain_mask.nii.gz
  cd ${WorkingDir}
  echo ${WorkingDir}
  5ttgen fsl T1w_acpc_brain_1mm.nii.gz 5TT.mif -premasked
  # 5tt2vis 5TT.mif vis.mif
  # mrconvert aparc+aseg.mgz aparc+aseg.nii.gz
  # rm aparc+aseg.mgz
  # labelconvert aparc+aseg.nii.gz FreeSurferColorLUT.txt fs_default.txt nodes.mif
  # labelsgmfix nodes.mif T1w_acpc_brain_1mm.nii.gz fs_default.txt nodes_fixSGM.mif -premasked


  # Diffusion image processing by mrtrix
  mrconvert reg_eddy_${PosData} DWI.mif -fslgrad GE15dir-b1000.bvec GE15dir-b1000.bval
  dwi2response dhollander DWI.mif RF_WM.txt RF_GM.txt RF_CSF.txt
  dwi2fod msmt_csd DWI.mif RF_WM.txt WM_FODs.mif RF_GM.txt GM_FODs.mif RF_CSF.txt CSF_FODs.mif

  # Diffusion tractography processing by mrtrix
  tckgen WM_FODs.mif 35M.tck -act 5TT.mif -backtrack -crop_at_gmwmi -seed_dynamic WM_FODs.mif -maxlength 250 -number 35M
  tcksift 35M.tck WM_FODs.mif 10M_SIFT.tck -act 5TT.mif -term_number 10M
  #tck2connectome 1M_SIFT.tck nodes_fixSGM.mif connectome.csv -zero_diagonal

done

