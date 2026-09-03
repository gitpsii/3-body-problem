function gravitational_acceleration(G, m1, m2, m3, d1, d2, d3)
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