# Author: Piotr Kawa
# Exercise 6

# x                     - variable that will be doubled
# c                     - constant added to result
# n                     - number of current iteration
# maximumNoOfIterations - maximum number of iterations
function computeRecursiveEquation(x :: Float64, c :: Float64, n :: Integer, maximumNoOfIterations :: Integer)

  result = x^2 + c
  @printf "Iteration %d: %0.20f\n" n result

  if n == maximumNoOfIterations
    return result
  else
    return computeRecursiveEquation(result, c, n + 1, maximumNoOfIterations)
  end
end

# main function of exercise
function main_6()

  c :: Float64 = 0.0
  x :: Float64 = 0.0
  n :: Integer = 1
  maximumNoOfIterations :: Integer = 40

  # 1)
  x = 1.0
  c = -2.0
  println("\n\nData Set #1")
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

  # 2)
  println("\n\nData Set #2")
  x = 2.0
  c = -2.0
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

  # 3)
  println("\n\nData Set #3")
  x = 1.999999999999999
  c = -2.0
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

  # 4)
  println("\n\nData Set #4")
  x = 1.0
  c = -1.0
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

  # 5)
  println("\n\nData Set #5")
  x = -1.0
  c = -1.0
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

  # 6)
  println("\n\nData Set #6")
  x = 0.75
  c = -1.0
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

  # 7)
  println("\n\nData Set #7")
  x = 0.25
  c = -1.0
  computeRecursiveEquation(x, c, n, maximumNoOfIterations)

end



main_6()
