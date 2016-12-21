library(rjson)
library(httr)
library(plyr)
options(fileEncoding = "utf-8")
options(stringsAsFactors = F)
token <- "EAACEdEose0cBALsPrZBZABjOUM0CKXZCyRwtuprNi4XZBO7ZClkuua2e4GRKo7rSJdL0iNUXgqtizKeo49LlSXZCuF1osNmFEZAUFirMl2AZA2dA1c0wT2a0kxAyxk1IAyZAXiZAPmqZBVtHrTUSbIGbsEkDtABqpGp1jxwRReApZACYIQZDZD"


# 連俞涵s Posts in FB -------------------------------------------------------
id <- "140216402663925"
query_post <- "140216402663925?fields=posts.limit(100)"
url_post <- sprintf("https://graph.facebook.com/v2.8/%s&access_token=%s", query_post, token)


# data_post <- getURL(url_post)
res_post <- fromJSON(content(GET(url_post),'text'))
# res_post <- fromJSON(data_post, unexpected.escape = "keep")


post <- do.call('rbind.fill', lapply(res_post$posts$data, as.data.frame))


nexturl <- res_post$posts$paging$"next"
# nextdata <- getURL(nexturl)
# nextres <- fromJSON(nextdata, unexpected.escape = "keep")
nextres <- fromJSON(content(GET(nexturl),'text'))
all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
post <- rbind(post, all)


while(T){
  nexturl <- nextres$paging$"next"
  if(is.null(nexturl)){
    break
  }
  # nextdata <- getURL(nexturl)
  # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
  nextres <- fromJSON(content(GET(nexturl),'text'))
  all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
  all$story <- NA
  post <- rbind(post, all)
  print(paste0("Number of post: ", nrow(post)))
  
}



# 連俞涵 post's comments --------------------------------------------
id <- "140216402663925"
token <- "EAACEdEose0cBALsPrZBZABjOUM0CKXZCyRwtuprNi4XZBO7ZClkuua2e4GRKo7rSJdL0iNUXgqtizKeo49LlSXZCuF1osNmFEZAUFirMl2AZA2dA1c0wT2a0kxAyxk1IAyZAXiZAPmqZBVtHrTUSbIGbsEkDtABqpGp1jxwRReApZACYIQZDZD"
query <- "140216402663925?fields=posts.limit(20){comments.limit(40)}"
url <- sprintf("https://graph.facebook.com/v2.8/%s&access_token=%s", query, token)


# data <- getURL(url)
# res <- fromJSON(data, unexpected.escape = "keep")
res <- fromJSON(content(GET(url),'text'))

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
    print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
    print(paste0("Number of total comments: ", nrow(grandcomment)))
    next
  }
  
  all <- do.call('rbind.fill', lapply(res$posts$data[[i]]$comments$data, as.data.frame))
  allcomment <- rbind(allcomment, all)
  
  
  nexturl <- res$posts$data[[i]]$comments$paging$"next"
  
  
  if(is.null(nexturl)){
    print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
    grandcomment <- rbind(grandcomment, allcomment)
    print(paste0("Number of total comments: ", nrow(grandcomment)))
    next
  }
  # nextdata <- getURL(nexturl)
  # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
  nextres <- fromJSON(content(GET(nexturl),'text'))
  all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
  allcomment <- rbind(allcomment, all)
  
  
  while(T){
    nexturl <- nextres$paging$"next"
    if(is.null(nexturl)){
      break
    }
    # nextdata <- getURL(nexturl)
    # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
    nextres <- fromJSON(content(GET(nexturl),'text'))
    all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
    allcomment <- rbind(allcomment, all)
    
  }
  print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
  grandcomment <- rbind(grandcomment, allcomment)
  print(paste0("Number of total comments: ", nrow(grandcomment)))
  
}


nexturl_post <- res$posts$paging$"next"
# nextdata_post <- getURL(nexturl_post)
# nextres_post <- fromJSON(nextdata_post, unexpected.escape = "keep")
nextres_post <- fromJSON(content(GET(nexturl_post),'text'))


for (i in 1:20){
  index <- index + 1
  allcomment <- data.frame(
    created_time = character(0), 
    from.name = character(0),
    from.id = character(0),
    message = character(0),
    id = character(0))
  
  
  if (is.null(nextres_post$data[[i]]$comments$data)){
    print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
    print(paste0("Number of total comments: ", nrow(grandcomment)))
    next
  }
  
  all <- do.call('rbind.fill', lapply(nextres_post$data[[i]]$comments$data, as.data.frame))
  allcomment <- rbind(allcomment, all)
  
  
  nexturl <- nextres_post$data[[i]]$comments$paging$"next"
  
  
  if(is.null(nexturl)){
    print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
    grandcomment <- rbind(grandcomment, allcomment)
    print(paste0("Number of total comments: ", nrow(grandcomment)))
    next
  }
  # nextdata <- getURL(nexturl)
  # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
  nextres <- fromJSON(content(GET(nexturl),'text'))
  all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
  allcomment <- rbind(allcomment, all)
  
  
  while(T){
    nexturl <- nextres$paging$"next"
    if(is.null(nexturl)){
      break
    }
    # nextdata <- getURL(nexturl)
    # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
    nextres <- fromJSON(content(GET(nexturl),'text'))
    all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
    allcomment <- rbind(allcomment, all)
  }
  print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
  grandcomment <- rbind(grandcomment, allcomment)
  print(paste0("Number of total comments: ", nrow(grandcomment)))
  
}

while (T){
  nexturl_post <- nextres_post$paging$"next"
  if(is.null(nexturl_post)){
    break
  }
  # nextdata_post <- getURL(nexturl_post)
  # nextres_post <- fromJSON(nextdata_post, unexpected.escape = "skip")
  nextres_post <- fromJSON(content(GET(nexturl_post),'text'))
  
  for (i in 1:20){
    index <- index + 1
    allcomment <- data.frame(
      created_time = character(0), 
      from.name = character(0),
      from.id = character(0),
      message = character(0),
      id = character(0))
    
    
    if (is.null(nextres_post$data[[i]]$comments$data)){
      print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
      print(paste0("Number of total comments: ", nrow(grandcomment)))
      next
    }
    
    all <- do.call('rbind.fill', lapply(nextres_post$data[[i]]$comments$data, as.data.frame))
    allcomment <- rbind(allcomment, all)
    
    
    nexturl <- nextres_post$data[[i]]$comments$paging$"next"
    
    
    if(is.null(nexturl)){
      print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
      grandcomment <- rbind(grandcomment, allcomment)
      print(paste0("Number of total comments: ", nrow(grandcomment)))
      next
    }
    # nextdata <- getURL(nexturl)
    # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
    nextres <- fromJSON(content(GET(nexturl),'text'))
    all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
    allcomment <- rbind(allcomment, all)
    
    
    while(T){
      nexturl <- nextres$paging$"next"
      if(is.null(nexturl)){
        break
      }
      # nextdata <- getURL(nexturl)
      # nextres <- fromJSON(nextdata, unexpected.escape = "keep")
      nextres <- fromJSON(content(GET(nexturl),'text'))
      all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
      allcomment <- rbind(allcomment, all)
    }
    print(paste0("Number of comments in post ", index, ": ", nrow(allcomment)))
    grandcomment <- rbind(grandcomment, allcomment)
    print(paste0("Number of total comments: ", nrow(grandcomment)))
    
  }
  
}
grandcomment <- grandcomment[,-6]
grandcomment[, "postid"] <- paste0(id, "_", substr(grandcomment[,"id"], 1,15))