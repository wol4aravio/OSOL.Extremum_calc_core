module DynamicSystems

using DifferentialEquations

function ode_satellite_orientation(x, params, t)
    x₁, x₂ = x
    u = params[1]
    return [
        x₂,
        u(t, x),
        u(t, x) ^ 2
    ]
end

function ode_satellite_stabilization(x, params, t)
    p, q, r = x
    u₁, u₂, u₃ = [c(t, x) for c in params]
    return [
        u₁ / 6,
        u₂ - 0.2 * p * r,
        0.2 * (u₃ + p * q),
        sum((u₁, u₂, u₃) .|> abs)
    ]
end

DS = Dict()
function create_ds(problem_name)
    global DS
    if problem_name ∉ keys(DS)
        if problem_name == "satellite_orientation"
            DS[problem_name] = ODEProblem(ode_satellite_orientation, nothing, (0.0, 1.0), p=nothing)
        elseif problem_name == "satellite_stabilization"
            DS[problem_name] = ODEProblem(ode_satellite_stabilization, nothing, (0.0, 1.0), p=nothing)
        end
    end
end

end
