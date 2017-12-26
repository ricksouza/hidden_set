from sage.all import *
import itertools

def main():

	t = 5
	n = 8
	prime = next_prime(11)
	
	R.<x> = PolynomialRing(GF(prime), 'x')
	
	list_of_values = range(0, prime)
	print(list_of_values)
	#Polinomios
	#list_coef_comb = list(itertools.combinations_with_replacement(list_of_values, 2))
	#print(len(list_coef_comb))
	#print(list_coef_comb)
	
	list_coef_comb = [p for p in itertools.product(list_of_values, repeat=t)]
	#print(list_coef_comb)
	print(len(list_coef_comb))
	list_hidden_set = list()
	entropy = 0
	entropy_2 = 0
	entropy_3 = 0
	
	#pontos
	#combinations = Combinations(list_of_values, 2)
	#point_comb_list = combinations.list()
	#print(combinations.list())
	
	new_orthogonal_array =list()
	
	for i in range (0, len(list_coef_comb)):
		coef_len = len(list_coef_comb[i])
		coef = list_coef_comb[i]
		#print(coef)
		f = 0
		for j in range (0, coef_len):
			#print(coef[j])
			f = f + coef[j]*x^j
		#*****************************************
		#print("Funcao f: ", f)
		#print("Avaliado em 2: ", f(2))
		#print("Avaliado em 9: ", f(9))
		#hidden set: [[2, 7], [9, 12]]
		
		if(f(2) == 7 and f(9) == 12):
			entropy += 1
			#print(f(3)) = 6
			#print(f(1)) = 11
			
		#print(entropy)
		
		g = R.lagrange_polynomial([(2, f(2)),(9, f(9))])
		if(g[0] == f[0]):
			new_orthogonal_array.append(f)
		
	for i in range (0, len(new_orthogonal_array)):
		f = new_orthogonal_array[i]
		print(f)
		if(f(2) == 7 and f(9) == 12):
			entropy_2 += 1
			#print(f)
		if(f(2) == 7 and f(9) == 12 and f(1) == 11):
			entropy_3 += 1
			#print(f)
		
		
	print("Linhas no orthogonal array normal: ", len(list_coef_comb))
	print("Entropia para 2 pontos no array normal: ", entropy)
	print("Linhas no orthogonal array alterado: ", len(new_orthogonal_array))
	print("Entropia para 2 pontos no  array alterado: ", entropy_2)
	print("Entropia para 3 pontos no  array alterado: ", entropy_3)
		#*****************************************
		#print(f)
		#list_lpe = list()
		#for k in range (2, t):
		#	list_of_values_without_zero = range(1, prime)
		#	comb = Combinations(list_of_values_without_zero, k)
			#print(comb.list())
			
		#	comb_list = comb.list()
			
			
			#for l in range (0, len(comb_list)):
			
			#	comb_item = comb_list[l]
				
			#	list_of_points_and_eval = list()
			#	for m in range(0, len(comb_item)):
				
			#		point_eval = list()
			#		point_eval.append(comb_item[m])
			#		point_eval.append(f(comb_item[m]))
					#print(point_eval)
			#		list_of_points_and_eval.append(point_eval)
			#	list_lpe.append(list_of_points_and_eval)
				
		#print(list_lpe)
		
		#for k in range(0, len(list_lpe)):
		
			#	g = R.lagrange_polynomial(list_lpe[k])
				#print(g)
				
			#	if(g[0] == f[0] and len(list_lpe[k]) == 2 and len(list_hidden_set) == 0
			#		and f != 0 and g != 0 and f[2] != 0):
					
			#		print("*************************")
			#		print(len(list_hidden_set))
			#		print("Function f: ", f)
			#		print("Function g: ", g)
			#		print("List of points and eval: ", list_lpe[k])
			#		list_hidden_set = list_lpe[k]
			#		print(list_hidden_set)
			#		print("*************************")
					
				#elif(len(list_of_points_and_eval) > 2):
				#else:
				#	aux = true
				#	for o in range(0, len(list_hidden_set)):
						#print(list_hidden_set[o])
						#print(list_of_points_and_eval)
				#		aux = aux & (list_hidden_set[o] in list_lpe[k])
						#print(aux)
						
				#	if(len(list_hidden_set) != 0):
				#		g = R.lagrange_polynomial(list_lpe[k])
				#		if(aux == True):
				#			entropy+=1
				#			print("*******************")
				#			print(entropy)
				#			print("Funcao g: ", g)
				#			print("Funcao f: ", f)
				#			print(list_hidden_set)
				#			print(list_lpe[k])
				#			#print(aux)
				#			print("*******************")
							
				#elif(list_hidden_set in list_of_points_and_eval):
				#	print(list_of_points_and_eval)
				#	print(list_hidden_set)
	

main()