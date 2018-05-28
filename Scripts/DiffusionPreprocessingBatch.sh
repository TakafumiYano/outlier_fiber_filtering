#!/bin/bash 


StudyFolder="${HOME}/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
Subjlist=$1 #Space delimited list of subject IDs
EnvironmentScript="${HOME}/projects/OsakaUniversity/Scripts/SetUpHCPPipeline.sh" #Pipeline environment script

if [ -n "${command_line_specified_study_folder}" ]; then
    StudyFolder="${command_line_specified_study_folder}"
fi

if [ -n "${command_line_specified_subj}" ]; then
    Subjlist="${command_line_specified_subj}"
fi


#Set up pipeline environment variables and software
source ${EnvironmentScript}

# Log the originating call
echo "$@"

#Assume that submission nodes have OPENMP enabled (needed for eddy - at least 8 cores suggested for HCP data)
#if [ X$SGE_ROOT != X ] ; then
#    QUEUE="-q verylong.q"
    QUEUE="-q hcp_priority.q"
#fi

PRINTCOM=""


for Subject in $Subjlist ; do
  echo $Subject

  #Input Variables
  SubjectID="$Subject" #Subject ID Name
  RawDataDir="$StudyFolder/$SubjectID/unprocessed/3T/Diffusion" #Folder where unprocessed diffusion data are

  PosData="${SubjectID}_DWI.nii.gz"
  WorkingDir=$StudyFolder/$SubjectID/Diffusion
  # mkdir $WorkingDir

  # # Preprocessing for the DWI image
  # echo "copying required ingredients"
  # cp ${RawDataDir}/${PosData} ${WorkingDir}/${PosData}
  # cp ${RawDataDir}/bvecs ${WorkingDir}/bvecs
  # cp ${RawDataDir}/bvals ${WorkingDir}/bvals
  cd ${WorkingDir}

  echo "eddy correction"

  ${FSLDIR}/bin/eddy_correct ${WorkingDir}/${PosData} ${WorkingDir}/eddy_${PosData} 0

  echo "exrtracting b0 image"
  ${FSLDIR}/bin/fslsplit eddy_${PosData}

  echo "DWI registration"
  ${FSLDIR}/bin/flirt -in ${WorkingDir}/vol0000.nii.gz -ref ${StudyFolder}/${SubjectID}/T1w/T1w_acpc_brain_1mm.nii.gz -out ${WorkingDir}/n_vol0000.nii.gz -omat ${WorkingDir}/n_vol0000.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 6  -interp trilinear
  
  ${FSLDIR}/bin/flirt -in ${WorkingDir}/eddy_${PosData} -applyxfm -init ${WorkingDir}/n_vol0000.mat -out ${WorkingDir}/reg_eddy_${PosData} -paddingsize 0.0 -interp trilinear -ref ${StudyFolder}/${SubjectID}/T1w/T1w_acpc_brain_1mm.nii.gz

done

