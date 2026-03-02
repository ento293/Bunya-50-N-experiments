
# TITLE: Plate data to tidy data
# AUTHOR: Charli Geer
# Created: Feb 16, 2026
# Purpose: Take raw data from 50N mismatch experiment and transfer into
# the empty columns of an existing tidy dataframe. Will keep the order 
# the same so this needs to be checked after transfer.
# This is a function to be used in each experimental analysis.


plate_to_tidy <- function(
    plate1,
    plate2,
    plate3,
    template,
    output_file = "output_file"
    ) {

# read in the plate data
plate_1 <- read_excel(plate1) %>%
  rename(excel_row = 1) %>% 
  mutate(row = 1:n()) %>%
  select(row, everything())
colnames(plate_1) <- c("row", "excel_row", as.character(1:(ncol(plate_1)-1)))

plate_2 <- read_excel(plate2) %>%
  rename(excel_row = 1) %>% 
  mutate(row = 1:n()) %>%
  select(row, everything())
colnames(plate_2) <- c("row", "excel_row", as.character(1:(ncol(plate_2)-1)))

plate_3 <- read_excel(plate3) %>%
  rename(excel_row = 1) %>% 
  mutate(row = 1:n()) %>%
  select(row, everything())
colnames(plate_3) <- c("row", "excel_row", as.character(1:(ncol(plate_3)-1)))

# read in the tidy data template
tidy_df <- read_excel(template)

# create function to collect data from each plate
# stack data vertically
extract_fLuc <- function(df) {
  main <- df %>%
    filter(row %in% 2:6) %>% # select rows
    select(all_of(as.character(2:11))) %>% # select columns
    as.matrix() %>% t() %>% as.vector() #transpose
  
  extra <- df %>%
    filter(row == 7) %>%
    select(all_of(as.character(2:5))) %>% 
    as.matrix() %>% t() %>% as.vector()
  
  c(main, extra) 
}

extract_nLuc <- function(df) {
  main <- df %>%
    filter(row %in% 12:16) %>% 
    select(all_of(as.character(2:11))) %>%
    as.matrix() %>% t() %>% as.vector()
  
  extra <- df %>%
    filter(row == 17) %>%   
    select(all_of(as.character(2:5))) %>%
    as.matrix() %>% t() %>% as.vector()
  
  c(main, extra)
}

# add plate1 data to tidy df
tidy_df <- tidy_df %>%
  mutate(
    fLuc = replace(
      fLuc,
      Plate == 1,
      extract_fLuc(plate_1)
    ),
    nLuc = replace(
      nLuc,
      Plate == 1,
      extract_nLuc(plate_1)
    )
  )

# add plate2 data to tidy df
tidy_df <- tidy_df %>%
  mutate(
    fLuc = replace(
      fLuc,
      Plate == 2,
      extract_fLuc(plate_2)
    ),
    nLuc = replace(
      nLuc,
      Plate == 2,
      extract_nLuc(plate_2)
    )
  )

# add plate3 data to tidy df
tidy_df <- tidy_df %>%
  mutate(
    fLuc = replace(
      fLuc,
      Plate == 3,
      extract_fLuc(plate_3)
    ),
    nLuc = replace(
      nLuc,
      Plate == 3,
      extract_nLuc(plate_3)
    )
  )

write_xlsx(tidy_df, path = output_file)
}

