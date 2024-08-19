library("rjson") 

result <- fromJSON(file = file.choose()) 
  
result[[3]]$id
