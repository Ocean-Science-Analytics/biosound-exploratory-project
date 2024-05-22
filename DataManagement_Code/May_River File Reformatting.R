# Adjusted from OOI File rename code
# Date: 7/2/2023
# JS edits 12/8/23 - Restructured script to manually extract date/time data from specific locations
#     Also adjusted the file formatting to replace any " " with "0" to fix previous problem with single digit seconds or days

# NOTE: Make sure to adjust input and output folders 


### Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "May.River"

# Set the path to your folder containing the wav files
input_folder <- "H:/BioSound/BioSound_Datasets/MayRiver/14M_1154_041019/000/wav/2019_03"

# Set the path to the output folder
output_folder <- "H:/BioSound/Processed_Datasets/02_Native_SR/May_River/May_River_renamed/2019_03"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Extract date/time part from the original file (starting from the 15th value from the right part of the file name)
  date_time_part <- substr(file_path, nchar(file_path) - 25, nchar(file_path) - 1)
  
  # Separate the components
  year_part <- paste0("20", substr(date_time_part, 21, 22))
  month_part <- substr(date_time_part, 18, 19)
  day_part <- substr(date_time_part, 15, 16)
  hour_part <- substr(date_time_part, 1, 2)
  minute_part <- substr(date_time_part, 4, 5)
  second_part <- substr(date_time_part, 7, 8)
  
  # Construct the new date/time format with spaces replaced by 0
  formatted_date_time <- paste0(year_part, month_part, day_part, "_", hour_part, minute_part, second_part)
  formatted_date_time <- gsub(" ", "0", formatted_date_time)
  
  # Create the new file name
  new_file_name <- paste0(user_title, "_", formatted_date_time, ".wav")
  
  return(new_file_name)
}

# Count of reformatted files
reformatted_count <- 0

# Create new versions in the output folder with updated names
for (file_path in wav_files) {
  new_file_name <- convert_file_names(file_path, user_title)
  new_file_path <- file.path(output_folder, new_file_name)
  
  # Copy the file to the output folder with the new name
  file.copy(file_path, new_file_path)
  
  reformatted_count <- reformatted_count + 1
}

# Generate output message at the end
cat("Reformatted", reformatted_count, ifelse(reformatted_count == 1, "file", ""),
    if (reformatted_count > 0) paste(user_title, "Files"), "\n")
