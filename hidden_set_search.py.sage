from sage.all import *

class Point:

	def __init__(self, x, y):
		self.x = int(x)
		self.y = int(y)
		
class PointsGenerator:
		
	def __init__(self, numberOfPoints, p, f = None):
		self.numberOfPoints = numberOfPoints
		self.p = p
		self.f = f
		
	def generatePoints(self):
		listOfPoints = list()
		
		for i in range (0, self.numberOfPoints):
		
			x = i+1
			print x
			gp = Point(x, self.f(x))
			listOfPoints.append(gp)
		return listOfPoints
		
	def generateRandomPoints(self):
		listOfPoints = list()
		for i in range(0, self.numberOfPoints):
			listOfPoints.append(Point(randint(0, self.p), randint(0, self.p)))
	
		return listOfPoints
		
	def generateRandomPointsWithFunction(self, listOfGivenPoints = None):
		listOfPoints = list()
		auxListX = list()
		
		
		if(listOfGivenPoints != None):
			for i in range(0, len(listOfGivenPoints)):
				x = listOfGivenPoints[i]
				y = self.f(x)
				gp = Point(x, y)
				listOfPoints.append(gp)
				
		if(listOfGivenPoints != None):
			numberOfPointsToGenerate = self.numberOfPoints - len(listOfGivenPoints)
		else:
			numberOfPointsToGenerate = self.numberOfPoints
		
		for i in range(0, numberOfPointsToGenerate):
		
			oldPoint = true
			while(oldPoint):
				x = randint(1, self.p - 1)
				#print x
				if (x not in auxListX):
					oldPoint = false
					auxListX.append(x)
					
					
			#x = randint(0, self.p - 1)
			y = self.f(x)
			gp = Point(x, y)
			listOfPoints.append(gp)
	
		return listOfPoints
		
class ListManager:

	def __init__(self):
		self.nList = dict()
		self.difDevList = dict()
		
	def initializeNList(self, listOfPoints):
		for i in range(0, len(listOfPoints)):
			key = listOfPoints[i].x
			value = listOfPoints[i].y
			self.nList[str(key)] = value
	
	def initializeDifDevList(self, listOfPoints):
		for i in range(0, len(listOfPoints)):
			key = listOfPoints[i].x
			value = listOfPoints[i].y
			self.difDevList[str(key)] = value
			
	def loadN(self, keyList):
		keyListLen = len(keyList)
		finalKey = ""
		
		for i in range(0, keyListLen):
			finalKey = finalKey + str(keyList[i].x)
		
		return int(self.nList[finalKey])
		
	def loadDifDev(self, keyList):
		keyListLen = len(keyList)
		finalKey = ""
		
		for i in range(0, keyListLen):
			finalKey = finalKey + str(keyList[i].x)
		
		return int(self.difDevList[finalKey])
		
	def storeDifDiv(self, difDev, keyList):
	
		keyListLen = len(keyList)
		finalKey = ""
		
		for i in range(0, keyListLen):
			finalKey = finalKey + str(keyList[i].x)
			
		self.difDevList[finalKey] = difDev
		
	def storeN(self, N, keyList):
	
		keyListLen = len(keyList)
		finalKey = ""
		
		for i in range(0, keyListLen):
			finalKey = finalKey + str(keyList[i].x)
			
		self.nList[finalKey] = N
		

		
def difDivCalculator(P, p2, p1, xn, x1):
	
	R = IntegerModRing(P)
	
	#print "P2: ", R(p2), " P1: ", R(p1), " XN: ", R(xn), " X1: ", R(x1)
	
	result = (R(p2) - R(p1))/(R(xn) - R(x1))
	#print "Result: ", result
	
	return result
	
