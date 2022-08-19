clear all
close all
clc

% Load image
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

%Load intrinsics paramters
load("../data/intrinsics.mat")

%Load cords
load("../data/correspondences.mat")

%Compute the Fundamental Matrix
F = computeF(pts1, pts2);

%Finding correspondences using epipolar constraints
load("../data/coords.mat")
pts2 = findEpipolarMatches(I1, I2, F, pts1);

%Compute the essential matrix
E = computeE(F, K1, K2);

%Computes the two camera projection matrices
[M2s] = camera2(E);
P1=[1 0 0 0;
    0 1 0 0;
    0 0 1 0;];
P1=K1*P1;
P2=K2*M2s(:,:,2);

%Compute the 3D sparse structure
pts3d = triangulation3D(P1,pts1,P2,pts2);

%Displays the 3D points using matlab plot3
figure(2);scatter3(pts3d(:,1),pts3d(:,2),pts3d(:,3))

% save extrinsic parameters for dense reconstruction
R1=eye(3);
t1=[0;0;0];
R2=M2s(1:3,1:3,2);
t2=M2s(:,4,2);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
