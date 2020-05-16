module Benchmarks

using Zygote

struct Benchmark
    f
    search_area::Array{Float64,2}
    solution::Array{Float64,1}
    name::String
    Benchmark(; f, search_area, solution, name) = new(f, search_area, solution, name)

end

# http://benchmarkfcns.xyz/
# http://infinity77.net/

################################################################################
#                                 2 DIM                                        #
################################################################################

function _ackley_2_func(v)
    x = v[1]
    y = v[2]
    return -200 * exp(-0.2 * sqrt(x^2 + y^2))
end

ackley_2 = Benchmark(
    f = _ackley_2_func,
    search_area = [[-32 32]; [-32 32]],
    solution = [0; 0],
    name = "AckleyNum2",
)

################################################################################

function _ackley_3_func(v)
    x = v[1]
    y = v[2]
    return -200 * exp(-0.2 * sqrt(x^2 + y^2)) + 5 * exp(cos(3x) + sin(3y))
end

ackley_3 = Benchmark(
    f = _ackley_3_func,
    search_area = [[-32 32]; [-32 32]],
    solution = [0.682584587365898; -0.36075325513719],
    name = "AckleyNum3",
)

################################################################################

function _adjiman_func(v)
    x = v[1]
    y = v[2]
    return cos(x)sin(y) - x/(y^2 + 1)
end

adjiman = Benchmark(
    f = _adjiman_func,
    search_area = [[-1 2]; [-1 1]],
    solution = [2; 0.10578],
    name = "Adjiman",
)

################################################################################

end
