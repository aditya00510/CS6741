### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ b7217e88-8099-11eb-0b13-bd944f6f0ca9
begin
	using Distributions
	using Random
	using Plots
	using PlutoUI
	pyplot()
	Random.seed!(0)
end

# ╔═╡ 3b240426-8095-11eb-00e9-db9fdfd20ab9
md"""
# Q1
(1 point) A popular law called the law of large numbers describes the result of performing the same experiment a large number of times. 

Consider the specific experiment of choosing a random integer and summing it with all previously chosen integers. Divide this sum by the number of samples to get the sample mean. By writing Julia code, demonstrate to yourself that this mean tends to 0 as we increase the number of chosen numbers. 

"""

# ╔═╡ 1f1d789a-8098-11eb-1084-fd85dc69f7d9
begin
	max_magnitude = 10000
	num_picks = 100000
	running_total = 0
	averages = []

	for pick in 1:num_picks
		running_total = running_total + rand(-max_magnitude:max_magnitude)
		push!(averages, running_total / pick)
	end
	plot(averages, xlabel="number of trials", ylabel="mean", legend=false)
end

# ╔═╡ 1ec3b3c8-8098-11eb-1fa6-27ac3e8f93c1
md"""
Alternatively, could directly use
```julia
cumsum(rand(-max_magnitude:max_magnitude, num_picks))
```
"""

# ╔═╡ 1ea5a3a6-8098-11eb-342b-3fb1cb1fed85
md"""
# Q2
(1 point) Consider a usual pack of playing cards. 

We are interested in computing the probability of picking n Jacks (of any suit) when drawing 5 random cards in two cases: (a) without replacement where a drawn card is not put back into the deck, and (b) with replacement where a drawn card is again put back into the deck.

Write Julia code to compute this (experimentally) and report the probabilities for different values n.
"""

# ╔═╡ 16c0722a-809c-11eb-1a0b-65bd60f66524
# without replacement
begin
	sample_size = 1000000
	without_repl_exp = [0,0,0,0,0,0]
	for _ in 1:sample_size
		deck = [0:51;]
		picked = []
		for i in 1:5
			cur = rand(deck)
			push!(picked, cur)
			deleteat!(deck, findfirst(x -> x==cur, deck))
		end
		num_jacks = sum((picked.%13) .== 10)
		without_repl_exp[num_jacks+1] += 1
	end
	without_repl_exp /= sample_size
	without_repl_exp
end

# ╔═╡ f10c2d3c-809c-11eb-0af6-69eb6d6af31c
# with replacement
begin
	with_repl_exp = [0,0,0,0,0,0]
	for _ in 1:sample_size
		picked = rand(0:51,5)
		num_jacks = sum((picked.%13) .== 10)
		with_repl_exp[num_jacks+1] += 1
	end
	with_repl_exp /= sample_size
	with_repl_exp
end

# ╔═╡ 4887897a-809e-11eb-374d-c19f0880b728
begin
   x = 0:5; # 2 columns means two lines
   p = plot(x, without_repl_exp, label = "without replacement")
   plot!(p, x, with_repl_exp, label = "with replacement")
   xlabel!("number of jacks")
   ylabel!("probability")
end

# ╔═╡ 1e69e83e-8098-11eb-1e36-67cb4bc25553
md"""
Alternatively, could directly use
```julia
sample(1:52, 5, replace = false)  
sample(1:52, 5, replace = true)
```
"""

# ╔═╡ 50c7b6ce-8095-11eb-01ea-894aa9c3477e
md"""
# Q3
(1 point) Let us continue with the previous question. Instead of running experiments, we would like to theoretically compute the probabilities. 


Go through the popular probability distributions and identify the ones that correspond to the two cases in the previous question. Then compare the values you got from your experiments with the theoretical ones. Are your results similar?
"""

# ╔═╡ 29b98340-809b-11eb-3055-455c608a9861
# without replacement - HYPERGEOMETRIC DISTRIBUTION
# Total Num of Elements = 52
# Num of Desired Elements = 4
# Num of Trials = 5
without_repl_th = [binomial(4,i) * binomial(48,5-i) / binomial(52,5) for i in 0:5]

# ╔═╡ 8e6ce3e0-80a0-11eb-2393-f346a3bcdc6a
without_repl_err = abs.(without_repl_th - without_repl_exp)

# ╔═╡ 5347cd08-809f-11eb-16e5-eb5c43cf2ec5
# with replacement - BINOMIAL DISTRIBUTION
# Num Trials = 5
# Probability of Success in Each Trial = 4/52
with_repl_th = [binomial(5,i) * (4/52)^i * (48/52)^(5-i) for i in 0:5]

