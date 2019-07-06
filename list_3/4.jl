# Author: Piotr Kawa
# Exercise 4

using .ComputingLinearEquations

function ex4()
  println("Bisection method")
  result = mbisekcji(x -> sin(x) - (x/2)^(2), 1.5, 2.0, 0.5*10.0^(-5), 0.5*10.0^(-5))
  println(result)

  println("Newton method: ")
  result = mstycznych(x -> sin(x) - (x/2)^(2), x-> cos(x) - x/2,  1.5, 0.5*10.0^(-5), 0.5*10.0^(-5), 100)
  println(result)

  println("Secant method:")
  result = msiecznych(x -> sin(x) - (0.5 * x)^2, 1.0, 2.0, 0.5 * 10.0^(-5), 0.5 * 10.0^(-5), 100)
  println(result)

end


ex4()
