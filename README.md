# Generic Primitive Detection in Point Clouds Using Novel Minimal Quadric Fits
This repository provides the MATLAB implementation and some data to run the sphere detection part of Birdal et al. CVPR'18 / PAMI'19.  It represents the official implementation of the paper:

### [Generic Primitive Detection in Point Clouds Using Novel Minimal Quadric Fits](https://arxiv.org/pdf/2102.08945.pdf)
[Tolga Birdal](http://tolgabirdal.github.io/), Benjamin Busam, Nassir Navab, Slobodan Ilic, Peter Sturm
Imperial College London | Technical University of Munich | Siemens AG

![SphereDetection](assets/SphereDetection.jpg?raw=true)

### Data and Running the Demo

Data is located under the `datasets` subfolder. Please run `test_spheres.m` to run it on the provided examples. 
We implement the most basic form of Alg. 1 of the main paper under `quadric-detection/fit_conic_birdal_sturm.m`.
The approximate fitting in Alg. 2 as well as the null-space solution can be found in `quadric-detection/fit_conic_birdal_under.m`.

### Citation

If you found this code or paper useful, please consider citing:

```shell
@article{birdal2019generic,
  title={Generic primitive detection in point clouds using novel minimal quadric fits},
  author={Birdal, Tolga and Busam, Benjamin and Navab, Nassir and Ilic, Slobodan and Sturm, Peter},
  journal={IEEE transactions on pattern analysis and machine intelligence},
  volume={42},
  number={6},
  pages={1333--1347},
  year={2019},
  publisher={IEEE}
}
@inproceedings{birdal2018minimalist,
  title={A minimalist approach to type-agnostic detection of quadrics in point clouds},
  author={Birdal, Tolga and Busam, Benjamin and Navab, Nassir and Ilic, Slobodan and Sturm, Peter},
  booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
  pages={3530--3540},
  year={2018}
}
```
