library("rjson") 
source("./r/get_pass_distance.r")
source("./r/plot_empty_field.r")
source("./r/get_pass_ids.r")

match_json <- fromJSON(file = "./data/events_copa_america_24/Argentina_vs_Canada.json") 

plot_field()

for (i in 1:length(match_json)){
    if((match_json[[i]]$type$id) == 30){
        related_event_id    <- match_json[[i]]$related_events[1]
        related_event_index <-get_related_event_index(related_event_id, match_json)
        related_event_type  <- match_json[[related_event_index]]$type$id

        source      <- match_json[[i]]$location
        destination <- match_json[[related_event_index]]$location

        distance<-get_pass_distance(source, destination)

        points(source[1], source[2], col="red", pch=19)
        points(destination[1], destination[2], col="blue", pch=19)
        segments(source[1], source[2], destination[1], destination[2], col="grey")
    }
}