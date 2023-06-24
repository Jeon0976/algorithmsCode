import sys
from collections import deque

# N,M,R 입력받기
N,M,R=map(int,sys.stdin.readline().split())

# 2차원 그래프 입력
graph=[[] for _ in range(N+1)]

# 간선 그래프화
for _ in range(M):
    u,v =map(int,sys.stdin.readline().split())
    graph[u].append(v)
    graph[v].append(u)

# 노드 순서대로 방문
for i in range(N+1):
    graph[i].sort()


# BFS factors
visited=[False for _ in range(N+1)]
answer=[-1 for _ in range(N+1)]

# BFS 함수
def bfs(graph,R):
    queue=deque()
    depth=0

    queue.append((R,depth)) # 핵심포인트 queue가 추가될 때 depth 정보도 같이 저장
    visited[R]=True
    answer[R]=depth

    while queue:
        current_vertex, depth = queue.popleft()
        answer[current_vertex]=depth
        
        for next_vertex in graph[current_vertex]:
            if not visited[next_vertex]:
                queue.append((next_vertex, depth+1)) #새로운 queue가 추가될 때 깊이+1 저장
                visited[next_vertex]=True

bfs(graph,R)

# 출력
for x in answer[1::]:
    print(x)