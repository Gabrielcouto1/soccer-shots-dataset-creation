library("rjson") 

source("./r/utils/get_distance.r")
source("./r/utils/plot_empty_field.r")
source("./r/utils/get_related_event_id.r")
home_team <- "Venezuela"
away_team <- "Canada"

match <- paste0(home_team, "_vs_", away_team)

json_path  <- paste0("./data/events_copa_america_24/", match)
json_path  <- paste0(json_path, ".json")
match_json <- fromJSON(file = json_path) 

img_path <- paste0("./plots/shots/", match)
img_path <- paste0(img_path, ".png")

width  <- match_json[[5]]$location[1]*2  
height <- match_json[[5]]$location[2]*2

png(file=img_path, width=width*10, height=height*10)

plot_field(width, height) 

play_type <- 16 # 16 = shot 30 = pass

for (i in 1:length(match_json)){
    if((match_json[[i]]$type$id) == play_type){ 
        related_event_id    <- match_json[[i]]$related_events[1]
        related_event_index <- get_related_event_index(related_event_id, match_json)
        related_event_type  <- match_json[[related_event_index]]$type$id

        source      <- match_json[[i]]$location
        
        destination <- match_json[[i]]$shot$end_location
        color1 <- "red"
        color2 <- "grey"

        if (match_json[[i]]$possession_team$name == away_team){
            color1 <- "black"
            color2 <- "red"
        } 

        print(destination)
        distance<-get_distance(source, destination)

        points(source[1], source[2], col=color1, pch=19)
        # points(destination[1], destination[2], col="blue", pch=19)
        segments(source[1], source[2], destination[1], destination[2], col=color2)
    }
}

mtext(match, side = 1, line = 2)
dev.off()