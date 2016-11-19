library("xml2")
library("rvest")
library("httr")
library("stringr")
options(stringAsFactor = F)




# Initium ---------------------------------------------------------------------
url_initium <- 'https://theinitium.com/search/?q=obama+news'
doc_initium <- read_html(url_initium)
hrefxpath_initium <- '/html/body/div[3]/div[1]/div/div[1]/div/div[2]//a'
findall_initium <- xml_find_all(doc_initium, hrefxpath_initium)
href_initium <- xml_attr(findall_initium, "href")
hrefs_initium <- paste0('https://theinitium.com', href_initium)

alldata_initium <- data.frame(title = character(0), 
                              content = character(0),
                              time = character(0),
                              journalist = character(0),
                              type = character(0),
                              link = character(0))

for (i in 1:length(hrefs_initium)){
    tdoc <- read_html(hrefs_initium[i])
    link <- hrefs_initium[i]
    
    # Title
    titlexpath <- '/html/body/div[3]/div[1]/div/article/h1'
    findtitle <- xml_find_all(tdoc, titlexpath)
    title <- xml_text(findtitle) 
    
    # Content
    contentxpath <- '/html/body/div[3]/div[1]/div/article/div[2]/div[1]/p'
    findcontent <- xml_find_all(tdoc, contentxpath)
    content <- xml_text(findcontent)
    content <- paste(content, collapse = " ")
    
    # Time
    timexpath <- '//*[@itemprop="datePublished"]'
    findtime <- xml_find_all(tdoc, timexpath)
    time <- xml_text(findtime)
    
    # Type
    typexpath <- '/html/body/div[3]/div[1]/div/article/div[1]/div/div/span[1]/a'
    findtype <- xml_find_all(tdoc, typexpath)
    type <- xml_text(findtype)
    
    
    tempdf <- data.frame(title = title, content = content, time = time, type = type, link = link)
    alldata_initium <- rbind(alldata_initium, tempdf)
}
