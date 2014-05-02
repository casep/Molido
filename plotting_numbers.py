#!/usr/bin/python
# plotting_numbers.py
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

import matplotlib.pyplot as plt
#plt.plot([1,2,3,4])
plt.plot([1,2,3,4], [1,4,9,16])

plt.ylabel('some numbers')
plt.show()