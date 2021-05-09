### A Pluto.jl notebook ###
# v0.14.3

using Markdown
using InteractiveUtils

# ╔═╡ 445dd770-a713-11eb-26f2-710ecc48ebd4
begin
	using Plots
	pyplot()
	using Random
	using StatPlots
	using Distributions
	using Combinatorics
	using QuadGK
	using LaTeXStrings
end

# ╔═╡ ac33fbf0-a712-11eb-2b7d-2d09f9c07cec
md"# Question 1"

# ╔═╡ fb7a2c70-a712-11eb-0086-65cc76c49d17
md"**Monte Carlo simulation**"

# ╔═╡ 41c5a05e-a713-11eb-0504-a1390e6e82b9
begin
	n=10^6
	total=0
	coin=[0,1]
	for i in 1:n
		heads=0
		for i in 1:50
			if(rand(coin)==1)
				heads+=1
			end
		end
		if(heads>=30)
			total+=1
		end
	end
	total=total/n
end

# ╔═╡ a0336ab0-a718-11eb-3fed-91e55f28140d
md"**Binomial Distribution**"

# ╔═╡ b6fdeb80-a718-11eb-04a0-9dad7782adf1
sum([binomial(50,i)*(0.5)^(i)*(0.5)^(50-i) for i in 30:50])

# ╔═╡ 206297e0-a71b-11eb-271a-59e1502add2f
md"**Approximation using CLT**"

# ╔═╡ 86bfbe20-6b97-453f-91f9-30869fa8632a
md"Here, we can easily calculate that μ=0.5 and variance=0.25 ,
n=50 \
Therefore, by CLT, it will follow a normal distribution of N(0.5×50,√0.25×√50).\
Getting at least 30 head means we need to compute the probability of P(≥30).\
\
"

# ╔═╡ 305da090-a71b-11eb-382a-6930f20e084e
begin
	dist=Normal(0.5*50,sqrt(0.25)*sqrt(50))
	ans=quadgk(x->pdf(dist,x),29.5,50)[1]
end

# ╔═╡ fb438c10-a712-11eb-3a8a-41a2f9789cb1
md"# Question 2"

# ╔═╡ f0375ec9-d76e-4e17-ad92-bb8876bd08b0
md"Now, here we need to make the fair coin biased such that the probability of getting at least 30 heaad out of 50 tossed is at least 50%"

# ╔═╡ 5c51fa31-80c8-4d11-84f9-8a47611c9ea9
md"**Using CLT**"

# ╔═╡ 62359509-7723-4b03-a247-8f9af7738177
md"Here we will slowly increase the value of probability and accordingly mean and variance will change. After every increment we will check whether the area under the normal distribution is at least 50% or not. If suitable probability is reached and the area covered under the normal distribution  exceeds the 50%, then we will break the loop."

# ╔═╡ fb1a0b10-a712-11eb-3cf0-136572b66906
begin
	prob2=0.5
	while(prob2<1)
		mean2= prob2;
		sigma2= sqrt(prob2*(1-prob2))
		dist2=Normal(mean2*50,sigma2*sqrt(50))
		ans2=quadgk(x->pdf(dist2,x),29.5,50)[1]
		prob2 = prob2+0.0000001
		if(ans2>=0.5)
			break
		end
		
	end
	prob2
end

# ╔═╡ d6fe5ac9-100b-4249-8dd9-43656faa67e1
md"Hence by making the coin biased in such a way that if probability of getting head  is 0.59, then the total pprobabiliity of getting 30 heads in 50 coin tosses exceeds 50%"

# ╔═╡ fccd7b43-74de-47c5-9fcb-70e296c585ce
md"**Verification using Monte Carlo experiment**"

# ╔═╡ f834452c-7286-4dff-9279-e19d9fbfa836
begin
	n2=10^6
	total2=0
	coin2=[0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,0]
	for i in 1:n
		heads2=0
		for i in 1:50
			if(rand(coin2)==1)
				heads2+=1
			end
		end
		if(heads2>=30)
			total2+=1
		end
	end
	total2=total2/n
end

# ╔═╡ df7ad3e2-f8b0-4913-92bc-c7bc9ccca203
md" here we can see if the coin is biased such that, the probability of getting head is 0.59, then the probability of getting at least 30 heads out of 50 tosses exceeds 50%"

# ╔═╡ d1e22d3f-fddf-4291-9310-c3a4888dae6a
md"**verification using Binomial Distribution**"

# ╔═╡ 2ee59ec9-6023-452e-bc57-d45b1a2e5770
md"We can also verify the above by using binomial distribution"

# ╔═╡ c103f78c-5eb9-4d27-a373-5cbb618ddf32
sum([binomial(50,i)*(0.59)^(i)*(0.41)^(50-i) for i in 30:50])

# ╔═╡ fa7b8120-a712-11eb-1612-87b63af35999
md"# Question 3"

# ╔═╡ 067043d0-a713-11eb-1ed1-7de03dc5b180
md"Let n number of suits.\
If we take CLT, then we get,a normal distribution with mean 100n and sigma 30√n.\
In this distribution we need to say that cdf at 3000=0.05\
Therefore,
```math
Z = \dfrac{3000-100n}{30√n}
```
Now for normal distribution with mean 0 and sigma 1, cdf at -1.64 is equal to 0.05, so we get:
```math
\dfrac{3000-100n}{30√n}=-1.64
```
```math
⟹100n-49.2√n-3000=0
```
```math
⟹√n=5.7287
```
```math
⟹n=32.8185
```
Therefore, n= 33.
"

