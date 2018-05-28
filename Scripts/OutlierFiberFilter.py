import subprocess
import re
import sys
import os

def fiberFilter(targetTCKFilePath):
    res = subprocess.check_output(["tckstats", targetTCKFilePath])
    TCKdict, TCKfile = os.path.split(targetTCKFilePath)
    string_res = res.decode('utf-8')
    regex = r'([+-]?[0-9]+\.?[0-9]*)'
    matchedList = re.findall(regex, string_res)
    res = 0
    if matchedList:
        TCKmean = float(matchedList[0])
        TCKmedian = float(matchedList[1])
        TCKstd = float(matchedList[2])
        TCKmin = float(matchedList[3])
        TCKmax = float(matchedList[4])
        TCKcount = float(matchedList[5])
        targetLength = TCKmean + 3 * TCKstd
        filteredTargetFilePath = str(TCKdict) + '/' + 'f' + str(TCKfile)
        print(filteredTargetFilePath)
        res = subprocess.check_output(["tckedit", "-maxlength", str(targetLength), targetTCKFilePath, filteredTargetFilePath])
    return res




args = sys.argv
targetTCKFileDir = args[1]
TCKdict, TCKfile = os.path.split(targetTCKFileDir)
print(TCKdict)
res = subprocess.check_output(["ls", TCKdict])
string_res = res.decode('utf-8')
regex = r'(.+.tck)'
matchedList = re.findall(regex, string_res)
if matchedList:
    for fiberFileName in matchedList:
        targetTCKFilePath = TCKdict + '/' + fiberFileName
        try:
            fiberFilterRes = fiberFilter(targetTCKFilePath)
        except:
            print('we found error')
        finally:
            print('done')
