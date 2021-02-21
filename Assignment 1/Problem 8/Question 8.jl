### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ fbe97a60-735c-11eb-2ec8-d18ecc078547
begin
	using Plots
		pyplot()
		using Random
	    p=[0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
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
	    num=10^5
end

# ╔═╡ c4fa1990-7368-11eb-0e05-15ce67e56079
md"**Question 8**"

# ╔═╡ a1fdf522-735d-11eb-0e35-c1e2f473f52c
begin
	for _ in 1:num
		for i in  0:9
			count=10
			for j in 1:20
				a=rand(1:10)
				if(a<=10-i)
					count+=1
				else
					count-=1
				end
	        if(count==0)
				break
			end
		   end
			if(i==0  && count>=10)
				p10+=1
			end
			if(i==1  && count>=10)
				p9+=1
			end
			if(i==2 && count>=10)
				p8+=1
			end
			if(i==3  && count>=10)
				p7+=1
			end
			if(i==4  && count>=10)
				p6+=1
			end
			if(i==5  &&count>=10)
				p5+=1
			end
			if(i==6 && count>=10)
				p4+=1
			end
			if(i==7  && count>=10)
				p3+=1
			end
			if(i==8  && count>=10)
				p2+=1
			end
			if(i==9  && count>=10)
				p1+=1
			end
		end
	end
	push!(ans,p10/num)
	push!(ans,p9/num)
	push!(ans,p8/num)	
	push!(ans,p7/num)	
	push!(ans,p6/num)	
	push!(ans,p5/num)	
	push!(ans,p4/num)	
	push!(ans,p3/num)	
	push!(ans,p2/num)	
	push!(ans,p1/num)
	plot(p,ans,xlabel="value of p from 0.0 to 0.9",ylabel="Required prbability",title="Plot for Question 8",legend=false)
end

# ╔═╡ 9bad0cc0-7366-11eb-28a8-5dd68f6d82bb
begin
  for i in 1:10
		println("p=",p[i],"       ","Respective probability=",ans[i])
  end
end

# ╔═╡ Cell order:
# ╟─c4fa1990-7368-11eb-0e05-15ce67e56079
# ╠═fbe97a60-735c-11eb-2ec8-d18ecc078547
# ╠═a1fdf522-735d-11eb-0e35-c1e2f473f52c
# ╠═9bad0cc0-7366-11eb-28a8-5dd68f6d82bb
