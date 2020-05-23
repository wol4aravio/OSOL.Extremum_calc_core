module DynamicSystems

using DifferentialEquations

function ode_satellite_orientation(x, p, t)
    x₁, x₂ = x
    u = p[1]
    return [
        x₂,
        u(t),
        u(t) ^ 2
    ]
end

DS = Dict()
function create_ds(problem_name)
    if problem_name == "satellite_orientation"
        global DS
        if problem_name ∉ keys(DS)
            DS[problem_name] = ODEProblem(ode_satellite_orientation, nothing, (0.0, 1.0), p=nothing)
        end
    end
end

end
