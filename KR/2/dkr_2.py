def is_monotone(lst: list[int]) -> bool:
    pairs = list((lst[i], lst[i+1]) for i in range(len(lst)-1))
    increasing = all(p[0] <= p[1] for p in pairs)
    decreasing = all(p[0] >= p[1] for p in pairs)
    
    return decreasing or increasing


def task_one():
    print('Элементы списка: ', end='')
    lst = list(map(int, input().split()))
    print(is_monotone(lst[::2]))


def task_two():
    string = input('Введите строку: ')
    str_set = set()
    counter = 0

    for i in range(1, len(string)+1):
        if i % 3 != 0:
            continue
        substring = string[i-3:i]
        if substring in str_set:
            continue
        else:
            str_set.add(string[i-3:i])
            counter += 1
    print(counter)