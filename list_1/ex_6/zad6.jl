# Author: Piotr Kawa
# Exercise 6

function ex6()

  # argument of f(x) and g(x)
  x = Float64(8.0)
  # next exponents of 8
  k = Float64(0.0)

  for i in 0 : 15
    variable = x ^ k
    println("k = ", k)

    println("f(x):")
    f(variable)

    println("g(x):")
    g(variable)

    k = k - 1.0
  end
end


# x - argument used for computing function
function f(x :: Float64)
  result  :: Float64 = Float64(sqrt(x^2 + 1.0)) -1.0
  @printf "%0.25f\n" result
end


# x - argument used for computing function
function g(x :: Float64)
  upper      :: Float64 = x ^ 2.0
  lowerLeft  :: Float64 = Float64(sqrt(Float64(x^2.0) + 1))
  lowerRight :: Float64 = 1.0
  x = Float64(upper / (lowerLeft + lowerRight))
  @printf "%0.25f\n" x
end

ex6()