# ╔═╡ 6ca756f6-f018-4820-a580-89a76ad422c8
begin
	base = Normal(100,30)
	ans3=0
	for n in 20:40
	    count3 = 0
	    for j in 1:1000
	        if sum(rand(base,n)) >= 3000
	            count3 += 1
	        end
	    end
	    if (count3/1000) >= 0.95 
	        ans3=n
	        break
	    end
	end
	ans3
end

# ╔═╡ 062271f0-a713-11eb-2040-9957f8824aa0
md"# Question 4"

# ╔═╡ c5f161da-67eb-4b61-8203-ee3dc8cb3f2a
function getn(dis)
	range_ = 1:10000
	d_n = Normal(0,1)
	n_mean = mean(d_n)
	n_std = std(d_n)
	n_skew = skewness(d_n)
	n_kurto = kurtosis(d_n)
	for i in 2:200
		vals = Float64[]
		for _ in range_
			temp = (rand(dis,i).-mean(dis)) ./std(dis)
			push!(vals, mean(temp))
		end

		vals = vals * sqrt(i)

		test_mean = mean(vals)
		test_std = std(vals)
		test_kurto = kurtosis(vals)
		test_skew = skewness(vals)

        if(abs(abs(test_mean) - abs(n_mean)) < 0.1 && 
				abs(abs(test_std) - abs(n_std)) < 0.1 && 
				abs(abs(test_kurto) - abs(n_kurto)) < 0.1 && 
				abs(abs(test_skew) - abs(n_skew))<0.1 )
			println("Smallest sample size: $dis = ", i)
			return i
		end
	end
end

# ╔═╡ e856dbfc-d18d-4234-8378-b02b82810b96
md"a) Uniform distribution between 0 and 1"

# ╔═╡ ff0fc182-10fc-4c4b-a7be-b032a5229a4a
begin
	Random.seed!(20)
	getn(Uniform(0,1))
end

# ╔═╡ 5eadcdbd-46df-4c97-b607-aa1f4364079f
md"b) Binomial distribution with p = 0.01"

# ╔═╡ 1d59df66-3b03-4951-aa65-0fd87137d69e
begin
	Random.seed!(20)
	getn(Binomial(100,0.01))
end

# ╔═╡ 38da49e6-857b-4a1c-99ae-aa2e66f183de
md"c) Binomial distribution with p = 0.5"

# ╔═╡ e968516e-154e-497d-a9fa-4183ba4493cc
begin
	Random.seed!(20)
	getn(Binomial(100,0.5))
end

# ╔═╡ cd448870-8eb3-4f46-8cfb-435e828b6bfd
md"d) Chi-square distribution with 3 degrees of freedom"

# ╔═╡ b6c3577b-84b1-40c9-a698-1eacf35ffa0a
begin
	Random.seed!(20)
	getn(Chisq(3))
end


# ╔═╡ Cell order:
# ╠═445dd770-a713-11eb-26f2-710ecc48ebd4
# ╟─ac33fbf0-a712-11eb-2b7d-2d09f9c07cec
# ╟─fb7a2c70-a712-11eb-0086-65cc76c49d17
# ╠═41c5a05e-a713-11eb-0504-a1390e6e82b9
# ╟─a0336ab0-a718-11eb-3fed-91e55f28140d
# ╠═b6fdeb80-a718-11eb-04a0-9dad7782adf1
# ╟─206297e0-a71b-11eb-271a-59e1502add2f
# ╟─86bfbe20-6b97-453f-91f9-30869fa8632a
# ╠═305da090-a71b-11eb-382a-6930f20e084e
# ╟─fb438c10-a712-11eb-3a8a-41a2f9789cb1
# ╟─f0375ec9-d76e-4e17-ad92-bb8876bd08b0
# ╟─5c51fa31-80c8-4d11-84f9-8a47611c9ea9
# ╟─62359509-7723-4b03-a247-8f9af7738177
# ╠═fb1a0b10-a712-11eb-3cf0-136572b66906
# ╟─d6fe5ac9-100b-4249-8dd9-43656faa67e1
# ╟─fccd7b43-74de-47c5-9fcb-70e296c585ce
# ╠═f834452c-7286-4dff-9279-e19d9fbfa836
# ╟─df7ad3e2-f8b0-4913-92bc-c7bc9ccca203
# ╟─d1e22d3f-fddf-4291-9310-c3a4888dae6a
# ╟─2ee59ec9-6023-452e-bc57-d45b1a2e5770
# ╠═c103f78c-5eb9-4d27-a373-5cbb618ddf32
# ╟─fa7b8120-a712-11eb-1612-87b63af35999
# ╟─067043d0-a713-11eb-1ed1-7de03dc5b180
# ╠═6ca756f6-f018-4820-a580-89a76ad422c8
# ╟─062271f0-a713-11eb-2040-9957f8824aa0
# ╠═c5f161da-67eb-4b61-8203-ee3dc8cb3f2a
# ╟─e856dbfc-d18d-4234-8378-b02b82810b96
# ╠═ff0fc182-10fc-4c4b-a7be-b032a5229a4a
# ╟─5eadcdbd-46df-4c97-b607-aa1f4364079f
# ╠═1d59df66-3b03-4951-aa65-0fd87137d69e
# ╟─38da49e6-857b-4a1c-99ae-aa2e66f183de
# ╠═e968516e-154e-497d-a9fa-4183ba4493cc
# ╟─cd448870-8eb3-4f46-8cfb-435e828b6bfd
# ╠═b6c3577b-84b1-40c9-a698-1eacf35ffa0a
