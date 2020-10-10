from pymongo import MongoClient
import pandas as pd
import numpy as np

# 최대 출력 수 설정
pd.set_option('display.max_row', 500)
pd.set_option('display.max_columns', 91)

connection = MongoClient('localhost', 27017)

# print(connection.list_database_names()) # 데이터베이스 목록 출력

db = connection.get_database('teama') # DB 선택
# print(db.list_collection_names()) # DB 내 collection 목록 출력

collection = db.get_collection('csi_data')

# result = collection.find({}, {'_id': 0}) # 원하는 데이터만 추출
# result = collection.find({'timestamp': 25}, {'_id': 0}) # 조건

# timestamp 범위 설정
# result = collection.find({"timestamp": {"$gt": 20, "$lt": 25}}) # timestamp 21-24구간 추출
# result = collection.find({"timestamp": {"$gte": 20, "$lte": 25}}) # timestamp 20-25구간 추출
# result = collection.find({"timestamp": {"$gte": 0, "$lte": 29}})
result = collection.find()


col = list(range(1, 91)) # 채널 수
col.insert(0, "timestamp") # column list

csi_df = pd.DataFrame(columns=col)

for i in result:
timestamp = i.get("timestamp")
data = i.get("antenna_A")
data.extend(i.get("antenna_B"))
data.extend(i.get("antenna_C"))
data.insert(0, timestamp) # 타임스탬프도 리스트에 추가
data = np.round(data, 4)
csi_df = csi_df.append(pd.Series(data, index=csi_df.columns), ignore_index=True) # 데이터프레임 삽입


print(csi_df)