# Gray's Reef NMS file reformatting adjusted for HI01
# Created by Liz Ferguson on 5/15/2024

# Make sure to adjust input and output folders

# Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "HI01"

# Set the path to your folder containing the wav files
folder_path <- "H:/BioSound/BioSound_Datasets/SanctSound_HI01/File_Rename_Test"

# List all wav files in the folder
wav_files <- list.files(folder_path, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Use regex to extract the full datetime part, ensuring we get the complete time including seconds
  matches <- regexec("_(\\d{8}T\\d{6})Z", file_path)
  match_data <- regmatches(file_path, matches)
  
  if (length(match_data[[1]]) > 1) {  # Check if a match was found
    datetime <- match_data[[1]][2]
    datetime <- sub("T", "_", datetime)  # Replace 'T' with '_'
    datetime <- sub("Z", "", datetime)   # Remove 'Z' at the end
    
    # Separate date and time for final format
    date_part <- substr(datetime, 1, 8)
    time_part <- substr(datetime, 10, 15)
    
    # Construct the new date/time format
    formatted_date_time <- paste0(date_part, "_", time_part)
    
    # Create the new file name
    new_file_name <- paste0(user_title, "_", formatted_date_time, ".wav")
    
    return(new_file_name)
  } else {
    return(NULL)  # Return NULL if no match was found (as a fallback)
  }
}

# Count of reformatted files
reformatted_count <- 0

# Rename files in the existing folder
for (file_path in wav_files) {
  new_file_name <- convert_file_names(file_path, user_title)
  new_file_path <- file.path(folder_path, new_file_name)
  
  # Rename the file in the same folder
  if (file.rename(file_path, new_file_path)) {
    reformatted_count <- reformatted_count + 1
  }
}

# Generate output message at the end
cat("Reformatted", reformatted_count, ifelse(reformatted_count == 1, "file", ""), 
    if (reformatted_count > 0) paste(user_title, "Files"), "\n")
