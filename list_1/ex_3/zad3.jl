# Author: Piotr Kawa
# Exercise 3

function zad3a()
  # lower bounds of third range [1.0; 2.0]
  x :: Float64 = 1.0
  # macheps
  delta ::Float64 = 2.0 ^ -52.0

  println("[1.0, 2.0]")
  println(bits(x))
  println(bits(x + delta))
  println(bits(x + 2 * delta))

end

function zad3b()
  # lower bounds of second range [0.5; 1.0]
  x :: Float64 = 0.5
  # macheps
  delta ::Float64 = 2.0 ^ -52.0

  println("[0.5, 1.0]")
  println(bits(x))
  println(bits(x + delta))
  println(bits(x + 2 * delta))

end

function zad3c()
  # lower bounds of third range [2.0; 4.0]
  x :: Float64 = 2.0
  # macheps
  delta ::Float64 = 2.0 ^ -52.0

  println("[2.0, 4.0]")
  println(bits(x))
  println(bits(x + delta))
  println(bits(x + 2 * delta))

end


zad3a()
zad3b()
zad3c()
