library(rjson)
library(RCurl)
library(plyr)
options(fileEncoding = "utf-8")
options(stringsAsFactors = F)
token <- "EAACEdEose0cBABH49ZBX1O4RyTe3NdkZA0ezKjJnVjIn4ab5sYvbq1hhblEocx7jZCBtPMk1L5QgHyjiJxq3ZBZCPAZBR74FzRfj7PkQaxcvryCeWbrmHQrLdNg37YKKLClraii4UEU6Og6EJwYqhPNN762g6ZB6ZAnzmuanNfMnTwZDZD"


# PTT's Posts in FB -------------------------------------------------------
id <- "316552595113604"
query_post <- "316552595113604?fields=posts.limit(100)"
url_post <- sprintf("https://graph.facebook.com/v2.8/%s&access_token=%s", query_post, token)


data_post <- getURL(url_post)
res_post <- fromJSON(data_post, unexpected.escape = "keep")


post <- do.call('rbind.fill', lapply(res_post$posts$data, as.data.frame))


nexturl <- res_post$posts$paging$"next"
nextdata <- getURL(nexturl)
nextres <- fromJSON(nextdata, unexpected.escape = "keep")
all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
post <- rbind(post, all)


while(T){
  nexturl <- nextres$paging$"next"
  if(is.null(nexturl)){
    break
  }
  nextdata <- getURL(nexturl)
  nextres <- fromJSON(nextdata, unexpected.escape = "keep")
  all <- do.call('rbind.fill', lapply(nextres$data, as.data.frame))
  all$story <- NA
  post <- rbind(post, all)
  print(paste0("Number of post: ", nrow(post)))
  
}



# PTT post's comments --------------------------------------------
id <- "316552595113604"
token <- "EAACEdEose0cBABH49ZBX1O4RyTe3NdkZA0ezKjJnVjIn4ab5sYvbq1hhblEocx7jZCBtPMk1L5QgHyjiJxq3ZBZCPAZBR74FzRfj7PkQaxcvryCeWbrmHQrLdNg37YKKLClraii4UEU6Og6EJwYqhPNN762g6ZB6ZAnzmuanNfMnTwZDZD"
query <- "316552595113604?fields=posts.limit(20){comments.limit(50)}"
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


nexturl_post <- res$posts$paging$"next"
nextdata_post <- getURL(nexturl_post)
nextres_post <- fromJSON(nextdata_post, unexpected.escape = "keep")


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

while (T){
  nexturl_post <- nextres_post$paging$"next"
  if(is.null(nexturl_post)){
    break
  }
  nextdata_post <- getURL(nexturl_post)
  nextres_post <- fromJSON(nextdata_post, unexpected.escape = "skip")
  
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
  
}

\