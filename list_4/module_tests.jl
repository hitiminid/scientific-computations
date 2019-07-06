using Interpolation
using Base.Test


x = [3.0, 1.0, 5.0, 6.0]
fx  = [1.0, -3.0, 2.0, 4.0]
result = [1.0, 2.0, -0.375, 0.175]
@test ilorazyRoznicowe(x, fx) ≈ result


x  = [5.0, -7.0, -6.0, 0.0]
fx = [1.0, -23.0, -54.0, -954.0]
ilorazy = ilorazyRoznicowe(x, fx)
point = 6.0
expectedResult = 666.0
@test warNewton(x, ilorazy, point) == expectedResult


x = [1.0, 15.0, 2.0, 5.0]
fx = [2.0, 2.0, 3.0, 2.0]
ilorazy = ilorazyRoznicowe(x, fx)
point = 3.14
expectedResult = 3.210449846153846
@test warNewton(x, ilorazyRoznicowe(x, fx), point) == expectedResult


x      =  [2.0, 2.0, 5.0, 1.0]
fx     =  [1.0, 2.0, 3.0, 4.0]
expectedResult = [-71.0, 86.0, -33.0, 4.0]
@test naturalna(x :: Vector{Float64}, fx :: Vector{Float64}) ≈ expectedResult
