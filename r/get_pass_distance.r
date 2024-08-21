get_pass_distance<-function(source, destination){
    distance<-((destination[1]-source[1]))^2 + (destination[2]-source[2])^2

    return (sqrt(distance))
}