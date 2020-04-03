import itertools
import matplotlib.pyplot as plt

def f1(n):
    for _ in itertools.repeat(None, 50_000_000 * n):
        pass
    return 0

def f2(n):
    for _ in itertools.repeat(None, 50_000_000 * n**2):
        pass

    return 0

def f3(n):
    for _ in itertools.repeat(None, 50_000_000 * 2**n):
        pass

    return 0

x = [1, 100, 300]
y = [0.75, 67.19, 222]

plt.plot(x, y)

plt.xlabel('Number for N')
plt.ylabel('Time (Seconds)')

plt.title('Function 1 N vs. Time')