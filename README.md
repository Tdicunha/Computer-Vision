# Computer-Vision
These four projects were undertaken as part of the course “Computer Vision” with the aim of providing insights into the field of computer vision and its diverse methodologies.

## Image Filtering and Hough Transform
This first project has the aim to develop an image processing algorithm to enable the construction of a line detector based on the Hough transform from a set of images. To achieve this goal, a set of algorithms was implemented in the different functions with the aim of obtaining similar results from the pre-existing functions in the “Matlab Image Processing Toolbox” library. In order to obtain these results, it was necessary to divide the project into four steps:
- Image Filter: This first step has the aim of smoothing an image through the convolution with a Gaussian filter, the size of which depends on the parameter sigma.
- Edge Filter: The second step has the aim of finding the edges and orientation from the convolution image obtained in the previous step.
- Hough Transform: The third step consists of the application of the Hough Transform to the image obtained in the previous step. Through this method, it is possible to detect several geometric shapes, such as lines, circles, and other parametric curves.
- Hough Lines: The last step has the aim to detect the maximum values of the matrix obtained in the previous step, in order to obtain the highest theta and rho values that define possible straight lines.

![img01](https://github.com/telmocunha/Computer-Vision/assets/45535834/ef18f7e2-6fc7-4caa-a873-9ab30fa2f74a)

![img01_04lines](https://github.com/telmocunha/Computer-Vision/assets/45535834/c996d12c-46e3-43c3-855c-feaa7f00c5d4)

## Feature Detection and Matching
The second project aims to develop image processing algorithms for detecting identical images between a query image and its subsequent test images while ensuring that the features remain invariant to translations, rotations, and scales. The project is structured into the following functions:
- Harris Corner: The first function in this algorithm identifies interest points using Harris Corner detection method.
- Keypoints detection: The second function returns a new data structure that contains the coordinates obtained from the previous step as well as the integration of two new parameters, which are the orientation of the keypoints and their scales.
- Feature Descriptor: This third function consists of the extraction of a descriptor for each feature centered on each point of interest obtained in the previous stage. To implement this function, two descriptor concepts were developed: a simple descriptor and an S-MOPS descriptor.
- Feature Matching: This fourth function implements an algorithm to associate features, i.e., using a query image to find the best matches in several test images. For this, two methods are used: the SSD method and the Ratio method.
- Show Matching: This last function has the purpose of displaying the keypoints of two images and connect these keypoints with lines.

<p float="left">
  <img src="https://github.com/telmocunha/Computer-Vision/assets/45535834/68b7a8e3-3c65-429f-88aa-134431647bca" width="400" />
  <img src="https://github.com/telmocunha/Computer-Vision/assets/45535834/30e4ca20-9255-4960-8824-20f569dfe49e" width="400" />
</p>

## Geometric Camera Calibration 
This third project has the goal to develop algorithms for the geometric calibration of a camera, calculating its parameters and determining the lens distortions coefficients. The project is divided into the following steps:
- Data Normalization: This first step consists of normalizing the points obtained in the xy.mat and XYZ.mat files.
- Direct Linear Transform: The second step has the aim of minimizing the algebraic error of the camera calibration.
- Camera Matrix Decomposition: The third step consists of calculating the intrinsic and extrinsic parameters from the decomposition of the calibration matrix obtained in the previous step. For this, it was used two methods: QR-Factorization and EXPlicit Decomposition.
- Gold Standard Algorithm: The final step of the project focuses on implementing an algorithm to minimize geometric errors

![image001](https://github.com/telmocunha/Computer-Vision/assets/45535834/4456b288-6f55-421f-b149-be9af3b275c8)

![i![work3_final_img](https://github.com/telmocunha/Computer-Vision/assets/45535834/48748fc2-459e-4e18-b10e-c187b4dfb15b)

## 3D Reconstruction
The last project has the aim to reconstruct a monument in 3D from a set of available images. By geometric calibrating a camera, it is possible to determine its intrinsic and extrinsic parameters using projective geometry. To achieve the goal of this project, two reconstruction methods were developed: Sparce Reconstruction and Dense Reconstruction.
### Sparce Reconstruction:
To implement this method, it is necessary to use two images of the monument. This allows to determine the fundamental matrix, essential matrix, and the corresponding points to perform the Sparce Reconstruction. This method is composed by the following steps: 
- Compute F: Calculates the fundamental matrix. 
- findEpipolarMatches: Calculates the epipolar lines of corresponding points in image 1 to image 2.
- Compute E: Calculates the essential matrix.
- Triangulation: Performs the Sparce Reconstruction.

![work4_sparse_img](https://github.com/telmocunha/Computer-Vision/assets/45535834/58fd1fcc-b139-44d6-adcc-09b11b848059)

### Dense Reconstruction
For a better visualization of 3D reconstructions, this method produces better results compared to Sparce Reconstruction. The following functions were used to develop this method:
- rectifyMatrices: This function determines two rectifications matrices and new intrinsic and extrinsic parameters.
- computeDisparity: This function creates a disparity map from a pair of rectified images.
- computeDepth: This function creates a depth map from the disparity map.

![work4_dense_img](https://github.com/telmocunha/Computer-Vision/assets/45535834/52958323-d3b5-4df3-af8c-91d8b0c3a2c1)
