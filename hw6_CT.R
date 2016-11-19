library("xml2")
library("rvest")
library("httr")
library("stringr")
options(stringAsFactor = F)

# 中時電子報搜尋 -----------------------------------------------------------------
url_CT <- 'http://www.chinatimes.com/search/result.htm?q=食安&gsc.page=1#gsc.tab=0&gsc.q=%E9%A3%9F%E5%AE%89&gsc.page=1'
doc_CT <- read_html(url_CT)
hrefxpath_CT <- '//*[@id="___gcse_0"]/div/div/div/div[5]/div[2]/div[2]/div/div[2]//div/div[1]/table/tbody/tr/td[2]/div[1]/a'
findall_CT <- xml_find_all(doc_CT, hrefxpath_CT)
hrefs_CT <- xml_attr(findall_CT, "href")

hrefs_CT <- c("http://opinion.chinatimes.com/20161114005133-262105", "http://opinion.chinatimes.com/20161110005780-262103",
             "http://www.chinatimes.com/newspapers/20160917000291-260114", "http://www.chinatimes.com/newspapers/20160923000482-260210",
             "http://www.chinatimes.com/realtimenews/20160706003060-260405", "http://www.chinatimes.com/newspapers/20160827000297-260204",
             "http://www.chinatimes.com/realtimenews/20160615003125-260405", "http://www.chinatimes.com/newspapers/20160907000418-260114",
             "http://www.chinatimes.com/newspapers/20160804000417-260114", "http://www.chinatimes.com/newspapers/20160721000464-260210")


alldata_CT <- data.frame(title = character(0), 
                              content = character(0),
                              time = character(0),
                              journalist = character(0),
                              link = character(0))

for (i in 1:2){
    tdoc <- read_html(hrefs_CT[i])
    link <- hrefs_CT[i]
    
    # Title
    titlexpath <- '//*[@id="page"]/div[3]/div[2]/article/header/h1'
    findtitle <- xml_find_first(tdoc, titlexpath)
    title <- xml_text(findtitle) 
    title <- trimws(title)
    
    # Content
    contentxpath <- '//*[@id="page"]/div[3]/div[2]/article/article//p'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)
    content <- paste(content, collapse = " ")
    
    # Time
    timexpath <- '//*[@id="page"]/div[3]/div[2]/article/div[2]/div[1]/time'
    findtime <- xml_find_all(tdoc, timexpath)
    time <- xml_text(findtime)
    time <- trimws(time)
    
    
    # Journalist
    journalistxpath <- '//*[@id="page"]/div[3]/div[2]/article/div[2]/div[1]/div/div'
    findjorunalist <- xml_find_all(tdoc, journalistxpath)
    journalist <- xml_text(findjorunalist)

    tempdf <- data.frame(title = title, content = content, time = time,  journalist = journalist, link = link)
    alldata_CT <- rbind(alldata_CT, tempdf)
}

for (i in 3:10){
    tdoc <- read_html(hrefs_CT[i])
    link <- hrefs_CT[i]
    
    # Title
    titlexpath <- '//*[@id="ONEAD-mobile-origin-content"]/div/article/header/h1'
    findtitle <- xml_find_first(tdoc, titlexpath)
    title <- xml_text(findtitle) 
    title <- trimws(title)
    
    # Content
    contentxpath <- '//*[@id="ONEAD-mobile-origin-content"]/div/article/article//p'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)
    content <- paste(content, collapse = " ")
    
    # Time
    timexpath <- '//*[@id="ONEAD-mobile-origin-content"]/div/article/div[2]/div[1]/time'
    findtime <- xml_find_all(tdoc, timexpath)
    time <- xml_text(findtime)
    time <- trimws(time)
    
    
    # Journalist
    journalistxpath <- '//*[@id="ONEAD-mobile-origin-content"]/div/article/div[2]/div[1]/div/cite/a'
    findjorunalist <- xml_find_all(tdoc, journalistxpath)
    journalist <- xml_text(findjorunalist)
    
    tempdf <- data.frame(title = title, content = content, time = time,  journalist = journalist, link = link)
    alldata_CT <- rbind(alldata_CT, tempdf)

}

