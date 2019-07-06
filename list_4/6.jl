# Author: Piotr Kawa
# Exercise 6

using Interpolation

# x -> abs(x) [-1.0, 1.0] for n = 5, 10, 15
rysujNnfx(x -> abs(x), -1.0, 1.0, 5)
rysujNnfx(x -> abs(x), -1.0, 1.0, 10)
rysujNnfx(x -> abs(x), -1.0, 1.0, 15)

# x -> 1/(1+x^2) [-5.0, 5.0] for n = 5, 10, 15
rysujNnfx(x -> 1/(1+x^2), -5.0, 5.0, 5)
rysujNnfx(x -> 1/(1+x^2), -5.0, 5.0, 10)
rysujNnfx(x -> 1/(1+x^2), -5.0, 5.0, 15)
