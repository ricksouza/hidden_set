def main():

	prime = 3
	R.<x> = PolynomialRing(GF(prime), 'x')
	
	#f = x^3+2*x^2+4*x+4
	
	#print f(1)
	#print f(2)
	
	g = R.lagrange_polynomial([(1, 1),(0, 1)]);
	print g
	
	R = IntegerModRing(prime)
	
	result = R(R(2)/R(2))
	
	print result

main()