# Author: Piotr Kawa
include("./blocksys.jl")
using blocksys

enablePivot  = true
disablePivot = false

runTest("./8A.txt", "./8b.txt", enablePivot,  "8_result_on")
runTest("./8A.txt", "./8b.txt", disablePivot, "8_result_off")

runTest("./A.txt", "./b.txt", enablePivot,  "16_result_on")
runTest("./A.txt", "./b.txt", disablePivot, "16_result_off")

runTest("./10A.txt", "./10b.txt", enablePivot,  "10k_result_on")
runTest("./10A.txt", "./10b.txt", disablePivot, "10k_result_off")

runTest("./50A.txt", "./50b.txt", enablePivot,  "50k_result_on")
runTest("./50A.txt", "./50b.txt", disablePivot, "50k_result_off")


runTestWithVectorComputing("./50A.txt", enablePivot, "vector8_on")
runTestWithVectorComputing("./50A.txt", enablePivot,  "8_result_on")
