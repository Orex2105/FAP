def MultipleOfFive(arr: list[int]) -> int:
    for index, value in enumerate(arr):
        if value % 5 == 0:
            return index
    raise Exception(f'В массиве {arr} нет числа, кратного 5')


def ReplaceMaxWithZero(arr: list[int]) -> None:
    arr[arr.index(max(arr))] = 0


def DoubleElements(arr: list[int]) -> None:
    IMin = arr.index(min(arr))
    arr = arr[:IMin+1] + list(map(lambda x: x*2, arr[:IMin+1]))


def RowFill(row: list[int], value: int) -> None:
    row[:] = [value] * len(row)


def task_one() -> None:
    from random import randint
    n, a, b = map(int, input('Введите размер массивов и диапазон заполнения (от a до b): ').split())
    ArrOne = [randint(a, b) for i in range(n)]
    ArrTwo = [randint(a, b) for i in range(n)]
    
    print(f'Массив A: {ArrOne}\nМассив B: {ArrTwo}')
    
    if MultipleOfFive(ArrOne) < MultipleOfFive(ArrTwo):
        ReplaceMaxWithZero(ArrOne)
        DoubleElements(ArrTwo)
    elif MultipleOfFive(ArrOne) > MultipleOfFive(ArrTwo):
        ReplaceMaxWithZero(ArrTwo)
        DoubleElements(ArrOne)
    else:
        raise Exception('Индексы первых числел, кратных 5, совпали у обоих массивов')
    
    print(f'Массив A после изменений: {ArrOne}')
    print(f'Массив B после изменений: {ArrTwo}')


def task_two() -> None:
    from random import randint
    a, b = map(int, input('Введите диапазон заполнения (от a до b)').split())
    matrix = [[randint(a, b) for i in range(8)] for j in range(8)]
    print(f'Исходная матрица: {matrix}')

    for row in matrix:
        MaxValue = max(row)
        if row.count(MaxValue) == 1:
            RowFill(row, 1)
        else:
            RowFill(row, -1)
    print(f'Конечная матрица: {matrix}')