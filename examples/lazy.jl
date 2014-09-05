require("../src/quantumoptics.jl")

using quantumoptics

N1 = 2
N2 = 2
N3 = 2^8
N = N1*N2*N3

b1 = GenericBasis([N1])
b2 = GenericBasis([N2])
b3 = GenericBasis([N3])

basis_total = CompositeBasis(b1, b2, b3)

op1 = Operator(b1, rand(N1,N1))
op2 = Operator(b2, rand(N2,N2))

psi = Ket(basis_total, rand(N))
psi2 = Ket(basis_total, rand(N))

l1 = operators_lazy.LazyTensor(basis_total, basis_total, [1], [op1])
l2 = operators_lazy.LazyTensor(basis_total, basis_total, [2], [op2])
l3 = operators_lazy.LazyTensor(basis_total, basis_total, [1,2], [op1,op2])
#println(full(l).data)
#println(tensor(a, identity(basis)).data)

#rho = identity(basis_total)
#rho = tensor(basis_ket(basis, 2), basis_ket(basis,1))
# println("a:")
# println(a.data)
# println("rho:")
# println(rho.data)

# println((l*rho).data)
# println((full(l)*rho).data)
println(vecnorm((l1*psi-full(l1)*psi).data))
println(vecnorm((l2*psi-full(l2)*psi).data))
println(vecnorm((l3*psi-full(l3)*psi).data))

rho = tensor(psi, dagger(psi2))
println(norm((l3*rho-full(l3)*rho).data))

full_l3 = full(l3)

l3*rho
@profile l3*rho
#full_l3*rho
#@time full_l3*rho