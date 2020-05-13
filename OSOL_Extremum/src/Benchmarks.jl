module Benchmarks

struct Benchmark
    f::Any
    search_area::Any
    Benchmark(;f, search_area) = new(f, search_area)
end

dummy = Benchmark(
    f = x->x * x,
    search_area = [[-10 10]]
)

end
