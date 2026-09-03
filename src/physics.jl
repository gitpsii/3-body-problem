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

function test_simulation(G, m1, m2, m3, v1, v2, v3, r1, r2, r3, dt)
    for i in 1:10
        v1, v2, v3, r1, r2, r3 = step(G, m1, m2, m3, v1, v2, v3, r1, r2, r3, dt)
        println(i, " ", r1)
    end
end