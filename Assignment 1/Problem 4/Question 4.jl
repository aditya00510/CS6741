### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ bccd61c0-6e8e-11eb-2cd1-357968664050
md"**Question 4**"

# ╔═╡ 716a7ba0-705f-11eb-3805-357deeff6c6a
md"**With Computation**"

# ╔═╡ 7b4e06c0-6e8c-11eb-0e1b-176b1546d73a
begin
	bag=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","~","`","!","@","#","%","^","&","*","(",")","_","-","+",".","\$"]
	num=1000000
	final=0
	arr=[]
	for _ in 1:8
		push!(arr,rand(bag))
	end
	for _ in 1:num
		temp=[]
		count=0
		for _ in 1:8
			push!(temp,rand(bag))
		end
		for i in 1:8
			if(arr[i]==temp[i])
				count+=1
			end
		end
		if(count>=2)
			final+=1
		end
	end
	println(final/num)
end

# ╔═╡ 5e045b80-705f-11eb-14fe-9bbbed76b8ab
md"**With Probability theory**"

# ╔═╡ f18787c0-705e-11eb-1bd9-e1f56174e4f6
1-binomial(8,0)*(1/78)^0*(77/78)^8-binomial(8,1)*(1/78)^1*(77/78)^7

# ╔═╡ Cell order:
# ╟─bccd61c0-6e8e-11eb-2cd1-357968664050
# ╟─716a7ba0-705f-11eb-3805-357deeff6c6a
# ╠═7b4e06c0-6e8c-11eb-0e1b-176b1546d73a
# ╟─5e045b80-705f-11eb-14fe-9bbbed76b8ab
# ╠═f18787c0-705e-11eb-1bd9-e1f56174e4f6
