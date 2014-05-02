#!/usr/bin/python
# wire3d.py
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

from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.gca(projection='3d')
ax = fig.add_subplot(111, projection='3d')

R = [7.3333335,8.333334,7.5555553,7.7777777,7,6.888889,19.555555,18.88889,19,21.222221,5.5555553,21.666666,7.888889,21.222221,17.333334,7.7777777,7.4444447,18.88889,7.5555553,7.111111,6.7777777,24.666666,4.111111,21.333334,23.555555,22.11111,7.3333335,7.7777777,20,24.666666]
G = [7.6666665,7.7777777,7.2222223,6.4444447,7.6666665,6.6666665,25.88889,21.444445,21.11111,26.777779,4,31.11111,7.3333335,27.555555,25.222221,7.2222223,7.3333335,21.88889,8.222222,7.111111,7,35.22222,8.666667,26.666666,30,29.777779,6.5555553,7.888889,25.444445,34.444447]
I=[6.185185,6.6666665,6.111111,5.851852,6.037037,5.5555553,20,17.925926,17.666666,21.296297,3.925926,23.444445,6.3333335,21.703703,18.74074,6.259259,6.037037,17.962963,6.4814816,5.888889,5.6296296,26.74074,5.4444447,21.407408,23.851852,23.074074,5.740741,6.4444447,20.25926,26.296297]

ax.plot_trisurf(R, G, triangles=triangles, I)

plt.show()

