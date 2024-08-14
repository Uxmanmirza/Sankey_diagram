setRepositories()


### Simple Sankey diagram ----
# install.packages("networkD3")
library(networkD3)

nodes1 <- data.frame(name = c("blaTEM", "mecA", "vanA", "tetA", "ampC", "CTX-M", "SHV", "KPC", "OXA", "ermB", "Poultry", "Human"))
edges <- data.frame(source = c(0, 1, 2, 3, 4,5, 6, 7, 8, 9), 
                    target = c(11, 10, 10, 11, 10, 10,10,10,10,10), 
                    value = c(20, 20, 30, 30, 30, 10, 40, 20, 50, 30))
 

# Create the Sankey diagram
sna <- sankeyNetwork(Links = edges, Nodes = nodes1, Source = "source", Target = "target", Value = "value", NodeID = "name",
                     fontSize = 20, nodeWidth = 35, 
                     LinkGroup = "color",  
                     colourScale = JS("d3.scaleOrdinal().range(d3.schemeCategory20)"))

sna

saveNetwork(sna, file = "sankey_diagram1.html", selfcontained = TRUE)

webshot("sankey_diagram1.html", "sankey_diagram1.png")


### Sankey diagram and save ----

library(networkD3)
library(dplyr)

# Create nodes dataframe
nodes <- data.frame(
  name = c("Citrobacter portucalensis", "Escherichia coli", "Citrobacter werkmanii",
           "Enterobacter hormaechei", "Providencia alcalifaciens", "Acinetobacter lwoffii",
           "Acinetobacter variabilis", "Acinetobacter baumannii", "Enterobacteriaceae",
           "Moraxellaceae", "tet (X4)", "tet (X6)", "tet (X3)", "tet (X15)",
           "Plasmid", "ICE", "Chromosome")
)

# Create links dataframe
links <- data.frame(
  source = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 9, 9, 9, 10, 11, 11, 12, 13),
  target = c(8, 8, 8, 8, 8, 9, 9, 9, 10, 11, 11, 12, 13, 14, 14, 15, 14, 16),
  value = c(30, 20, 10, 10, 10, 10, 10, 10, 50, 10, 10, 10, 5, 60, 20, 10, 20, 5)
)

# Define color palette
color_palette <- c("#FF9999", "#E69F9F", "#CCCCFF", "#FFB3D9", "#FF6666", 
                   "#FFB3BA", "#FFB3BA", "#A6D5FF", "#B399FF", "#99FFCC", 
                   "#FFD700", "#FF6347", "#9370DB", "#20B2AA")

# Assign colors to links based on source
links$color <- color_palette[links$source + 1]



p <- sankeyNetwork(Links = links, Nodes = nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              fontSize = 13, nodeWidth = 35, LinkGroup = "color",  
              colourScale = JS("d3.scaleOrdinal().range(d3.schemeCategory20)"))
p


saveNetwork(p, file = "sankey_diagram.html", selfcontained = TRUE)

# Save 
install.packages("webshot", dependencies = T)
library(webshot)
webshot::install_phantomjs()
webshot("sankey_diagram.html", "sankey_diagram.png")

