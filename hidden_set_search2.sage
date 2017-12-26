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
		for i in range(0, self.numberOfPoints):
			listOfPoints.append(Point(randint(0, self.p), randint(0, self.p)))
	
		return listOfPoints
		
	def generatePointsWithFunction(self, listOfGivenPoints = None):
		listOfPoints = list()
		
		
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
			x = randint(0, self.p)
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
	
	result = (R(p2) - R(p1))/(R(xn) - R(x1))
	#print "Result: ", result
	
	return result

def main():

	pointsToGenerate = 6
	prime = next_prime(2^17)
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
	#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
	
	pg = PointsGenerator(pointsToGenerate, prime, f)
	listOfPoints = pg.generatePointsWithFunction(listOfGivenPoints)
	
	print f
	
	lMan = ListManager()
	lMan.initializeNList(listOfPoints)
	lMan.initializeDifDevList(listOfPoints)
	
	combinations = Combinations(listOfPoints)
	combList = combinations.list()
	
	R = IntegerModRing(prime)
	
	for i in range (0, combinations.cardinality()):
		n = len(combinations[i])
		if n >= 2:
			
			#imprimir pontos que foram combinados
			#for j in range(0, len(combList[i])):
				#print "x", j, ": ", (combList[i])[j].x
			
			N1 = lMan.loadN( (combList[i])[:(n-1)] )
			#print "N1 = ", N1
			
			p2 = lMan.loadDifDev( (combList[i]) [1:] )
			#print "p2 = ", p2
			
			p1 = lMan.loadDifDev( (combList[i]) [:(n-1)] )
			#print "p1 = ", p1
			
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
			
			if( str(N) in secrets ):
				secrets[str(N)] += 1
			else:
				secrets[str(N)] = 1
			
				
	for key in secrets:
		
		if (secrets[key] != 1 and int(key) == f[0]):
			print key, "(HIDDEN SET FOUND) : ", secrets[key]
		elif(secrets[key] != 1):
			print key, " : ", secrets[key]
	#print secrets
			
	
main()








