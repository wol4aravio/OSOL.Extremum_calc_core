module Benchmarks

struct Benchmark
    f
    search_area
    solution
    Benchmark(;f, search_area, solution) = new(f, search_area, solution)
end

###########################################################################
#                                 2 DIM                                   #
###########################################################################

ackley_2 = Benchmark(
    f = function(v)
        x = v[1]
        y = v[2]
        return -200exp(-0.2sqrt(x^2 + y^2))
    end,
    search_area = [[-32 32]; [-32 32]],
    solution = [0; 0]
)

end
