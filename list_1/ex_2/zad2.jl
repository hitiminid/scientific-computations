# Author: Piotr Kawa
# Exercise 2

function computeMachepsUsingKahanFormula()

  # macheps computed using Float16
  macheps16 :: Float16 = 0.0
  # macheps computed using Float32
  macheps32 :: Float32 = 0.0
  # macheps computed using Float64
  macheps64 :: Float64 = 0.0

  macheps16 = 3.0 * (Float16(4.0 / 3.0) - 1.0) - 1.0
  @printf "[Float16]\nKahan = %0.20f \n Julia = %0.20f\n\n" macheps16 eps(Float16)

  macheps32 = 3.0 * (Float32(4.0 / 3.0) - 1.0) - 1.0
  @printf "[Float32]\nKahan = %0.20f \nJulia = %0.20f\n\n" macheps32 eps(Float32)

  macheps64 = 3.0 * (Float64(4.0 / 3.0) - 1.0) - 1.0
  @printf "[Float64]\nKahan = %0.20f \nJulia =  %0.20f\n\n" macheps64 eps(Float64)
end


computeMachepsUsingKahanFormula()
