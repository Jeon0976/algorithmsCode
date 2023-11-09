import sys 

input = sys.stdin.readline

n = int(input())

loveArray = [[] for _ in range(n * n)]
order = [] 

answer = [[-1 for _ in range(n)] for _ in range(n)]

dx = [-1, 1, 0, 0]
dy = [0, 0, -1, 1]

score = [0, 1, 10, 100, 1000]

result_count = 0 

for _ in range(n * n): 
    temp_array = list(map(int, input().split()))
    order.append(temp_array[0] - 1)

    for i in range(1,5):
        loveArray[temp_array[0] - 1].append(temp_array[i] - 1)

def check_position(x, y, love):
    love_count = 0
    empty = 0 

    for i in range(4): 
        nx = x + dx[i]
        ny = y + dy[i]

        if nx < 0 or nx >= n or ny < 0 or ny >= n: 
            continue

        # swift의 contain
        if answer[nx][ny] in love: 
            love_count += 1 
        
        if answer[nx][ny] == -1: 
            empty += 1
    return love_count, empty

for value in order: 
    max_love = -1
    max_empty = -1 

    x = y = 0 

    for i in range(n): 
        for j in range(n):
            if answer[i][j] == -1: 
                love_count, empty = check_position(i,j,loveArray[value])

                if max_love < love_count or (max_love == love_count and max_empty < empty): 
                    max_love = love_count
                    max_empty = empty

                    x, y = i, j

    answer[x][y] = value

for i in range(n): 
    for j in range(n):
        love_count, _ = check_position(i, j, loveArray[answer[i][j]])
        result_count += score[love_count]

print(result_count)