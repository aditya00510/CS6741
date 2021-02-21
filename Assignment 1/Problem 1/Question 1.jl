### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 57c5e462-6d20-11eb-1ab4-db7ee850921b
begin
	using Plots
	pyplot()
	using Random
end

# ╔═╡ 64c3a80e-6d1f-11eb-2ed1-7d4de8c4ffa3
md"# Assignment 1
"

# ╔═╡ 9ac55710-6d1f-11eb-08cd-212f1aa727e3
md"**Question 1**"

# ╔═╡ 519a9b80-6d20-11eb-0bc2-5ded56f9e894
begin
	x=0
	arr=[]
	count=0
end

# ╔═╡ bfe5fa90-6e19-11eb-1eda-5d35dfec2538
begin
	for i in 1:5*10^4
		x=x+rand(-10^7:10^7)
		count=count+1
		push!(arr,x/count)
	end
	plot(arr,legend=false)
end

# ╔═╡ Cell order:
# ╟─64c3a80e-6d1f-11eb-2ed1-7d4de8c4ffa3
# ╟─9ac55710-6d1f-11eb-08cd-212f1aa727e3
# ╠═519a9b80-6d20-11eb-0bc2-5ded56f9e894
# ╠═57c5e462-6d20-11eb-1ab4-db7ee850921b
# ╠═bfe5fa90-6e19-11eb-1eda-5d35dfec2538
