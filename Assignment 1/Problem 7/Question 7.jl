### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 7a8c2b40-734b-11eb-3115-fbaa9381ef78
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

# ╔═╡ d483e9e0-7368-11eb-138e-591becedcb43
md"**Question 7**"

# ╔═╡ ff4a8f70-734b-11eb-06a9-2bf68b4e0e50
begin
	for _ in 1:10000
		for i in  0:10
			count=10
			flag=0
			for j in 1:20
				a=rand(1:10)
				if(a<=10-i)
					count+=1
				else
					count-=1
				end
			if(i==0 && flag==0 && count<=0)
				p10+=1
				flag=1
			end
			if(i==1 && flag==0 && count<=0)
				p9+=1
				flag=1
			end
			if(i==2 && flag==0 && count<=0)
				p8+=1
				flag=1
			end
			if(i==3 && flag==0 && count<=0)
				p7+=1
				flag=1
			end
			if(i==4 && flag==0 && count<=0)
				p6+=1
				flag=1
			end
			if(i==5 && flag==0 && count<=0)
				p5+=1
				flag=1
			end
			if(i==6 && flag==0 && count<=0)
				p4+=1
				flag=1
			end
			if(i==7 && flag==0 && count<=0)
				p3+=1
			    flag=1
			end
			if(i==8 && flag==0 && count<=0)
				p2+=1
				flag=1
			end
			if(i==9 && flag==0 && count<=0)
				p1+=1
				flag=1
			end
			if(i==10  && flag==0 && count<=0)
				p0+=1
				flag=1
			end
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
	plot(p,ans,xlabel="value of p from 0.0 to 1.0",ylabel="Required prbability",title="Plot for Question 7",legend=false)
end

# ╔═╡ de144072-734c-11eb-363a-55547d618fce
for i in 1:11
		println("p=",p[i],"       ","Respective probability=",ans[i])
end

# ╔═╡ Cell order:
# ╟─d483e9e0-7368-11eb-138e-591becedcb43
# ╠═7a8c2b40-734b-11eb-3115-fbaa9381ef78
# ╠═ff4a8f70-734b-11eb-06a9-2bf68b4e0e50
# ╠═de144072-734c-11eb-363a-55547d618fce
