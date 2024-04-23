# collpcm 1.4

## Minor changes

- Correction to label switching algorithm for when number of groups is fixed through `model.search=FALSE` in `collpcm.control()`

# collpcm 1.3

## Minor changes

- Fixed bug in MKL position finding for latent dimension `d=1`; this bug did not cause any problems for `d=2` but meant that for `d=1` the run would break at the MKL optimization
- Fixed minor bug in beta initialization in `collpcm.control()`; it is unlikely that this bug had a significant impact on results

# collpcm 1.2

## Minor changes

- Added checks for bad values of latent space dimension argument in `collpcm.fit()`
- Removed erroneous reshaping of the latent position array samples in `collpcm.fit()`; this code had no impact as its effect was undone in a later reshaping step
- `plot` function for `collpcm` class changed to automatically include pie charts of membership

## Larger changes

- Rewrite of the `collpcm.control()` function for better clarity 
- `collpcm.fit()` now has a native implementation of Procrustes matching which was previously sourced from `vegan` package
- A vignette has been added to this version


