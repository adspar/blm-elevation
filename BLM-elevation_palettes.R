# This is a colorblind-friendly palette I like to use 
cbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
# barplot(1:8, col = cbPalette) # run this to see the colors

## pick colors to correspond to conditions
conditions_palette <- cbPalette[c(1,3,2)] 
names(conditions_palette) <- c("BLM", "BtB", "control" )

## colors for parties
parties_palette <- cbPalette[c(7,6,5)]
names(parties_palette) <- c("Republican", "Democrat", "Independent")
