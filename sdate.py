#!/usr/bin/env python
""" Calculate the Julian Date """

import time
import math

t = time.time()

""" Technically, we should be adding 2440587.5,
    however, since we are trying to stick to the stardate
    concept, we add only 40587.5"""
jd = (t / 86400.0 + 40587.5)

# Use the idea that 10 Julian days is equal to 1 stardate
print "%05.2f" % jd

