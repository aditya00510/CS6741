#This question is coded in VS Code. It doesn't require pluto
using Distributions
using Random
using Plots
pyplot()

ans3=[]
for i in 1:50
    push!(ans3,0)
end
for i in 1:100
    push!(ans3,0)
end
for i in 1:200
    push!(ans3,1)
end
for i in 1:250
    push!(ans3,2)
end
for i in 1:350
    push!(ans3,3)
end
for i in 1:100
    push!(ans3,4)
end
for i in 1:50
    push!(ans3,5)
end
for i in 1:30
    push!(ans3,6)
end
for i in 1:28
    push!(ans3,7)
end
for i in 1:26
    push!(ans3,8)
end
for i in 1:24
    push!(ans3,9)
end
for i in 1:22
    push!(ans3,10)
end
for i in 1:20
    push!(ans3,11)
end
println("mean=",mean(ans3))
println("median=",median(ans3))
println("mode=",mode(ans3))

histogram(ans3)
vline!([mean(ans3)],label="Mean",color="green",line=3)
vline!([mode(ans3)],label="Mode",color="yellow",line=3)
vline!([median(ans3)],label="Median",color="red",line=3)