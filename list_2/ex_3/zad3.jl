# Author: Piotr Kawa
# Exercise 3


function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond (10, 100.0);
#
# Pawel Zielinski
        if n < 2
         error("size n should be > 1")
        end
        if c< 1.0
         error("condition number  c of a matrix  should be >= 1.0")
        end
        (U,S,V)=svd(rand(n,n))
        return U*diagm(linspace(1.0,c,n))*V'
end

function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>0
#
#
# Usage: hilb (10)
#
# Pawel Zielinski
        if n < 1
         error("size n should be > 0")
        end
        A= Array{Float64}(n,n)
        for j=1:n, i=1:n
                A[i,j]= 1 / (i + j - 1)
        end
        return A
end


function main()
  runHilbert()
  runRandom()
end

function runHilbert()
  for i in 1:20
    computeHilbertMatrix(i)
  end
end

# n - size of a matrix
function computeHilbertMatrix(n :: Int)
  A = hilb(n)
  B = A * ones(n, 1)

  varGauss  = gauss(A, B)
  varInvert = invert(A, B)

  println("\n--------------")
  println("#$n")
  println("--------------")

  println("Gauss:")
  showArray(varGauss)

  println("\n\nInverted:")
  showArray(varInvert)

  println("\nCond of matrix: ", cond(A))
  println("\n\nGauss Error: ")
  println(computeAverageError(varGauss, n))
  println("Invert Error: ")
  println(computeAverageError(varInvert, n))

end

# array - array to show
function showArray(array)
  for i in 1:size(array,1)
    @printf "%0.20f, " array[i]
  end
end

# matrix - matrix used for computing error
# size   - size of a matrix
function computeAverageError(matrix, size)
  return norm(matrix - ones(size,1)) / norm(ones(size,1))
end

# A - matrix
# b - vector
function gauss(A, b)
  return A\b
end

# A - matrix
# b - vector
function invert(A, b)
  return inv(A)*b
end

function runRandom()
  testRandomMatrixOfGivenSize(5)
  testRandomMatrixOfGivenSize(10)
  testRandomMatrixOfGivenSize(20)
end

# n - size of a matrix
function testRandomMatrixOfGivenSize(n ::Int)
  println("\n\n#################")
  println("Matrix size = ", n)
  println("#################\n\n")

  varGauss, varInvert = computeRandomMatrix(n, 1.0)
  println("Condition number: 1\n")
  showResult(varGauss, varInvert, n)

  varGauss, varInvert = computeRandomMatrix(n, 10.0)
  println("Condition number: 10\n")
  showResult(varGauss, varInvert, n)

  varGauss, varInvert = computeRandomMatrix(n, 10.0^3)
  println("Condition number: 10^3\n")
  showResult(varGauss, varInvert, n)

  varGauss, varInvert = computeRandomMatrix(n, 10.0^7)
  println("Condition number: 10^7\n")
  showResult(varGauss, varInvert, n)

  varGauss, varInvert = computeRandomMatrix(n, 10.0^12)
  println("Condition number: 10^12\n")
  showResult(varGauss, varInvert, n)

  varGauss, varInvert = computeRandomMatrix(n, 10.0^16)
  println("Condition number: 10^16\n")
  showResult(varGauss, varInvert, n)

end

# varGauss  - matrix computed via Gauss method
# varInvert - matrix computed via invert method
# n         - size of a matrix
function showResult(varGauss, varInvert, n)
  println("Gauss:")
  showArray(varGauss)
  println("\n\nInverted:")
  showArray(varInvert)
  println("\n\nGauss Error: ")
  println(computeAverageError(varGauss, n))
  println("Invert Error: ")
  println(computeAverageError(varInvert, n))
end

# n - size of a matrix
# c - condition number
function computeRandomMatrix(n :: Int, c :: Float64)
  A = matcond(n, c)
  B = A * ones(n, 1)
  var_Gauss = A\B
  var_Inv   = inv(A)*B
  return var_Gauss, var_Inv
end

main()
