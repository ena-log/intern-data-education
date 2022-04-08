# -*- coding: utf-8 -*-
"""
Created on Thu Aug 13 09:41:13 2020

@author: user
"""

import pandas as pd
from matplotlib import rc
import matplotlib.pyplot as plt

plt.rc('font',family='NanumGothic',size=12)

data=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리지히/정제데이터/보행노인사고다발지역과 시설수.csv",engine='python')

data["신없행비율"]=data["신호등없는"]/data["횡단보도"]
data["신호등있는"]=data["횡단보도"]-data["신호등없는"]
data["신있행비율"]=data["신호등있는"]/data["횡단보도"]
data=data.fillna(0)
data["1"]=1

plt.scatter(data["신없행비율"],data["1"],label="신호등없는 횡단보도/횡단보도")
# plt.xlabel("신호등없는 횡단보도/횡단보도")
# plt.ylabel("사고건수")


plt.scatter(data["신있행비율"],data["1"],label="신호등있는 횡단보도/횡단보도")
# plt.xlabel("신호등있는 횡단보도/횡단보도")
# plt.ylabel("사고건수")

plt.legend()

# df=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리지히/정제데이터/사고다발지역 분석데이터 7개구.csv", engine='python')
# plt.scatter(data["방지턱 개"],data["사고건수"])
# plt.xlabel("방지턱 개수")
# plt.ylabel("사고건수")