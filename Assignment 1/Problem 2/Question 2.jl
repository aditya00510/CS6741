### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 350d3160-71d2-11eb-2760-35bd8a65afa5
begin
	using Plots
	pyplot()
	using Random
	bag=["0","0","0","0","1","0","0","0","0","0","0","0","0","0","0","0","0","0","0","1","0","0","0","0","0","0","0","0","0","0","1","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","1"]
		ans1=[]
	    ans2=[]
		num=10^6
		count0=0
		count1=0
		count2=0
		count3=0
		count4=0
	    count5=0
	    count6=0
	    count7=0
	    count8=0
	    count9=0
	    count10=0
end

# ╔═╡ c7058270-71d2-11eb-1037-ed306b922693
md"**Without replacement**"

# ╔═╡ 628ab360-71d2-11eb-2720-8ff464d47623
begin
	for i in 1:num
		bag1=copy(bag)
		c1=rand(bag1)
		deleteat!(bag1, findfirst(x-> x == "0", bag1))
		c2=rand(bag1)
		deleteat!(bag1, findfirst(x-> x == "0", bag1))
		c3=rand(bag1)
		deleteat!(bag1, findfirst(x-> x == "0", bag1))
		c4=rand(bag1)
		deleteat!(bag1, findfirst(x-> x == "0", bag1))
		c5=rand(bag1)
		if(c1=="0" && c2=="0" && c3=="0" && c4=="0" && c5=="0")
			count0=count0+1
		end
	end
	push!(ans1,count0/num)
	for i in 1:num
				bag2=copy(bag)
				c6=rand(bag2)
				deleteat!(bag2, findfirst(x-> x == "1", bag2))
				c7=rand(bag2)
				deleteat!(bag2, findfirst(x-> x == "0", bag2))
				c8=rand(bag2)
				deleteat!(bag2, findfirst(x-> x == "0", bag2))
				c9=rand(bag2)
				deleteat!(bag2, findfirst(x-> x == "0", bag2))
				c10=rand(bag2)
				if(c6=="1" && c7=="0" && c8=="0" && c9=="0" && c10=="0")
					count1=count1+1
				end
		end
		push!(ans1,5*count1/num)
	for i in 1:num
				bag3=copy(bag)
				c11=rand(bag3)
				deleteat!(bag3, findfirst(x-> x == "1", bag3))
				c12=rand(bag3)
				deleteat!(bag3, findfirst(x-> x == "1", bag3))
				c13=rand(bag3)
				deleteat!(bag3, findfirst(x-> x == "0", bag3))
				c14=rand(bag3)
				deleteat!(bag3, findfirst(x-> x == "0", bag3))
				c15=rand(bag3)
				if(c11=="1" && c12=="1" && c13=="0" && c14=="0" && c15=="0")
					count2=count2+1
				end
			end
			push!(ans1,5*2*count2/num)
	for i in 1:num
				bag4=copy(bag)
				c16=rand(bag4)
				deleteat!(bag4, findfirst(x-> x == "1", bag4))
				c17=rand(bag4)
				deleteat!(bag4, findfirst(x-> x == "1", bag4))
				c18=rand(bag4)
				deleteat!(bag4, findfirst(x-> x == "1", bag4))
				c19=rand(bag4)
				deleteat!(bag4, findfirst(x-> x == "0", bag4))
				c20=rand(bag4)
				if(c16=="1" && c17=="1" && c18=="1" && c19=="0" && c20=="0")
					count3=count3+1
				end
			end
			push!(ans1,5*2*count3/num)
	for i in 1:num
				bag5=copy(bag)
				c21=rand(bag5)
				deleteat!(bag5, findfirst(x-> x == "1", bag5))
				c22=rand(bag5)
				deleteat!(bag5, findfirst(x-> x == "1", bag5))
				c23=rand(bag5)
				deleteat!(bag5, findfirst(x-> x == "1", bag5))
				c24=rand(bag5)
				deleteat!(bag5, findfirst(x-> x == "1", bag5))
				c25=rand(bag5)
				if(c21=="1" && c22=="1" && c23=="1" && c24=="1" && c25=="0")
					count4=count4+1
				end
			end
		push!(ans1,5*count4/num)
	plot(0:4,ans1,xlabel="No. of jacks that can be drawn",ylabel="Respective probability",title="Experimental solution(Without replacemnt)",legend=false)
end

# ╔═╡ db6a4de0-71d2-11eb-28d4-e743983052b6
md"**With replacement**"

# ╔═╡ e9693870-71d2-11eb-3465-0748e534f051
begin
	for i in 1:num
		temp=0
		for _ in 1:5
			a=rand(bag)
			if(a=="1")
				temp+=1
			end
		end
		if(temp==0)
			count5+=1
		end
		if(temp==1)
			count6+=1
		end
		if(temp==2)
			count7+=1
		end
		if(temp==3)
			count8+=1
		end
		if(temp==4)
			count9+=1
		end
		if(temp==5)
			count10+=1
		end
	end
	push!(ans2,count5/num)
	push!(ans2,count6/num)
	push!(ans2,count7/num)
	push!(ans2,count8/num)
	push!(ans2,count9/num)
	push!(ans2,count10/num)
	plot(0:5,ans2,xlabel="No. of jacks that can be drawn",ylabel="Respective probability",title="Experimental solution(With replacement)",legend=false)
end

# ╔═╡ Cell order:
# ╠═350d3160-71d2-11eb-2760-35bd8a65afa5
# ╟─c7058270-71d2-11eb-1037-ed306b922693
# ╠═628ab360-71d2-11eb-2720-8ff464d47623
# ╟─db6a4de0-71d2-11eb-28d4-e743983052b6
# ╠═e9693870-71d2-11eb-3465-0748e534f051
