from sage.all import *

def function_to_test(secret):

	prime = next_prime(20)
	#file = open(file_string, "a")
	R.<x> = PolynomialRing(GF(prime), 'x')
	contador = 0
	#print(list_values)
	for i in range(0, prime):
		for j in range(0, prime):
			for k in range (0, prime):
				for l in range(0, prime):
			
					#f = j*x^3 + k*x^2 + l*x + secret
					f = x^5
					file = open("poly/"+ str(f), "a")
					#print(f)
					
					listOfPoints = list()
					for m in range(0, prime):
						listOfPoints.append(m)
					
					#listOfPoints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
					
					

					combinations = Combinations(listOfPoints)
					combList = combinations.list()
					for m in range(0, len(combList)):
						if(len(combList[m]) < 20 and len(combList[m]) > 0):
						#if(len(combList[m]) == 6):
							list_of_evaluations = list()
							list_values = combList[m]
							for n in range(0, len(list_values)):
								minor_list = list()
								minor_list.append(list_values[n])
								minor_list.append(f(list_values[n]))
								list_of_evaluations.append(minor_list)
								
							g = R.lagrange_polynomial(list_of_evaluations)
							#print(g)
							if(g[0] == secret):
								file.write(str(combList[m]))
								file.write("    :   Polynom - ")
								file.write(str(g))
								file.write("\n")
								#print("hidden set found!!!")
					file.close()
					print(f)

def main():

	for j in range(0, 11):
		function_to_test(j)
	prime = 11
	R.<x> = PolynomialRing(GF(prime), 'x')
	f = x^4
	#g = 7*x^2 + 5*x
	#fg = f - (g)
	#gcd(f, x^p - x)
	#fg_gcd = fg.gcd(x^prime - x)
	#print ("fg_gcd: ", fg_gcd)
	#print fg_gcd.degree()
	
	#print f.roots()
	#w = R.lagrange_polynomial([(1, f(1)), (10, f(10))])
	w = x
	print ("W: ", w)
	fw = f - (w)
	print fw
	print fw.roots()
	fw_gcd = fw.gcd(x^prime - x)
	print ("gcd: ")
	print fw_gcd.degree()

main()