library("plotrix")

plot_field <- function(width, height) {
    h <- height
    w <- width

    # windows(width=w/10, height=h/10)
    par(bg="#969696")
    plot(1, type="n", xlim=c(0,w), ylim=c(0,h), axes=FALSE, xlab="", ylab="")

    rect(0, 0, w, h,col="#39782e", border="white", lwd=3) # Desenhando linhas laterais do campo

    points(w/2, h/2, col="white", pch=19, cex=2) # Ponto do meio de campo

    segments(w/2, 0, w/2, h, col="white", lwd=3) # Linha de meio de campo

    draw.circle(w/2, h/2, 9.15, border="white", lwd=3) # Círculo do meio campo

    draw.circle(11,h/2,9.15, border="white", lwd=3) # Círculo da grande área esquerda
    draw.circle(w-11, h/2, 9.15, border="white", lwd=3) # Círculo da grande área direita

    rect(0, ((h/2)-20.16), 16.5, ((h/2)+20.16), col="#39782e", border="white", lwd=3) # Grande área esquerda
    rect(w, ((h/2)-20.16), w-16.5, ((h/2)+20.16), col="#39782e", border="white", lwd=3) # Grande área direita

    points(11, h/2, pch=19, col="white") # Marca do Penalti esquerda
    points(w-11, h/2, pch=19, col="white") # Marca do Penalti direita

    rect(0, ((h/2)-9.16), 5.5, ((h/2)+9.16), border="white", lwd=3) # Pequena area esquerda
    rect(w, ((h/2)-9.16), w-5.5, ((h/2)+9.16), border="white", lwd=3) # Pequena area direita

    rect(-2.44, ((h/2)-3.66), 0, ((h/2)+3.66), border="white", lwd=3) # Gol esquerdo
    rect(w, ((h/2)-3.66), w+2.44, ((h/2)+3.66), border="white", lwd=3) # Gol esquerdo

    # Desenhando marcas dos escanteios
    draw.arc(0, 0, radius = 1, deg1 = 0, deg2 = 90, col = "white", lwd=2) 
    draw.arc(w, 0, radius = 1, deg1 = 180, deg2 = 90, col = "white", lwd=2)
    draw.arc(w, h, radius = 1, deg1 = 180, deg2 = 270, col = "white", lwd=2)
    draw.arc(0, h, radius = 1, deg1 = 270, deg2 = 360, col = "white", lwd=2)
}