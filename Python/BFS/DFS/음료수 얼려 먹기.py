# #!/bin/python3

# # import math
# # import os
# # import random
# # import re
# # import sys

# # # class SinglyLinkedListNode:
# # #     def __init__(self, node_data):
# # #         self.data = node_data
# # #         self.next = None

# # # class SinglyLinkedList:
# # #     def __init__(self):
# # #         self.head = None
# # #         self.tail = None

# # #     def insert_node(self, node_data):
# # #         node = SinglyLinkedListNode(node_data)

# # #         if not self.head:
# # #             self.head = node
# # #         else:
# # #             self.tail.next = node

# # #         self.tail = node

# # # def print_singly_linked_list(node, sep, fptr):
# # #     while node:
# # #         fptr.write(str(node.data))

# # #         node = node.next

# # #         if node:
# # #             fptr.write(sep)



# # # class test: 
# # #     def __init__(self, data, next = None): 
# # #         self.data = data 
# # #         self.next = next

# # # test2 = test(5)
# # # test3 = test(5,test2)

# # # def dee(test):
# # #     test22 = test.data
# # #     print(test22)

# # # dee(test2)

# # # def delete(test):
# # #     if test.data % 2 == 0 and test.next != None: 


# # class Node:
# #     def __init__(self, data=None):
# #         self.data = data
# #         self.next = None


# # def filter_even(node):
# #     # 가장 처음 노드를 기억하기 위한 변수
# #     head = node

# #     # 현재 노드와 이전 노드를 추적하는 변수
# #     prev_node = None
# #     curr_node = node

# #     while curr_node is not None:
# #         # 현재 노드의 값이 짝수인지 확인
# #         if curr_node.data % 2 == 0:
# #             # 짝수이면, 이전 노드가 현재 노드의 다음 노드를 가리키게 합니다.
# #             if prev_node is not None:
# #                 prev_node.next = curr_node.next
# #             else:
# #                 # 이전 노드가 없으면(즉, 현재 노드가 첫 번째 노드이면), 두 번째 노드가 새로운 머리가 됩니다.
# #                 head = curr_node.next
# #         else:
# #             # 노드의 값이 홀수이면, 이전 노드를 업데이트합니다.
# #             prev_node = curr_node

# #         # 현재 노드를 다음 노드로 업데이트합니다.
# #         curr_node = curr_node.next

# #     return head


# # # 테스트
# # node1 = Node(2)
# # node2 = Node(2)
# # node3 = Node(3)
# # node4 = Node(4)
# # node1.next = node2
# # node2.next = node3
# # node3.next = node4

# # filtered_list = filter_even(node1)
# # current_node = filtered_list
# # while current_node is not None:
# #     print(current_node.data)
# #     current_node = current_node.next
# # # 출력: 1 3
# #!/bin/python3

# import math
# import os
# import random
# import re
# import sys



# #
# # Complete the 'findMinimumTime' function below.
# #
# # The function is expected to return an INTEGER.
# # The function accepts following parameters:
# #  1. UNWEIGHTED_INTEGER_GRAPH centre
# #  2. INTEGER_ARRAY status
# #

# #
# # For the unweighted graph, <name>:
# #
# # 1. The number of nodes is <name>_nodes.
# # 2. The number of edges is <name>_edges.
# # 3. An edge exists between <name>_from[i] and <name>_to[i].
# #
# #

# def findMinimumTime(centre_nodes, centre_from, centre_to, status):
#     graph = {i: [] for i in range(1, centre_nodes+1)}
#     for i in range(len(centre_from)):
#         graph[centre_from[i]].append(centre_to[i])
#         graph[centre_to[i]].append(centre_from[i])

#     surplus = [i for i in range(1, centre_nodes+1) if status[i-1] == 3]
#     deficit = {i for i in range(1, centre_nodes+1) if status[i-1] == 1}

#     visited = [False] * (centre_nodes+1)
#     queue = deque(surplus)

#     for center in surplus:
#         visited[center] = True

#     time = 0
#     while deficit:
#         for _ in range(len(queue)):
#             center = queue.popleft()
#             if center in deficit:
#                 deficit.remove(center)
#             for neighbor in graph[center]:
#                 if not visited[neighbor]:
#                     queue.append(neighbor)
#                     visited[neighbor] = True
#         time += 1

#     return time - 1 if deficit else time

# if __name__ == '__main__':
#     fptr = open(os.environ['OUTPUT_PATH'], 'w')

#     centre_nodes, centre_edges = map(int, input().rstrip().split())

#     centre_from = [0] * centre_edges
#     centre_to = [0] * centre_edges

#     for i in range(centre_edges):
#         centre_from[i], centre_to[i] = map(int, input().rstrip().split())

#     status_count = int(input().strip())

#     status = []

#     for _ in range(status_count):
#         status_item = int(input().strip())
#         status.append(status_item)

#     result = findMinimumTime(centre_nodes, centre_from, centre_to, status)

#     fptr.write(str(result) + '\n')

#     fptr.close()
