# -*- coding: utf-8 -*-
"""
Created on Thu Aug 13 11:28:19 2020

@author: user
"""



import pandas as pd
from matplotlib import rc
import matplotlib.pyplot as plt

plt.rc('font',family='NanumGothic',size=12)

data=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리지히/정제데이터/노인보호구역과 시설수.csv",engine='python')

data["신없행비율"]=data["신호등없는"]/data["횡단보도수"]
data["신호등있는"]=data["횡단보도수"]-data["신호등없는"]
data["신있행비율"]=data["신호등있는"]/data["횡단보도수"]
data=data.fillna(0)

plt.scatter(data["신없행비율"],data["장소유형코"],label="신호등없는 횡단보도/횡단보도")
# plt.xlabel("신호등없는 횡단보도/횡단보도")
# plt.ylabel("사고건수")
# 

plt.scatter(data["신있행비율"],data["장소유형코"],label="신호등있는 횡단보도/횡단보도")
# plt.xlabel("신호등있는 횡단보도/횡단보도")
# plt.ylabel("사고건수")

plt.legend()
plt.title("노인보호구역")
# df=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리지히/정제데이터/사고다발지역 분석데이터 7개구.csv", engine='python')
# plt.scatter(data["방지턱 개"],data["사고건수"])
# plt.xlabel("방지턱 개수")
# plt.ylabel("사고건수")