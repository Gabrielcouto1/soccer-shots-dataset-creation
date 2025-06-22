library("rjson") 

# Pegando os ids de cada passe completo, juntamente com o id do recebimento desse passe

get_related_event<-function(id, match_json) {
    for (i in 1:length(match_json)) {
        if (match_json[[i]]$id == id) {
            event_json <- match_json[[i]]
            break
        }
    }
    return(event_json)
}