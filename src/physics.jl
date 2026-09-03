using Plots
using LinearAlgebra

function gravitational_acceleration(G, m1, m2, m3, r1, r2, r3)
     d1 = r2 - r1
     d2 = r3 - r1
     d3 = r3 - r2
    distance1 = norm(d1)
    distance2 = norm(d2)
    distance3 = norm(d3)
    direction1 = d1 / distance1
    direction2 = d2 / distance2
    direction3 = d3 / distance3
    a12 = G * m2 / distance1^2 * direction1
    a21 = G * m1 / distance1^2 * -direction1
    a13 = G * m3 / distance2^2 * direction2
    a31 = G * m1 / distance2^2 * -direction2
    a23 = G * m3 / distance3^2 * direction3
    a32 = G * m2 / distance3^2 * -direction3
    return a12, a21, a13, a31, a23, a32
end


function total(a12, a13, a21, a23, a31, a32)
    a1 = a12 + a13
    a2 = a21 + a23
    a3 = a31 + a32
    return a1, a2, a3
end

function velocity(v1, v2, v3, a1, a2, a3, dt)
    v1_n = v1 + a1*dt
    v2_n = v2 + a2*dt
    v3_n = v3 + a3*dt
    return v1_n, v2_n, v3_n
end

function position(r1, r2, r3, v1_n, v2_n, v3_n, dt)
    r1_n = r1 + v1_n*dt
    r2_n = r2 + v2_n*dt
    r3_n = r3 + v3_n*dt
    return r1_n, r2_n, r3_n
end

function step(G, m1, m2, m3, v1, v2, v3, r1, r2, r3, dt)
    a12, a21, a13, a31, a23, a32 = gravitational_acceleration(G, m1, m2, m3, r1, r2, r3)
    a1, a2, a3 = total(a12, a13, a21, a23, a31, a32)
    v1, v2, v3 = velocity(v1, v2, v3, a1, a2, a3, dt)
    r1, r2, r3 = position(r1, r2, r3, v1, v2, v3, dt)
    return v1, v2, v3, r1, r2, r3
end

function test_simulation(G, m1, m2, m3, v1, v2, v3, r1, r2, r3, dt, t)
    r1_history = Vector{Vector{Float64}}()
    r2_history = Vector{Vector{Float64}}()
    r3_history = Vector{Vector{Float64}}()

    push!(r1_history, r1)
    push!(r2_history, r2)
    push!(r3_history, r3)

    for i in 1:t
        v1, v2, v3, r1, r2, r3 = step(G, m1, m2, m3, v1, v2, v3, r1, r2, r3, dt)

        push!(r1_history, r1)
        push!(r2_history, r2)
        push!(r3_history, r3)
    end

    return r1_history, r2_history, r3_history
end

function trajectory(r1_history, r2_history, r3_history)
    x1 = [r[1] for r in r1_history]
    y1 = [r[2] for r in r1_history]

    x2 = [r[1] for r in r2_history]
    y2 = [r[2] for r in r2_history]

    x3 = [r[1] for r in r3_history]
    y3 = [r[2] for r in r3_history]

    plot(x1, y1, label="Body 1")
    plot!(x2, y2, label="Body 2")
    plot!(x3, y3, label="Body 3")
end

function animate_trajectory(r1_history, r2_history, r3_history)

    anim = @animate for i in 1:5:length(r1_history)

        x1 = [r[1] for r in r1_history[1:i]]
        y1 = [r[2] for r in r1_history[1:i]]

        x2 = [r[1] for r in r2_history[1:i]]
        y2 = [r[2] for r in r2_history[1:i]]

        x3 = [r[1] for r in r3_history[1:i]]
        y3 = [r[2] for r in r3_history[1:i]]

# Black Canvas

        plot(
            x1,
            y1,
            color=:royalblue,
            linewidth=2,
            label=false,
            background_color=:black,
            foreground_color=:white,
            grid=false,
            axis=false,
            aspect_ratio=:equal,
            xlims=(-2, 2),
            ylims=(-2, 2),
            size=(1000, 800)
        )


        plot!(
            x2,
            y2,
            color=:orange,
            linewidth=2,
            label=false
        )

        plot!(
            x3,
            y3,
            color=:white,
            linewidth=2,
            label=false
        )


        scatter!(
            [x1[end]],
            [y1[end]],
            color=:royalblue,
            markersize=9,
            markerstrokewidth=0,
            label=false
        )

        scatter!(
            [x2[end]],
            [y2[end]],
            color=:orange,
            markersize=9,
            markerstrokewidth=0,
            label=false
        )

        scatter!(
            [x3[end]],
            [y3[end]],
            color=:white,
            markersize=9,
            markerstrokewidth=0,
            label=false
        )

    end
    gif(anim, "three_body.gif", fps=30)

end