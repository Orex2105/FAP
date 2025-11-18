from typing import Callable


def simpson(f: Callable, a: int, b: int, n: int) -> int:
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


if __name__ == '__main__':
    func = lambda x: 2*(x**3) + (-1) * x**2 + 1 * x + 2
    