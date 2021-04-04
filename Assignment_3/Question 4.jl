#This question is coded in VS Code. It doesn't require pluto
using Distributions
using Plots
pyplot()
using Random

ans=[]
for _ in 1:10000
    temp=rand(Uniform(0,1),30)
    push!(ans,maximum(temp)-minimum(temp))
end
histogram(ans,xlabel="range",ylabel="count",label="count of ranges",color="yellow",bin=100)
function calculate_mean(ans)
    bin=100
    arr=[]
    for i in 1:bin
        count=0
        for j in 1:length(ans)
            if ans[j]>= (i-1)*1/bin 
                if ans[j]<=(i)*1/bin
                    count+=1
                end
            end
        end
        for _ in 1:count
            push!(arr,i/bin)
        end
    end
    return mean(arr)
end
vline!([calculate_mean(ans)],label="Mean",color="green",line=3)
function calculate_median(ans)
    bin=100
    arr=[]
    for i in 1:bin
        count=0
        for j in 1:length(ans)
            if ans[j]>= (i-1)*1/bin 
                if ans[j]<=(i)*1/bin
                    count+=1
                end
            end
        end
        for _ in 1:count
            push!(arr,i/bin)
        end
    end
    return median(arr)
end
vline!([calculate_median(ans)],label="Median",color="red",line=3)
function calculate_mode(ans)
    bin=100
    arr=[]
    for i in 1:bin
        count=0
        for j in 1:length(ans)
            if ans[j]>= (i-1)*1/bin 
                if ans[j]<=(i)*1/bin
                    count+=1
                end
            end
        end
        for _ in 1:count
            push!(arr,i/bin)
        end
    end
    return mode(arr)
end

vline!([calculate_mode(ans)],label="Mode",color="blue",line=3)