class OrthogonalArrayCreator:

	def __init__(self, prime, f):
		self.prime = prime
		self.f = f
		
	def generateOrthogonalArray2(self):
		list = sage.combinat.designs.orthogonal_arrays.orthogonal_array(4, 5, 4)
		
		for i in range (0, len(list)):
			print list[i]
		
	def generateOrthogonalArray(self):
		for i in range (0, self.prime):
			for j in range (0, self.prime):
				if (j != i):
					for k in range (0, self.prime):
						if (k != j and k != i):
							for l in range (0, self.prime):
								if (l != k and l != j and l != i):
									
						
									R.<x> = PolynomialRing(GF(self.prime), 'x')
									print self.f(i), self.f(j), self.f(k), self.f(l)
									g = R.lagrange_polynomial( [ (i, self.f(i)), (j, self.f(j)), (k, self.f(k)), (l, self.f(l))  ]  );
									#print g
						

def findHiddenSet():

	pointsToGenerate = 8
	prime = next_prime(100)
	threshold = 4
	
	
	
	secrets = dict()
	
	#Gerar pontos com esse polinomio: 
	
	#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
	#Gerar polinomio aleatorio
	R.<x> = PolynomialRing(GF(prime), 'x')
	f = GF(prime)['x'].random_element(threshold-1)
	listOfGivenPoints = None
	#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#

	
	#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
	#Polinomio especifico
	#R.<x> = PolynomialRing(GF(prime), 'x')
	#f = 130*x^5 + 212*x^4 + 556*x^3 + 118*x^2 + 219*x + 334
	#listOfGivenPoints = [654, 704]
	#f = x^4
	#f = x^3 + 2*x^2 + 4*x + 4
	#listOfGivenPoints = [1, 3]
	#listOfGivenPoints = None
	#f = 729*x^4 + 69*x^3 + 66*x^2 + 778*x + 525
	#listOfGivenPoints = [190, 708]
	#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
	
	#oag = OrthogonalArrayCreator(prime, f)
	#oag.generateOrthogonalArray()
	
	pg = PointsGenerator(pointsToGenerate, prime, f)
	#listOfPoints = pg.generatePoints()
	listOfPoints = pg.generateRandomPointsWithFunction(listOfGivenPoints)
	
	#print "Lista de Pontos: "
	for i in range (0, len(listOfPoints)):
		print (listOfPoints[i]).x
	
	print "Polinomio original", f
	
	lMan = ListManager()
	lMan.initializeNList(listOfPoints)
	lMan.initializeDifDevList(listOfPoints)
	
	combinations = Combinations(listOfPoints)
	combList = combinations.list()
	
	R = IntegerModRing(prime)
	
	hiddenSetCounter = 0
	
	for i in range (0, combinations.cardinality() - 1):
		n = len(combinations[i])
		if n >= 2:
			
			list_of_points_and_evaluations = list()
			
			#imprimir pontos que foram combinados
			for j in range(0, len(combList[i])):
				#print "x", j, ": ", (combList[i])[j].x
				list_p = list()
				list_p.append((combList[i])[j].x)
				list_p.append(f((combList[i])[j].x))
				#Criar uma mini lista com x e y
				# Adicionar cada um em uma nova lista
				list_of_points_and_evaluations.append(list_p)
			
			N1 = lMan.loadN( (combList[i])[:(n-1)] )
			#print "N1 = ", N1
			
			p2 = lMan.loadDifDev( (combList[i]) [1:] )
			#print "p2 = ", p2
			
			p1 = lMan.loadDifDev( (combList[i]) [:(n-1)] )
			#print "p1 = ", p1
			
			#print "lista de combinacoes:"
			#for u in range (0, len(combList[i])):
			#	print (combList[i])[u].x
			
			#print combList[i]
			xn = (combList[i])[n-1].x
			#print "xn = ", xn
			x1 = (combList[i])[0].x
			#print "x1 = ", x1
			
			difDiv = difDivCalculator(prime, p2, p1, xn, x1)
			
			lMan.storeDifDiv( difDiv, (combList[i]) )
			#Fazer N2
			combAux = 1
			
			for j in range(0, len(combList[i]) - 1):
				combAux = R(combAux) * R((0 - (combList[i])[j].x))
			#print "combAux = ", combAux
			N2 = R(difDiv) * R(combAux)
			#print "N2 = ", N2
			#Fazer N
			N = R(N1) + R(N2)
			#print "N >>>>>>>>>>>>>>>>= ", N
			
			#Guardar N
			lMan.storeN(N, (combinations[i]) )
			#Guardar Polinomios
			
			if(N == f[0]):
				print "Hidden Set Found!!!!!!!"
				hiddenSetCounter += 1
				#combList[i]
				R.<x> = PolynomialRing(GF(prime), 'x')
				g = R.lagrange_polynomial(list_of_points_and_evaluations);
				print "polinomio: ", g
				
				
				for j in range(0, len(combList[i])):
					print "x", j, ": ", (combList[i])[j].x
					
			
			if( str(N) in secrets ):
				secrets[str(N)] += 1
			else:
				secrets[str(N)] = 1		
				
	return hiddenSetCounter			
	#for key in secrets:
		
	#	if (secrets[key] != 1 and int(key) == f[0]):
	#		print key, "(HIDDEN SET FOUND) : ", secrets[key]
	#	elif(secrets[key] != 1):
	#		print key, " : ", secrets[key]
	#print secrets
	
