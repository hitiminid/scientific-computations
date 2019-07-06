# Author: Piotr Kawa
# Exercise 7

function zad7()
  # point in which derivatives will be computed
  x0 :: Float64 = 1.0
  # exponent
  n  = 0

  for n = 0 : 54
    # delta
    h = 2.0 ^ (-n)
    # result of computing approximate derivative
    approximate :: Float64 = computeApproximateDerivative(x0, h)
    # computing derivative
    derivative  :: Float64 = computeDerivative(1.0)
    # computation error
    error       :: Float64 = computeError(approximate, derivative)

    println("h = 2^(", -n, ")")
    @printf "Approximate derivative = %0.25f\n" approximate
    @printf "Derivative             = %0.25f\n" derivative
    @printf "Error                  = %0.25f\n" error
  end
end

# x - point in which should derivative be computed
function computeDerivative(x :: Float64)
  return Float64(cos(x)) - Float64(3.0 * sin(3.0 * x))
end

# x0 - point in which should derivative be computed
# h  - delta
function computeApproximateDerivative(x0 :: Float64, h)
  return (f(x0 + h) - f(x0)) / h
end

# x - first derivative
# y - second derivative
function computeError(x :: Float64, y :: Float64)
  return abs(Float64(x - y))
end

# x - argument for sin() and cos() functions
function f(x :: Float64)
  return sin(x) + cos(3.0*x)
end


zad7()
