from sage.all import *

def genShares(self, shareList, pointsToEval, prime):


	for i in range (0, pointsToEval):
	
		pointList = list()
		
		r = randint(0, prime)
		e = randint(0, prime)
		
		pointList.append(r)
		pointList.append(e)
		print pointList
		
		shareList.append(pointList)
	
	return shareList
	
def evalPoints(self, shareList, h, pointsToEval, prime):
	for i in range (0, pointsToEval):
	
		x = randint(0, prime)
		y = h(x)
		
		pointList = list()
		
		pointList.append(x)
		pointList.append(y)
		
		shareList.append(pointList)
	
	return shareList

def main():

	prime = 1009

	w = 2
	t = 4
	n = 4
	k = randint(0, prime)

	shareList = list()
	pointsToEval = w - 1
	
	shareList = genShares(shareList, pointsToEval, prime)
	
	pointList = list()
	pointList.append(0)
	pointList.append(k)
	
	print pointList
	
	shareList.append(pointList)
	
	R.<x> = PolynomialRing(GF(prime), 'x')
	#print shareList
	f = R.lagrange_polynomial(shareList);
	
	print f
	
	shareList = evalPoints(shareList, f, 1, prime)
	print "Hidden Sets: ", shareList
	
	pointsToEval = t - w
	
	shareList = genShares(shareList, pointsToEval, prime)
	
	g = R.lagrange_polynomial(shareList);
	
	shareList = evalPoints(shareList, g, n-t, prime)
	
	print shareList
	print g

main()