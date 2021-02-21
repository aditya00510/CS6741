### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ daad2650-71fc-11eb-29ca-4f5fb305156b
begin
	using Plots
		pyplot()
		using Random
	    p=[0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
		ans=[]
		p10=0
		p9=0
		p8=0
		p7=0
		p6=0
		p5=0
		p4=0
		p3=0
		p2=0
		p1=0
	    p0=0
end

# ╔═╡ d9830eb0-727f-11eb-1a89-1b925c66b542
md"**Question 6**"

# ╔═╡ a0a7d3f0-71fd-11eb-138d-4960e0830939
begin
	for _ in 1:10000
		for i in  0:10
			count=0
			for j in 1:20
				a=rand(1:10)
				if(a<=10-i)
					count+=1
				else
					count-=1
				end
			end
			if(i==0 && count>=0)
				p10+=1
			end
			if(i==1 && count>=0)
				p9+=1
			end
			if(i==2 && count>=0)
				p8+=1
			end
			if(i==3 && count>=0)
				p7+=1
			end
			if(i==4 && count>=0)
				p6+=1
			end
			if(i==5 && count>=0)
				p5+=1
			end
			if(i==6 && count>=0)
				p4+=1
			end
			if(i==7 && count>=0)
				p3+=1
			end
			if(i==8 && count>=0)
				p2+=1
			end
			if(i==9 && count>=0)
				p1+=1
			end
			if(i==10 && count>=0)
				p0+=1
			end
		end
	end
	push!(ans,p10/10000)
	push!(ans,p9/10000)
	push!(ans,p8/10000)	
	push!(ans,p7/10000)	
	push!(ans,p6/10000)	
	push!(ans,p5/10000)	
	push!(ans,p4/10000)	
	push!(ans,p3/10000)	
	push!(ans,p2/10000)	
	push!(ans,p1/10000)
	push!(ans,p0/10000)
	plot(p,ans,xlabel="value of p from 0.0 to 1.0",ylabel="Required prbability",title="Plot for Question 6",legend=false)
end

# ╔═╡ 13d41660-734b-11eb-00ef-d54f90794ea5
begin
 for i in 1:11
		println("p=",p[i],"       ","Respective probability=",ans[i])
 end
end

# ╔═╡ 0c92ee70-7400-11eb-1c77-5d804ae8676d


# ╔═╡ Cell order:
# ╟─d9830eb0-727f-11eb-1a89-1b925c66b542
# ╠═daad2650-71fc-11eb-29ca-4f5fb305156b
# ╠═a0a7d3f0-71fd-11eb-138d-4960e0830939
# ╠═13d41660-734b-11eb-00ef-d54f90794ea5
# ╠═0c92ee70-7400-11eb-1c77-5d804ae8676d
