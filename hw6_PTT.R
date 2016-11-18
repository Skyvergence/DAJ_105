library("xml2")
library("rvest")
library("httr")
library("stringr")
options(stringAsFactor = F)


# PTT StupidClown版 -----------------------------------------------------------
url_ptt <- 'https://www.ptt.cc/bbs/StupidClown/index3210.html'
doc_ptt <- read_html(url_ptt)


hrefpath_ptt <- '//*[@id="main-container"]/div[2]//div/div[3]/a' 
findall_ptt <- xml_find_all(doc_ptt, hrefpath_ptt)
href_ptt <- xml_attr(findall_ptt, "href")
hrefs_ptt <- paste0('https://www.ptt.cc', href_ptt)

alldata_ptt <- data.frame(title = character(0), 
                          content = character(0),
                          time = character(0),
                          author = character(0),
                          link = character(0))

for (i in 1:length(hrefs_ptt)){
    tdoc <- read_html(hrefs_ptt[i])
    link <- hrefs_ptt[i]
    
    # Title
    titlexpath <- '//*[@id="main-content"]/div[3]/span[2]'
    findtitle <- xml_find_first(tdoc, titlexpath)
    title <- xml_text(findtitle) 
    title <- trimws(title)
    
    
    # Content
    contentxpath <- '//*[@id="main-content"]/text()'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)
    content <- trimws(content)
    content <- paste(content, collapse = " ")
    content <- gsub("\n", "", content)

    
    
    
    # Time
    timexpath <- '//*[@id="main-content"]/div[4]/span[2]'
    findtime <- xml_find_first(tdoc, timexpath)
    time <- xml_text(findtime)
    
    
    # Author
    authorxpath <- '//*[@id="main-content"]/div[1]/span[2]'
    findauthor <- xml_find_first(tdoc, authorxpath)
    author <- xml_text(findauthor)
    
    tempdf <- data.frame(title=title, content=content, time = time,  author = author, link = link)
    alldata_ptt <- rbind(alldata_ptt, tempdf)
}

