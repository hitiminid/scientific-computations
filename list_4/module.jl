# Author: Piotr Kawa
# Exercises 1-4
module Interpolation
  export ilorazyRoznicowe, iloraz, warNewton, rysujNnfx, naturalna

  using Plots
  # x - wektor wezlow
  # f - wektor wartosci interpolowanej funkcji w wezlach
  function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    fx = Array{Float64}(length(x))
    for i=1:length(x)
      fx[i] = iloraz(getindex(x, 1:i), getindex(f, 1:i))
    end
    return fx
  end

  # x - wektor wezlow
  # f - wektor wartosci interpolowanej funkcji w wezlach
  function iloraz(x::Vector{Float64}, f::Vector{Float64})
    if length(x) == 1
      return f[1]
    end
    if length(x) == 2
      return (f[2] - f[1])/(x[2] - x[1])
    end
    return (iloraz(getindex(x, 2:length(x)), getindex(f, 2:length(f))) - iloraz(getindex(x, 1:length(x)-1), getindex(f, 1:length(f)-1))) / (x[length(x)] - x[1])
  end

  # x  - wektor wezlow
  # fx - wektor ilorazow roznicowych
  # t  - punkt w ktorym obliczona bedzie wartosc wielomianu
  function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(fx)
    w = Array{Float64}(n)
    w[n] = fx[n]

    for i = n-1:-1:1
        w[i] =  fx[i] + (t - x[i]) * w[i + 1]
    end
    nt = w[1]
    return nt
  end

  # x  - wektor wezlow
  # fx - wektor ilorazow roznicowych
  function naturalna(x :: Vector{Float64}, fx :: Vector{Float64})
    n = length(x)
    a = Array{Float64}(n)
    a[n] = fx[n]

    for i = n-1:-1:1
      a[i] = fx[i]
      for j = i:n-1
        a[j] = a[j] - (a[j+1] * x[i])
      end
    end
    return a
  end

  # f   - anonimowa funkcja
  # a,b - przedzial interpolacji
  # n   - stopien wielomianu interpolacyjnego
  function rysujNnfx(f, a :: Float64, b :: Float64, n :: Int)
    x = Array{Float64}(n+1)
    fx = Array{Float64}(n+1)
    leftSideOfRange = a
    rightSideOfRange = b

    for i = 0:n
      x[i + 1] = a + i * ((b - a) / n)
      fx[i + 1] = f(x[i + 1])
    end

    quotient = ilorazyRoznicowe(x, fx)
    interpolationFunction = y -> warNewton(x, quotient, y)
    plotlyjs()
    plot(f, label="Original", leftSideOfRange, rightSideOfRange)
    plot!(interpolationFunction, label="Interpolation", leftSideOfRange, rightSideOfRange)
  end
end
