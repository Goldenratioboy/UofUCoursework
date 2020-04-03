import matplotlib.pyplot as plt

x = [1, 4, 8]
y = [6.7*10**-7, 5.2*10**-6, 8.5*10**-5]

plt.plot(x, y)

plt.xlabel('Number for N')
plt.ylabel('kwH')

plt.title('Function 3 N vs. kwH')

plt.show()