#This question is coded in VS Code. It doesn't require pluto
using Distributions
using Plots
pyplot()
using Statistics
using StatsBase
using QuadGK

#using Newtons method to solve for the value y
function OneSidedTail(dist,y,rtol,x)
	while true
			result = 100*quadgk(dist, -Inf, y, rtol=rtol)[1]-100+x
			temp = -result /(100*dist(y)) 
			y += temp
			abs(temp) ≤ abs(y)*rtol && break
	end
	return y
end

rng=(1:1:99)
a=OneSidedTail.(x->pdf(Normal(0,1),x),1,0.0001,rng)
display(plot(rng,a,xlabel="x",ylabel="OneSidedTail(x)",label="OneSidedTail(x) for Normal Distribution"))
b=OneSidedTail.(x->pdf(TDist(10),x),1,0.0001,rng)
display(plot(rng,b,xlabel="x",ylabel="OneSidedTail(x)",label="OneSidedTail(x) for TDist Distribution"))
plot(x->x, x->pdf(Normal(0, 1), x), -10, 10, label="Normal distribution")
plot!(x->x, x->pdf(Normal(0, 1), x), -10, OneSidedTail(x->pdf(Normal(0,1),x),1,0.0001,95), fill=(0, :green,0.3), label="Area of Normal")
plot!(x->x, x->pdf(TDist(10),x),-10, OneSidedTail(x->pdf(TDist(10),x),1,0.0001,95), fill=(0, :orange), label="Area of Tdist")
#println(OneSidedTail(x->pdf(Normal(0,1),x),1,0.0001,0.95))
#plot(x->x, x->pdf(TDist(10), x), -10, 10, label="TDist distribution")
#plot!(x->x, x->pdf(Normal(0, 1), x), -10, OneSidedTail(x->pdf(Normal(0,1),x),1,0.0001,95), fill=(0, :green,0.3), label="Area of Normal")
#plot!(x->x, x->pdf(TDist(10),x),-10, OneSidedTail(x->pdf(TDist(10),x),1,0.0001,95), fill=(0, :orange), label="Area of Tdist")