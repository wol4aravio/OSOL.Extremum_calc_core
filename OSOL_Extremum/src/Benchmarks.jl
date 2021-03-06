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

function _beale_func(v)
    x = v[1]
    y = v[2]
    return (1.5 - x - x*y)^2 + (2.25 - x + x*y^2)^2 + (2.625 - x + x*y^3)^2
end

beale = Benchmark(
    f = _beale_func,
    search_area = [[-4.5 4.5]; [-4.5 4.5]],
    solution = [3; 0.5],
    name = "Beale",
)

################################################################################

function _booth_func(v)
    x = v[1]
    y = v[2]
    return (x + 2y - 7)^2 + (2x + y - 5)^2
end

booth = Benchmark(
    f = _beale_func,
    search_area = [[-10 10]; [-10 10]],
    solution = [1; 3],
    name = "Booth",
)

################################################################################

function _brent_func(v)
    x = v[1]
    y = v[2]
    return (x + 10)^2 + (y + 10)^2 + exp(-x^2 - y^2)
end

brent = Benchmark(
    f = _brent_func,
    search_area = [[-20 0]; [-20 0]],
    solution = [-10; -10],
    name = "Brent",
)

################################################################################

function _easom_func(v)
    x = v[1]
    y = v[2]
    return -cos(x)*cos(y)*exp(-(x - π)^2 - (y - π)^2)
end

easom = Benchmark(
    f = _easom_func,
    search_area = [[-100 100]; [-100 100]],
    solution = [π; π],
    name = "Easom",
)

################################################################################

function _keane_func(v)
    x = v[1]
    y = v[2]
    nume = (sin(x - y))^2 * (sin(x + y))^2
    denom = sqrt(x^2 + y^2)
    return -nume/denom
end

keane = Benchmark(
    f = _keane_func,
    search_area = [[-100 100]; [-100 100]],
    solution = [π; π],
    name = "Keane",
)

################################################################################

function _matyas_func(v)
    x = v[1]
    y = v[2]
    return 0.26 * (x^2 + y^2) - 0.48*x*y
end

matyas = Benchmark(
    f = _matyas_func,
    search_area = [[-10 10]; [-10 10]],
    solution = [0; 0],
    name = "Matyas",
)

################################################################################

end
