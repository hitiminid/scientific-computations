# Author: Piotr Kawa
# Exercise 5

# pn - variable used as result
# r - constant
# currentIteration - number of current iteration
# maxNumberOfIterations - maximum number of iterations
function computeRecursion(pn :: Number, r :: Number, currentIteration :: Int64, maxNumberOfIterations :: Int64)

  result = pn + r*pn*(1 - pn)
  println("Iteration #$currentIteration: $result")

  if currentIteration == maxNumberOfIterations
    return result
  else
    return computeRecursion(result, r, currentIteration + 1, maxNumberOfIterations)
  end
end


function ex5_a()
  println("Exercise 5a")

  println("\n###########\nAlgorithm A\n###########\n")
  n = computeRecursion(Float32(0.01), 3, 1, 40)

  println("\n###########\nAlgorithm B\n###########\n")
  n = computeRecursion(Float32(0.01), 3, 1, 10)
  println()
  println("old n = ", n)
  n = floor(n, 3)
  println("new n = ", n)
  computeRecursion(n, 3, 11, 40)
end


function ex5_b()
  println("\n\n###########\nExercise 5b\n###########\n")
  println("[Float32]")
  n = computeRecursion(Float32(0.01), 3, 1, 40)

  println("\n\n[Float64]")
  n = computeRecursion(Float64(0.01), 3, 1, 40)
end


function main_5()
  ex5_a()
  ex5_b()
end


main_5()
