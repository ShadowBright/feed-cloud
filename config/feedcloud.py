#!/usr/bin/python

import sys
from os import path
from wordcloud import WordCloud

import bs4
from bs4 import BeautifulSoup as BSoup
import os, re, sys, math, os.path, urllib, string, random, time

#from nltk.corpus import stopwords
from nltk.tokenize import RegexpTokenizer
from nltk.stem import PorterStemmer, WordNetLemmatizer
from nltk.stem.lancaster import LancasterStemmer
import matplotlib.pyplot as plt
import shutil

lemmStr = WordNetLemmatizer()
#portStr = PorterStemmer()
#lStr = LancasterStemmer()

import feedparser

def getTermsPerFeed(feed,titles):

   d = feedparser.parse(feed)

   for post in d.entries:
      titles.add(post.title) 


def getTermsPerReddit(site,links):

   url = urllib.urlopen(site).read()

   soup=BSoup(url,"html.parser")

   #links = []

   for link in soup.findAll('a',attrs={'class':'title may-blank '}):
      links.add(link.contents[0])

links = set()
feedFile = "feeds.txt"

if not os.path.isfile(feedFile):
   sys.exit(feedFile + " not found")

with open(feedFile) as feeds:
    feedLinks = feeds.read().splitlines()

outFile="feedWordBag"

for feed in feedLinks:
   if feed.startswith("#"):
      print "bypassing feed " + feed
   else: 
      if feed.startswith("rss:"):
         rss = feed.replace("rss:","")
         getTermsPerFeed(rss,links)
         print "searching rss: " + rss
      else:   
         getTermsPerReddit(feed,links)
         print "searching reddit: " + feed

stopwordFile="stopwords.txt"

if not os.path.isfile(stopwordFile):
   print stopwordFile + " not found, bypassing filtering"
   sw=""
else:
   swFile = open(stopwordFile,"r")
   sw = swFile.read()


txt=" ".join(links).lower()

tokenizer = RegexpTokenizer(r'[A-Za-z]+') #(r'\w+')
tokenBag = tokenizer.tokenize(txt)

wordBag = ' '.join([lemmStr.lemmatize(word) for word in tokenBag if word not in sw])

wordBag = ''.join(i for i in wordBag if ord(i)<128)

with open(outFile + ".txt", "w") as text_file:
    text_file.write(wordBag)

wdth = int(os.environ['SCR_WDTH'])
hght = int(os.environ['SCR_HGHT'])

wordcloud = WordCloud(width=wdth,height=hght, relative_scaling=.3).generate(wordBag)

fileName = outFile + ".jpg"

if os.path.exists(fileName):
    os.remove(fileName)

wordcloud.to_file(fileName)

#import Image
from PIL import Image

im1 = Image.open(fileName)
im2 = im1.point(lambda p: p * 0.5)
im2.save(fileName)

output_dir = os.environ['OUTPUT_DIR']

shutil.copy2(os.getcwd() + '/' + fileName, output_dir + '/' + fileName)


