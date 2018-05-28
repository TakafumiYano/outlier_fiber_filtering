#!/bin/bash 


StudyFolder="/media/takafumi/media_bk/projects/OsakaUniversity" #Location of Subject folders (named by subjectID)
ScriptDir=$StudyFolder/Scripts

WorkingDir=$StudyFolder/$1/Diffusion

cd ${StudyFolder}
mkdir MeanTrack

cp ${WorkingDir}/track_normalized/n_$1_3-42.tck MeanTrack/n_$1_3-42.tck
cp ${WorkingDir}/track_normalized/n_$1_6-42.tck MeanTrack/n_$1_6-42.tck
cp ${WorkingDir}/track_normalized/n_$1_7-42.tck MeanTrack/n_$1_7-42.tck

cp ${WorkingDir}/track_normalized/n_$1_9-42.tck MeanTrack/n_$1_9-42.tck
cp ${WorkingDir}/track_normalized/n_$1_7-43.tck MeanTrack/n_$1_7-43.tck
cp ${WorkingDir}/track_normalized/n_$1_6-44.tck MeanTrack/n_$1_6-44.tck

cp ${WorkingDir}/track_normalized/n_$1_7-44.tck MeanTrack/n_$1_7-44.tck
cp ${WorkingDir}/track_normalized/n_$1_46-52.tck MeanTrack/n_$1_46-52.tck
cp ${WorkingDir}/track_normalized/n_$1_46-54.tck MeanTrack/n_$1_46-54.tck

cp ${WorkingDir}/track_normalized/n_$1_10-59.tck MeanTrack/n_$1_10-59.tck
cp ${WorkingDir}/track_normalized/n_$1_46-59.tck MeanTrack/n_$1_46-59.tck
cp ${WorkingDir}/track_normalized/n_$1_46-84.tck MeanTrack/n_$1_46-84.tck
