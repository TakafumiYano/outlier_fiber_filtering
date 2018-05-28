# -*- coding: utf-8 -*- 

import subprocess
import re
import sys
import os
import numpy as np
from sklearn.covariance import MinCovDet, EmpiricalCovariance
import scipy.stats as stats

 
def calcurate_mahalabinos_distance(TCKname):
    length_stats = TCKname+"-stat.txt"
    tdi_stats = TCKname+"-tdi.txt"
    cur_stats = TCKname+"-cur.txt"
    length =np.loadtxt(length_stats, delimiter = '\t')
    tdi = np.loadtxt(tdi_stats, delimiter = '\t')
    tdi = np.reciprocal(tdi)
    cur = np.loadtxt(cur_stats, delimiter = '\t')
    n_samples = length.shape[0]
    tdi = np.reshape(tdi, (n_samples,1))
    cur = np.reshape(cur, (n_samples,1))
    length = np.reshape(length, (n_samples,1))
    X = np.hstack((length, tdi, cur))
    robust_cov = MinCovDet().fit(X)
    robust_mahal = robust_cov.mahalanobis(X - robust_cov.location_)
    return robust_mahal

 
if __name__ == '__main__':

    args = sys.argv
    targetTCKFileDir = args[1]
    TCKdict, TCKfile = os.path.split(targetTCKFileDir)
    TCKname, TCKext = os.path.splitext(TCKfile)
    print(TCKname)
    robust_mahal = calcurate_mahalabinos_distance(TCKname)
    median_val = np.median(robust_mahal)
    mad = np.median(abs(robust_mahal - median_val), axis=0)
    score_data = (robust_mahal-median_val)/mad + 100
    robust_mahal_name = TCKname+"-robustscore.txt"
    # inline_tracto_name = TCKname+"-inline.txt"
    # outliers = (robust_mahal  > stats.chi2.ppf(0.9999, 2))
    # print(stats.chi2.ppf(0.9999, 2) )
    # outliers = not(outliers)
    # outliers = outliers.astype(int)
    np.savetxt(robust_mahal_name, score_data)
    # np.savetxt(inline_tracto_name, outliers)


