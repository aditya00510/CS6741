### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ c7ee6400-7dd4-11eb-2114-f5ddb55cc8e2
begin
	using DataFrames
	using Random
	using Plots
	pyplot()
	using Dates
	using HTTP
	using JSON
end

# ╔═╡ d46d9e50-7dd2-11eb-29af-7b0ce5f1ed4a
md"# Question 1"

# ╔═╡ 07123510-7dd2-11eb-3462-9f0439eb4425
begin
	d=DataFrame(v1=["Agnostic","Atheist","Buddhist","Catholic","Don't know/refused","Evangelical Prot","Hindu","Historically Black Prot","Jehovah's Witness","Jewish"],v2=[rand(1:100) for _ in 1:10],v3=[rand(1:100) for _ in 1:10],v4=[rand(1:100) for _ in 1:10],v5=[rand(1:100) for _ in 1:10],v6=[rand(1:100) for _ in 1:10],v7=[rand(1:100) for _ in 1:10],v8=[rand(1:100) for _ in 1:10],v9=[rand(1:100) for _ in 1:10],v10=[rand(1:100) for _ in 1:10],v11=[rand(1:100) for _ in 1:10])
	rename!(d,:v1=>:religion)
	rename!(d,:v2=>:"<\$10k")
	rename!(d,:v3=>:"\$10-20k")
	rename!(d,:v4=>:"\$20-30k")
	rename!(d,:v5=>:"\$30-40k")
	rename!(d,:v6=>:"\$40-50k")
	rename!(d,:v7=>:"\$50-75k")
	rename!(d,:v8=>:"\$75-100k")
	rename!(d,:v9=>:"\$100-150k")
	rename!(d,:v10=>:">\$150k")
	rename!(d,:v11=>:"Don't know/resfused")
	d
end

# ╔═╡ 25ddd030-7dd2-11eb-28e0-853c70587557
begin
	dstacked=DataFrames.stack(d,2:11,:religion)
	temp=select(dstacked,:religion,:variable=>:income,:value=>:freq)
	ans=groupby(temp,:religion)
	vcat(ans[1],ans[2],ans[3],ans[4],ans[5],ans[6],ans[7],ans[8],ans[9],ans[10])
end

# ╔═╡ 5da46b40-7dd3-11eb-3a76-edd2506b25e5
md"# Question 2"

