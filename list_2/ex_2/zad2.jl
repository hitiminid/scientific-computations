# Author: Piotr Kawa
# Exercise 2

using Plots

# function that generates a plot
function createPlot()
  # left side of range
  start = 0
  # right side of range
  finish = 60
  # function that will be presented
  f(x) = exp(x) * log(1+exp(-x))
  plotlyjs()
  # plot creation
  plot(f, label="", color= :blue, start, finish)
end

createPlot()