def print_values(list_values, file_string, secret):
	
	prime = 11
	#file = open(file_string, "a")
	R.<x> = PolynomialRing(GF(prime), 'x')
	contador = 0
	#print(list_values)
	list_final_value = list()
	
	for i in range(1, prime):
		for j in range(0, prime):
			for k in range (0, prime):
				for l in range(0, prime):
			
					f = i*x^4 + j*x^3 + k*x^2 + l*x + secret
					#print f
					list_of_evaluations = list()
					for l in range(0, len(list_values)):
						minor_list = list()
						minor_list.append(list_values[l])
						minor_list.append(f(list_values[l]))
						list_of_evaluations.append(minor_list)
				
					#print "f: ", f
					#print list_of_evaluations
					g = R.lagrange_polynomial(list_of_evaluations)
					
					list_final_value.append(g[0])
					
					#print "polinomio: ", g
					#file.write(str(g[0]))
					#file.write(str(list_values))
					#file.write("   :   ")
					#file.write("f(x): "+ str(f))
					#file.write("   :   ")
					#file.write("g(x): "+ str(g))
					
					#if(g[0] == secret):
					#	contador += 1
					#	file.write(" -  Hidden Set Found!!!!")
					#file.write("\n")
					
	#t[str(list_values)] = list_final_value
	#t.write(sys.stdout, format='ascii')
	#file.write("Quantidade de Hidden Sets: %s, " % contador)
	#file.close()
	#print("Hidden sets: %s para o segredo %s" % (contador, secret))
	#print "contador: ", contador
	
def main():
	
	print "Tentando encontrar hidden sets. >>>>>>>>>************************>>>>>>>>>>>>>>>>>>"
	hiddenSetCounter = 0
	
	for i in range (0, 1):
		hiddenSetCounter = hiddenSetCounter + findHiddenSet()
	

	#listOfPoints = [1, 2, 3, 4, 6, 7, 8, 9, 10]

	#combinations = Combinations(listOfPoints)
	#combList = combinations.list()
	
	#print(len(combList))
	
	#for j in range(0, 11):
	#	for i in range(0, len(combList)):
			#if(len(combList[i]) < 4 and len(combList[i]) > 1):
	#		if(len(combList[i]) == 3):
	#			print combList[i]
	#			nomeArquivo = "%s.txt" % combList[i]
				
	#			print_values(combList[i], nomeArquivo, j)
					
	
	
	#prime = 7
	#R.<x> = PolynomialRing(GF(prime), 'x')
	
	#f = x^3+2*x^2+4*x+4
	
	#print f(1)
	#print f(2)
	
	#g = R.lagrange_polynomial([(1, 6),(2, 4)]);
	#print g
	

	
	print "Hidden Sets Found: ", hiddenSetCounter		
	
main()