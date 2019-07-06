# Author: Piotr Kawa
# Exercise 6

using ComputingLinearEquations
using Plots
Pkg.add("PlotlyJS")

# function that generates a plot
function createPlotf1()
  # left side of range
  start = 0.5
  # right side of range
  finish = 1.5
  # function that will be presented
  f(x) = e^(1-x) -1
  plotlyjs()
  # plot creation
  plot(f, label="", color= :blue, start, finish)
end

createPlotf1()

function createPlotf2()
  # left side of range
  start =-3
  # right side of range
  finish = 4
  # function that will be presented
  f(x) = x*e^(-x)
  plotlyjs()
  # plot creation
  plot(f, label="", color= :blue, start, finish)
end



# computations for first function
function ex6a()
  println("Bisection #1")
  result = mbisekcji(x -> e^(1-x) -1, 0.0, 2.0, 10.0^(-5), 10.0^(-5))
  println(result)

  println("Bisection #2")
  result = mbisekcji(x -> e^(1-x) -1, -1.0, 2.0, 10.0^(-5), 10.0^(-5))
  println(result)

  println("Newton #1")
  result = mstycznych(x -> e^(1-x) -1, x -> -1.0 * (e)^(1-x), 0.5, 10.0^(-5), 10.0^(-5), 50)
  println(result)

  println("Newton #2")
  result = mstycznych(x -> e^(1-x) -1, x -> -1.0 * (e)^(1-x), 7.3, 10.0^(-5), 10.0^(-5), 500)
  println(result)

  println("Secant method ")
  result = msiecznych(x -> e^(1-x) -1, 0.0, 2.00, 10.0^(-5), 10.0^(-5), 500)
  println(result)
end

ex6a()

# computations for second function
function ex6b()
  println("Bisection #1")
  result = mbisekcji(x -> x*e^(-x), -1.0, 1.0, 10.0^(-5), 10.0^(-5))
  println(result)

  println("Bisection #2 ")
  result = mbisekcji(x -> x*e^(-x), -1.0, 1.01, 10.0^(-5), 10.0^(-5))
  println(result)

  println("Newton")
  result = mstycznych(x -> x*e^(-x), x -> ((-1.0)* e^(-x)) *(x-1.0), 0.5, 10.0^(-5), 10.0^(-5), 50)
  println(result)

  println("Secant method #1")
  result = msiecznych(x -> x*e^(-x), -10.0, 10.0, 10.0^(-5), 10.0^(-5), 500)
  println(result)

  println("Secant method #2")
  result = msiecznych(x -> x*e^(-x), -0.75, 1.00, 10.0^(-5), 10.0^(-5), 500)
  println(result)

end

ex6b()

# additional tests for first function
function exAddTests1()
  println("Newton methods with given arguments")
  println("f1 and x0 > 1")
  i = 0
  y = 1.0
  while i != 100

    # println(" x = ", y)
    println(mstycznych(x -> e^(1-x) -1, x -> -1.0 * (e)^(1-x),  y ,10.0^(-5), 10.0^(-5), 100000))
    y = y + 1.0
    i = i+1
  end
end

exAddTests1()

# additional tests for second function
function exAddTests2()
  println("f2 and x0 = 1")
  it = 0
  maxitNumber = 1
  while it != 4
    result = mstycznych(x -> x*e^(-x), x -> ((-1.0)* e^(-x)) *(x-1.0), 1.0, 10.0^(-5), 10.0^(-5), maxitNumber)
    println(result)
    maxitNumber = maxitNumber * 10
    it = it + 1
    println(maxitNumber)
  end

  println("f2 and x0 > 1")
  i = 0
  y = 1.0
  while i != 100

    println(" x = ", y)
    result = mstycznych(x -> x*e^(-x), x -> ((-1.0)* e^(-x)) *(x-1.0), y ,10.0^(-5), 10.0^(-5), 100)
    y = y + 1.0
    i = i + 1.0
    println(result)
  end
end

exAddTests2()
