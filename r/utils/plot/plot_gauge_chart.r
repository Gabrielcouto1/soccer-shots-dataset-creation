library(ggplot2)
library(gridExtra)
library(grid)

plot_gauge_chart <- function(home_prob, draw_prob, away_prob, home_team, away_team){
    home_prob <- home_prob*100
    draw_prob <- draw_prob*100
    away_prob <- away_prob*100

    posicao_ponteiro <- home_prob

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
        label = paste0(round(posicao_ponteiro, 1), "%"),
        size = 12,
        fontface = "bold",
        color = "black"
      ) +
      theme_void() +
      theme(legend.position = "none") +
      labs(title = "Índice de merecimento") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))

    # Create text grobs for the bottom text
    left_text <- textGrob(
      paste(home_team, "probability:", round(home_prob, 1), "%"),
      x = 0.1, y = 2, just = "left", gp = gpar(fontsize = 10))
    # ARRUMAR ESSA MERDA AQ PQP!!!!!!!!!!!!!!!!!!
    center_text <- textGrob(
      paste("Draw probability:", round(draw_prob, 1), "%"),
      x = 0.5, y = 0.5, just = "left", gp = gpar(fontsize = 10))
    
    right_text <- textGrob(
      paste(away_team, "probability:", round(away_prob, 1), "%"),
      x = 19, y = 0.5, just = "right", gp = gpar(fontsize = 10))

    # Combine everything
    grid.arrange(
      gauge_chart,
      arrangeGrob(left_text, center_text, right_text, nrow = 1),
      heights = c(0.9, 0.1)
    )
}