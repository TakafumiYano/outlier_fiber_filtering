#!/bin/bash 


StudyFolder="/media/takafumi/media_bk/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
ScriptDir=$StudyFolder/Scripts

WorkingDir=$StudyFolder/$1/Diffusion

cd ${WorkingDir}
echo ${WorkingDir}

echo $1

mkdir track
cd track
connectome2tck -node 3,6,7,9,42,43,44,46,10 ../10M_SIFT.tck ../$1_no_cellebrum_assignments.txt $1_

cd ../

warpinit /usr/share/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz flirt-[].nii
transformconvert inT1w_acpc_brain_1mm.mat /usr/share/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz T1w_acpc_brain_1mm.nii.gz flirt_import inT1w_acpc_brain_1mm.mrtrix

mrtransform flirt-[].nii -linear inT1w_acpc_brain_1mm.mrtrix flirt2tck.mif

mkdir track_normalized


tcknormalise track/$1_3-42.tck flirt2tck.mif track_normalized/n_$1_3-42.tck
tcknormalise track/$1_6-42.tck flirt2tck.mif track_normalized/n_$1_6-42.tck
tcknormalise track/$1_7-42.tck flirt2tck.mif track_normalized/n_$1_7-42.tck
tcknormalise track/$1_9-42.tck flirt2tck.mif track_normalized/n_$1_9-42.tck
tcknormalise track/$1_7-43.tck flirt2tck.mif track_normalized/n_$1_7-43.tck
tcknormalise track/$1_6-44.tck flirt2tck.mif track_normalized/n_$1_6-44.tck
tcknormalise track/$1_7-44.tck flirt2tck.mif track_normalized/n_$1_7-44.tck
tcknormalise track/$1_46-52.tck flirt2tck.mif track_normalized/n_$1_46-52.tck
tcknormalise track/$1_46-54.tck flirt2tck.mif track_normalized/n_$1_46-54.tck
tcknormalise track/$1_10-59.tck flirt2tck.mif track_normalized/n_$1_10-59.tck
tcknormalise track/$1_46-59.tck flirt2tck.mif track_normalized/n_$1_46-59.tck
tcknormalise track/$1_46-84.tck flirt2tck.mif track_normalized/n_$1_46-84.tck
