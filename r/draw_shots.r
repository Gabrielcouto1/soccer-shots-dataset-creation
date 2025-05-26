library("rjson") 

source("./r/utils/get_distance.r")
source("./r/utils/plot_empty_field.r")
source("./r/utils/get_related_event_id.r")
source("./r/utils/get_xg_proportion.r")
home_team <- "Argentina"
away_team <- "Canada"
 #TODO: SOMAR OS XG E FAZER UM NEGOCIO PARECIDO COM O CRUZEIRODATA DO MERECIMENTO! 
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

play_type <- c(16, 25) # 16 = shot 30 = pass

for (i in 1:length(match_json)){
    current_play_type <- (match_json[[i]]$type$id)
    if(current_play_type %in% play_type ){ 
        if (current_play_type == 16){
            related_event_id    <- match_json[[i]]$related_events[1]
            related_event_index <- get_related_event_index(related_event_id, match_json)
            related_event_type  <- match_json[[related_event_index]]$type$id

            source      <- match_json[[i]]$location
            destination <- match_json[[i]]$shot$end_location

            color_source <- "black"
            color_segment <- "red"
            point_size <- 1.5

            if (match_json[[i]]$team$name == away_team){
                source[1] = 120 - source[1]
                destination[1] = 120 - destination[1]            
            } 

            if ((match_json[[i]]$shot$outcome$id == 97) || (match_json[[i]]$shot$type$id == 88)){
                color_source <- "green"
                point_size <- get_xg_proportion(match_json[[i]])
            }

            
        }else if (current_play_type == 25){
            color_source <- "blue"
            color_segment <- "blue"
            point_size <- 3
            if (match_json[[i]]$possession_team$name == home_team){
                print("aaa")
                source <- match_json[[i]]$location
                destination <- c(120, 40)
            } 
        }
        distance<-get_distance(source, destination)

        points(source[1], source[2], col=color_source, pch=19, cex=point_size)
        # points(destination[1], destination[2], col="blue", pch=19)
        segments(source[1], source[2], destination[1], destination[2], col=color_segment, lwd=1)
    }
}
mtext(paste0(home_team, " vs ", away_team), side = 1, line = 2, cex = 2)
dev.off()