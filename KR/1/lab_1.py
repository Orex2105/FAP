from math import log, cbrt
from typing import Callable


def two(start: float, end: float, step: float,
        f: Callable[[float], float]) -> None:
    x = start

    print("-" * 20)
    print(f'|{"x":^8}|{"y":^9}|')
    print("-" * 20)

    while x <= end:
        try:
            y = f(x)
            print(f'| {x:6.2f} | {y:7.2f} |')
        except (ValueError, ZeroDivisionError):
            print(f'| {x:6.2f} | {f(abs(x)):>7} |')
        x += step
    print("-" * 20)


def one(x: float) -> Callable[[float], float]:
    if x < -9:
        return lambda x: log(x) / (x**2)
    elif -9 < x < -2:
        return lambda x: -x * cbrt(x)
    elif -2 <= x < 4:
        return lambda x: log(x) + x**(x*0.1)
    elif x >= 4:
        return lambda x: log(x) / x**2
    else:
        return lambda x: 0


def main():
    x = float(input("Введите x: "))
    func = one(x)
    print(f"Ответ на первое задание: {func(x)}")

    if input('Выполнить второе задание? (y/n, default - n)\n').lower() == 'y':
        two(start=-11.0, end=6.0, step=0.2, f=func)


main()