# ╔═╡ 71e02ae0-7dd3-11eb-2aff-6b1ce6db3c49
begin
	data_2=DataFrame()
	data_2.id=["MX17004" for _ in 1:10]
	data_2.year=[2010 for _ in 1:10]
	data_2.month=[1,1,2,2,3,3,4,4,5,5]
	data_2.element=["tmax","tmin","tmax","tmin","tmax","tmin","tmax","tmin","tmax","tmin"]
	data_2.d1=[20.4,14.7,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d2=[missing,missing,30.9,21.1,missing,missing,missing,missing,missing,missing]
	data_2.d3=[missing,missing,missing,missing,28.7,24.7,30,5,missing,missing]
	data_2.d4=[missing,missing,missing,missing,missing,missing,missing,missing,28,06]
	data_2.d5=[missing,missing,missing,missing,missing,missing,50.2,28.7,missing,missing]
	data_2.d6=[missing,missing,missing,missing,26,18,missing,missing,missing,missing]
	data_2.d7=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d8=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d9=[missing,missing,56,18,missing,missing,missing,missing,missing,missing]
	data_2.d10=[missing,missing,missing,missing,19,12,missing,missing,missing,missing]
	data_2.d11=[missing,missing,missing,missing,missing,missing,19,09,missing,missing]
	data_2.d12=[missing,missing,missing,missing,missing,missing,missing,missing,23,12]
	data_2.d13=[31,14,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d14=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d15=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d16=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d17=[missing,missing,38,19,missing,missing,missing,missing,missing,missing]
	data_2.d18=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d19=[missing,missing,missing,missing,50,3,missing,missing,missing,missing]
	data_2.d20=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d21=[missing,missing,missing,missing,missing,missing,23,11.5,missing,missing]
	data_2.d22=[missing,missing,missing,missing,missing,missing,missing,missing,27,18.5]
	data_2.d23=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d24=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d25=[missing,missing,missing,missing,12,6,missing,missing,missing,missing]
	data_2.d26=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d27=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d28=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d29=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing]
	data_2.d30=[missing,missing,missing,missing,28,20,missing,missing,missing,missing]
	data_2
end

# ╔═╡ 5b425800-7dd6-11eb-2567-194d488f4c7a
begin
	data_2_stacked=DataFrames.stack(data_2,5:34)
	data_2_unstacked=unstack(data_2_stacked,:element,:value)
	data_2_temp=dropmissing!(data_2_unstacked)
	rename!(data_2_temp,:variable=>"day")
	data_2_temp[!,:day] = [chop(i,head=1,tail=0) for i in data_2_temp[!,:day]]
	data_2_temp[!,:day] = [parse(Int,i) for i in data_2_temp[!,:day]]
	data_2_temp
end

# ╔═╡ 99d12ed0-7f01-11eb-34b1-11391c1c8ed6
begin
	data_2_final=select(data_2_temp,:id,[:year,:month,:day]=>ByRow((yy,m,ddd)->Dates.Date(yy,m,ddd))=>:date,:tmax,:tmin)
	data_2_final
end

# ╔═╡ fc822090-7dd3-11eb-2de0-6fa1adcceed1
md"# Question 3"

# ╔═╡ 0af7c1c0-7dd4-11eb-248a-a92c1679ad78
begin
	data_3=DataFrame()
	data_3.year=[2000 for _ in 1:15]
	data_3.artist=["2 Pac","2 Pac","2 Pac","2 Pac","2 Pac","2 Pac","2 Pac","2Ge+her","2Ge+her","2Ge+her","3 Doors Down","3 Doors Down","3 Doors Down","3 Doors Down","3 Doors Down"]
	data_3.time=["4:12","4:12","4:12","4:12","4:12","4:12","4:12","3:15","3:15","3:15","3:53","3:53","3:53","3:53","3:53"]
	data_3.track=["Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","Baby Don't Cry","The Hardest Part of...","The Hardest Part of...","The Hardest Part of...","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite"]
	data_3.date=["2000-02-26","2000-03-04","2000-03-11","2000-03-18","2000-03-25","2000-04-01","2000-04-08","2000-09-02","2000-09-09","2000-09-16","2000-04-08","2000-04-15","2000-04-22","2000-04-29","2000-05-06"]
	data_3.week=[1,2,3,4,5,6,7,1,2,3,1,2,3,4,5]
	data_3.rank=[87,82,72,77,87,94,99,91,87,92,81,70,68,67,66]
	data_3
end

# ╔═╡ 1143b200-7dd4-11eb-2884-931d36429f6f
begin
	temp_3=unique(data_3[:,[:artist,:track,:time]])
    insertcols!(temp_3,1,:id=>1:3,makeunique=true)
	temp_3
end

# ╔═╡ b727e310-7dd6-11eb-08e0-d5ad84e73ba9
select(innerjoin(temp_3,data_3,on=[:artist,:track,:time]),:id,:date,:rank)

# ╔═╡ ce33b2a0-7dd6-11eb-1e9f-4b5f0dd17c0f
md"# Question 4"

# ╔═╡ 65ed1910-7dd7-11eb-3ce3-759deb629281
begin
	link= "https://api.covid19india.org/data.json"
	temp5=HTTP.get(link)
	fetched_data = JSON.parse(String(temp5.body))
	data_4=DataFrame(fetched_data["cases_time_series"][1])
	for i in 2:398
		temp6 = DataFrame(fetched_data["cases_time_series"][i])
		data_4=outerjoin(data_4,temp6,on=[:dailyconfirmed,:dailydeceased,:dailyrecovered,:date,:dateymd,:totalconfirmed,:totaldeceased,:totalrecovered])
	end
	data_4[!,:dailyconfirmed] = [parse(Int,i) for i in data_4[!,:dailyconfirmed]]
    data_4[!,:dailydeceased] = [parse(Int,i) for i in data_4[!,:dailydeceased]] 
    data_4[!,:dailyrecovered] = [parse(Int,i) for i in data_4[!,:dailyrecovered]] 
	data_4
end

# ╔═╡ 73403340-7dd7-11eb-3e0a-477267e73c76
begin
	format=DateFormat("y-m-d")
	temp_4=data_4[:,:dateymd]
	yyyy=[]
	mm=[]
	dd=[]
	for i in 1:398
	   temp1=Dates.Date(temp_4[i],format)
	   push!(yyyy,Dates.year(temp1))
	  	push!(mm,Dates.month(temp1))
		push!(dd,Dates.day(temp1))
	end
	data_4.year=[yyyy[i] for i in 1:398]
	data_4.month=[mm[i] for i in 1:398]
	data_4.day=[dd[i] for i in 1:398]
	data_4
end

# ╔═╡ 876ab4d0-7dd7-11eb-3e09-256394917dd0
begin
	g=groupby(data_4,[:year,:month])
	combine(g,:dailyconfirmed=>sum,:dailydeceased=>sum,:dailyrecovered=>sum)
end

# ╔═╡ d5113f10-7dd7-11eb-0907-cfda8c926f52
md"# Question 5"

# ╔═╡ 14cd5120-7dd8-11eb-1b44-679c746fd486
a=plot(data_4[:,:dateymd],data_4[:,:dailyconfirmed],xlabel="Date(YYYY-MM-DD)",ylabel="Daily confirmed cases",legend=false)

# ╔═╡ 2a693d02-7dd8-11eb-2a76-cf29e56e7726
b=plot(data_4[:,:dateymd],data_4[:,:dailydeceased],xlabel="Date(YYYY-MM-DD)",ylabel="Daily deceased cases",legend=false)

# ╔═╡ 2c99ffb0-7dd8-11eb-1c13-9d06e3e5f1a6
c=plot(data_4[:,:dateymd],data_4[:,:dailyrecovered],xlabel="Date(YYYY-MM-DD)",ylabel="Daily recovered cases",legend=false)

# ╔═╡ 4e1c0840-7dd8-11eb-3a3b-39115891eda4
begin
	confirmed=data_4[:,:dailyconfirmed]
	deceased=data_4[:,:dailydeceased]
	recovered=data_4[:,:dailyrecovered]
	sum_c=0
	sum_d=0
	sum_r=0
	avg_c=[]
	avg_d=[]
	avg_r=[]
	for i in 1:7
		sum_c+=confirmed[i]
		sum_d+=deceased[i]
		sum_r+=recovered[i]
	end
	push!(avg_c,sum_c/7)
	push!(avg_d,sum_d/7)
	push!(avg_r,sum_r/7)
	for i in 8:398
		sum_c+=confirmed[i]-confirmed[i-7]
		sum_d+=deceased[i]-deceased[i-7]
		sum_r+=recovered[i]-recovered[i-7]
		push!(avg_c,sum_c/7)
		push!(avg_d,sum_d/7)
		push!(avg_r,sum_r/7)
	end
end

# ╔═╡ 6404b490-7dd8-11eb-2d37-350d21c0f2af
begin
	z=plot(data_4[7:398,:dateymd],avg_c,xlabel="Date(YYYY-MM-DD)",ylabel="Moving average of daily confirmed cases",legend=false)
	plot(a,z)
end

# ╔═╡ 65688a50-7dd8-11eb-1dfe-ddd5456c95fb
begin
	e=plot(data_4[7:398,:dateymd],avg_d,xlabel="Date(YYYY-MM-DD)",ylabel="Moving average of daily deceased cases",legend=false)
	plot(b,e)
end

# ╔═╡ 65e3adc0-7dd8-11eb-2658-198f606ec84c
begin
	f=plot(data_4[7:398,:dateymd],avg_r,xlabel="Date(YYYY-MM-DD)",ylabel="Moving average of daily recovered cases",legend=false)
	plot(c,f)
end

# ╔═╡ Cell order:
# ╟─d46d9e50-7dd2-11eb-29af-7b0ce5f1ed4a
# ╠═c7ee6400-7dd4-11eb-2114-f5ddb55cc8e2
# ╠═07123510-7dd2-11eb-3462-9f0439eb4425
# ╠═25ddd030-7dd2-11eb-28e0-853c70587557
# ╟─5da46b40-7dd3-11eb-3a76-edd2506b25e5
# ╠═71e02ae0-7dd3-11eb-2aff-6b1ce6db3c49
# ╠═5b425800-7dd6-11eb-2567-194d488f4c7a
# ╠═99d12ed0-7f01-11eb-34b1-11391c1c8ed6
# ╟─fc822090-7dd3-11eb-2de0-6fa1adcceed1
# ╠═0af7c1c0-7dd4-11eb-248a-a92c1679ad78
# ╠═1143b200-7dd4-11eb-2884-931d36429f6f
# ╠═b727e310-7dd6-11eb-08e0-d5ad84e73ba9
# ╟─ce33b2a0-7dd6-11eb-1e9f-4b5f0dd17c0f
# ╠═65ed1910-7dd7-11eb-3ce3-759deb629281
# ╠═73403340-7dd7-11eb-3e0a-477267e73c76
# ╠═876ab4d0-7dd7-11eb-3e09-256394917dd0
# ╟─d5113f10-7dd7-11eb-0907-cfda8c926f52
# ╠═14cd5120-7dd8-11eb-1b44-679c746fd486
# ╠═2a693d02-7dd8-11eb-2a76-cf29e56e7726
# ╠═2c99ffb0-7dd8-11eb-1c13-9d06e3e5f1a6
# ╠═4e1c0840-7dd8-11eb-3a3b-39115891eda4
# ╠═6404b490-7dd8-11eb-2d37-350d21c0f2af
# ╠═65688a50-7dd8-11eb-1dfe-ddd5456c95fb
# ╠═65e3adc0-7dd8-11eb-2658-198f606ec84c
