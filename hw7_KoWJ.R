library(rjson)
library(RCurl)
library(plyr)
options(fileEncoding = "utf-8")
options(stringsAsFactors = F)
token <- "EAACEdEose0cBAMBhxgy25HJ5hXlzORPH9w8tZBtcE8ur0t4RG74Vz3r4NDj42td8sSUy1COUIdOdZCGqIgvQEgNaoZAy8Mkq2FpD6TaVfxD0634FaTrfHelV2oG4jWPS8dnHNrOxQGUX43Q4EcfjH1FltgvqrMVVuqBmiEuwQZDZD"


# 柯文哲FB粉絲專頁前20則post -------------------------------------------------------
id <- "136845026417486"
query_post <- "136845026417486?fields=posts.limit(20)"
url_post <- sprintf("https://graph.facebook.com/v2.8/%s&access_token=%s", query_post, token)


data_post <- getURL(url_post)
res_post <- fromJSON(data_post, unexpected.escape = "keep")


twenty_post <- do.call('rbind.fill', lapply(res_post$posts$data, as.data.frame))


# 柯文哲FB粉絲團前20則post的comment ------------------------------------------------
id <- "136845026417486"
query <- "136845026417486?fields=posts.limit(20){comments.limit(45)}"
url <- sprintf("https://graph.facebook.com/v2.8/%s&access_token=%s", query, token)


data <- getURL(url)
res <- fromJSON(data, unexpected.escape = "keep")


grandcomment <- data.frame(
              created_time = character(0), 
              from.name = character(0),
              from.id = character(0),
              message = character(0),
              id = character(0))

index <- 0
for (i in 1:20){
  index <- index + 1
  allcomment <- data.frame(
    created_time = character(0), 
    from.name = character(0),
    from.id = character(0),
    message = character(0),
    id = character(0))
  
  
  if (is.null(res$posts$data[[i]]$comments$data)){
    break
  }
  
  all <- do.call('rbind.fill', lapply(res$posts$data[[i]]$comments$data, as.data.frame))
  allcomment <- rbind(allcomment, all)
  
  
  nexturl <- res$posts$data[[i]]$comments$paging$"next"
  nextdata <- getURL(nexturl)
  nextres <- fromJSON(nextdata, unexpected.escape = "keep")
  all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
  allcomment <- rbind(allcomment, all)
  
  
  while(T){
    nexturl <- nextres$paging$"next"
    if(is.null(nexturl)){
      break
    }
    nextdata <- getURL(nexturl)
    nextres <- fromJSON(nextdata, unexpected.escape = "keep")
    all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
    allcomment <- rbind(allcomment, all)
    
  }
  print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
  grandcomment <- rbind(grandcomment, allcomment)
  print(paste0("Number of total comments: ", nrow(grandcomment)))
  
}

grandcomment[, "postid"] <- paste0(id, "_", substr(grandcomment[,"id"], 1,15))








