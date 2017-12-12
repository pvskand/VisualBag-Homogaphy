# Homography Estimation and Visual Bag of Words
This project contains the following:
1) Homography_ready_made/ - A folder to easily access the mosaic images and run them
2) code/ - folder containing souce code and dataset.
3) report.pdf - report of the assignment
4) nearest_neighbours/ - folder consisting of some of the 200 visualizations of the patches (closest neighbours to the mean)
5) This README

-------------------------------------------------------------------------

Download the `fashion-mnist_test.csv` and `fashion-mnist_train.csv` from Fashion MNIST data github page.

## TASK 1 - Visual Bag of words

Run : go to code/
and type RunAll_2014CSB1034 in the matlab console.

-------------------------------------------------------------------------

## TASK 2 - Mosaic

Run code:
go to code/
and type the following : [cropped_mosaic] = ComputeHomography_2014CSB1034(img1, img2)
where img1 is the image 1 and img2 is the image 2. Sample images are present in Homography_ready_made/ folder.

Now choose 4 points in img1 and hit enter, and similarly choose 4 points in img2 and hit enter. The mosaic image will be shown after the code runs.
-------------------------------------------------------------------------
Homography_ready_made
In order to show some ready made output, I have made a ready-made code that wouldn't require you marking the points.
To run the code type : ComputeHomographyReady in the MATLAB console and see the output.


-------------------------------------------------------------------------

nearest_neighbours/ - directory consists of the visualizaions of the patches that are the closest to the mean clusters. 

-------------------------------------------------------------------------

References :
[1] : http://www.cs.cornell.edu/courses/cs6670/2011sp/projects/p2/project2.html - Yosemite and the campus images are taken from this site.