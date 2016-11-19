library("xml2")
library("rvest")
library("httr")
library("stringr")
options(stringAsFactor = F)

# 中央社 ---------------------------------------------------------------------
url_central <- 'http://www.cna.com.tw/search/hysearchws.aspx?q=%E9%A3%9F%E5%AE%89'
doc_central <- read_html(url_central)
hrefxpath_central <- '//*[@class="search_result_list"]//li/a'
findall_central <- xml_find_all(doc_central, hrefxpath_central)
href_central <- xml_attr(findall_central, "href")
hrefs_central <- paste0('http://www.cna.com.tw', href_central)

alldata_central <- data.frame(title = character(0), 
                              content = character(0),
                              time = character(0),
                              journalist = character(0),
                              link = character(0))

for (i in 1:length(hrefs_central)){
    tdoc <- read_html(hrefs_central[i])
    link <- hrefs_central[i]
    
    # Title
    titlexpath <- '//*[@itemprop="headline"]'
    findtitle <- xml_find_all(tdoc, titlexpath)
    title <- xml_text(findtitle) 
    
    
    # Content
    contentxpath <- '//*[@id="aspnetForm"]/div[6]/div[2]/div[2]/div[5]/section/p[1]/text()'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)

    
    # Time
    timexpath <- '//*[@class="update_times"]/p[1]'
    findtime <- xml_find_all(tdoc, timexpath)
    time <- xml_text(findtime)
    time <- sub(".*時間：(.*)", "\\1", time)
    
    # Journalist
    contentxpath <- '//*[@itemprop="articleBody"]/p'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)
    content <- trimws(content)
    journalist <- substr(sub(".*中央社記者(.*{3})","\\1", substr(content[1], 1,16)), 1,3)
    
    
    content <- paste(content, collapse = " ")
    tempdf <- data.frame(title = title, content = content, time = time,  journalist = journalist, link = link)
    alldata_central <- rbind(alldata_central, tempdf)
}