# ╔═╡ c994ae76-80a0-11eb-0c8d-8bf4e7834b38
with_repl_err = abs.(with_repl_th - with_repl_exp)

# ╔═╡ 2e0f92ae-8098-11eb-3698-99c40379fda6
md"""
Alternatively, could directly use
```julia
Hypergeometric(4, 48, 5)
Binomial(5, 4/52)
```
"""

# ╔═╡ 2df80eac-8098-11eb-31c9-3b7f423c9caf
md"""
# Q4
(1 point) For this and the next question, we will setup an elaborate cybersecurity 🔐 context.

Consider a plain-text authentication system where a password has to be 8 characters and can comprise of alphabets (both lower and upper case), numericals (0 to 9) and special characters (16 options ~ ! @ # $ % ^ & * ( ) _ + = - `). Every time a password is entered on a login website, it gets stored in a database if at least two characters in the entered password are exactly the same (position and value) as the actual password.

If a hacker was to randomly try out different passwords, then (a) compute the probability of a password getting stored in the database using simple probability theory, and (b) confirm it with experiments in Julia.
"""

# ╔═╡ 2ddf56c8-8098-11eb-0baa-e32da74a464e
md"""
### (a)
The given setup is a binomial distribution with 8 independent trials (i.e. each position is an independent trial).

Let X, a random variable, be the number of characters that match. So,
$P(X>=k) = \sum_{k=2}^8 \binom{8}{k} (p)^k * (1-p)^{8-k}$
Since we have 78 independent characters, so $p = \frac{1}{78}$

We want $P(X>=2)$,

$P(X>=2) = 1 - [P(X=0) + P(X=1)]$

$= 1 - [\binom{8}{0} \frac{77}{78})^8 + \binom{8}{1} (\frac{1}{78})(\frac{77}{78})^7]$

$= 1 - [0.901922 + 0.093706] = 0.004371818$
"""

# ╔═╡ 2dc839e8-8098-11eb-1a7f-a9dcfec74814
md"""
### (b)
Since all characters are independent, we shall denote them with numbers by 1-78
"""

# ╔═╡ e89d03fc-81b0-11eb-187d-a3331878e1b8
#denote characters by 1-78
function generateRandomPassword(length)
	return [rand(1:78) for _ in 1:length]
end

# ╔═╡ 9c2dd9e8-81b1-11eb-1a70-a1cc5c7f5d4b
userPassword = generateRandomPassword(8)
## Common mistake:
## the userPassword must be generated randomly
## this carries 0.25/1 marks

# ╔═╡ ca61f618-81b5-11eb-0a08-6f1bd2cb4cbd
begin
	numIterations = 1e6
	matchThreshold = 2
	numMatchSuccess = float(0)
end

# ╔═╡ d43e55c6-81b0-11eb-06a5-0d172fb305f7
begin
	for _ in 1:numIterations
		randomPassword = generateRandomPassword(8)

		numMatches = sum(userPassword .== randomPassword)

		if numMatches >= matchThreshold
			numMatchSuccess += 1
		end
	end
	experimentalProb = numMatchSuccess/numIterations
end

# ╔═╡ 2daf4cda-8098-11eb-2ca5-1bb989465385
md"""
# Q5
(1 point) Storing the attempts made into a database itself is also a security threat. Why? Many random password tries may overload the database and crash the authentication system. Given this system constraint, we would like to redesign our password check.

Suppose we do not want to store more than 1,000 entries in the database when a million random password attempts are made by a hacker, how should you change the rule in the previous question of the password storage in the database. In the answer, first argue what you are doing, then write the Julia code that helps you figure out the new rule.
"""

# ╔═╡ 2d984a9e-8098-11eb-08ba-7fbe44f53ce6
md"""
### Solution
The question specifies that we need to change the method of password storage, not of probability calculation. So, rather than stopping the storage of attempts when count crosses 1000, we must change the rule such that the probability of storage decreases.

The idea is to increase the minimum number of characters that need to be matched until the associated probability drops below 0.001.

Borrowing from Q4's answer, theoretically $P(X>=2) = 0.004371818$.

We now try to increase the number of matching characters, from 2 to 3, and let us compute its theorectical probability.

$P(X>=3) = P(X>=2) - P(X=2)$
$= 0.004371818 - \binom{8}{2} (\frac{1}{78})^2(\frac{77}{78})^6$
$= 0.000112$

Since, this is less than 0.001, this modification should work
"""

