# Дано натуральное число n. Найдите произведение всех его цифр.
def one():
    n, p = int(input()), 1
    while n != 0:
        a = n % 10
        p *= a
        n = n // 10
    print(p)


# Дано натуральное число n. Найдите количество его положительных делителей.
def two():
    n = int(input())
    x, k = 1, 0
    
    while x <= n:
        if n % x == 0:
            k += 1
        x += 1
    print(k)


# Дано натуральное число n. Определите, является ли оно совершенным.
def three():
    n, x, s = int(input()), 1, 0
    while x <= n:
        if n % x == 0:
            s += x
        x += 1
    print('ДА' if s==n else 'НЕТ')


# Дано число n. Затем вводится n натуральных чисел (по одному на строку).
# Определите, сколько из этих чисел являются простыми.
def four():
    i, k, n = 1, 0, int(input('Введите n: '))
    
    while i <= n:
        x, c = 1, 0
        y = int(input('Введите y: '))
        
        while x <= y:
            if y % x == 0:
                c += 1
            x += 1
            
        if c == 2:
            k += 1
        i += 1
    print(k)


def is_perfect_num(num: int) -> bool:
    return sum(i + num//i for i in range(2, int(num**0.5) + 1) if num % i == 0) + 1 == num


def five():
    from math import prod
    print(prod([i for i in list(map(int, input().split())) if is_perfect_num(i)]))


if __name__ == '__main__':
    five()