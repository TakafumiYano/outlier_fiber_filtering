Subjlist=$1
Subjlist_noext="${Subjlist%.*}"
# echo $Subjlist_noext

# # 線維の長さ
value=$(tckstats -output median $Subjlist_noext.tck -quiet)
echo $Subjlist_noext, $value