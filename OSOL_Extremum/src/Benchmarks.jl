module Benchmarks

struct Benchmark
    f
    search_area::Array{Float64,2}
    solution::Array{Float64,1}
    Benchmark(; f, search_area, solution) = new(f, search_area, solution)
end

###########################################################################
#                                 2 DIM                                   #
###########################################################################

function _ackley_2_func(v)
    x = v[1]
    y = v[2]
    return -200 * exp(-0.2 * sqrt(x^2 + y^2))
end

ackley_2 = Benchmark(
    f = _ackley_2_func,
    search_area = [[-32 32]; [-32 32]],
    solution = [0; 0],
)

###########################################################################

function _ackley_3_func(v)
    x = v[1]
    y = v[2]
    return -200 * exp(-0.2 * sqrt(x^2 + y^2)) + 5 * exp(cos(3x) + sin(3y))
end

ackley_3 = Benchmark(
    f = _ackley_3_func,
    search_area = [[-32 32]; [-32 32]],
    solution = [0.682584587365898; -0.36075325513719],
)

###########################################################################
