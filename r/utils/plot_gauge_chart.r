library(ggplot2)

plot_gauge_chart <- function(prob1, prob2, prob3){
    posicao_ponteiro <- prob1

    cores <- c("Seção 1" = "#0000FF", "Seção 2" = "#c3c3c3", "Seção 3" = "#FF0000", "Invisível" = "white")

    df <- data.frame(
      categoria = c("Seção 1", "Seção 2", "Seção 3", "Invisível"),
      valor = c(prob1, prob2, prob3, 100)
    )

    df$fracao <- df$valor / sum(df$valor)
    df$ymax <- cumsum(df$fracao)
    df$ymin <- c(0, head(df$ymax, n = -1))

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
        label = paste0(posicao_ponteiro, "%"),
        size = 12,
        fontface = "bold",
        color = "black"
      ) +
      theme_void() +
      theme(legend.position = "none") +
      labs(title = "Gráfico de Velocímetro (Gauge Chart)") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))


    print(gauge_chart)
}

