# -*-coding: utf-8 -*-
"""
Author: Griffin Chure
File Name:
Creation Date: 2016-06-23
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
#Glob all of the csv files.
files = glob.glob('*.csv')

#Sort them. 
files.sort()

#Set the concentrations of the samples.
concs = [0, 10, 1000, 100, 10000, 100000]

#Make an empty vector for the dataframes
dfs = []
cols = ['YFP-H', 'mCherry-H']
#Iterate through and load the files.
for i, f in enumerate(files):
    df = pd.DataFrame(pd.read_csv(f))
    df = df[cols]
    df.insert(0, 'conc', concs[i])
    dfs.append(df)
data = pd.concat(dfs, axis=0)
data.columns = ['conc', 'yfp', 'mcherry']
data.to_csv('20160622_aK_FACS_data.csv', index=False)


