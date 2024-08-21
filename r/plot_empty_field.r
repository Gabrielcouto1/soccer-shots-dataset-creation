library("plotrix")

plot_field <- function() {
    
    windows(width=12, height=8)
    par(bg="green")
    plot(1, type="n", xlim=c(0,120), ylim=c(0,80))

    rect(0, 0, 120, 80, border="white", lwd=2) # Desenhando linhas laterais do campo

    points(60, 40, col="white", pch=19, cex=1.5) # Ponto do meio de campo

    segments(60, 0, 60, 80, col="white", lwd=2) # Linha de meio de campo

    draw.circle(60,40,9.15, border="white") # Círculo do meio campo


    draw.circle(11,40,9.15, border="white") # Círculo da grande área esquerda
    rect(0, 19.84, 16.5, 60.16, col="green", border="white") # Grande área esquerda
    points(11, 40, pch=19, col="white") # Marca do Penalti esquerda
    rect(0, 30.84, 5.5, 49.16, border="white") # Pequena area esquerda
    rect(-2.44, 36.34, 0, 43.66, border="white") # Gol esquerdo
    
    draw.circle(109,40,9.15, border="white") # Círculo da grande área direita
    rect(120, 19.84, 103.5, 60.16, col="green", border="white") # Grande área direita
    points(109, 40, pch=19, col="white") # Marca do Penalti direita
    rect(120, 30.84, 114.5, 49.16, border="white") # Pequena area direita
    rect(120, 36.34, 122.44, 43.66, border="white") # Gol esquerdo

    # Desenhando marcas dos escanteios
    draw.arc(0, 0, radius = 1, deg1 = 0, deg2 = 90, col = "white", lwd=2) 
    draw.arc(120, 0, radius = 1, deg1 = 180, deg2 = 90, col = "white", lwd=2)
    draw.arc(120, 80, radius = 1, deg1 = 180, deg2 = 270, col = "white", lwd=2)
    draw.arc(0, 80, radius = 1, deg1 = 270, deg2 = 360, col = "white", lwd=2)
}