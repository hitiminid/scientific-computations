import numpy as np
import matplotlib.pyplot as plt

ax = plt.subplot(111)
x = np.arange(0.0, 40.0, 0.0001)
func = np.exp(x)*np.log(1+np.exp(-x))
line, = plt.plot(x, func, lw=2)

plt.show()
