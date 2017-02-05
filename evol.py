# -*- coding: utf-8 -*- 

import html2text
import requests
# html = open("foobar.html").read()
import sys
import os

reload(sys)  
sys.setdefaultencoding('utf8')

import csv

import codecs
# print html2text.html2text(page.content)

# junk,sep,stats = html2text.html2text(page.content).partition("Pokedex Entry")
# stats,sep,junk = stats.partition("[Back to Pokedex]")

# import re
# stats = re.sub(r'http\S*', '', stats)
# print stats


# junk,sep,stats = html2text.html2text(page.content).partition("Extra Form")
# stats,sep,junk = stats.partition("## __ 읽으신 분들")
# print stats

from bs4 import BeautifulSoup

def __init__(self):
	pass

# def getADS(name):

# 	page = requests.get("https://namu.wiki/w/"+name)
# 	soup = BeautifulSoup(page.content, "html.parser")
# 	# print soup.get_text().split("3세데ROA",1)[1]
# 	text = soup.get_text()
# 	junk,sep,desc = text.partition("3세대ORAS")
# 	desc,sep,rest = desc.partition("4~5세대")
# 	desc = desc.replace("\n","")
# 	if (len(desc)<1):
# 		junk,sep,desc = text.partition("루비오메가루비") 
# 		desc,sep,rest = desc.partition("사파이어")
	# defense,sep,rest = rest.partition("STA")
	# print rest
	# rest = rest.split('\n', 2)[1]
	# sta = rest.replace("\n","").replace(" ","")
	# sta,sep,junk = rest.partition(" Attacking Movesets")
	# sta,sep,junk = rest.partition(" Rating Explanation")
	# atk = os.linesep.join([s for s in atk.splitlines() if s]).replace("\n","").replace(" ","")
	# defense = os.linesep.join([s for s in defense.splitlines() if s]).replace("\n","").replace(" ","")
	# sta = os.linesep.join([s for s in sta.splitlines() if s])
	# ret = [atk,defense,sta]
	# return ret
	return desc

def main():
	print getADS('1')
	print getADS('3')
	with codecs.open('/Users/YongHui/git/Pok-dex-KOR/pokemon_KR3.csv','r', 'utf-8') as csvinput:
	    with open('/Users/YongHui/git/Pok-dex-KOR/pokemon_KR4.csv', 'w') as csvoutput:
	        writer = csv.writer(csvoutput, lineterminator='\n')
	        reader = csv.reader(csvinput)

	        all = []
	        for row in reader:
	        	if (row[0]=='id') :
 
	        	else :
	        		if(row[-1]=='')
        		all.append(row)

	        writer.writerows(all)
	# getADS("이상해씨")
	# getADS("이상해꽃")
	# getADS("파이리")
	# getADS("뚜벅쵸")

if  __name__ =='__main__':main()