
# Heat Map, returns a heat map of intensities, takes a wavenumber or range (and calculates the mean)
irHeatmap <- function (wavenumber) {
  # Setup these parametric variables.
  pH <- c(3,7.3,12)
  collagenConc <- c(0,10,30)

  # Array to hold the intensities for a given wavenumber
  absVal <- c()


  # Loop gets intensities.
  for (i in c(1:length(newIR$groups))) {
    nextVal <-mean(c(newIR$data[i, wavenumber]))
    absVal <- c(absVal, nextVal)
  }

  # creates a matrix of the intensity values.
  vnames <-c()
  for (i in c(1:length(newIR$names))) {
   nextName <-substring(c(newIR$names), 1, 2)
   vnames <- c(vnames, nextName)
  }
  mnames <- matrix(vnames, nrow = 3, ncol = 3, byrow = TRUE, dimnames = list(pH, collagenConc))

  mdat <- matrix(c(absVal), nrow = 3, ncol = 3, byrow = TRUE, dimnames = list(pH, collagenConc))
  colors <- brewer.pal(9, "YlGnBu")
  my_palette <- colorRampPalette(colors)(n = 299)
  heatmap.2(mdat,
            main = "Collagen deposition dependence on pH and concentration", # heat map title
            cellnote = mnames,
            notecol="black",      # change font color of cell labels to black
            density.info="none",  # turns off density plot inside color legend
            trace="none",         # turns off trace lines inside the heat map
            margins =c(12,12),     # widens margins around plot
            col=my_palette,       # use on color palette defined earlier
            #breaks=col_breaks,    # enable color transition at specified limits
            dendrogram="none",     # only draw a row dendrogram
            Colv="NA",            # turn off column clustering
            Rowv="NA",
            xlab = "Collagen Concentration v/v %",
            ylab = "pH",
            srtCol = 0,
            offsetRow = 2,
            offsetCol = 3)
}
irHeatmapRMS <- function (wavenumber) {
  # Setup these parametric variables.
  pH <- c(3,7.3,12)
  collagenConc <- c(0,10,30)

  # Array to hold the intensities for a given wavenumber
  absVal <- c()


  # Loop gets intensities.
  for (i in c(1:length(newIR$groups))) {
    y <- c(newIR$data[i, wavenumber])
    nextVal <-sqrt(sum(y^2)/length(y))
    absVal <- c(absVal, nextVal)
  }

  # creates a matrix of the intensity values.
  vnames <-c()
  for (i in c(1:length(newIR$names))) {
    nextName <-substring(c(newIR$names), 1, 2)
    vnames <- c(vnames, nextName)
  }
  mnames <- matrix(vnames, nrow = 3, ncol = 3, byrow = TRUE, dimnames = list(pH, collagenConc))

  mdat <- matrix(c(absVal), nrow = 3, ncol = 3, byrow = TRUE, dimnames = list(pH, collagenConc))
  colors <- brewer.pal(9, "YlGnBu")
  my_palette <- colorRampPalette(colors)(n = 299)
  heatmap.2(mdat,
            main = "Collagen deposition dependence on pH and concentration", # heat map title
            cellnote = mnames,
            notecol="black",      # change font color of cell labels to black
            density.info="none",  # turns off density plot inside color legend
            trace="none",         # turns off trace lines inside the heat map
            margins =c(12,12),     # widens margins around plot
            col=my_palette,       # use on color palette defined earlier
            #breaks=col_breaks,    # enable color transition at specified limits
            dendrogram="none",     # only draw a row dendrogram
            Colv="NA",            # turn off column clustering
            Rowv="NA",
            xlab = "Collagen Concentration v/v %",
            ylab = "pH",
            srtCol = 0,
            offsetRow = 2,
            offsetCol = 3)
}
