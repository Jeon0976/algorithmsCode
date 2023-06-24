from collections import deque, defaultdict
import sys

def findMinimumTime(centre_nodes, centre_from, centre_to, status):
    graph = defaultdict(list)
    count = len(centre_from)

    for i in range(count):
        graph[centre_to[i]].append(centre_from[i])
        graph[centre_from[i]].append(centre_to[i])

    surplus_centers = [i+1 for i in range(centre_nodes) if status[i] == 3]
    dist = [sys.maxsize] * (centre_nodes + 1)
    print(surplus_centers)
    print(dist)
    queue = deque(surplus_centers)
    for center in surplus_centers:
        dist[center] = 0
    print(dist)
    while queue:
        center = queue.popleft()
        for i in graph[center]:
            if dist[center] + 1 < dist[i]:
                dist[i] = dist[center] + 1
                queue.append(i)
    print(dist)
    deficit_centers = [i+1 for i in range(centre_nodes) if status[i] == 1]
    print(deficit_centers)
    return max(dist[center] for center in deficit_centers)

ledd = findMinimumTime(3, [1,1],[2,3],[2,1,2])
print(ledd)  # Output: 2

tet = [1,2,3,4,5]
tet.count

# defualtdict 