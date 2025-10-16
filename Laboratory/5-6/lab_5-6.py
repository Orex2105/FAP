def one():
    from random import  randint
    A = [randint(-99, 67) for i in range(30)]
    print(f'Массив A: {A}')
    print(f'Массив B: {[i for i in A if i % 2 == 0]}')


def two():
    n = int(input('Размер массива: '))
    print('Элементы массива через пробел:')
    arr = list(map(int, input().split()))
    print(arr == sorted(arr))


def three():
    from random import randint
    arr = [randint(-50, 100) for i in range(20)]
    set(arr); list(arr)
    print(f'Массив: {arr}')

    arr_copy = arr.copy()
    for i in reversed(arr_copy):
        if i > 0:
            arr_copy.remove(i)
            print(f'Без последнего положительного элемента ({i}): {arr_copy}')
            break
    
    arr_copy = arr.copy()
    max_value = max(arr_copy)
    arr_copy.remove(max_value)
    print(f'Без наибольшего элемента ({max_value}): {arr_copy}')


one()
two()
three()