# Gray's Reef NMS file reformatting adjusted for HI01
# Created by Liz Ferguson on 5/15/2024

# Make sure to adjust input and output folders

# Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "HI01"

# Set the path to your folder containing the wav files
input_folder <- "H:/BioSound/BioSound_Datasets/SanctSound_HI01/File_Rename_Test"
output_folder <- "H:/BioSound/BioSound_Datasets/SanctSound_HI01/File_Rename_Test/Test_Rename"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Find the position of the date/time part using regex
  matches <- regexec("_(\\d{8}T\\d{6})Z", file_path)
  match_data <- regmatches(file_path, matches)
  
  # Extract the date/time part from the match
  date_time_part <- substring(match_data[[1]][2], 1, nchar(match_data[[1]][2]) - 1) # Drop the 'Z' at the end
  
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
  file.copy(file_path, new_file_path)
  
  reformatted_count <- reformatted_count + 1
}

# Generate output message at the end
cat("Reformatted", reformatted_count, ifelse(reformatted_count == 1, "file", ""), 
    if (reformatted_count > 0) paste(user_title, "Files"), "\n")