# ╔═╡ 2d80e462-8098-11eb-3dad-bdd5a09e4563
# theoretical computation
begin
	q5_p = 1/78
	[sum([binomial(8,k) * (q5_p)^k * (1-q5_p)^(8-k) for k in minMatchingChars:8]) for minMatchingChars in 1:8]
end

# ╔═╡ 2d6ac7f4-8098-11eb-3333-2d5ff6063123
md"""
# Q6
(2 points + 2 bonus points) Let us talk now about stock markets, which many would (and some rich people would disagree) is a game of chance. 

You start with Rs 10 and play an investment game for 20 days wherein each day you may lose Re 1 with a probability of p or gain Re 1 with a probability of 1 - p.  

What is the probability that at the end of 20 days, you have at least Rs 10 with you? Notice that we have not specified p, and hence you are required to compute the probability for a range of values of p. You can also attempt a symbolic answer in terms of p for a bonus of 2 marks 🥇🥇.

If you think about this problem carefully, you will have a doubt: What happens if you went bankrupt in between (i.e., you had lost all your Rs 10)? For this question, assume that you can continue to play the game even if you are bankrupt. 

"""

# ╔═╡ 2d3834ec-8098-11eb-1893-310a0636bd70
#experimental computation
begin
	Random.seed!(123)
	p_range = [i/10 for i in  0:10]
	n_games = 20
	n_runs = 10^6
	winning_value = 10
	losing_return = 1
	winning_return = 1
	probability_array = []
	for p in p_range
    	success_count = 0
    	for run in 1:n_runs 
        	current_money = 10
        	for game in 1:n_games
            	current_draw = rand(1:10)
            	if ( current_draw > 10*p)
            		current_money += winning_return
            	else current_money -= losing_return          
            	end          
        	end
        	if (current_money >= winning_value)
            	success_count +=1 
        	end
    	end
    	push!(probability_array ,success_count/n_runs)
	end
	 probability_array
end

# ╔═╡ 5377ebb2-81cd-11eb-268a-75e2e41d5bc6
#theoretical computation
begin
	p_comp = []
	for k in 0.0:0.1:1.0
		tot_prob = 0
		for i in 10:20
			tot_prob += binomial(20,i)*((1-k)^i)*(k^(20-i))
		end
		push!(p_comp,tot_prob)
	end
	p_comp
end

# ╔═╡ 68a842b2-81cc-11eb-1d8b-61cd32cd8c57
begin
	plot(0:0.1:1,probability_array, line= 6, color=:blue, title="Q-6", label="experimental result", xlabel="probability of losing = p", ylabel="probability of having at\nleast 10 rupees at last")
	plot!(0:0.1:1,p_comp, line=2,title="Q-6", label="theoretical result")
end

# ╔═╡ d2c603e4-81ce-11eb-1510-679dddc76f0a
md"the theoretical results matches with the experimental one"

# ╔═╡ 72191c5e-81cc-11eb-015b-37845400c624
md"### Bonus question

Since we start with 10 rupees, we will end up with at least 20 rupees at the end of 20 games if we win at least 10 games.
Let X be the random variable that denotes the number of games I win at the end of 20 games.

Clearly X is a binomial random variable with probability of success as ‘(1-p)’.

Now Required probability is P(X>=10).

P(X>=10)  = 
$
\sum_{i = 10}^{20} \binom{20}{i}(1-p)^i*p^{(20-i)}\\
$

"

# ╔═╡ 2d1fbd18-8098-11eb-2e01-f9efa81b8d51
md"""
# Q7
(1 point) The stock market game is quite a delight for a probability exercise and hence we will continue with it for this and the next question. 

Compute the probability of going bankrupt (at least once). Do this with code in Julia, again showing results for different values of p.
"""

# ╔═╡ 347e930e-8098-11eb-1258-0fd6aa042f69
md"Using seed is crucial for reproducability of experiments, which most of you had missed out on doing.(No marks deducted this time)"

# ╔═╡ 34642ece-8098-11eb-384b-9de43ade45a5
Random.seed!(1)

# ╔═╡ 7efa4ce0-81c7-11eb-2949-8b4c2bfd8963
md"The question asks to compute probability of going bankrupt atleast once. So using Monte Carlo simulations, we count the number of times the player went bankrupt atleast once during the 20 days, amongst the total number of iterations." 

# ╔═╡ 8a0265a0-81c7-11eb-38f1-896d850fc9d5
begin
	probs=[i for i in collect(0:0.1:1)]
	iterations=10^6
	bankrupt_probs=[]
	for p in probs
		num_bankrupt=0
		for i in 1:iterations
			money=10
			for j in 1:20
				if(rand() > p)
					money+=1
				else
					money-=1
				end
				if(money<=0)
					num_bankrupt+=1
					break
				end
			end
		end
		push!(bankrupt_probs,num_bankrupt/iterations)
	end
