# Author: Piotr Kawa
# Exercise 5

using Interpolation

# e^x [0.0, 1.0] for n = 5, 10, 15
rysujNnfx(x -> exp(x), 0.0, 1.0, 5)
rysujNnfx(x -> exp(x), 0.0, 1.0, 10)
rysujNnfx(x -> exp(x), 0.0, 1.0, 15)

# x^2*sin(x) [-1.0, 1.0] for n = 5, 10, 15
rysujNnfx(x -> x^2*sin(x), -1.0, 1.0, 5)
rysujNnfx(x -> x^2*sin(x), -1.0, 1.0, 10)
rysujNnfx(x -> x^2*sin(x), -1.0, 1.0, 15)
