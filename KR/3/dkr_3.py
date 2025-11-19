from typing import Callable


def simpson(f: Callable, a: float, b: float, n: int) -> float:
    if n % 2 != 0:
        raise ValueError("n должно быть четным")
    
    h = (b - a) / n
    x = [a + i * h for i in range(n+1)]
    y = [f(xi) for xi in x]
    
    total = y[0] + y[-1]
    
    for i in range(1, n):
        if i % 2 == 1:
            total += 4 * y[i]
        else:
            total += 2 * y[i]

    return (h / 3) * total


def area(a: float, b: float, n: int) -> float:
    f = lambda x: max(2 * x**3 - x**2 + x + 2, 0)
    return simpson(f, a, b, n)


def main():
    while True:
        print("\n1 — Вычислить площадь\n" \
        "2 — Оценить погрешность\n" \
        "3 — Выход")

        cmd = input("Выберите пункт: ")

        match cmd:
            case '1':
                a = float(input("a = "))
                b = float(input("b = "))
                n = int(input("n (четное) = "))
                print("Площадь =", area(a, b, n))
            case '2':
                a = float(input("a = "))
                b = float(input("b = "))
                n = int(input("n (четное) = "))
                s1 = area(a, b, n)
                s2 = area(a, b, 2 * n)
                print("Погрешность ≈", abs(s2 - s1))
            case '3':
                break


if __name__ == "__main__":
    main()