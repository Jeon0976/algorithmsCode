# 큰 수의 법칙 
# N은 무조건 2개 이상
# m은 
n, m, k = map(int,input().split())
data = list(map(int,input().split()))

data.sort(reverse= True)

first = data[0]
second = data[1]

result = 0 

def noLoop():   
    global result 

    if first == second:
        print(first * m)
    else: 
        share = m // (k + 1) # 정수 나눗셈
        rest = m % (k + 1)
        result = (((k * first) + second) * share) + (rest * first)


def loop(): 
    global m 
    global result 
    while True:
        for i in range(k):
            if m == 0:
                break
            result += first
            m -= 1
        if m == 0:
            break
        result += second
        m -= 1


# noLoop()

loop()

print(result)
