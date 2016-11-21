library("xml2")
library("rvest")
library("httr")
library("stringr")
options(stringAsFactor = F)

# 聯合知識庫 -------------------------------------------------------------------
url_udn <- 'http://udndata.com/ndapp/Searchdec2007?udndbid=udnfree&page=1&SearchString=%AD%B9%A6%77%2B%A4%E9%B4%C1%3E%3D20161014%2B%A4%E9%B4%C1%3C%3D20161112%2B%B3%F8%A7%4F%3D%C1%70%A6%58%B3%F8%7C%B8%67%C0%D9%A4%E9%B3%F8%7C%C1%70%A6%58%B1%DF%B3%F8%7CUpaper&sharepage=10&select=1&kind=2'
url_udn <- GET(url_udn, set_cookies('JSESSIONID'='8D415D01B31B2148B0EE8ADA8E9F6C24-n1'))
doc_udn <- read_html(url_udn)
hrefxpath_udn <- '//*[@align="left"]/a'
findall_udn <- xml_find_all(doc_udn, hrefxpath_udn)
findall_udn <- findall_udn[-c(1:3)]
findall_udn <- findall_udn[-length(findall_udn)]
href_udn <- xml_attr(findall_udn, "href")
href_udn <- href_udn[!is.na(href_udn)]
hrefs_udn <- paste0('http://udndata.com', href_udn)


alldata_udn <- data.frame(title = character(0), 
                          content = character(0),
                          time = character(0),
                          author = character(0),
                          link = character(0))
for (i in 1:10){
    url <- hrefs_udn[i]
    url <- GET(url, set_cookies('JSESSIONID'= '8D415D01B31B2148B0EE8ADA8E9F6C24-n1'))
    tdoc <- read_html(url)
    link <- hrefs_udn[i]
    
    # Title
    titlexpath <- '//*[@class="story_title"]'
    findtitle <- xml_find_all(tdoc, titlexpath)
    title <- xml_text(findtitle)
    title <- title[2]
    
    # Content
    contentxpath <- '//*[@align="left"]/table[3]/tr/td//p'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)
    temp <- content
    content <- paste(content, collapse = " ")
    
    # Time
    time <- temp[length(findcontent) - 1]
    time <- substr(time, 2, 11)
    
    # Author
    authorxpath <- '//*[@class="story_author"]'
    findauthor <- xml_find_all(tdoc, authorxpath)
    author <- xml_text(findauthor)
    author <- gsub("【", "", author)
    author <- gsub("】", "", author)
    author <- sub("記者(.{3})╱.{2}報導","\\1", author)

    tempdf <- data.frame(title = title, content = content, time = time,  author = author, link = link)
    alldata_udn <- rbind(alldata_udn, tempdf)
}
