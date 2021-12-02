# Matlab source code for numerical simulation of CSPI

## Main functions

1. `PatternImage` simulate the structured illumination light field
                  produced by the Hadamard basis pattern
                  (pattern image by 4f system)

2. `CSPI` simulate the complex-amplitude single-pixel imaging
          using coherent structured illumination

## Called functions

1. `pad2center` pad around matrix with 0

2. `pad2centerx2` pad around matrix with 0 to 2x

3. `system4filter` frequency domain filtering with 4f system

    * `lpfilter` computes frequency domain lowpass filters

        * `dftuv` computes meshgrid frequency matrices

## Data

* `usaf1k` the sampling matrix (1000*1000) of the USAF-1951 resolution
           test chart (partial) with 1 µm sampling interval

## Reference

1. H-Y Hou et al. Complex-amplitude single-pixel imaging using coherent
    structured illumination[J]. Optics Express, 2021, 29(25): 41827–41841.
    DOI:[10.1364/OE.443258](https://doi.org/10.1364/OE.443258).

2. H-Y Hou et al. Supplementary document for Complex-amplitude single-pixel
    imaging using coherent structured illumination -
    [5552671.pdf](https://doi.org/10.6084/m9.figshare.17074667.v2).
    Optica Publishing Group.
