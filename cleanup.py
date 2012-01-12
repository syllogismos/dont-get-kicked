import fileinput
from util import *
import pickle


training = fileinput.FileInput("test1.csv")
indexes = training.readline()
indexes = indexes.split(',')


make = set()
transmission = set()
wheeltypeid = set()
nationality = set()
size = set()
topthree = set()
primeunit = set()
aucguart = set()



def makedivide(filehandle):
	objects = open('objectsdump','r')
	aa = open('averagesdump','r')
	auct = pickle.load(objects)
	ma = pickle.load(objects)
	tr = pickle.load(objects)
	wh = pickle.load(objects)
	na = pickle.load(objects)
	si = pickle.load(objects)
	tt = pickle.load(objects)
	pu = pickle.load(objects)
	au = pickle.load(objects)
	avg = pickle.load(aa)
	training = fileinput.FileInput('test1.csv')
	#temp = training.readline()
	for line in training:
		boo = line.strip()
		boo = line.split(',')
		for i in range(18,26): 
			if boo[i]=='NULL':boo[i] = str(avg[(i,boo[6])])
		filehandle.write(boo[0]+" "+boo[1]+" "+str(auct[boo[3]])+" "+boo[5]+" "+str(ma[boo[6]])+" "+str(tr[boo[11]])+" "+str(wh[boo[12]])+" "+boo[14]+" "+str(na[boo[15]])+" "+str(si[boo[16]])+" "+str(tt[boo[17]])+" "+boo[18]+" "+boo[19]+" "+boo[20]+" "+boo[21]+" "+boo[22]+" "+" "+boo[23]+" "+boo[24]+" "+boo[25]+" "+str(pu[boo[26]])+" "+str(au[boo[27]])+" "+boo[31]+" "+boo[32]+" "+boo[33])
	training.close()
	filehandle.close()


def preparetest(filehandle):
	objects = open('objectsdump','r')
	aa = open('averagesdump','r')
	auct = pickle.load(objects)
	ma = pickle.load(objects)
	tr = pickle.load(objects)
	wh = pickle.load(objects)
	na = pickle.load(objects)
	si = pickle.load(objects)
	tt = pickle.load(objects)
	pu = pickle.load(objects)
	au = pickle.load(objects)
	avg = pickle.load(aa)
	training = fileinput.FileInput('test1.csv')
	#temp = training.readline()
	for line in training:
		boo = line.strip()
		boo = line.split(',')
		for i in range(17,25): 
			if boo[i]=='NULL':boo[i] = str(avg[(i+1,boo[5])])
		filehandle.write(boo[0]+" "+str(auct[boo[2]])+" "+boo[4]+" "+str(ma[boo[5]])+" "+str(tr[boo[10]])+" "+str(wh[boo[11]])+" "+boo[13]+" "+str(na[boo[14]])+" "+str(si[boo[15]])+" "+str(tt[boo[16]])+" "+boo[17]+" "+boo[18]+" "+boo[19]+" "+boo[20]+" "+boo[21]+" "+" "+boo[22]+" "+boo[23]+" "+boo[24]+" "+str(pu[boo[25]])+" "+str(au[boo[26]])+" "+boo[30]+" "+boo[31]+" "+boo[32])
	training.close()
	filehandle.close()

def makesets():
	make = set()
	transmission = set()
	wheeltypeid = set()
	nationality = set()
	size = set()
	topthree = set()
	primeunit = set()
	aucguart = set()
	training = fileinput.FileInput("test1.csv")
	#indexes = training.readline().strip()
	#indexes = indexes.split(',')
	for line in training:
		values = line.strip().split(',')
		make.add(values[6])
		transmission.add(values[11])
		wheeltypeid.add(values[12])
		nationality.add(values[15])
		size.add(values[16])
		topthree.add(values[17])
		primeunit.add(values[26])
		aucguart.add(values[27])

# ma,tr,wh,na,si,tt,pu,auc



def count(w):
	training = fileinput.FileInput('test1.csv')
	count = 0
	for line in training:
		boo = line.strip()
		boo = boo.split(',')
		if boo[6]==w: count+=1
	training.close()
	return count



def average(index,make):
	training = fileinput.FileInput('test1.csv')
	tot = 0
	count = 0
	for line in training:
		boo = line.strip().split(',')
		if boo[6] == make and (boo[index] != 'NULL' and boo[index] != '' ):
			count += 1
			tot += int(boo[index])
	training.close()
	return tot/count

def checknull(index):
	training = fileinput.FileInput('test1.csv')
	for line in training:
		boo = line.strip().split(',')
		if boo[index] == 'NULL':
			print True
			training.close()
			return
	training.close()



def returndict(index):
	training = fileinput.FileInput('test1.csv')
	#i = training.readline()
	a = set()
	for line in training:
		boo = line.strip().split(',')
		a.add(boo[index])
	a = list(a)
	training.close()
	return a




def median(index,make):
	training = fileinput.FileInput('test1.csv')
	#i = training.readline()
	counts = Counter()
	for line in training:
		boo = line.strip().split(',')
		if boo[6] == make:
			counts[boo[index]] += 1
	training.close()
	return counts

def allmedian(index):
	training = fileinput.FileInput('test1.csv')
	counts = Counter()
	#i = training.readline()
	for line in training:
		boo = line.strip().split(',')
		counts[boo[index]] += 1
	training.close()
	return counts

def crap(make):
	make = list(make)
	ma = {(make[i],i+1) for i in range(len(make))}
	ma = dict(ma)
	return ma

