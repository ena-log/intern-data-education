# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 23:07:27 2020

@author: user
"""


import pandas as pd

acci=pd.read_csv('C:/Users/user/Desktop/프로젝트/전처리/서울특별시 노인사고_동_19.csv', encoding='utf-8')
dead=pd.read_csv('C:/Users/user/Desktop/프로젝트/데이터/노인 최종 데이터/노인 전처리/도로교통공단_교통사고 정보_20200714.csv',engine='python')
dead=dead[dead['사고유형_대분류']=='차대사람']
dead=dead[dead['발생지시도']=='서울']
dead=dead.reset_index(drop=True)
acci=acci[acci['사망자수']>=1]
acci=acci.reset_index(drop=True)

dead['cd']=dead['발생년월일시'].astype(str).str[:8]
acci['cd']=acci['사고번호'].astype(str).str[:8]
dead['구']=dead['발생지시군구']
acci["cd2"]=acci['사고일시'].str.split(' ').str[3].str[:2]
dead["cd2"]=dead['발생년월일시'].astype(str).str[8:]
dead=pd.merge(acci,dead,on=['cd','구','cd2'],how='left')

dead.to_csv('C:/Users/user/Desktop/프로젝트/전처리/노인사망사고정보.csv',encoding='utf-8-sig')