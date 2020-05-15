include("./Benchmarks.jl")

using .Benchmarks
using Bukdu

problems = [
    Benchmarks.ackley_2,
    Benchmarks.ackley_3,
    Benchmarks.adjiman,
]

struct RESTController <: ApplicationController
    conn::Conn
end

function health(c::RESTController)
    return render(JSON, "OK")
end

function list_of_problems(c::RESTController)
    return render(JSON, [p.name for p in problems])
end

routes() do
    get("/health", RESTController, health)
    get("/problems", RESTController, list_of_problems)
end

Bukdu.start(8085)
