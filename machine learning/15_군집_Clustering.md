## 군집 (Clustering)
비지도 학습으로 비슷한 특성을 가지는 데이터들끼리 그룹으로 묶는다

### 적용
  - 고객 분류
    - 고객 데이터를 바탕으로 비슷한 특징의 고객들을 묶어 성향을 파악할 수 있다
  - 이상치 탐지
    - 모든 군집에 묶이지 않는 데이터는 이상치일 가능성이 높다
  - 준지도학습
    - 레이블이 없는 데이터셋에 군집을 이용해 Label을 생성해 분류지도 학습을 할 수 있다 또는 레이블을 좀 더 세분화 할 수 있다

### K-mean (K-평균)
 - 가장 널리 사용되는 군집 알고리즘 중 하나
 - 데이터셋을 K개의 군집으로 나눈다. K는 하이퍼파라미터로 사용자가 지정
 - 군집의 중심이 될 것 같은 임의의 지점(Centroid)을 선택해 해당 중심에 가장 가까운 포인트들을 선택하는 기법

 #### 알고리즘 이해
  ![image](https://user-images.githubusercontent.com/76146752/113425903-9af27a00-940d-11eb-9b95-a2e8910be1ac.png)

### 특징
  - K-mean은 군집을 원 모양으로 간주
  - 모든 특성은 동일한 Scale을 가져야 한다
  - 이상치에 취약하다
  - 
    ``` python
        import numpy as np
        import pandas as pd
        import matplotlib.pyplot as plt
        import matplotlib as mpl
        
        mpl.rcParams['font.family'] = 'malgun gothic'
        mpl.rcParams['axes.unicode_minus'] = True
        
        from sklearn.datasets import load_iris
        data = load_iris()
        X,y = data['data'], data['target']
        
        # Kmean은 scaling 필요
        scaler = StandardScaler()
        X_scaled = scaler.fit_transfrom(X)
        
        from sklearn.cluster import KMeans
        
        # 모델생성 - 몇 개의 그룹으로 나눌지 지정
        kmeans = KMeans(n_clusters = 3, random_state=1)
        
        # 학습
        kmeans.fit(X_scaled)
        
        cluster = kmeans.labels_
    ```
    
 ### Inertia value를 이용한 적정 군집수 판단
  - inertia
      - 군집 내 데이터들과 중심간의 거리의 합으로 군집의 응집도를 나타내는 값이다
      - 값이 작을수록 응집도가 높게 군집화가 잘 되었다고 평가할 수 있다
      - Kmean의 inertia_ 속성으로 조회할 수 있다
      - 군집 단위 별로 inertia 값이 조회한 후 급격히 떨어지는 지점이 적정 군집수라 판단할 수 있다
      -  
        ``` python
            # inertia 조회
            kmeans.inertia_
            
            k_list = range(2,15)
            inertia_list = [] # inertia 점수저장할 리스트
            for k in k_list:
              model = KMeans(n_clusters=k, random_state=1)
              model.fit(X_scaled)
              inertia_list.append(model.inertia_)
              
            inertia_list
            
            plt.figure(figsize=(7,6))
            plt.plot(k_list, inertia_list)
            plt.show()
        ```
  ![image](https://user-images.githubusercontent.com/76146752/113427458-02a9c480-9410-11eb-89a9-da8222314079.png)

 ### 평가 : 실루엣 지표
  - 실루엣 계수 (silhouette coefficient)
      - 개별 관측치가 해당 군집 내의 데이터와 얼마나 가깝고 가장 가까운 다른 군집과 얼마나 먼지를 나타내는 지표
      - 1에 가까울수록 좋은 지표이다
      - 0에 가까울 수록 다른 군집과 가까움을 나타낸다
  - silhouette_samples()
      - 개별 관측지의 실루엣 계수 반환
  - silhouette_score()
      - 실루엣 계수들의 평균
  - 좋은 군집화의 지표
      - 실루엣 계수 평균이 1에 가까울수록 좋다
      - 실루엣 계수 평균과 개별군집의 실루엣 계수 평균의 편차가 크지 않아야 한다
  - 
    ``` python
        from sklearn.metrics import silhouette_score, silhouette_samples
        
        s_coef = silhouette_samples(X_scaled, cluster)
        
        silhouette_score(X_scaled, cluster)
        
        np.mean(s_coef)
    ```
        

