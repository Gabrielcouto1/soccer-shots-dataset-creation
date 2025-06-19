library("rjson") 

source("./r/utils/plot/get_distance.r")
source("./r/utils/plot/plot_empty_field.r")
source("./r/utils/get_related_event_id.r")
source("./r/utils/get_match_json.r")

home_team   <- "Real Madrid"
away_team   <- "Barcelona"
match_id    <- "68319"
competition <- "la_liga"

match_json <- get_match_json(home_team, away_team, match_id, competition)

img_path <- paste0("./plots/passes/", home_team, "_vs_", away_team, "_", match_id, ".png")

width  <- match_json[[5]]$location[1]*2
height <- match_json[[5]]$location[2]*2

png(file=img_path, width=width*10, height=height*10)

plot_field(width, height)

for (i in 1:length(match_json)){
    if((match_json[[i]]$type$id) == 30){
        related_event_id    <- match_json[[i]]$related_events[1]
        related_event_index <-get_related_event_index(related_event_id, match_json)
        related_event_type  <- match_json[[related_event_index]]$type$id

        source      <- match_json[[i]]$location
        destination <- match_json[[related_event_index]]$location

        distance<-get_distance(source, destination)

        points(source[1], source[2], col="red", pch=19)
        points(destination[1], destination[2], col="blue", pch=19)
        segments(source[1], source[2], destination[1], destination[2], col="grey")
    }
}

mtext(paste0(home_team, " vs ", away_team), side = 1, line = 2)
dev.off()