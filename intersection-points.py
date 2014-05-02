#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fsolve

# function to simplify intersection solution
def findIntersection(func1, func2, x0):
    return fsolve(lambda x: func1(x) - func2(x), x0)

# data range
x = np.linspace(0, 45, 10000)

# functions that will intersect
funky = lambda x: np.cos(x / 5) * np.sin(x / 2)
line = lambda x: 0.01 * x - 0.5

# starting estimate
x0 = [15, 20, 30, 35, 40, 45]

# solutions on intersection points
result = findIntersection(funky, line, x0)

for i in range(0, 6):
    print "(", result[i], ", ", line(result)[i], ")"

# plot
plt.title('Intersection points')
plt.plot(x, funky(x), label='Funky func')
plt.plot(x, line(x), label='Line func')
plt.plot(result, line(result), 'o')
plt.xlim(0, 45)
plt.ylim(-1, 1)
plt.legend()
plt.show()
