##README.md

To reproduce the downloading and cleaning of the UCI HAR dataset, simply source file "run_analysis.R". If the UCI HAR dataset is not already downloaded and unzipped in the working directory, then uncomment the first two lines of "run_analysis.R" to download and unzip the files. The zip archive is almost 60MB, so it is best to just download it once.

"run_analysis.R" is the only script that must be run. However, within the UCI HAR Dataset folder, there are several descriptive text files that describe how the dataset was assembled from Samsung smartphone accelerometer and gyroscope signals. Also, a CodeBook.md file describes step-by-step the data cleaning process used to produce "tidy_data.txt"