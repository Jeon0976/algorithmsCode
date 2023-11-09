import sys
input = sys.stdin.readline

height = int(input())
lst = list(map(int, input().split()))

answer = [[] for _ in range(height)]


def check(left, right, level, answer):
    if left > right: 
        return 
    
    mid = (left + right) // 2 

    answer[level].append(lst[mid])

    check(left, mid - 1, level + 1, answer)
    check(mid + 1, right, level + 1, answer)

check(0, len(lst) - 1, 0, answer)

for level in answer:
    for val in level: 
         print(val, end=" ")
    print()