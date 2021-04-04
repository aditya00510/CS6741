#This question is coded in VS Code. It doesn't require pluto
using CSV
using Distributions
using StatsBase
using Dates 
using Missings
using Plots
pyplot()
using DataFrames


df=DataFrame(CSV.File("states.csv"))

#inserting week as a seperate column
function Calculate_week(date, start=Date(df[1,:Date]))::Int64
	return ceil((date-start).value/7)+1
end
insertcols!(df,2,:Week=>Calculate_week.(df.Date,df[1,:Date]))

#Calculating stateswise confirmed cases
tempgrp=groupby(df,:State)

function Calculate_confirm(df1)
    Cases=[]
    for i in 1:size(df1,1)
        push!(Cases,0)
    end
    Cases[1]=df1[1,:Confirmed]
    for i in 2:size(df1,1)
        Cases[i]=df1[i,:Confirmed]-df1[i-1,:Confirmed]
    end
    insertcols!(df1,4,:DailyConfirmedCases=>Cases)
end

grp=[]
for i in 1:length(tempgrp)
    push!(grp,Calculate_confirm(copy(tempgrp[i])))
end
updated_df=vcat(grp[1],grp[2],grp[3],grp[4],grp[5],grp[6],grp[7],grp[8],grp[9],grp[10],grp[11],grp[12],grp[13],grp[14],grp[15],grp[16],grp[17],grp[18],grp[19],grp[20],grp[21],grp[22],grp[23],grp[24],grp[25],grp[26],grp[27],grp[28],grp[29],grp[30],grp[31],grp[32],grp[33],grp[34],grp[35],grp[36],grp[37],grp[38])
#println(updated_df)

#Updating the table such that confirmed cases are there in column stateswise
grpsc=groupby(updated_df,[:Week,:State])
dfsc=combine(grpsc,:DailyConfirmedCases=>sum=>"Weekwise New Cases")
dfscStacked = DataFrames.stack(dfsc,Not([:Week,:State]))
dfscunstacked=unstack(dfscStacked,:State,:value)
dfscfinal = select(dfscunstacked,Not(:variable))
dffinal=select(dfscfinal, Not([:Week,:India]))
for col in names(dffinal)
    dffinal[!,col] = Missings.coalesce.(dffinal[!,col], 0)
end

#Computing covaraince, pearson correlation and spearman correlation
function covmat(dffinal)
    n=ncol(dffinal)
    c=rand(n,n)
    for i in 1:n
        for j in 1:n
            col1=dffinal[:,i]
            col2=dffinal[:,j]
            c[i,j]=cov(col1,col2)
        end
    end
    return c
end
covv=covmat(dffinal)
display(heatmap(names(dffinal),names(dffinal),covv))
function correlation(dffinal)
    n=ncol(dffinal)
    c=rand(n,n)
    for i in 1:n
        for j in 1:n
            col1=dffinal[:,i]
            col2=dffinal[:,j]
            c[i,j]=cor(col1,col2)
        end
    end
    return c
end 
corr=correlation(dffinal)
display(heatmap(names(dffinal),names(dffinal),corr))
function spearman(dffinal)
    n=ncol(dffinal)
    c=rand(n,n)
    for i in 1:n
        for j in 1:n
            col1=dffinal[:,i]
            col2=dffinal[:,j]
            c[i,j]=corspearman(col1,col2)
        end
    end
    return c
end
corsp=spearman(dffinal)
display(heatmap(names(dffinal),names(dffinal),corsp))


