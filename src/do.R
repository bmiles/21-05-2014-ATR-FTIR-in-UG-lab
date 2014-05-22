source('src/func.R')
groupHooks <- c("silicon","APTES","collagen") #sample is the optics bacgrkound measurement
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

newFileName <- paste(getwd(), "/graphs/ATR-FTIR test with a Ge ATR crystal 21-05-2014", ".pdf", sep = "")
  pdf(file=newFileName, paper="a4r", width=9)
  par(mfrow = c(1,1), mar = c(5.1,5.1,4.1,2.1))
  plotSpectra(baseSpec,
              which=c(3,2,1),
              xlim=c(4400,400),
              title="ATR-FTIR test with a Ge ATR crystal, 21-05-2014",
              offset= 0.02,
              yrange=c(-0.01,0.25),
              xaxt = "n")
  at <- seq(from = 0, to = max(baseSpec$freq), by = 100)
  axis(side = 1, at = at, las = 2, hadj = 0.9)
dev.off()

newFileName <- paste(getwd(), "/graphs/ATR-FTIR test with a Ge ATR crystal detail 21-05-2014", ".pdf", sep = "")
  pdf(file=newFileName, paper="a4r", width=9)
  par(mfrow = c(1,1), mar = c(5.1,5.1,4.1,2.1))
  plotSpectra(baseSpec,
              which=c(3,2,1),
              xlim=c(1800,1300),
              title="ATR-FTIR test with a Ge ATR crystal APTES detail, 21-05-2014",
              offset= 0.01,
              yrange=c(-0.01,0.05),
              xaxt = "n",
              lab.pos = (mean(baseSpec$freq)*0.65))
  at <- seq(from = 0, to = max(baseSpec$freq), by = 20)
  axis(side = 1, at = at, las = 2, hadj = 0.9)
dev.off()
