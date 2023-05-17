import sys
# 수 자료형 
## int
a = 100
print(a)
print(type(a))
## float
b = 0.3
c = 0.6 
d = round(b+c,5)
if d == 0.9: 
    print(True)
    print(d)
else: 
    print(False)  
    print(d)
ef = 102411
ww = 2
print(ef/ww)
print(ef%ww)
print(ef//ww)

a = [1,2,3,4,5]
print(a)
print(a[0])
print(a[-1])
a.append(10)
a[4] = 6
print(a)
print(a[0:1])
print(a[1::2])
print(a[::-1])

array = [i for i in range(21) if i != 0 and i % 2 == 0]
print(array)


n = 3 
m = 4 
array2 = [[i+1 for i in range(m)] for _ in range(n) ]
print(array2)


flattened = [num for row in array2 for num in row]
print(flattened)

flattened.reverse()
print(flattened)
flattened.sort()
print(flattened)
flattened.sort(reverse = True)
flattened.remove(1)
print(flattened)
print(flattened.count(4))

array3 = [[0]* m] * n 
print(array3)
array3[1][1] = 5
print(array3)

stringData = "Hello"
stringData2 = "World"

print(stringData + " " + stringData2)

dict = { "name": 2222, "Test2": "test", "Test": 223}
dict.update({"Test2": 33})
print(dict)

print(dict.keys())
print(dict.values())
test2 = list(dict.values())
sortedTest2 = sorted(test2)
print(sortedTest2)

dict.pop("Tes222", "Test")

print(dict)

for i in range(5):
    # print(i)
    a = (lambda a, b: a+b)(i,i)
    print(a)
aa = 0
def func(): 
    global aa
    aa += 1

for _ in range(15): 
    func()

# print(aa)

# numbers = [1,2,3,4,5,6,7,8,9,10]
# even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
# print(even_numbers)

# line = list(map(int,sys.stdin.readline().rstrip().split()))
# print(line)

# result = sum(line)
# minResult = min(line) 
# maxResult = max(line)

# print(result)

import itertools 

items = [1,2,3]

permu = list(itertools.permutations(items,2))
permui = list(itertools.product(items, repeat= 2))
combi = list(itertools.combinations(items,2))
combiRe = list(itertools.combinations_with_replacement(items,2))
print(permu)
print(permui)
print(combi)
print(combiRe)

import heapq

def heapSort(iterable): 
    h = []
    result = []
    # 모든 원소를 차례대로 힙에 삽입 
    for value in iterable: 
        heapq.heappush(h,-value)
    # 힙에 삽입된 모든 원소를 차례대로 꺼내어 담기 
    for _ in range(len(h)):
        result.append(-heapq.heappop(h))
    return result

beforeArray = [1,2,3461,23,5,547,5,2,6,85,6,84,2,1,4,5,3,42,5,7,3]
resultSort = heapSort(beforeArray)
print(resultSort)