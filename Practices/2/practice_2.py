def one():
    n = int(input())
    print(f'Число\tКвадрат')
    print('-'*15)
    
    for i in range(1, n+1, 2):
        print(f'{i}\t{i**2}')


def two():
    a, b, c = [int(input()) for i in range(3)]
    counter = 0
    
    while a >= c:
        if counter:
            a += a / 100 * 15
        a -= b
        counter += 1
    print(counter)


def three():
    segments_coords = []
    for i in range(4):
        a = int(input())
        b = int(input())
        segments_coords.append((a, b))

    n = int(input())
    points = [int(input()) for i in range(n)]

    segments_count = [0, 0, 0, 0]

    for point in points:
        for i, (start, end) in enumerate(segments_coords):
            if start <= point <= end:   
                segments_count[i] += 1
    
    print(segments_count)


def four():
    n = int(input())
    factories = [tuple(map(int, input().split())) for i in range(n)]

    total_power = 0
    for factory in factories:
        total_power += factory[1]

    powerful_factory_number = -1
    for factory in factories:
        if factory[0] > powerful_factory_number:
            powerful_factory_number = factory[0]
    
    print(total_power, powerful_factory_number)


#one()
#two()
three()
four()