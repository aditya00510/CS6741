### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 77e5eae0-7060-11eb-045d-cd60dbedbf67
md"**Question 5**"

# ╔═╡ 86c179d0-7060-11eb-1f22-ed89145933bb
md"When we were trying to store passwords with matching at least two characters, then in 1 million around 4400 passwords are being stored, so we will be storing passwords with matching at least 3 characters, and in this way in 1 million roughly around 150 passwords are getting stored"

# ╔═╡ 1350dd10-7060-11eb-242c-798360fd58d2
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
		if(count>=3)
			final+=1
		end
	end
	println(final/num)
end

# ╔═╡ Cell order:
# ╟─77e5eae0-7060-11eb-045d-cd60dbedbf67
# ╟─86c179d0-7060-11eb-1f22-ed89145933bb
# ╠═1350dd10-7060-11eb-242c-798360fd58d2
