include("./Benchmarks.jl")
include("./Controls.jl")
include("./DynamicSystems.jl")

using Bukdu
using DifferentialEquations
using .Benchmarks
using .Controls

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

function solve_ode(c::RESTController)
    problem_name = c.params.problem_name
    controls = c.params.controls
    return_controls = c.params.return_controls
    initial_state = convert(Array{Float64}, c.params.initial_state)
    integration_settings = c.params.integration_settings

    DynamicSystems.create_ds(problem_name)
    controls = [Controls.create_control(c) for c in controls]
    DynamicSystems.DS[problem_name] = remake(DynamicSystems.DS[problem_name], p=controls, u0=initial_state)
    solution = solve(DynamicSystems.DS[problem_name], saveat=integration_settings["saveat"])

    response = Dict("t" => solution.t, "x" => solution.u)
    if return_controls
        response["u"] = [c.(solution.t, solution.u) for c in controls]
        response["u"] = [collect(t) for t in zip(response["u"]...)]
    end

    render(JSON, response)
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
        post("/problems/$name/f", RESTController, problem_call)
    end
    for p in problems
        name = p.name
        function problem_call(c::RESTController)
            @info :payload (c.params.x)
            return render(JSON, p.f'(c.params.x))
        end
        post("/problems/$name/f_grad", RESTController, problem_call)
    end
    post("/ds", RESTController, (c) -> solve_ode(c))
    plug(Plug.Parsers, [:json])
end

Bukdu.start(8085, host = "0.0.0.0")
wait()
