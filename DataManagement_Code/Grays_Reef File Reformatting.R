# Gray's Reef NMS file reformatting 
# Created by Jared Stephens 12/6/23

### Make sure to adjust input and output folders 


### Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "GRNMS"

# Set the path to your folder containing the wav files
input_folder <- "H:/BioSound/BioSound_Datasets/NEFSC_GRNMS_201812_GR01/671363112_48kHz/"

# Set the path to the output folder
output_folder <- "H:/BioSound/Processed_Datasets/NEFSC_GRNMS_GR01/GR01_renamed/"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Extract date/time part from the original file (starting from the 15th value from the right part of the file name)
  date_time_part <- substr(file_path, nchar(file_path) - 15, nchar(file_path) - 1)
  
  # Separate the components
  year_part <- paste0("20", substr(date_time_part, 1, 2))
  month_part <- substr(date_time_part, 3, 4)
  day_part <- substr(date_time_part, 5, 6)
  hour_part <- substr(date_time_part, 7, 8)
  minute_part <- substr(date_time_part, 9, 10)
  second_part <- substr(date_time_part, 11, 12)
  
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
  file.copy(file_path, new_file_path)
  
  reformatted_count <- reformatted_count + 1
}

# Generate output message at the end
cat("Reformatted", reformatted_count, ifelse(reformatted_count == 1, "file", ""),
    if (reformatted_count > 0) paste(user_title, "Files"), "\n")
