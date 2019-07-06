# Author: Piotr Kawa
# Exercise 5

using .ComputingLinearEquations
using Plots
Pkg.add("PlotlyJS")


# function that generates a plot
function createPlot()
  # left side of range
  start = 0
  # right side of range
  finish = 2
  # function that will be presented
  f(x) = 3*x - exp(x)
  plotlyjs()
  # plot creation
  plot(f, label="", color= :blue, start, finish)
end

createPlot()

function ex5()

  println("[0; 1]")
  result = mbisekcji(x -> 3*x - e^x, 0.0, 1.0, 10.0^(-4), 10.0^(-4))
  println(result)

  println("[1; 2]")
  result = mbisekcji(x -> 3*x - e^x, 1.0, 2.0, 10.0^(-4), 10.0^(-4))
  println(result)

  #bad idea - gives bad results
  println("[0; 2]")
  result = mbisekcji(x -> 3*x - e^x, 0.0, 2.0, 10.0^(-4), 10.0^(-4))
  println(result)
end

ex5()
