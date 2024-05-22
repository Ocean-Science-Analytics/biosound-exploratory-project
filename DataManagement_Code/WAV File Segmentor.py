# This script segments WAV files into shorter files based on a user defined time 

import os
import soundfile as sf
from datetime import datetime, timedelta


input_folder = "H:/BioSound/Processed_Datasets/01_16kHz_SR/SanctSound_HI01/HI01_renamed_16kHz/2019_02_300sec" # Folder directory with WAV files
output_folder = "H:/BioSound/Processed_Datasets/01_16kHz_SR/SanctSound_HI01/HI01_renamed_16kHz/2019_02_150sec" # Folder directory where new segmented files will be saved
segment_length_minutes = 2.5  # Segmented file length (in mintues)


def split_wav_file(input_file, output_folder, segment_length_minutes):
    # Load the input WAV file
    data, samplerate = sf.read(input_file)
    # Calculate the number of samples in each segment
    segment_length_seconds = segment_length_minutes * 60
    segment_length_samples = int(samplerate * segment_length_seconds)
    # Calculate the total number of segments
    total_segments = len(data) // segment_length_samples
    # Get the base filename without extension
    base_filename = os.path.splitext(os.path.basename(input_file))[0]
    # Create the output folder if it doesn't exist
    os.makedirs(output_folder, exist_ok=True)
    # Split the WAV file into segments and save each segment as a separate WAV file
    for i in range(total_segments):
        start_index = i * segment_length_samples
        end_index = start_index + segment_length_samples
        segment_data = data[start_index:end_index]
        # Calculate the time increment based on segment length
        time_increment = timedelta(minutes=i * segment_length_minutes)
        # Create the new filename with the time increment
        new_filename = (datetime.strptime(base_filename[-15:], "%Y%m%d_%H%M%S") + time_increment).strftime("%Y%m%d_%H%M%S")
        output_file = os.path.join(output_folder, f"{base_filename[:-15]}{new_filename}.wav")
        sf.write(output_file, segment_data, samplerate)

def split_wav_files_in_folder(input_folder, output_folder, segment_length_minutes):
    # Iterate over all files in the input folder
    for file_name in os.listdir(input_folder):
        if file_name.endswith(".wav"):
            input_file = os.path.join(input_folder, file_name)
            split_wav_file(input_file, output_folder, segment_length_minutes)

split_wav_files_in_folder(input_folder, output_folder, segment_length_minutes)


# C:\\Users\\16614\\Documents\\OSA\\Scikit-Maad\\Test Folder
# C:\\Users\\16614\\Documents\\OSA\\Scikit-Maad\\Test Folder\\Output Files
