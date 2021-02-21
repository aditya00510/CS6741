### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ bb8a7000-6e16-11eb-3057-975143f60c09
begin
	using Plots
	pyplot()
	using Random
end

# ╔═╡ d13a2010-6e18-11eb-26d3-3b7ad5bc0fc4
md"**Question 3**"

# ╔═╡ bc30b032-6e18-11eb-0e50-814ce542a2d4
md"**Without replacemnt**"

# ╔═╡ db255720-6e18-11eb-31c0-05b542652675
begin
	cards=5
	N=52
	a=4
	without_replacement=[]
	replacement=[]
end

# ╔═╡ e42284b0-6e18-11eb-0574-191beca58cf4
begin
	for i in 0:4
		push!(without_replacement,binomial(a,i)*binomial(N-a,cards-i)/binomial(N,cards))
	end
	plot(0:4,without_replacement,xlabel="No. of jacks that can be drawn",ylabel="Respective probability",title="Theoretical solution(Without replacement)",legend=false)
end

# ╔═╡ eecffa50-6e18-11eb-08b6-67f8c7a4266c
md"**With replacement**"

# ╔═╡ 0bda0f50-6e19-11eb-064e-2de157893b3e
begin
	for i in 0:cards
		push!(replacement,binomial(5,i)*(4/52)^(i)*(48/52)^(5-i))
	end
	plot(0:5,replacement,xlabel="No. of jacks that can be drawn",ylabel="Respective probability",title="Theoretical solution(With replacement)",legend=false)
end

# ╔═╡ Cell order:
# ╟─d13a2010-6e18-11eb-26d3-3b7ad5bc0fc4
# ╠═bb8a7000-6e16-11eb-3057-975143f60c09
# ╟─bc30b032-6e18-11eb-0e50-814ce542a2d4
# ╠═db255720-6e18-11eb-31c0-05b542652675
# ╠═e42284b0-6e18-11eb-0574-191beca58cf4
# ╟─eecffa50-6e18-11eb-08b6-67f8c7a4266c
# ╠═0bda0f50-6e19-11eb-064e-2de157893b3e
