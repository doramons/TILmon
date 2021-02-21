####벡터화 - 벡터연산
    - 같은 형태의 배열(벡터,행렬)간의 연산은 같은 index의 원소끼리 연산을 한다
        - Element-wise(원소별) 연산이라고도 한다
        - 배열간의 연산시 배열의 형태(shape)가 같아야 한다
        - 배열의 형태가 다른 경우 Broadcast 조건을 만족하면 연산이 가능하다
        
#####벡터/행렬과 스칼라간 연산
    
        $$
\begin{align}
x=
\begin{bmatrix}
1 \\
2 \\
3 \\
\end{bmatrix}
\end{align}
$$

$$
\begin{align}
10 - x = 10 -
\begin{bmatrix}
1 \\
2 \\
3 \\
\end{bmatrix}
=
\begin{bmatrix}
10 - 1 \\
10 - 2 \\
10 - 3 \\
\end{bmatrix}
=
\begin{bmatrix}
9 \\
8 \\
7 \\
\end{bmatrix}
\end{align}
$$
        
        
        
