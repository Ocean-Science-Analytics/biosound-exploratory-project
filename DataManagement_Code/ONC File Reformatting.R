# ONC file reformatting 
# Created by Jared Stephens 12/8/23

# NOTE: Make sure to adjust input and output folder paths


### Set your user-defined title
# NOTE: Don't put a "_" in the user title, this will mess up the SM4 format
user_title <- "ONC"


# Set the path to your folder containing the wav files
input_folder <- "H:/BioSound/BioSound_Datasets/ONC_MEF_1004539/2019_02"

# Set the path to the output folder
output_folder <- "H:/BioSound/Processed_Datasets/02_Native_SR/ONC_MEF_1004539/ONC_MEF_renamed/2019_02"

# List all wav files in the input folder
wav_files <- list.files(input_folder, pattern = "\\.wav$", full.names = TRUE)

 