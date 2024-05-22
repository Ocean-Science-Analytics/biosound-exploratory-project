# This code it to remove the extra underscore in a set of files for GRNMS

# Define the directory with your files
directory_path <- "H:/BioSound/Processed_Datasets/01_16kHz_SR/Chuckchi_Sea_AK_16kHz_SR/Chuckchi_Sea_AK_5min/2019_03_5min"

# Get a list of all files in the directory
file_list <- list.files(directory_path, full.names = TRUE)

# Loop through each file and rename it
for (file_path in file_list) {
  # Get the base file name
  base_name <- basename(file_path)
  
  # Check if the name contains "GRNMS__" or whatever prefix
  if (grepl("Chuckchi.Sea__", base_name)) {
    # Replace the double underscore with a single one
    new_name <- gsub("Chuckchi.Sea__", "Chuckchi.Sea_", base_name)
    
    # Create the new full file path
    new_path <- file.path(directory_path, new_name)
    
    # Rename the file
    file.rename(file_path, new_path)
  }
}
