import random

print("100")
for i in range(100):
    print(40)

    for i in range(40):
        if i == 39:
            print(random.randint(0,10))
        else:
            print(random.randint(0,10), end=" ")
