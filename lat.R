install.packages("ggplot2")
install.packages("factoextra")
install.packages("magick")

set.seed(123)
data <- rbind(
  matrix(rnorm(100, mean = 0), ncol = 2),
  matrix(rnorm(100, mean = 3), ncol = 2),
  matrix(rnorm(100, mean = 6), ncol = 2)
)
data <- as.data.frame(data)

k <- 3
kmeans_result <- kmeans(data, centers = k, nstart = 25)

# Simpan centroid untuk setiap iterasi
centroids <- list()
for (i in 1:10) {
  kmeans_result <- kmeans(data, centers = k, nstart = i)
  centroids[[i]] <- kmeans_result$centers
}

library(ggplot2)
library(magick)
library(factoextra)

images <- list()
for (i in 1:length(centroids)) {
  p <- fviz_cluster(kmeans_result, data = data, geom = "point", 
                    ellipse.type = "convex", 
                    palette = "jco", 
                    ggtheme = theme_minimal()) +
    geom_point(aes(x = centroids[[i]][,1], y = centroids[[i]][,2]), 
               color = "red", size = 5) +
    ggtitle(paste("Iterasi:", i)) +
    theme(plot.title = element_text(hjust = 0.5))
  
  # Simpan plot sebagai gambar
  ggsave(filename = paste0("plot_", i, ".png"), plot = p)
  images[[i]] <- image_read(paste0("plot_", i, ".png"))
}

gif <- image_animate(image_join(images), fps = 1)
image_write(gif, "cluster_centroids.gif")
