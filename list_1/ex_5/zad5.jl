# Author: Piotr Kawa
# Exercise 5


function computeDotProduct()
  # first vector (Float32)
  x32 = Float32[2.718281828, -3.141592654, 1.414213562, 0.5772156649 , 0.3010299957]
  # second vector (Float32)
  y32 = Float32[1486.2497  , 878366.9879 , -22.37492  , 4773714.647  , 0.000185049]
  # dot product (Float32)
  s32 :: Float32 = 0.0

  # first vector (Float64)
  x64 = Float64[2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
  # second vector (Float64)
  y64 = Float64[1486.2497  , 878366.9879 , -22.37492  , 4773714.647 , 0.000185049]
  # dot product (Float64)
  s64 :: Float64 = 0.0

  println("\n#########\n[Float32]\n#########")
  algorithm1(x32, y32, s32)
  algorithm2(x32, y32, s32)
  algorithm3_32(x32, y32, s32)
  algorithm4_32(x32, y32, s32)

  println("\n#########\n[Float64]\n#########")
  algorithm1(x64, y64, s64)
  algorithm2(x64, y64, s64)
  algorithm3_64(x64, y64, s64)
  algorithm4_64(x64, y64, s64)
end



# x - first vector
# y - second vector
# S - dot product of x and y
function algorithm1(x, y, S)
  println("\n1st algorithm:")
  for i = 1:5
    xy = x[i] * y[i]
    S += xy
  end
  @printf "S = %0.20f\n" S
end



# x - first vector
# y - second vector
# S - dot product of x and y
function algorithm2(x, y, S)
  println("\n2nd algorithm:")
  for i in 5:-1:1
    xy = x[i] * y[i]
    S += xy
  end
  @printf "S = %0.20f\n" S
end


# x - first vector
# y - second vector
# S - dot product of x and y
function algorithm3_32(x, y, S)

  println("\n3rd algorithm [32]:\n")
  # arrays containing results that are positive and negative
  positive, negative = createarrays(x, y, S, true)

  sort(positive)
  sort(negative, rev=true)

  # variable used for sum
  sum :: Float32 = 0.0
  # sum of positive elements
  positiveSum = sumArrayElements(positive, sum)
  sum = 0.0
  # sum of negative elements
  negativeSum = sumArrayElements(negative, sum)

  result = positiveSum + negativeSum
  @printf "result = %0.20f\n" result
end



# x    - first vector
# y    - second vector
# S    - sum
# is32 - bool value determining whether created arrays should be Float32 or Float64
function createarrays(x, y, S, is32)
  if is32
    positive = Float32[]
    negative = Float32[]
  else
    positive = Float64[]
    negative = Float64[]
  end

  for i in 1:5
    xy = x[i] * y[i]
    if xy >= 0
      push!(positive, xy)
    else
      push!(negative, xy)
    end
  end
  return positive, negative
end



# x - first vector
# y - second vector
# S - dot product of x and y
function algorithm3_64(x, y, S)

  println("\n3rd algorithm [64]:\n")
  positive, negative = createarrays(x, y, S, false)

  sort(positive)
  sort(negative, rev=true)

  # variable used for sum
  sum :: Float64 = 0.0
  # sum of positive elements
  positiveSum = sumArrayElements(positive, sum)
  sum = 0.0
  # sum of negative elements
  negativeSum = sumArrayElements(negative, sum)

  result = positiveSum + negativeSum
  @printf "result = %0.20f\n" result
end


# x - first vector
# y - second vector
# S - dot product of x and y
function algorithm4_32(x, y, S)

  println("\n4rd algorithm [32]:\n")
  positive, negative = createarrays(x, y, S, true)

  sort(positive, rev=true)
  sort(negative)

  sum :: Float32 = 0.0
  positiveSum = sumArrayElements(positive, sum)
  sum = 0.0
  negativeSum = sumArrayElements(negative, sum)

  result = positiveSum + negativeSum
  @printf "result = %0.20f\n" result
end



# x - first vector
# y - second vector
# S - dot product of x and y
function algorithm4_64(x, y, S)
  println("\n4rd algorithm [64]:\n")
  positive, negative = createarrays(x, y, S, false)

  sort(positive, rev=true)
  sort(negative)

  sum :: Float64 = 0.0
  positiveSum = sumArrayElements(positive, sum)
  sum = 0.0
  negativeSum = sumArrayElements(negative, sum)

  result = positiveSum + negativeSum
  @printf "result = %0.20f\n" result
end

# array - array on which the operation will be performed
# sum   - sum of all values within array, will be returned
function sumArrayElements(array, sum)
  for i in 1:size(array,1)
    sum += array[i]
  end
  return sum
end

computeDotProduct()
