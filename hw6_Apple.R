library("xml2")
library("rvest")
library("httr")
library("stringr")
options(stringAsFactor = F)

# 蘋果基金會 -------------------------------------------------------------------
url_apple <- 'http://search.appledaily.com.tw/charity/projlist/'
doc_apple <- read_html(url_apple)
hrefpath_apple <- '//*[@id="inquiry3"]/table//tr/td[2]/a'
findall_apple <- xml_find_all(doc_apple, hrefpath_apple)
hrefs_apple <- xml_attr(findall_apple, "href")


alldata_apple <- data.frame(title = character(0), 
                            content = character(0),
                            time = character(0),
                            journalist = character(0),
                            link = character(0))

for (i in 1:length(hrefs_apple)){
    tdoc <- read_html(hrefs_apple[i])
    link <- hrefs_apple[i]
    
    # Title
    titlexpath <- '//*[@id="h1"]'
    findtitle <- xml_find_first(tdoc, titlexpath)
    title <- xml_text(findtitle) 
    title <- trimws(title)
    title <- gsub("A|[0-9]","",title)
    
    
    # Content
    introcontentxpath <- '//*[@id="introid"]'
    findintrocontent <- xml_find_all(tdoc, introcontentxpath)
    introcontent <- xml_text(findintrocontent)
    introcontent <- trimws(introcontent)
    bcontentxpath <- '//*[@id="bcontent"]'
    findbcontent <- xml_find_all(tdoc, bcontentxpath)
    bcontent <- xml_text(findbcontent)
    bcontent <- trimws(bcontent)
    content <- paste(bcontent, collapse = " ")
    content <- paste(introcontent, content, collapse = " ")
    
    # Time
    timexpath <- '//*[@id="maincontent"]/div[2]/article/div[1]/time'
    findtime <- xml_find_all(tdoc, timexpath)
    time <- xml_text(findtime)
    
    # Journalist
    journalistxpath <- '//*[@id="introid"]'
    findjorunalist <- xml_find_all(tdoc, journalistxpath)
    journalist <- xml_text(findjorunalist)
    journalist <-  sub(".*攝影[╱／/](.*)","\\1", journalist)
    journalist <- substr(journalist, 1,3)
    
    tempdf <- data.frame(title = title, content = content, time = time,  journalist = journalist, link = link)
    alldata_apple <- rbind(alldata_apple, tempdf)
    
    
}