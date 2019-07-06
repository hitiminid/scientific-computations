# Author: Piotr Kawa
# Exercise 1


###########################################################################################
# Compute macheps of Float16, Float32 and Float64. Compare with results of eps() function #
###########################################################################################

function getEpsilons()

  println("[macheps]\n\n")
  println("Float16")
  float16 :: Float16 = 1.0
  computeEpsilon(float16)
  @printf "eps()   = %0.40f\n" eps(Float16)

  println("Float32")
  float32 :: Float32 = 1.0
  computeEpsilon(float32)
  @printf "eps()   = %0.40f\n" eps(Float32)

  println("Float64")
  float64 :: Float64 = 1.0
  computeEpsilon(float64)
  @printf "eps()   = %0.40f\n" eps(Float64)
end


# nextMacheps - number that is used for computing macheps
function computeEpsilon(nextMacheps)
  # result of function
  macheps = nextMacheps
  while (nextMacheps + 1 > 1.0)
    macheps = nextMacheps
    nextMacheps = nextMacheps / 2
  end
  @printf "macheps = %0.40f\n" macheps
end

getEpsilons()


###########################################################################################
# Iteratively compute eta where eta > 0.0                                                 #
###########################################################################################

function getETAs()

  println("\n\n[eta]\n\n")
  println("Float16")
  float16 :: Float16 = 1.0
  float16 = computeETA(float16)
  @printf "getETAs()   = %0.24f\n" float16
  @printf "nextfloat() = %0.24f\n" nextfloat(Float16(0.0))

  println("Float32")
  float32 :: Float32 = 1.0
  float32 = computeETA(float32)
  @printf "getETAs()   = %0.150f\n" float32
  @printf "nextfloat() = %0.150f\n" nextfloat(Float32(0.0))

  println("Float64")
  float64 :: Float64 = 1.0
  float64 = computeETA(float64)
  @printf "getETAs()   = %0.325f\n" float64
  @printf "nextfloat() = %0.325f\n" nextfloat(Float64(0.0))
end


# current - number that will be divided by two in order to compute eta
function computeETA(current)
  # used for determining the validity of next result
  next = current
  while next > 0.0
    current = next
    next = next / 2
  end
  return current
end

getETAs()


###########################################################################################
# Iteratively compute maximum number for each floating point number format                #
###########################################################################################

function getMax()
  println("\n\n[MAX]\n\n")
  println("[Float16]\n")
  computeMax16()

  println("\n[Float32]\n")
  computeMax32()

  println("\n[Float64]\n")
  computeMax64()

end

function computeMax16()
  # currently maximum number
  current = Float16(1.0)
  # variable that will be added to current result
  next    = eps(Float16)
  # variable used for determining when the step should be increased
  n = 1
  while !isinf(Float16(current + next))
    current = Float16(current + next)
    n = n + 1
    if n > 2^10
      n = 1
      next = next * 2.0
    end
  end
  @printf "computeMax16 = %0.5f\n" current
  @printf "realmax()    = %0.5f\n" realmax(Float16)
end

function computeMax32()
  # currently maximum number
  current  = Float32(1.0)
  # variable that will be added to current result
  next = eps(Float32)
  # variable used for determining when the step should be increased
  n = 1
  while !isinf(Float32(current + next))
    current = Float32(current + next)
    n = n + 1
    if n > 2^23
      n = 1
      next = next * 2.0
    end
  end
  @printf "computeMax32 = %0.5f\n" current
  @printf "realmax()    = %0.5f\n" realmax(Float32)
end

function computeMax64()
  # currently max value
  current = Float64(1.0)
  while !isinf(Float64(current * 2.0))
    current = Float64(current * 2.0)
  end
  # variable added to current result, used for determining whether the number is still in range
  x = current
  while x > 1.0
    if !isinf(current + x)
      current = current + x
    end
    x = x / 2.0
  end

  @printf "computeMax64 = %0.5f\n" current
  @printf "realmax()    = %0.5f\n" realmax(Float64)
end

getMax()
