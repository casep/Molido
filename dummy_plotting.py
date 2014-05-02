#!/usr/bin/python
# dummy_plotting.py
#
# Copyright (C) 2013 - Carlos "casep" Sepulveda
# carlos.sepulveda@gmail.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fsolve


# data range
x = np.linspace(0, 45, 10000)

# functions that will intersect
line = lambda x: 0.01 * x - 0.5

# plot
plt.title('Simple line')
plt.plot(x, line(x), label='Line func')
plt.xlim(0, 45)
plt.ylim(-1, 1)
plt.legend()
plt.show()
