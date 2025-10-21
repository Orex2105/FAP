def one():
    string = input()
    print(f'Первый символ: {string[0]}')
    print(f'Последний символ: {string[len(string)-1]}')
    if len(string) >= 3 and len(string) % 2 != 0:
        print(f'Средний символ: {string[(len(string)-1)//2]}')


def two():
    string = input()
    pm_counter = 0
    zero_after_pm = 0
    
    for index, char in enumerate(string):
        if char == '+' or char == '-':
            pm_counter += 1
            if index + 1 < len(string) and string[index + 1] == '0':
                zero_after_pm += 1
    
    print(f'Плюсов и минусов: {pm_counter}')
    print(f'Ноль после + или - встретился {zero_after_pm} раз(а)')


def three():
    string = input()
    counter = 0
    
    for i in range(len(string)-2, -1, -1):
        if i + 2 < len(string) and string[i:i+3] == 'aba':
            counter += 1
    print(f'aba встретилось {counter} раз(а)')