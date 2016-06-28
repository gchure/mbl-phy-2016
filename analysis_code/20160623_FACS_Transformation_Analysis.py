# -*-coding: utf-8 -*-
"""
Author: Griffin Chure
File Name:
Creation Date: 2016-06-24
Purpose:
"""
#------------------------------------------------------------------------------- 
# DEPENDENCIES
#------------------------------------------------------------------------------- 
#Allow for python 2.7 compatibility
from __future__ import print_function, unicode_literals
from __future__ import absolute_import, division 

#Packages for numerics
import numpy as np

#File management modules. 
import os
import shutil 
import fnmatch
import glob 

#For managing dataframes.
import pandas as pd 

#Image processing utilities. 
import skimage.io
import skimage.morphology
import skimage.segmentation
import skimage.filters
import skimage.exposure

#Custom-written modules. 
import pboc.filters
import pboc.io
import pboc.segmentation
import pboc.process
import pboc.plot
import pboc.props

#Packages for plotting.
import matplotlib.pyplot as plt
from matplotlib.pyplot import cm #Color map.
import seaborn as sns

rc = {'lines.linewidth': 1.5,
      'axes.labelsize' : 14,
      'axes.titlesize' : 18,
      'axes.facecolor' : 'EBEBEB',
      'axes.edgecolor' : '000000',
      'axes.linewidth' : 0.75,
      'axes.frameon' : True,
      'xtick.labelsize' : 11,
      'ytick.labelsize' : 11,
      'font.family' : 'Droid Sans',
      'grid.linestyle' : ':',
      'grid.color' : 'a6a6a6',
      'mathtext.fontset' : 'stixsans',
      'mathtext.sf' : 'sans'}
plt.rc('text.latex', preamble=r'\usepackage{sfmath}')
plt.rc('mathtext', fontset='stixsans', sf='sans') 
sns.set_context('notebook', rc=rc)
sns.set_style('darkgrid', rc=rc)
sns.set_palette("deep", color_codes=True)
#------------------------------------------------------------------------------- 

#Load all of the data files.
data_files = glob.glob('../data_files/WH2016-06-23*.csv')
np.sort(data_files)
data = [pd.read_csv(f) for f in data_files]

#Load all of the data as a single dataframe.
plt.figure()
cols = ['YFP-H', 'mCherry-H', 'FSC-H', 'SSC-H']
dfs = []
for i,d in enumerate(data):
    d = d[cols]
    d.columns = ['y', 'r', 'fsc', 'ssc']
    d.insert(0, 'conc', i)
    dfs.append(d)

d = pd.concat(dfs, axis=0)

#Make the tform vs no tform histograms
plt.figure()
d[d.conc==0].y.hist(bins=10000, normed=True, color='b', alpha=0.5, 
        histtype='stepfilled', label='- DNA')
d[d.conc!=0].y.hist(bins=10000, normed=True, color='g', alpha=0.5, 
        histtype='stepfilled', label='+ DNA')
plt.xlabel('YFP intensity')
plt.ylabel('normalized counts')
plt.yscale('log')
plt.legend()


#Let's look at the mCherry channels to do some filtering.
plt.figure()
d[d.conc==0].r.hist(bins=10000, normed=True, color='b', alpha=0.5, histtype='stepfilled',
        label = '- DNA',)
d[d.conc!=0].r.hist(bins=10000, normed=True, color='g', alpha=0.5, histtype='stepfilled',
        label = '+ DNA',)
plt.xscale('log')
plt.xlabel('mCherry intensity')
plt.ylabel('normalized frequency')
plt.legend()

#There is a bunch of shit let's impose bounds on mCherry.
d = d[(d.r < 1E5) & (d.r >  1200)]

#Now remake the histograms of YFP.
plt.close('all')
plt.figure()
d[d.conc==0].y.hist(bins=10000, normed=True, color='b', alpha=0.5,
    histtype='stepfilled', label='- DNA')
d[d.conc!=0].y.hist(bins=10000, normed=True, color='g', alpha=0.5,
    histtype='stepfilled', label='+ DNA')
plt.xlabel('YFP intensity (filtered)')
plt.ylabel('normalized frequency')
plt.xscale('log')
plt.yscale('log')
plt.legend()
plt.tight_layout()

#Just make an ecdf, which will be more informative.

def ecdf(vals):
    x = np.sort(vals)
    y = np.arange(len(vals)) / len(vals)
    return x, y

tformx, tformy = ecdf(d[d.conc!=0].y)
autox, autoy = ecdf(d[d.conc==0].y)
plt.close('all')
plt.figure()
plt.plot(autox, autoy, ',', color='b', label='- DNA')
plt.plot(tformx, tformy, ',', color='g', label='- DNA')
plt.xlabel('YFP intensity')
plt.ylabel('ecdf')
plt.xscale('log')


