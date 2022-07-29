# for a single study ----

custom_scatterplot <- function(data = study2$df ,
                     x = "elevation",
                     xlab = NULL,
                     y = "police_funding",
                     ylab = NULL,
                     group = "condition",
                     pal = conditions_palette,
                     text.size = 15) {
  
  
  scatter <- ggplot(data,
                    aes(x = .data[[x]],
                        y = .data[[y]],
                        color = .data[[group]])) +
    scale_colour_manual(values = pal) +
    #scale_fill_manual(values=pal) +
    #ylab(x) +
    #scale_x_continuous(limits = c(.8, 7.2)) + # pulls the line beyond the data a bit
    #scale_shape_discrete(      solid=F      ) +
    geom_jitter(size = 1, alpha = .3) +
    geom_smooth(
      method = lm,
      size = 1.4,
      fullrange = F,
      level = 0.95
    )  +
    xlab(xlab) +
    ylab(ylab) +
    theme_classic( base_size = text.size) +
    theme(legend.position = "none")
  
  ydensity <- 
    ggplot( data,
            aes(.data[[y]], colour=.data[[group]])
    ) + 
    geom_density(alpha=.3) + 
    scale_color_manual(values = pal, name = "Condition") + 
    #ylim(0, 1) +  #not sure if we need this
    coord_flip() + 
    theme_classic( base_size = text.size) +
    theme(legend.position = "right",
          axis.title.y = element_blank(),
          axis.text.x = element_blank()
    )
  
  xdensity <- ggplot(data, aes(.data[[x]], colour=.data[[group]])) + 
    geom_density(alpha=.3) + 
    # ylim(0, 3) +
    scale_color_manual(values = pal) + 
    theme_classic( base_size = text.size) +
    theme(legend.position = "none",
          axis.title.x = element_blank(),
          axis.text.y = element_blank() )
  
  blank_plot <- ggplot(data, aes(fill=.data[[group]], linetype=.data[[group]]))+
    #geom_blank(aes(1,1))+
    theme(plot.background = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          panel.border = element_blank(),
          panel.background = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_blank(), 
          axis.text.y = element_blank(),
          axis.ticks = element_blank()
    )
  
  grid.arrange( xdensity, blank_plot, scatter, ydensity,
                ncol = 2, nrow = 2, heights = c(.5,1), widths = c(1, .75)  )
  
  
}

# multi study ----




custom_scatterplot_all <- function(
                               x = "conservativism_overall",
                               xlab = NULL,
                               y = "elevation",
                               ylab = NULL,
                               group = "condition",
                               pal = conditions_palette,
                               text.size = 15) {
  
  
  data <-   bind_rows(
    list(
      pilot  =    pilot$df  %>% select(group, x, y),
      study1 =    study1$df %>% select(group, x, y),
      study2 =    study2$df %>% select(group, x, y)
    ),
    .id = "study"
  )
  
  
  
  scatter <- ggplot(data,
                    aes(x = .data[[x]],
                        y = .data[[y]],
                        color = .data[[group]],
                        linetype = study,
                        shape = study)) +
    scale_colour_manual(values = pal) +
    scale_linetype_manual(values=c("longdash","dotted",  "solid")) +
    #scale_fill_manual(values=pal) +
    xlab(xlab) +
    ylab(ylab) +
    #scale_x_continuous(limits = c(.8, 7.2)) + # pulls the line beyond the data a bit
    #scale_shape_discrete(      solid=F      ) +
    geom_jitter(size = 1, alpha = .3) +
    geom_smooth(
      method = lm,
      size = 1.4,
      fullrange = F,
      level = 0.95
    )  +
    theme_classic( base_size = text.size) +
    theme(legend.position = "none")
  
  ydensity <- 
    ggplot( data,
            aes(.data[[y]], colour=.data[[group]], linetype = study)
    ) + 
    geom_density(alpha=.3) + 
    scale_color_manual(values = pal, name = "Condition") + 
    scale_linetype_manual(values=c("longdash","dotted",  "solid"), name = "Study") +
    #ylim(0, 1) +  #not sure if we need this
    coord_flip() + 
    theme_classic( base_size = text.size) +
    theme(legend.position = "right",
          axis.title.y = element_blank(),
          axis.text.x = element_blank()
    )
  
  xdensity <- ggplot(data, aes(.data[[x]], colour=.data[[group]], linetype = study)) + 
    geom_density(alpha=.3) + 
    scale_linetype_manual(values=c("longdash","dotted",  "solid")) +
    # ylim(0, 3) +
    scale_color_manual(values = pal) + 
    theme_classic( base_size = text.size ) +
    theme(legend.position = "none",
          axis.title.x = element_blank(),
          axis.text.y = element_blank())
  
  blank_plot <- ggplot(data, aes(fill=.data[[group]], linetype=.data[[group]]))+
    #geom_blank(aes(1,1))+
    theme(plot.background = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          panel.border = element_blank(),
          panel.background = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_blank(), 
          axis.text.y = element_blank(),
          axis.ticks = element_blank()
    )
  
  grid.arrange( xdensity, blank_plot, scatter, ydensity,
                ncol = 2, nrow = 2, heights = c(.5,1), widths = c(1, .75)  )
  
  
}



