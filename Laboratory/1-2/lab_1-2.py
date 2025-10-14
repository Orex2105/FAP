def task_1():
    x1, y1, z1 = (int(input()) for i in range(3))
    x2, y2, z2 = (int(input()) for i in range(3))

    day_1 = x1*5 + y1*7 + z1*8
    day_2 = x2*5 + y2*7 + z2*8
    f = 123.12445

    print(
        f"""В первый день: {day_1}
Во второй день: {day_2}
За два дня: {day_1+day_2}"""
    )


def task_2():
    n = int(input())
    
    entrance = (n - 1) // 36 + 1
    floor = (n % 36 - 1) // 4 + 1
    
    print(f"""Подъезд: {entrance}
Этаж: {floor}""")


def task_3():
    n = input()
    print('Палиндром' if n == n[::-1] else 'Не палиндром')


def task_4():
    rook = [int(input()) for i in range(2)]
    target = [int(input()) for i in range(2)]
    
    if rook[0] == target[0] or rook[1] == target[1]:
        print('Бьет')
    else:
        print('Не бьет')


def task_5():
    from random import randint

    x = int(input())
    y = int(input())
    k = int(input())

    volumes = [randint(1, 20) for i in range(x)]
    count = 0
    
    for _ in volumes:
        if _ == y:
            count += 1
    
    print('Yes' if count >= k else 'No')

task_4()
task_5()