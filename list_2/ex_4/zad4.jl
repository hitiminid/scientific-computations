# Author: Piotr Kawa
# Exercise 4

Pkg.add("Polynomials")
using Polynomials


function run4()
  # first polynomial
  firstDataSet  = reverse([1, -210.0, 20615.0,-1256850.0, 53327946.0,-1672280820.0, 40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0, 1307535010540395.0, -10142299865511450.0, 63030812099294896.0, -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0, 8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0, -8752948036761600000.0, 2432902008176640000.0])
  # second polynomial
  secondDataSet = reverse([1, -210.0-(1/2^(23)), 20615.0,-1256850.0, 53327946.0,-1672280820.0, 40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0, 1307535010540395.0, -10142299865511450.0, 63030812099294896.0, -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0, 8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0, -8752948036761600000.0, 2432902008176640000.0])
  # collect returns array of Integers in a given range
  z = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0]

  # creating polynomials using first set of data
  firstPolynomial=Poly(firstDataSet)
  p=poly(z)

  # function used for computing roots
  zk = computeRoots(firstPolynomial)
  computeDifferenceBetweenRealAndComputedRoots(zk)

  println("\nFirst Data Set\n")
  for i in 1:20
        println("\nzk[$i] = $(zk[i])")
        print("|P(x)| = $(abs(polyval(firstPolynomial, zk[i]))) ")
        print("|p(x)| = $(abs(polyval(p, zk[i]))) ")
  end

  # polynomial with second data set
  secondPolynomial=Poly(secondDataSet)
  println("\n\nRoots of second polynomial:")
  zk = roots(secondPolynomial)

  for i = 1:20
    println("zk[$i] = $(zk[i])")
  end

  println("\nSecond Data Set\n")
  for i in 1:20
    println("\nzk[$i] = $(zk[i])")
    print("|P(x)| = $(abs(polyval(secondPolynomial, zk[i]))) ")
  end

end

# Polynomial - polynomial that is used to compute it's roots
function computeRoots(Polynomial)
  computedRoots = roots(Polynomial)
  println("Roots of first polynomial:")
  println(computedRoots)
  println("\n")
  return computedRoots
end

# rootsArray - array containing roots
function computeDifferenceBetweenRealAndComputedRoots(rootsArray)
  j :: Int64 = 20
  println("Difference between real and computed roots:\n")
  for i in rootsArray
    if j > 9
      @printf "k = %d zk = %.20f, |zk - k| = %.20f\n" j i abs(j-i)
    else
      @printf "k = %d  zk = %.20f,  |zk - k| = %.20f\n" j i abs(j-i)
    end
    j = j - 1
  end
end

# array - array that will be displayed
function showArray(array)
  for i in 1:size(array,1)
    @printf "%.20f, " array[i]
  end
end


run4()
