#!/usr/bin/python

import sys
from os import path
import feedparser

def getTermsPerFeed(feed,titles):

   d = feedparser.parse(feed)

   for post in d.entries:
      titles.add(post.title)  

titles = set()

getTermsPerFeed("http://www.inoreader.com/stream/user/1006104772/tag/Bigdata",titles)

for title in titles:
   print title
