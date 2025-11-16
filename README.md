# Image Super-Resolution using Interpolation and Wavelets

### Project Description: 
This project enhances low-resolution images by combining interpolation with wavelet-based reconstruction. Interpolation upsamples the image, and wavelet processing restores edges and fine details, producing a clearer, sharper high-resolution output.

#### Summary - 
This project explores a hybrid approach to Image Super-Resolution by combining classical interpolation techniques with wavelet-based reconstruction. The system first enlarges a low-resolution image using bilinear or bicubic interpolation, providing a smooth but detail-limited baseline. To recover the high-frequency components lost during upscaling, the interpolated image is processed using the Discrete Wavelet Transform (DWT), which separates it into approximation and detail sub-bands. By enhancing these detail components and then reconstructing the image through the inverse DWT, the method restores sharper edges, finer textures, and improved structural clarity.

This approach achieves noticeably better results than interpolation alone, offering a balance between computational simplicity and enhanced visual quality. The project demonstrates how combining interpolation with wavelet-domain processing can effectively improve image resolution for applications in photography, surveillance, medical imaging, and remote sensing.

#### Course concepts used - 
1. Interpolation Techniques
2. Discrete Wavelet Transform (DWT)
3. Image Reconstruction / Inverse DWT
   
#### Additional concepts used -
1. Frequency Domain Analysis
2. Image Quality Evaluation Metrics
   
#### Dataset - 
This project uses sample test images from the USC-SIPI Image Database, a widely used benchmark dataset for image processing research. The primary image used for experiments is:

USC-SIPI Miscellaneous Dataset – Image 4.2.03 (Mandrill)
Download Link:
https://sipi.usc.edu/database/database.php?volume=misc&image=4.2.03

The USC-SIPI dataset provides high-quality grayscale and color images commonly used in digital image processing tasks such as filtering, compression, wavelets, and super-resolution. The “Mandrill” image is known for its complex textures and high-frequency patterns, making it ideal for testing reconstruction and edge-enhancement algorithms.

#### Novelty - 
1. Hybrid Fusion of Interpolation and Wavelet Details
2. Dual-Wavelet Decomposition for Enhanced Frequency Mixing
3. Lightweight Super-Resolution Without Deep Learning
   
### Outputs:
#### Important intermediate steps
1. Convert RGB to YCbCr
The image is separated into luminance (Y) and chrominance (Cb, Cr) channels because human vision is more sensitive to luminance details.

2. Bicubic Upscaling
The Y, Cb, and Cr channels are upsampled using bicubic interpolation to create an initial high-resolution baseline image.

3. Wavelet Decomposition (DWT)
The upscaled luminance channel is decomposed into LL, LH, HL, and HH sub-bands, which represent approximation and high-frequency detail components.

4. Luminance Sharpening
A sharpened version of the upscaled luminance channel is created to extract stronger edges and additional high-frequency structure.

5. Wavelet Coefficient Fusion
Detail sub-bands of the original and sharpened luminance (LH, HL, HH) are fused using a max-abs strategy to recover stronger edges and textures.

6. Inverse DWT + Channel Merging
The fused wavelet components are reconstructed using IDWT and combined back with the chrominance channels to produce the final SR image.

#### Final output
<img width="1455" height="796" alt="image" src="https://github.com/user-attachments/assets/b2beb653-3bd3-46ee-9c8a-eb2d29845c54" />


### References:
1. Image Dataset – USC SIPI Image Database.
2. MATLAB Documentation: imresize, dwt2, idwt2, imsharpen, rgb2ycbcr.
3. R. C. Gonzalez and R. E. Woods, Digital Image Processing, 4th Edition, Pearson, 2018.
   
### Limitations
1. Limited Detail Recovery
2. Sensitive to Noise
   
### Future Work
1. Integrate Deep Learning Models
2. Implement Multi-Level Wavelet De
