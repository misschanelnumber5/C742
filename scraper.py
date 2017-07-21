import requests
from bs4 import BeautifulSoup, SoupStrainer
import bs4
import re
import csv
import os

os.remove('file.csv')
outFile= file("file.csv",'w')
#define link to scrape
search_link = "https://www.census.gov/data/tables/2016/demo/popest/state-total.html"

#Open the link and pull data
r = requests.get(search_link)
#set variable equal to raw HTML data
raw_html = r.text
#push the raw HTML through beautiful soup for manipulation
soup = BeautifulSoup(raw_html, 'html.parser')
#define variable to add to the beginning of relative links to complete the URL
baseLink="https://www.census.gov"
#define empty set for data points to be added
#set are unable to store duplicates
linkSet= set()

#This loop will find every a tag with href inside and interate through each result
#if it is an external link, no changes will be made
#if it is a relative link, the base URL will be added to the beginning
for a in soup.find_all('a', href=True):

    tf=a['href'].startswith('http')

    if tf == True:
    	link=a['href']
    else:
    	link=baseLink + a['href']
    #add formed URL into the set defined above	
    linkSet.add(link)

#take all of the links imported into the set and extract them into a CSV file
# the set is unable to store duplicates so this method will prevent all duplicates from being extracted
for i in linkSet:
	outFile.write(i + '\n')
    