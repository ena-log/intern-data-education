# -*- coding: utf-8 -*-
"""
Created on Thu Aug 13 03:32:54 2020

@author: user
"""

import pandas as pd
from matplotlib import rc
import matplotlib.pyplot as plt

plt.rc('font',family='NanumGothic',size=12)

data=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리지히/정제데이터/보행노인사고다발지역과 시설수.csv",engine='python')

park=len(data[data["도시공원"]>0])
sport=len(data[data["체육시설"]>0])
hos=len(data[data["병원"]>0])
sch=len(data[data["노인교실"]>0])
krd=len(data[data["경로당"]>0])
market=len(data[data["전통시장"]>0])

cross=len(data[data["신호등없는"]>0])
ncross=len(data[data["신호등있는"]>0])
pro=len(data[data["노인보호구"]>0])
tuck=len(data[data["방지턱 개"]>0])

colors = ['red', 'yellow','yellowgreen', 'lightcoral', 'lightskyblue', 'lightyellow']
plt.pie([krd,market,park,hos,sch,sport], labels=["경로당","전통시장","도시공원","병원","노인교실","생활체육시설"],shadow=True, startangle=90,colors=colors,autopct='%d%%')
plt.title('노인교통사고다발지역 주변시설')

# data=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리지히/정제데이터/노인보호구역과 시설수.csv",engine='python')

# park=len(data[data["공원수_NUMPOINTS"]>0])
# sport=len(data[data["체육시설수_NUMPOINTS"]>0])
# hos=len(data[data["의료기관수_NUMPOINTS"]>0])
# sch=len(data[data["노인교실수_NUMPOINTS"]>0])
# krd=len(data[data["경로당수_NUMPOINTS"]>0])
# market=len(data[data["전통시장수_NUMPOINTS"]>0])

# colors = ['red', 'yellow','yellowgreen', 'lightcoral', 'lightskyblue', 'lightyellow']
# plt.pie([krd,market,park,hos,sch,sport], labels=["경로당","전통시장","도시공원","병원","노인교실","생활체육시설"],shadow=True, startangle=90,colors=colors,autopct='%d%%')
# plt.title('노인보호구역 주변시설')
