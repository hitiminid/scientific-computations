# Author: Piotr Kawa
# Exercise 4

function exercise4()
  # lower bounds of checked range
  lowerbounds :: Float64 = 1.0
  # upper bounds
  upperbounds :: Float64 = 2.0
  # number used for checking whether x * (1/x) != 1
  x           :: Float64 = 1.0

  while x <= 2.0
    x = x + eps(Float64)
    leftSide :: Float64 = (x * (1.0/x))
    if leftSide != 1.0
      println("x = ", x )
    end
  end
end

exercise4()
