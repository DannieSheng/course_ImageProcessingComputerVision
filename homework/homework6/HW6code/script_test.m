dbstop if error
clear
close all
clc

I = imread('tools.pgm');

tau = 2.5;
L = regiongrow_seg( I, tau );