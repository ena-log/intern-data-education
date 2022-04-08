# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 11:30:40 2020

@author: user
"""


import pandas as pd
import seaborn as sns

data=pd.read_csv("C:/Users/user/Desktop/지히/전처리/250.csv", engine='python')
data=data.fillna(0)


# cor=data.corr()
# sns.heatmap(cor,annot=True)

import matplotlib.pyplot as plt

import matplotlib as mpl
from matplotlib import font_manager, rc
import matplotlib.font_manager as fm
# font_name = font_manager.FontProperties(fname="C:/Users/user/Downloads/NanumFontSetup_TTF_SQUARE/NanumSquareR.ttf",size=50).get_name()
# rc('font', family=font_name)
# mpl.rcParams['axes.unicode_minus']=False
path="C:/Users/user/Downloads/NanumFontSetup_TTF_SQUARE/NanumSquareR.ttf"
fontprop=fm.FontProperties(fname=path, size=18)

plt.scatter(data[["횡단보도"]],data[["사고다발지"]])
plt.xlabel('횡단보도',fontproperties=fontprop)
plt.ylabel('acci_num')


datay=data[data["사고다발지"]==1]
datan=data[data["사고다발지"]==0]
datay=datay.reset_index(drop=True)
datan=datan.reset_index(drop=True)
datay["count"]=1
datan["count"]=1
datay_1=datay.groupby("신호등없는").count()
datay_1=datay_1[["count"]]

