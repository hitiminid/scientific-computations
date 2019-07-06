# Author: Piotr Kawa
# Exercises 1-3 tests

include("module.jl");
using ComputingLinearEquations
using Base.Test

delta   = 10.0^(-5)
epsilon = 10.0^(-5)
maxit = 100

# f(x) = x - 5
# m0 = 5.0
f     = x -> x - 5
f_der = x -> 1
result = 5.0

@test mbisekcji(f, -10.0, 10.0, delta, epsilon)[1] ≈ result atol=epsilon
@test mbisekcji(f, -476.0, 476.0, delta, epsilon)[1] ≈ result atol=epsilon
@test mbisekcji(f, -5.0, 10.0, delta, epsilon)[1] ≈ result atol=epsilon
@test mstycznych(f, f_der, 5.0, delta, epsilon, maxit)[1] ≈ result atol=epsilon
@test mstycznych(f, f_der, -1025.0, delta, epsilon, maxit) == (5.0, 0.0, 1, 0)
@test msiecznych(f, 4.0, 5.0, delta, epsilon, maxit)[1] ≈ result atol=epsilon
@test msiecznych(f, -50.0, 2.0, delta, epsilon, maxit) == (5.0, 0.0, 1, 0)

# f(x) = ln(x)
# m0 = 1.0
f = x -> log(x)
f_der = x -> 1/x
result = 1.0

@test mbisekcji(f, 0.5, 2.0, delta, epsilon)[1] ≈ result atol=epsilon
@test mbisekcji(f, 100.0, 200.0, delta, epsilon) == (0,0,0,1)
@test mstycznych(f, f_der, 0.25, delta, epsilon, maxit)[1] ≈ result atol=epsilon
@test msiecznych(f, 0.2, 0.4, delta, epsilon, maxit)[1] ≈ result atol=epsilon
