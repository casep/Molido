#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

# function to model and create data: Two-Gaussian
def func(x, a0, b0, c0, a1, b1, c1):
    return a0 * np.exp(-(x - b0)**2 / (2 * c0**2)) \
           + a1 * np.exp(-(x - b1)**2 / (2 * c1**2))

# clean data
x = np.linspace(0, 20, 200)
y = func(x, 1, 3, 1, -2, 15, 0.5)

# add noise to data
yn = y + 0.2 * np.random.normal(size=len(x))

# fit noisy data providing guesses
guesses = [1, 3, 1, 1, 15, 1]
popt, pcov = curve_fit(func, x, yn, p0=guesses)

# print best fit and variances (diagonal elements)
for i in range(0, 6):
    print "(", popt[i], "+/-", pcov[i,i], ")"

# plot
plt.title('Fitting two Gaussians')
plt.plot(x, y, label='Function')
plt.scatter(x, yn)
yfit = func(x, popt[0], popt[1], popt[2], popt[3], popt[4], popt[5])
plt.plot(x, yfit, '--', label='Best Fit')
plt.legend()
plt.xlabel('x')
plt.ylabel('y = f(x)')
plt.show()

