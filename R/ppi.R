#' Calculate the PPI (Plant Phenology Index)
#'
#' Function to calculate the PPI from sun-sensor corrected NIR (near-infrared) and red reflectances after Jin and Eklundh 2014
#'
#' @param dvi
#' Difference vegetation index (DVI = NIR - red) using sun-sensor corrected
#' reflectances, for example from nadir-view MODIS NBAR
#'
#' @param zenith.angle
#' Solar zenith angles (in radians) corresponding to the \code{dvi} values.
#'
#' @param M
#' Canopy maximum of \code{dvi}, default is estimated
#' from given values plus small constant (0.005)
#'
#' @param dvi.soil
#' DVI of soil, default value is 0.09.
#'
#' @param G
#' Geometric function of leaf angular distribution.
#' Default value 0.5 is valid for flat and needle leaves,
#' when assuming a spherical leaf angle distribution.
#'
#' @details
#' This function calculates the PPI, as given in Jin H, Eklundh L. 2014.
#' A physically based vegetation index for improved monitoring of plant
#' phenology. Remote Sensing of Environment 152: 512–525. DOI: 10.1016/j.rse.2014.07.010.
#'
#' Default parameters are as in the paper.
#'
#' No NA values are accepted (throws an error).
#'
#' @return Values of PPI.
#'
#' @examples
#' # some MODIS NBAR data
#' data(modis)
#'
#' # remove any NA
#' modis.na <- na.omit(modis)
#'
#' # MODIS data has factor of 10000; zenith angle converted into radians
#' ppi.values <- ppi(dvi = (modis.na$nir - modis.na$red) / 10000,
#'                   zenith.angle = modis.na$solar.zenith.angle / 180 * pi)
#' plot(modis.na$date, ppi.values)
#'
#' @export
ppi <- function(dvi, zenith.angle, M = max(dvi) + 0.005, dvi.soil = 0.09, G = 0.5){

  stopifnot(!anyNA(dvi), !anyNA(zenith.angle))

  if(any(zenith.angle > pi)) warning("zenith.angle must be in radians, but is most probably in degrees")

  d_c <- 0.0336 + 0.0477/cos(zenith.angle)
  Q_E <- d_c + (1 - d_c) * G / cos(zenith.angle)
  K <- 1/(4*Q_E) * (1 + M)/(1 - M)

  - K * log( (M - dvi) / (M - dvi.soil) )

}
