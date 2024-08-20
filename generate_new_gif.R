library(ggplot2)
library(grid)
library(png)
library(magick)

text1 = "Geospatial Intelligence Lab"
text2 = "\"Geospatial Intelligence for Sustainable Infrastructure and Industry\""
text3 = "Advancing the forefront of geospatial analysis and AI \nby creating cutting-edge methods and tools \nfor sustainable development within infrastructure and industry sectors."

ggplot() + 
  theme_void() +
  annotation_custom(textGrob(text1, x = 0.1, y = 0.815, just = "left", 
                             gp = gpar(fontsize = 20, fontface = "bold", 
                                       col = "white", lwd = 2.5)), 
                    xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  annotation_custom(textGrob(text2, x = 0.1, y = 0.7, just = "left", 
                             gp = gpar(fontsize = 16.5, fontface = "italic", 
                                       col = "white", lwd = 2.25)), 
                    xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  annotation_custom(textGrob(text3, x = 0.1, y = 0.55, just = "left", 
                             gp = gpar(fontsize = 11.5, fontface = "bold", 
                                       col = "white", lwd = 1.05)), 
                    xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  theme(plot.background = element_rect(fill = "transparent", color = NA))

ggsave("./text.png", width = 8, height = 4, dpi = 300, bg = "transparent")

gif = image_read("./bg.gif")
gif_info = image_info(gif)[1,]
text_overlay = image_read("./text.png") |> 
  image_scale(geometry = paste0(gif_info$width,"x",gif_info$height))

frames = image_apply(gif, function(frame) {
  image_composite(frame, text_overlay, offset = "+70+60")
})
image_write(image_animate(frames), path = "bg_with_text.gif")