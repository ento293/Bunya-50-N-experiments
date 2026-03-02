
# TITLE: Plate data to tidy data
# AUTHOR: Charli Geer
# Created: Feb 26, 2026
# Purpose: Create single- and double-normalized graph of 50N experiment data

# HOW TO USE: fill in name of tidy template and raw plate data excel files.
# NOTE: plate files must match the exact raw format from the plate reader!


make_plots <- function(
    df,                  # df_norm_avg from analysis
    experiment_name,     # for file outputs
    experiment_date,     
    MG,                  # LACV, BUNV, or KRIV
    NSs_presence,        # with/yes or without/no
    point_color = "slateblue",
    error_bar_color = "slateblue",
    name_color = "grey60"
    ) {
  
  # Set y axis min and max values for cases when std_dev > mean, 
  # This way, negative values won't be undefined by the log scale in ggplot
  yaxis_min <- 1e-1
  yaxis_max <- 1e5
  
  # singly normalized luminescence (normalize to N-only)
  ggplot(df) +
    geom_point(aes(x = .data[[paste0(MG, "_pct_id")]], y = mean_lum), 
               shape=21, 
               fill=point_color, 
               color="black", 
               size=3, 
               stroke=0.25) +
    geom_errorbar(aes(x=.data[[paste0(MG, "_pct_id")]], 
                      ymin = ifelse((mean_lum - sd_lum) < yaxis_min, yaxis_min, mean_lum - sd_lum),
                      ymax = ifelse((mean_lum + sd_lum) > yaxis_max, yaxis_max, mean_lum + sd_lum)),
                  linewidth=0.25, 
                  alpha=0.5, 
                  color = error_bar_color) + 
    geom_text(aes(x=.data[[paste0(MG, "_pct_id")]], y=mean_lum, label=N), 
              size=2.5, 
              color=name_color, 
              nudge_x=3, 
              nudge_y=0, 
              check_overlap = F ) +
    xlab(glue("Pairwise AA identity of N protein to {MG} N protein (%)")) +
    ylab("nLuc relative N-only cells") +
    scale_y_log10() +
    theme_bw()  +
    ggtitle(glue("Activity of 50 N proteins with {MG} L ({NSs_presence} NSs)"), subtitle= experiment_date)
  
  # save as PDF
  ggsave(filename = glue("{experiment_name}_singly_normalized.pdf"),
         path = "../plots",
         units="in",
         width=10,
         height=7.5)
  
  # doubly normalized luminescence (normalize to N-only and fLuc)
  ggplot(df) +
    geom_point(aes(x= .data[[paste0(MG, "_pct_id")]], y=mean_rel_lum), shape=21, 
               fill= point_color, 
               color="black", 
               size=3, 
               stroke=0.25) +
    geom_errorbar(aes(x=.data[[paste0(MG, "_pct_id")]], 
                      ymin = ifelse((mean_rel_lum - sd_rel_lum) < yaxis_min, yaxis_min, mean_rel_lum - sd_rel_lum),
                      ymax = ifelse((mean_rel_lum + sd_rel_lum) > yaxis_max, yaxis_max, mean_rel_lum + sd_rel_lum)),
                  linewidth=0.25, 
                  alpha=0.5, 
                  color = error_bar_color) +
    geom_text(aes(x=.data[[paste0(MG, "_pct_id")]], y=mean_rel_lum, label=N), 
              size=2.5, 
              color=name_color, 
              nudge_x=3, 
              nudge_y=0, 
              check_overlap = F ) +
    xlab(glue("Pairwise AA identity of N protein to {MG} N protein (%)")) +
    ylab("nLuc relative to fLuc relative to N-only cells") +
    scale_y_log10() +
    theme_bw()  +
    ggtitle(glue("Activity of 50 N proteins with {MG} L ({NSs_presence} NSs)"), subtitle= experiment_date)
  
  # save as PDF
  ggsave(filename = glue("{experiment_name}_doubly_normalized.pdf"),
         path = "../plots",
         units="in",
         width=10,
         height=7.5)
}

