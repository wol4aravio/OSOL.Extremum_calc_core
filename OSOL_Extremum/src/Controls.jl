module Controls

struct PiecewiseConstantControl
    grid::Array{Float64,1}
    grid_values::Array{Float64,1}
    default_value::Float64
    PiecewiseConstantControl(;grid, grid_values, default_value = 0.0) =
        length(grid_values) >= length(grid) ? error("Wrong config") : new(grid, grid_values, default_value)
end

@noinline function (pcc::PiecewiseConstantControl)(x)
    for (i, x0) in enumerate(pcc.grid[1:length(pcc.grid)-1])
        x1 = pcc.grid[i + 1]
        if x0 <= x < x1
            return pcc.grid_values[i]
        end
    end
    return pcc.default_value
end


struct PiecewiseLinearControl
    grid::Array{Float64,1}
    grid_values::Array{Float64,1}
    default_value::Float64
    PiecewiseLinearControl(;grid, grid_values, default_value = 0.0) =
        length(grid_values) != length(grid) ? error("Wrong config") : new(grid, grid_values, default_value)
end

@noinline function (plc::PiecewiseLinearControl)(x)
    for (i, x0) in enumerate(plc.grid[1:length(plc.grid)-1])
        x1 = plc.grid[i + 1]
        if x0 <= x < x1
            y0 = plc.grid_values[i]
            y1 = plc.grid_values[i + 1]
            return (y1 * (x - x0) + y0 * (x1 - x)) / (x1 - x0)
        end
    end
    return plc.default_value
end

function create_control(json)
    if json["type"] == "piecewise_constant"
        grid = convert(Array{Float64}, json["grid"])
        grid_values = convert(Array{Float64}, json["grid_values"])
        return PiecewiseConstantControl(grid=grid, grid_values=grid_values)
    elseif json["type"] == "piecewise_linear"
        grid = convert(Array{Float64}, json["grid"])
        grid_values = convert(Array{Float64}, json["grid_values"])
        return PiecewiseLinearControl(grid=grid, grid_values=grid_values)
    end
end

end
