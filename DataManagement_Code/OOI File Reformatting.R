# OOI File Reformatting 
# Created by Jared Stephens 12/8/23

# NOTE: Make sure to adjust input and output folder paths


### Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "OOI"


# Set the path to your folder containing the wav files
input_folder <- "H:/BioSound/BioSound_Datasets/OOI_HYDBBA106/2019_02"

# Set the path to the output folder
output_folder <- "H:/BioSound/Processed_Datasets/02_Native_SR/OOI_HYDBBA106/OOI_HYDBBA106_renamed"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Extract date/time part from the original file using regex
  date_time_match <- regmatches(file_path, regexpr("_\\d{8}-\\d{6}", file_path))
  date_time_part <- substr(date_time_match, 2, nchar(date_time_match))
  
  # Separate the components
  year_part <- substr(date_time_part, 1, 4)
  month_part <- substr(date_time_part, 5, 6)
  day_part <- substr(date_time_part, 7, 8)
  hour_part <- substr(date_time_part, 10, 11)
  minute_part <- substr(date_time_part, 12, 13)
  second_part <- substr(date_time_part, 14, 15)
  
  # Construct the new date/time format
  formatted_date_time <- paste0(year_part, month_part, day_part, "_", hour_part, minute_part, second_part)
  
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
  file.copy(file_path, new_file_path, overwrite = TRUE)
  
  reformatted_count <- reformatted_count + 1
}

# Generate output message at the end
cat("Reformatted", reformatted_count, ifelse(reformatted_count == 1, "file", ""),
    if (reformatted_count > 0) paste(user_title, "Files"), "\n")
