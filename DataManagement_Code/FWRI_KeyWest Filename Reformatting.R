# Marathon_FW filename reformatting 
# Created by Jared Stephens on 12/7/23

### Make Sure to adjust input and output folders



### Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "KeyWest"


# Set the path to your folder containing the wav files
input_folder <- "H:/BioSound/BioSound_Datasets/FWRI_KeyWest_WDR_grouper/2020-02"

# Set the path to the output folder
output_folder <- "H:/BioSound/Processed_Datasets/02_Native_SR/FWRI_KeyWest/FWRI_renamed/2020-02-renamed"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

# Function to convert file names
convert_file_names <- function(file_path, user_title) {
  # Extract date/time part from the original file name
  date_time_part <- gsub(".*/(\\d{8}T\\d{6})\\.wav", "\\1", file_path)
  
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

