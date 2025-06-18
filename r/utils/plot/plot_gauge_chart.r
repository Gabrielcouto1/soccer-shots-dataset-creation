library(ggplot2)
library(gridExtra)
library(grid)
source("./r/utils/get_match_outcome.r")
plot_gauge_chart <- function(home_prob, draw_prob, away_prob, home_team, away_team, competition){
    home_prob <- home_prob*100
    draw_prob <- draw_prob*100
    away_prob <- away_prob*100

    posicao_ponteiro <- home_prob

	match <- paste0(home_team, "_vs_", away_team)

    cores <- setNames(c("#00FF00", "#838383", "#FF0000", "white"), 
                 	  c(home_team, "Draw", away_team, "Invisível"))

    df <- data.frame(
      	categoria = c(home_team, "Draw", away_team, "Invisível"),
      	valor = c(home_prob, draw_prob, away_prob, 100)
    )

    df$fracao <- df$valor / sum(df$valor)
    df$ymax <- cumsum(df$fracao)
    df$ymin <- c(0, head(df$ymax, n = -1))

    # Create just the gauge chart without any annotations
    gauge_chart <- ggplot() +
      	geom_rect(data = df, aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 3, fill = categoria)) +
      	geom_segment(
      	  aes(x = 2.5, y = posicao_ponteiro / 200, xend = 3.8, yend = posicao_ponteiro / 200),
      	  arrow = arrow(length = unit(0.3, "cm")),
      	  lineend = "round",
      	  linewidth = 1.5,
      	  color = "black"
      	) +
      	coord_polar(theta = "y", start = -pi/2) +
      	xlim(c(0, 4)) +
      	scale_fill_manual(values = cores) +
      	annotate(
      	  "text", x = 0, y = 0,
      	  label = paste(round(posicao_ponteiro, 1), "%", sep=""),
      	  size = 12,
      	  fontface = "bold",
      	  color = "black"
      	) +
      	theme_void() +
      	theme(legend.position = "none") +
      	labs(title = "Outcome simulator (by xG)") +
      	theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))

	outcome_text <- textGrob(
        paste(home_team, " (",get_match_outcome(match, competition), ") ",away_team, sep=""),
        x = 2, y = 2.8, just = "centre", gp = gpar(fontsize = 25))

    home_prob_text <- textGrob(
        paste(home_team, " wins ", round(home_prob, 1), "% of times", sep=""),
        x = 0.1, y = 2, just = "centre", gp = gpar(fontsize = 16))
    
    away_prob_text <- textGrob(
        paste(away_team, " wins ", round(away_prob, 1), "% of times", sep=""),
        x = 1, y = 2, just = "centre", gp = gpar(fontsize = 16))

	text <- paste("These numbers are a result of 10.000 simulations of the match.",
				  "The simulations follow a binomial distribuition, where X is a shot",
				  "and the probability is statsbomb's xG. This graphic was inspired",
				  "by CruzeiroData (x.com/CruzeiroData).", sep="\n")
	
	description <- textGrob(
        text,
        x = -2, y = 0.35, just = "left", gp = gpar(fontsize = 11))

    grid.arrange(
      gauge_chart,
      arrangeGrob(outcome_text, home_prob_text, away_prob_text, description, nrow = 1),
      heights = c(0.5, 0.1)
    )
}