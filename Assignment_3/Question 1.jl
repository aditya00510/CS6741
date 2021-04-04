#This question is coded in VS Code. It doesn't require pluto
using QuadGK
using Distributions
using DataFrames

function divergence(p,q)
	return quadgk(x->pdf(p,x)*log(pdf(p,x)/pdf(q,x)),-35,35)
end

ans1=DataFrame()
ans1.v=1:5
ans1.KL_divergence=[divergence(TDist(i),Normal(0,1))[1] for i in 1:5]
println(ans1)