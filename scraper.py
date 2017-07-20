import requests
from bs4 import BeautifulSoup, SoupStrainer
import bs4
import re

search_link = "https://www.census.gov/data/tables/2016/demo/popest/state-total.html"
r = requests.get(search_link)
raw_html = r.text
soup = BeautifulSoup(raw_html, 'html.parser')

l=[]
for a in soup.find_all('a', href=True):
    #print(a['href'])
    l.append(a['href'])
    
print (l)
