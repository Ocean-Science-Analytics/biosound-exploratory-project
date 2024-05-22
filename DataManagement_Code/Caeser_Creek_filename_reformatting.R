# Caeser Creek file naming 
# Created by Jared Stephens 12/6/23

### Make sure to adjust input and output folders



### Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "CaserCreek"


# Set the path to your folder containing the wav files
input_folder <- "C:/Users/16614/Documents/OSA/Scikit-Maad/Caeser Creek"
output_folder <- "C:/Users/16614/Documents/OSA/Scikit-Maad/Caeser Creek/Output"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Extract date/time part from the original file name
  date_time_part <- gsub(".*/(\\d{8}T\\d{6})_.*\\.wav", "\\1", file_path)
  
  # Convert date/time part to the desired format
  formatted_date_time <- format(
    as.POSIXct(date_time_part, format = "%Y%m%dT%H%M%S"),
    format = "%Y%m%d_%H%M%S"
  )
  
  # Create the new file name
  new_file_name <- paste0(user_title, "_", formatted_date_time, ".wav")
  
  return(new_file_name)
}

# Count of reformatted files
reformatted_count <- 0

# This loop converts the actual files
# Create new versions in the output folder with updated names
for (file_path in wav_files) {
  new_file_name <- convert_file_names(file_path, user_title)
  new_file_path <- file.path(output_folder, new_file_name)
  
  # Copy the file to the output folder with the new name
  file.copy(file_path, new_file_path)
  
  reformatted_count <- reformatted_count + 1
}

# Generate output message
cat("Reformatted", reformatted_count, ifelse(reformatted_count == 1, "file", ""), user_title, "Files\n")