end

# ╔═╡ 96b5bd60-81c7-11eb-3f15-ddb40e51ab5d
md"In each iteration, we play the game for 20 days. p is the probability of loosing Re 1 and 1-p is the probability of winning. This seemed to be a common mistake in many of the solutions, where p was taken to be the probability of winning Re 1. If we ever go bankrupt during the 20 runs of the game, then that particular iteration is a favourable outcome for the event of going bankrupt atleast once."

# ╔═╡ 80ecffb0-81c8-11eb-2479-df61e1768e9b
probs

# ╔═╡ 830e5910-81c8-11eb-07df-23fe948e4fc5
bankrupt_probs

# ╔═╡ 344739d6-8098-11eb-204c-afb162232330
md"""
# Q8
(2 point) In this last problem of this assignment, let us work out some conditional probability.  

We will combine the settings from Q6 and Q7. Given that you knew that you do not go bankrupt even once, what is the probability that you end up with Rs. 10 or more at the end of 20 days? 

First share your overall idea, then the code snippet which helps you compute this, and finally the answer and how it relates to the answers in the previous two questions

"""

# ╔═╡ 5184b4b8-8095-11eb-39c5-8f77df4fd61f
md"First, let's define the **events** involved.\
Let A = Event that I end up with Rs 10 or more after playing the game for 20 days.\
B = Event that I do not go bankrupt even once while playing the game for 20 days."

# ╔═╡ 503799f4-8095-11eb-3d86-c36a9b0493a0
md"To compute **P(A|B)** = P(A $\cap$ B)/P(B)"

# ╔═╡ 9f0a0b50-81c8-11eb-247c-4deec4d1e739
md"Following the same idea as before of using Monte Carlo simulations, we repeat the 20 days game many times and count the fraction of times we ended up with Rs 10 or more, among the cases when we didn't go bankrupt even once. This is because:"

# ╔═╡ a738c550-81c8-11eb-2885-01eb451d04de
md"**P(A|B)** = (count(A $\cap$ B)/iterations)/(count(B)/iterations)\
 =count(A $\cap$ B)/count(B)"

# ╔═╡ b118d8d0-81c8-11eb-2909-bddc0f9fdba4
begin
	probabs=[i for i in collect(0:0.1:1)]
	simulations=10^6
	conditional_probs=[]
	for p in probs
		num_AandB=0
		num_B=0
		for i in 1:simulations
			flag=0
			money=10
			for j in 1:20
				if(rand() > p)
					money+=1
				else
					money-=1
				end
				if(money<=0)
					flag=1
					break
				end
			end
			if(flag==0)
				num_B+=1
				if(money>=10)
					num_AandB+=1
				end
			end	
		end
		push!(conditional_probs,num_AandB/num_B)
	end
end

# ╔═╡ b6ef4af0-81c8-11eb-243c-fdb8eea506e3
probabs

# ╔═╡ bdebc67e-81c8-11eb-32c7-191bce5131c1
conditional_probs

# ╔═╡ c6dc70f0-81c8-11eb-1dc7-01b57eecbe4f
md"###### Relating to Q6 and Q7"

# ╔═╡ c970fe80-81c8-11eb-2848-bd7627d9ecd5
md"Here, you have to define clearly the realtion of Q8 to Q6 and Q7 in terms of the events.\
Probability of Event A is computed in Q6.\
Probability of complement of event B is computed in Q7.\
**Additional observation**\
We know that:\
A $\cap$ B = A $-$ A $\cap$ B`\
A $\cap$ B` consists of only one outcome: 10 straight losses followed by 10 wins. Other than that, any outcome in A also lies in A $\cap$ B. Hence, we can approximate P(A $\cap$ B) with that of P(A). This can also be verified experimentally."

# ╔═╡ d09f8690-81c8-11eb-3834-538d63e08cd5
begin
	intersection_probs=[]
	for p in probs
		AandB=0
		for i in 1:simulations
			flag=0
			money=10
			for j in 1:20
				if(rand() > p)
					money+=1
				else
					money-=1
				end
				if(money<=0)
					flag=1
					break
				end
			end
			if(flag==0)
				if(money>=10)
					AandB+=1
				end
			end	
		end
		push!(intersection_probs,AandB/simulations)
	end
end

# ╔═╡ d5eec750-81c8-11eb-0752-b9145dce4aa8
intersection_probs

