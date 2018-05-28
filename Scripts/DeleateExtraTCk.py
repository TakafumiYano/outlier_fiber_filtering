import subprocess
import re
import sys
import os

def deleteAbundanTCK(targetFileName):
	res = subprocess.check_output(["rm", targetFileName])
	print(res)


args = sys.argv
targetTCKFileDir = args[1]
targetSubjectID = args[2]
TCKdict, TCKfile = os.path.split(targetTCKFileDir)
print(TCKdict)
for i in range(1,91):
	for j in range(1,91):
		if i>j:
			targetFileName = TCKdict + '/' + str(targetSubjectID) + '_' + str(i) + '-' + str(j) + '.tck'
			print(targetFileName)
			try:
				deleteAbundanTCK(targetFileName)
			except:
				print('we found error')
			finally:
				print('done')
