# Author: Piotr Kawa
# Exercises 1-3

module ComputingLinearEquations
  export mbisekcji, mstycznych, msiecznych

  # f              - anonymous function
  # a,b            - ends of given range
  # delta, epsilon - computation precision
  function mbisekcji(f, a :: Float64, b :: Float64, delta :: Float64, epsilon :: Float64)
    M = 100
    k = 0
    u = f(a)
    v = f(b)

    e = b - a

    if sign(u) == sign(v)
      return 0, 0, 0, 1
    end

    k = 1
    for k in 1:M
      e = e / 2
      c = a + e
      w = f(c)
      if abs(e) < delta || abs(w) < epsilon
        return c, w, k, 0
      end

      if sign(w) != sign(u)
        b = c
        v = w
      else
        a = c
        u = w
      end
    end
    return (c, w, M, 0)
  end


  # f, pf          - anonymous function and it's derivative
  # x0             - starting approximation
  # delta, epsilon - computation precision
  # maxit          - maximum number of iterations
  function mstycznych(f, pf, x0 :: Float64, delta :: Float64, epsilon :: Float64, maxit :: Int)
    x1 = 0
    v = f(x0)

    if abs(v) < epsilon
      return (x0, v, 0, 0)
    end

    for k in 1:maxit
      if abs(pf(x0)) < epsilon
        return (x0, v, k, 2)
      end
      x1 = x0 - (v / pf(x0))
      v  = f(x1)
      if abs(x1 - x0) < delta || abs(v) < epsilon
        return (x1, v, k, 0)
      end
      x0 = x1
    end
    return (x1, v, maxit, 1)
  end


  # f              - anonymous function
  # x0,x1          - starting approximation
  # delta, epsilon - computation precision
  # maxit          - maximum number of iterations
  function msiecznych(f, x0 :: Float64, x1 :: Float64, delta :: Float64, epsilon :: Float64, maxit :: Int )

    fa = f(x0)
    fb = f(x1)

    for k in 1:maxit
      if abs(fa) > abs(fb)
        fb, fa = fa, fb
        x0, x1 = x1, x0
      end

      s = (x1 - x0) / (fb - fa)
      x1 = x0
      fb = fa
      x0 = x0 - (fa * s)
      fa = f(x0)

      if abs(x1 - x0) < delta || abs(fa) < epsilon
        return (x0, fa, k, 0)
      end
    end
    return (x0, fa, maxit, 1)
  end
end