# ╔═╡ df42ee80-81c8-11eb-12fe-95950674ef7a
md"This(P(A $\cap$ B) is approximately equal to the probabilities found in Q6(P(A)). Hence the answer to Q8 can also be found as follows:\
P(A|B) ~ P(A)/P(B) = P(A)/(1-P(B`))\
where P(A) and P(B`) were found in Q6 and Q7 respectively."

# ╔═╡ Cell order:
# ╠═b7217e88-8099-11eb-0b13-bd944f6f0ca9
# ╟─3b240426-8095-11eb-00e9-db9fdfd20ab9
# ╠═1f1d789a-8098-11eb-1084-fd85dc69f7d9
# ╟─1ec3b3c8-8098-11eb-1fa6-27ac3e8f93c1
# ╟─1ea5a3a6-8098-11eb-342b-3fb1cb1fed85
# ╠═16c0722a-809c-11eb-1a0b-65bd60f66524
# ╠═f10c2d3c-809c-11eb-0af6-69eb6d6af31c
# ╠═4887897a-809e-11eb-374d-c19f0880b728
# ╟─1e69e83e-8098-11eb-1e36-67cb4bc25553
# ╟─50c7b6ce-8095-11eb-01ea-894aa9c3477e
# ╠═29b98340-809b-11eb-3055-455c608a9861
# ╠═8e6ce3e0-80a0-11eb-2393-f346a3bcdc6a
# ╠═5347cd08-809f-11eb-16e5-eb5c43cf2ec5
# ╠═c994ae76-80a0-11eb-0c8d-8bf4e7834b38
# ╟─2e0f92ae-8098-11eb-3698-99c40379fda6
# ╟─2df80eac-8098-11eb-31c9-3b7f423c9caf
# ╟─2ddf56c8-8098-11eb-0baa-e32da74a464e
# ╟─2dc839e8-8098-11eb-1a7f-a9dcfec74814
# ╠═e89d03fc-81b0-11eb-187d-a3331878e1b8
# ╠═9c2dd9e8-81b1-11eb-1a70-a1cc5c7f5d4b
# ╠═ca61f618-81b5-11eb-0a08-6f1bd2cb4cbd
# ╠═d43e55c6-81b0-11eb-06a5-0d172fb305f7
# ╟─2daf4cda-8098-11eb-2ca5-1bb989465385
# ╟─2d984a9e-8098-11eb-08ba-7fbe44f53ce6
# ╠═2d80e462-8098-11eb-3dad-bdd5a09e4563
# ╟─2d6ac7f4-8098-11eb-3333-2d5ff6063123
# ╠═2d3834ec-8098-11eb-1893-310a0636bd70
# ╠═5377ebb2-81cd-11eb-268a-75e2e41d5bc6
# ╠═68a842b2-81cc-11eb-1d8b-61cd32cd8c57
# ╟─d2c603e4-81ce-11eb-1510-679dddc76f0a
# ╟─72191c5e-81cc-11eb-015b-37845400c624
# ╟─2d1fbd18-8098-11eb-2e01-f9efa81b8d51
# ╟─347e930e-8098-11eb-1258-0fd6aa042f69
# ╠═34642ece-8098-11eb-384b-9de43ade45a5
# ╟─7efa4ce0-81c7-11eb-2949-8b4c2bfd8963
# ╠═8a0265a0-81c7-11eb-38f1-896d850fc9d5
# ╟─96b5bd60-81c7-11eb-3f15-ddb40e51ab5d
# ╠═80ecffb0-81c8-11eb-2479-df61e1768e9b
# ╠═830e5910-81c8-11eb-07df-23fe948e4fc5
# ╟─344739d6-8098-11eb-204c-afb162232330
# ╟─5184b4b8-8095-11eb-39c5-8f77df4fd61f
# ╟─503799f4-8095-11eb-3d86-c36a9b0493a0
# ╟─9f0a0b50-81c8-11eb-247c-4deec4d1e739
# ╟─a738c550-81c8-11eb-2885-01eb451d04de
# ╠═b118d8d0-81c8-11eb-2909-bddc0f9fdba4
# ╠═b6ef4af0-81c8-11eb-243c-fdb8eea506e3
# ╠═bdebc67e-81c8-11eb-32c7-191bce5131c1
# ╟─c6dc70f0-81c8-11eb-1dc7-01b57eecbe4f
# ╟─c970fe80-81c8-11eb-2848-bd7627d9ecd5
# ╠═d09f8690-81c8-11eb-3834-538d63e08cd5
# ╠═d5eec750-81c8-11eb-0752-b9145dce4aa8
# ╟─df42ee80-81c8-11eb-12fe-95950674ef7a
