library(tidyverse)
library(readxl)
library(patchwork)

df <- read_excel("./2025_01_31_BUNV_50N_exp1_tidy.xlsx")

# remove L-only from the data frame and use N-only instead
# df <- df %>% 
#   filter(!(N == "BUNV L only"))

# calculate nLuc / fLuc
df <- df %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc
df$bg_nLuc          <- df %>% filter(N == "BUNV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
df$bg_nLuc_rel_fLuc <- df %>% filter(N == "BUNV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only
df <- df %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# ---------------------
# activity vs. distance
# ---------------------

# pairwise % identity between GPCs involved
dist_df <- read_excel("../Orthobunya_metadata.xlsx")

df <- left_join(df, dist_df, by=c("N_pMDS" = "pMDS"))

# calculate averages of normalized luminescence
# use double-normalized luminescence values.  
# That is, normalized to both N-only and fLuc
df_norm_avg <- df %>% 
  group_by (N) %>%
  summarize(mean_lum     = mean(nLuc_rel_bg),
            sd_lum       = sd(nLuc_rel_bg),
            mean_rel_lum = mean(nLuc_rel_fLuc_rel_bg),
            sd_rel_lum   = sd(nLuc_rel_fLuc_rel_bg),
            BUNV_pct_id  = mean(Pct_ID_BUNV_N),
            .groups="drop") 

# Set y axis min and max values for cases when std_dev > mean, 
# This way, negative values won't be undefined by the log scale in ggplot
yaxis_min <- 1e-1
yaxis_max <- 1e5


# singly normalized luminescence - to N-only
ggplot(df_norm_avg) +
  geom_point(aes(x=BUNV_pct_id, y=mean_lum), shape=21, 
             fill="slateblue", color="black", size=3, stroke=0.25) +
  geom_errorbar(aes(x=BUNV_pct_id, 
                    ymin = ifelse((mean_lum - sd_lum) < yaxis_min, yaxis_min, mean_lum - sd_lum),
                    ymax = ifelse((mean_lum + sd_lum) > yaxis_max, yaxis_max, mean_lum + sd_lum)),
                linewidth=0.25, alpha=0.5, color="slateblue") + 
  geom_text(aes(x=BUNV_pct_id, y=mean_lum, label=N), 
            size=2.5, color="grey60", 
            nudge_x=3, 
            nudge_y=0, 
            check_overlap = F ) +
  xlab("Pairwise AA identity of N protein to BUNV N protein (%)") +
  ylab("nLuc relative N-only cells") +
  scale_y_log10() +
  theme_bw()  +
  ggtitle("Activity of 50 N proteins with BUNV L", subtitle="January 31, 2025")

# save as PDF
ggsave("2025_02_07_BUNV_50N_results_singly_normalized.pdf", units="in", width=10, height=7.5)

# doubly normalized luminescence (normalize to N-only and fLuc)
ggplot(df_norm_avg) +
  geom_point(aes(x=BUNV_pct_id, y=mean_rel_lum), shape=21, 
             fill="slateblue", color="black", size=3, stroke=0.25) +
  geom_errorbar(aes(x=BUNV_pct_id, 
                    ymin = ifelse((mean_rel_lum - sd_rel_lum) < yaxis_min, yaxis_min, mean_rel_lum - sd_rel_lum),
                    ymax = ifelse((mean_rel_lum + sd_rel_lum) > yaxis_max, yaxis_max, mean_rel_lum + sd_rel_lum)),
                linewidth=0.25, alpha=0.5, color="slateblue") +
  geom_text(aes(x=BUNV_pct_id, y=mean_rel_lum, label=N), 
            size=2.5, color="grey60", 
            nudge_x=3, 
            nudge_y=0, 
            check_overlap = F ) +
  xlab("Pairwise AA identity of N protein to BUNV N protein (%)") +
  ylab("nLuc relative to fLuc relative to N-only cells") +
  scale_y_log10() +
  theme_bw()  +
  ggtitle("Activity of 50 N proteins with BUNV L", subtitle="January 31, 2025")

# save as PDF
ggsave("2025_02_07_BUNV_50N_results_doubly_normalized.pdf", units="in", width=10, height=7.5)
