#This question is coded in VS Code. It doesn't require pluto
using QuadGK
using Distributions
using DataFrames
using DSP
using Plots
pyplot()

inc = 0.005
rng = -5:inc:8
points = 1 + 1/inc
ans=DataFrame()
ans.n = 2:10
kld = []
function divergence(arr)
	mu =sum([rng[i]*(arr[i]/(points-1)) for i in 1:length(rng)])
	sigma= sqrt(sum([(rng[i]-mu)^2*(arr[i]/(points-1)) for i in 1:length(rng)]))
	NormDisc= [pdf(Normal(mu, sigma), i) for i in rng]
	total = 0
	for i in 1:length(rng)
		if arr[i] > 0
			total = total + arr[i]*log2(arr[i]/NormDisc[i])
		end
	end
	push!(kld,total)
end
function convolution(X)
	total=0
	for i in rng
       total+=pdf(Uniform(0,1), i)*pdf(Uniform(0,1), X-i)
	end
	return total
end

function convolution2(X)
	total=0
	for i in 1:length(rng)
		total+=conv_arr[i]*pdf(Uniform(0,1), X-rng[i])
	end
	return total
end

arr = [pdf(Uniform(0,1), i) for i in rng]
divergence(arr)
conv1 = convolution.(rng)/points
divergence(conv1)
conv_arr = copy(conv1)
for j in 1:8
	global conv_arr = convolution2.(rng)/points
	divergence(conv_arr)
end
ans.KLDivergence=kld[2:10]
println(ans)
plot(2:10, kld[2:10], xlabel="different values of n", ylabel="KL Divergence",legend=false)