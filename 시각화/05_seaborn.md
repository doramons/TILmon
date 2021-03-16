#### Seaborn
   - matplotlib을 기반으로 다양한 테마와 그래프를 제공하는 파이썬 시각화 패키지
   - http://seaborn.pydata.org/
    - 공식 사이트의 [gallary] (http://seaborn.pydata.org/examples/index.html)에 제공하는 다양한 그래프와 예제를 확인 할 수 있다.
    - 설치: 아나콘다에 포함되어있음
        ```
          pip install seaborn
          conda install seaborn
        ```
        
        ``` python
            import seaborn as sns
            tips = sns.load_dataset('tips')
        ```
        
 ##### rugplot, kdeplot, distplot
   - 1차원 연속형 값들의 분포를 시각화 하는 그래프

 ##### rugplot
   - 각 데이터들의 위치를 보여준다
   - 
     ``` python
         plt.figure(figsize=(6,6))
         sns.ruplot(tips['total_bill'])
         plt.show()
     ```


