source('src/func.R')
groupHooks <- c("aptes","coll","Analyst") #sample is the optics bacgrkound measurement
groupColors <- brewer.pal(length(groupHooks), "Dark2")

setwd('data')
files2SpectraObject(gr.crit = groupHooks, gr.cols = groupColors,
                    freq.unit = "wavenumber cm^-1",
                    int.unit = "Absorbance Units",
                    descrip = "ATR-FTIR data",
                    format = "csv",
                    alignTMS = FALSE,
                    out.file = "specData",
                    debug = FALSE)
setwd('..')
load("data/specData.RData")
spec <- saveLoadReference
baseSpec <- baselineSpec(saveLoadReference, int=FALSE, retC=TRUE, method="rfbaseline")

# remove noisy, uninteresting region:
newIR <- removeFreq(baseSpec, rem.freq =
                      baseSpec$freq > 1800 & baseSpec$freq < 2500)

newFileName <- paste(getwd(), "/graphs/ATR-FTIR data for different substrates with collagen, 16-05-2014", ".pdf", sep = "")
  pdf(file=newFileName, paper="a4r", width=9)
  par(mfrow = c(1,1), mar = c(5.1,5.1,4.1,2.1))
  plotSpectra(baseSpec, which=c(1,2,3,4,5), title="ATR-FTIR data for different substrates with collagen, 16-05-2014", offset= 0.05, yrange=c(-0.1,0.75), xaxt = "n")
  at <- seq(from = 0, to = max(baseSpec$freq), by = 100)
  axis(side = 1, at = at, las = 2, hadj = 0.9)
dev.off()

newFileName <- paste(getwd(), "/graphs/ATR-FTIR data for different substrates with collagen detail, 16-05-2014", ".pdf", sep = "")
  pdf(file=newFileName, paper="a4r", width=9)
  par(mfrow = c(1,1), mar = c(5.1,5.1,4.1,2.1))
  plotSpectra(baseSpec, which=c(1,2,3,4,5), xlim=c(1800,932), title="ATR-FTIR data for different substrates with collagen, 09-05-2014", offset= 0.03, yrange=c(-0.01,0.4), xaxt = "n",  lab.pos = (mean(baseSpec$freq)*0.65))
  at <- seq(from = 0, to = max(baseSpec$freq), by = 20)
  axis(side = 1, at = at, las = 2, hadj = 0.9)
dev.off()
