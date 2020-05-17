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
    for p in problems
        name = p.name
        function problem_call(c::RESTController)
            @info :payload (c.params.x)
            return render(JSON, p.f(c.params.x))
        end
        post("/call_f/$name", RESTController, problem_call)
    end
    for p in problems
        name = p.name
        function problem_call(c::RESTController)
            @info :payload (c.params.x)
            return render(JSON, p.f'(c.params.x))
        end
        post("/call_f_grad/$name", RESTController, problem_call)
    end
    plug(Plug.Parsers, [:json])
end

Bukdu.start(8085, host = "0.0.0.0")
wait()
