# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 01:05:55 2020

@author: 서지희
"""

import pandas as pd
import lightgbm as lgb
from sklearn.ensemble import RandomForestRegressor

data=pd.read_csv("C:/Users/user/Desktop/프로젝트/전처리/노인 분석 데이터.csv",engine='python')
data=data.drop(["Unnamed: 16","CCTV"],axis=1)
data["독거노인"]=data["독거노인"].astype(int)
data=data.fillna(0)
data["신호등/면적"]=data["신호등"]/data["면적"]
data["횡단보도/면적"]=data["횡단보도"]/data["면적"]
data["과속방지턱/면적"]=data["과속방지턱"]/data["면적"]
data["노인보호구역/면적"]=data["노인보호구역"]/data["면적"]
data["공공 체육시설/면적"]=data["공공 체육시설"]/data["면적"]
data["독거노인/면적"]=data["독거노인"]/data["면적"]
data["저소득 독거노인/면적"]=data["저소득 독거노인"]/data["면적"]
data["전통시장/면적"]=data["전통시장"]/data["면적"]
data["도시공원/면적"]=data["도시공원"]/data["면적"]
data["노인 교통사고/면적"]=data["노인 교통사고"]/data["면적"]

train_x=data.iloc[:,4:24]
train_x=train_x.drop(["노인 교통사고"],axis=1)
train_y=data[["노인 교통사고/면적"]]
#
train_x.columns=["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"]

mdl=RandomForestRegressor(random_state=0,n_estimators=70, max_depth=19, max_features=4)
mdl.fit(train_x,train_y)
print(mdl.score(train_x,train_y))

mdl.feature_importances_

#동별 regression
#from sklearn.preprocessing import RobustScaler
#
#d1=train_x.iloc[:,4:]
#scaler=RobustScaler()
#scaler.fit(d1)
#x_scaled=scaler.transform(d1)
#
#scaler.fit(train_y)
#y_scaled=scaler.transform(train_y)

def remove_outlier(df_in, col_name):
    q1 = df_in[col_name].quantile(0.25)
    q3 = df_in[col_name].quantile(0.75)
    iqr = q3-q1 #Interquartile range
    fence_low  = q1-1.5*iqr
    fence_high = q3+1.5*iqr
    df_out = df_in.loc[(df_in[col_name] > fence_low) & (df_in[col_name] < fence_high)]
    return df_out

#data=data[data["노인 교통사고"]!=0]
# data=remove_outlier(data,"신호등/면적")
# data=remove_outlier(data,"노인 교통사고")
import matplotlib.pyplot as plt
import seaborn as sns
import matplotlib.font_manager as fm

from matplotlib import font_manager, rc
font_name = font_manager.FontProperties(fname="C:/Users/user/Downloads/NanumFontSetup_TTF_SQUARE/NanumSquareR.ttf",size=50).get_name()
plt.style.use('seaborn-white')
rc('font', family=font_name)

plt.scatter(data[["횡단보도/면적"]],data[["노인 교통사고/면적"]])
plt.xlabel('sign')
plt.ylabel('acci_num')

# cor=data.corr()
# sns.heatmap(cor,annot=True)



#lgb_train = lgb.Dataset(train_x, label=train_y)
#
#
#lgb_param = {
#    "objective":"regression",
#    "metrics":"mae",
#    "learning_rate":0.005,
#    "max_depth":3
#}
#
#print("cv start")
#cv_result = lgb.cv(
#    lgb_param,
#    lgb_train,
#    num_boost_round=99999,
#    nfold=10,
#    early_stopping_rounds=10,
#    stratified=False,
#    verbose_eval=10 
#)
#
#print("train start")
#lgb_model = lgb.train(
#    lgb_param,
#    lgb_train,
#    num_boost_round=len(cv_result["l1-mean"])
#)


