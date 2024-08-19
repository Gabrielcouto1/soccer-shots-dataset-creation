library("rjson") 

result <- fromJSON(file = file.choose()) 

pass_distance<-function(source, destination){
    distance<-((destination[1]-source[1]))^2 + (destination[2]-source[2])^2

    return(format(sqrt(distance), nsmall=20))
}

source      <-result[[5]]$location
destination <-result[[5]]$pass$end_location

pass_distance(source, destination)

ids<-c()

for(i in 1:length(result)){
    if(!is.null(result[[i]]$pass$end_location) & (result[[i]]$type$id=!30&result[[i]]$type$id=!42)){
        ids<-c(ids, result[[i]]$id)
    }
}
print(ids)

# os ids de tipo de jogada de passes devem iguais a 30 ou 42
# id 30 = passe
# id 42 = bola recebida