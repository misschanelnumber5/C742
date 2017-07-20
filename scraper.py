import requests
from bs4 import BeautifulSoup, SoupStrainer
import bs4
import re

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
#define empty list for data points to be added
l=[]

#This loop will find every a tag with href inside and interate through each result
for a in soup.find_all('a', href=True):
    #define tf as a variable containing the true/false result of the question, does this link start with http? This will find relative/universal links
    tf=a['href'].startswith('http')
    #if it does start with HTTP
    if tf == True:
    	#print('extLink - ' + a['href'])
    	link=a['href']
    #if it doesn't start with HTTP
    else:
    	#print('notExtLink - ' + baseLink + a['href'])
    	link=baseLink + a['href']
    #append list to contain all of the values
    l.append(link)
print(l)
    