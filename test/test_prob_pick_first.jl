using SymbolicRegression, Test

n = 10

options = Options(
    binary_operators=(+, -, *, /),
    unary_operators=(cos, sin),
    probPickFirst=0.999,
)
members = PopMember{Float32}[]

# Generate members with scores from 0 to 1:
for i=1:n
    tree = Node("x1") * 3.2f0
    score = Float32(i-1)/(n-1)
    push!(members, PopMember(tree, score))
end

pop = Population(members, n)

best_pop_member = [
    SymbolicRegression.bestOfSample(pop, options).score
    for j=1:100
]

mean_value = sum(best_pop_member)/length(best_pop_member)

# Make sure average score is small
@test mean_value < 0.1