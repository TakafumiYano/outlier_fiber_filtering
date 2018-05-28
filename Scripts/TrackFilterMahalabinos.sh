Subjlist=$1
Subjlist_noext="${Subjlist%.*}"
echo $Subjlist_noext

# # 線維の長さ
# tckstats -dump ${Subjlist_noext}-stat.txt ${Subjlist_noext}.tck

# # 密度のサンプリング
# tckmap -stat_vox mean -template ../T1w_acpc_restore_brain.nii.gz ${Subjlist_noext}.tck ${Subjlist_noext}-tdi.mif

# tcksample -stat_tck mean ${Subjlist_noext}.tck ${Subjlist_noext}-tdi.mif ${Subjlist_noext}-tdi_buffer.txt

# cat ${Subjlist_noext}-tdi_buffer.txt | tr ' ' '\n' > ${Subjlist_noext}-tdi.txt

# rm ${Subjlist_noext}-tdi_buffer.txt

# rm ${Subjlist_noext}-tdi.mif

# # 曲率のサンプリング

# tckmap -contrast curvature -stat_vox mean -vox 2,2,2 -template ../T1w_acpc_restore_brain.nii.gz ${Subjlist_noext}.tck ${Subjlist_noext}-cur.mif

# tcksample -stat_tck mean ${Subjlist_noext}.tck ${Subjlist_noext}-cur.mif ${Subjlist_noext}-cur_buffer.txt

# cat ${Subjlist_noext}-cur_buffer.txt | tr ' ' '\n' > ${Subjlist_noext}-cur.txt

# rm ${Subjlist_noext}-cur_buffer.txt

# rm ${Subjlist_noext}-cur.mif


# 計算したスコアに対して、±2SD区間で閾値を設定して外れ値を除外する。
tckedit -tck_weights_in ${Subjlist_noext}-robustscore.txt -maxweight 104  -minweight 96 ${Subjlist} ${Subjlist_noext}_filtered.tck -force