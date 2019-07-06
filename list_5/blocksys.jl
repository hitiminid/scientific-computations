# Author: Piotr Kawa
# Exercise 1

module blocksys
  include("matrixgen.jl")
  export loadA, loadB, gauss, backwardSolve, printMatrix, returnData, computeAnError, runTest, runTestWithVectorComputing

  machepsFloat64 = eps(Float64)

  # Function used for loading matrix A
  # path - file path of source file
  function loadA(path::String)
    elements = Float64[]
    file = open(path)
    lines = readlines(file)
    close(file)

    sizeAString, sizeBString = split(lines[1])
    mainArraySize            = parse(Int64, sizeAString)
    secondaryArraysSize      = parse(Int64, sizeBString)
    M = spzeros(mainArraySize, mainArraySize)

    for line in lines[2:end]
      lineElementsString = split(line)
      i       = parse(Int64,   lineElementsString[1])
      j       = parse(Int64,   lineElementsString[2])
      value   = parse(Float64, lineElementsString[3])
      M[i, j] = value
    end
    return M, mainArraySize, secondaryArraysSize
  end


  # Function used for loading vector b
  # path - file path of source file
  function loadB(path::String)
    file = open(path)
    lines = readlines(file)
    close(file)

    numberOfElements = parse(Int64, lines[1])
    vector = spzeros(numberOfElements)

    for i = 2:numberOfElements+1
      element :: Float64 = parse(Float64, lines[i])
      vector[i-1] = element
    end
    return vector, numberOfElements
  end

  # Function writes given vector to a file
  # vector - vector to display
  function returnData(vector :: SparseVector, fileName :: String)
    writedlm(fileName, vector)
  end

  # Function writes given vector and an error to a file
  # vector   - vector to display
  # fileName - the name of a file
  function returnDataWithAnError(vector :: SparseVector, fileName :: String)
    n = size(vector)[1]
    error = computeAnError(vector)

    open(fileName, "w") do f
        write(f,"$error\n")
        for i = 1:n
          write(f, "$(vector[i])\n")
        end
    end
  end

  # Main function of a program - performs Gauss elimination
  # A           - input matrix
  # b           - input vector
  # n           - size of input matrix
  # choosePivot - use pivot
  function gauss(A :: SparseMatrixCSC, b :: SparseVector, n :: Int64, l :: Int64, choosePivot :: Bool)
    index = 0
    for k = 1 : n-1
      if (choosePivot)
        runPivot(A, b, k, l, n)
      end

      if (abs(A[k,k]) < machepsFloat64)
        println("A[", k, ",", k, "] value = ", A[k,k])
        println("In order to compute matrices with zeros please use an option with a pivot!")
        return A, b, false
      end
      columnZeroing(A, b, k, n, l)
    end
    return A, b, true
  end

  # Perform column zeroing
  # A           - input matrix
  # b           - input vector
  # k           - current index
  # n           - size of input matrix
  # l           - size of small matrices
  function columnZeroing(A :: SparseMatrixCSC, b :: SparseVector, k :: Int64, n :: Int64, l :: Int64)
    lowerBound = computeRangeForStandardGauss(k, n, l)
    for j = k + 1 : lowerBound
      a = A[j,k] / A[k,k]
      A[j,k] = 0.0
      for i = k + 1 : lowerBound
          A[j,i] = A[j,i] - (a * A[k,i])
      end
      b[j] = b[j] - (a * b[k])
    end
  end

  # Compute range used in backward solving
  # row              - current row
  # sizeOfBigArray   - size of input matrix
  # sizeOfSmallArray - size of smaller matrices
  # @returns         - computed bound
  function computeRangeForStandardGauss(row :: Int64, sizeOfBigArray :: Int64, sizeOfSmallArray :: Int64)
    maxIndex = row + 1 + 2 * sizeOfSmallArray

    if (maxIndex > sizeOfBigArray)
      return sizeOfBigArray
    else
      return maxIndex
    end
  end

  # Perform pivot partition
  # A           - input matrix
  # b           - input vector
  # k           - current index
  # l           - size of small matrices
  # n           - size of input matrix
  function runPivot(A :: SparseMatrixCSC, b :: SparseVector, k :: Int64, l :: Int64, n :: Int64)
    p = findIndexOfMaxValue(A, k, l, n)
    leftBound, rightBound =  determinePivotChoosingBounds(n, k, l)

    for j = leftBound : rightBound
      A[k,j], A[p,j]=A[p,j], A[k, j]
    end
    b[k], b[p] = b[p], b[k]
  end

  # Compute range used in backward solving
  # row              - current row
  # sizeOfBigArray   - size of input matrix
  # sizeOfSmallArray - size of smaller matrices
  # @returns         - computed bound
  function determinePivotChoosingBounds(sizeOfBigArray :: Int64, currentIndex :: Int64, sizeOfSmallArray :: Int64)
    nonZeroValuesWidth = 3 * sizeOfSmallArray

    if (currentIndex - nonZeroValuesWidth < 1)
      leftBound = 1
    else
      leftBound = currentIndex - nonZeroValuesWidth
    end

    if (currentIndex + nonZeroValuesWidth > sizeOfBigArray)
      rightBound = sizeOfBigArray
    else
      rightBound = currentIndex + nonZeroValuesWidth
    end

    return leftBound, rightBound
  end

  # Function used for finding maximum number within a given column
  # A          - input matrix
  # l          - size of smaller matrices
  # n          - size of input matrix
  # @returns x - row of max number
  function findIndexOfMaxValue(A :: SparseMatrixCSC, k :: Int64, l :: Int64, n :: Int64)
    index       = 0
    maxValue    = 0.0
    bottomBound = computeBoundForMaxElementSearch(k, l, n)

    for j = k : bottomBound
      if (abs(A[j,k]) > maxValue)
        maxValue = abs(A[j, k])
        index = j
      end
    end
    return index
  end

  # Function used for computing bounds used for finding maximum element in a column
  # currentIndex     - current column
  # sizeOfSmallArray - size of smaller matrices
  # mainArraySize    - size of input matrix
  # @returns x       - range within which search for maximum number will be performed
  function computeBoundForMaxElementSearch(currentIndex :: Int64, sizeOfSmallArray :: Int64, mainArraySize :: Int64)
    searchRange = currentIndex + 2 * sizeOfSmallArray

    if (searchRange > mainArraySize)
      return mainArraySize
    else
      return searchRange
    end
  end

  # Function used for backward solving
  # A          - input matrix
  # b          - input vector
  # n          - size of input matrix
  # l          - size of smaller matrices
  # @returns x - computed vector
  function backwardSolve(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    x = spzeros(n)
    for i in n : -1 : 1
      s = b[i]
      range = computeBackwardSolveRange(i, n, l)
      for j in i+1 : range
         s = s - A[i, j] * x[j]
      end
      x[i] = s / A[i, i]
    end
    return x
  end

  # Compute range used in backward solving
  # row              - current row
  # sizeOfBigArray   - size of input matrix
  # sizeOfSmallArray - size of smaller matrices
  # @returns         - computed bound
  function computeBackwardSolveRange(row :: Int64, sizeOfBigArray :: Int64, sizeOfSmallArray :: Int64)
    newRange = 3 * sizeOfSmallArray

    if (row + newRange > sizeOfBigArray)
      rightBound = sizeOfBigArray
    else
      rightBound = row + newRange
    end
    return rightBound
  end

  # Display given matrix
  # matrix - matrix to print
  function printMatrix(matrix :: SparseMatrixCSC)
    for i = 1 : size(matrix, 1)
      for j = 1 : size(matrix, 2)
        @printf "%0.2f " matrix[i,j]
      end
      println()
    end
  end

  # Compute an error using norms
  # vector - check an error within a vector's data
  function computeAnError(vector :: SparseVector)
    vectorOfOnes = ones(size(vector))
    return norm(vector - vectorOfOnes) / norm(vectorOfOnes)
  end

  # Function used for testing
  # arrayPath  - array
  # vectorPath - vector
  # pivot      - should pivot be used
  # filename   - where the result should be saved
  function runTest(arrayPath :: String, vectorPath :: String, pivot :: Bool, fileName :: String)
      M, n ,l             = loadA(arrayPath)
      b, numberOfElements = loadB(vectorPath)

      A, B, isCorrect = gauss(M,b, n, l, pivot)
      x = backwardSolve(A, B, n, l)
      returnData(x, fileName)
      if (isCorrect)
          println(computeAnError(x))
      end
  end

  # Function used for testing
  # arrayPath  - array
  # vectorPath - vector
  # pivot      - should pivot be used
  # filename   - where the result should be saved
  function runTestWithVectorComputing(arrayPath :: String, pivot :: Bool, fileName :: String)
      M, n ,l = loadA(arrayPath)
      b       = computeVector(M, n, l)

      A, B, isCorrect = gauss(M,b, n, l, pivot)
      x = backwardSolve(A, B, n, l)
      returnDataWithAnError(x, fileName)
      if (isCorrect)
          println(computeAnError(x))
      end
  end

  # Computing vector
  # A - matrix
  # n - matrix size
  # l - small matrix size
  function computeVector(A::SparseMatrixCSC, n::Int64, l::Int64)

      leftBound  = 1
      rightBound = 2 * l
      temp       = 0.0
      vector     = spzeros(n)
      move       = false

      for i = 1 : n

          for k = leftBound : rightBound
              temp = temp + A[i,k]
          end

          if ((i%l) == 0 && move)
              leftBound = leftBound + l;
          elseif (i == l && !move)
              leftBound = l - 1;
              move      = true
          end

          if (rightBound + l > n)
            rightBound = n
          else
            rightBound = rightBound + l
          end

          vector[i] = temp
          temp = 0.0
      end
      return vector
  end
end
