library(tidyverse)
library(readxl)
library(lme4)
library(writexl)


# combine 50N experiments (no NSs) into one excel sheet

# read in data
L1 <- read_excel("../2025_10_06_LACV_50N_no_NSs_exp1/data/2025_10_09_LACV_50N_no_NSs_exp1_tidy.xlsx")
L2 <- read_excel("../2026_02_03_LACV_50N_no_NSs_exp2/data/2026_02_06_LACV_50N_no_NSs_exp2_tidy.xlsx")
L3 <- read_excel("../2026_02_12_LACV_50N_no_NSs_exp3/data/2026_02_15_LACV_50N_no_NSs_exp3_tidy.xlsx")

B1 <- read_excel("../2025_10_10_BUNV_50N_no_NSs_exp1/data/2025_10_10_BUNV_50N_no_NSs_exp1_tidy.xlsx")
B2 <- read_excel("../2026_01_17_BUNV_50N_no_NSs_exp2/data/2026_01_17_BUNV_50N_no_NSs_exp2_tidy.xlsx")

K1 <- read_excel("../2026_03_16_KRIV_50N_no_NSs_exp1/data/2026_03_18_KRIV_50N_no_NSs_exp1_tidy.xlsx")
K2 <- read_excel("../2026_03_29_KRIV_50N_no_NSs_exp2/data/2026_03_18_KRIV_50N_no_NSs_exp1_tidy.xlsx")

# kinda brute forcing things
# but normalizing each experiment to its own N-only control
# then will combine into one df

# -----
# L1
# -----

# calculate nLuc / fLuc
L1 <- L1 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
L1$bg_nLuc          <- L1 %>% filter(N == "LACV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
L1$bg_nLuc_rel_fLuc <- L1 %>% filter(N == "LACV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
L1 <- L1 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# add exp_name column
L1 <- L1 %>% 
  mutate(exp_name = "LACV1")

# -----
# L2
# -----

# calculate nLuc / fLuc
L2 <- L2 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
L2$bg_nLuc          <- L2 %>% filter(N == "LACV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
L2$bg_nLuc_rel_fLuc <- L2 %>% filter(N == "LACV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
L2 <- L2 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)
# add exp_name column
L2 <- L2 %>% 
  mutate(exp_name = "LACV2")

# -----
# L3
# -----

# calculate nLuc / fLuc
L3 <- L3 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
L3$bg_nLuc          <- L3 %>% filter(N == "LACV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
L3$bg_nLuc_rel_fLuc <- L3 %>% filter(N == "LACV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
L3 <- L3 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# add exp_name column
L3 <- L3 %>% 
  mutate(exp_name = "LACV3")

# -----
# B1
# -----

# calculate nLuc / fLuc
B1 <- B1 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
B1$bg_nLuc          <- B1 %>% filter(N == "BUNV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
B1$bg_nLuc_rel_fLuc <- B1 %>% filter(N == "BUNV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
B1 <- B1 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# add exp_name column
B1 <- B1 %>% 
  mutate(exp_name = "BUNV1")

# -----
# B2
# -----

# calculate nLuc / fLuc
B2 <- B2 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
B2$bg_nLuc          <- B2 %>% filter(N == "BUNV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
B2$bg_nLuc_rel_fLuc <- B2 %>% filter(N == "BUNV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
B2 <- B2 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# add exp_name column
B2 <- B2 %>% 
  mutate(exp_name = "BUNV2")

# -----
# K1
# -----

# calculate nLuc / fLuc
K1 <- K1 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
K1$bg_nLuc          <- K1 %>% filter(N == "KRIV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
K1$bg_nLuc_rel_fLuc <- K1 %>% filter(N == "KRIV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
K1 <- K1 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# add exp_name column
K1 <- K1 %>% 
  mutate(exp_name = "KRIV1")

# -----
# K2
# -----

# calculate nLuc / fLuc
K2 <- K2 %>% mutate(nLuc_rel_fLuc = nLuc / fLuc)

# calculate N-only nLuc average
K2$bg_nLuc          <- K2 %>% filter(N == "KRIV N only") %>% summarize(bg_nLuc = mean(nLuc)) %>% pull(bg_nLuc)
K2$bg_nLuc_rel_fLuc <- K2 %>% filter(N == "KRIV N only") %>% summarize(bg_nLuc_rel_fLuc = mean(nLuc_rel_fLuc)) %>% pull(bg_nLuc_rel_fLuc)

# normalize to N-only nLuc average
K2 <- K2 %>% mutate(nLuc_rel_bg = nLuc / bg_nLuc,
                    nLuc_rel_fLuc_rel_bg = nLuc_rel_fLuc / bg_nLuc_rel_fLuc)

# add exp_name column
K2 <- K2 %>% 
  mutate(exp_name = "KRIV2")


# combine dfs and save
df <- rbind(L1, L2, L3, B1, B2, K1, K2)

write_xlsx(df, "combined_50N_data.xlsx")


# set up a glm with exp_name and Experiment
model <- glmer(
  nLuc_rel_fLuc_rel_bg ~ N +
    
)
