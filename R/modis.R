#' Some MODIS NBAR reflectances
#'
#' A dataset containing nadir-view reflectances
#' from a pixel in the Bavarian Forest National Park (Germany),
#' which has long snow seasons each year.
#'
#' @format A data.frame / data.table with 254 rows and 4 variables:
#' \describe{
#'   \item{date}{Date}
#'   \item{nir}{NIR reflectance, in 1/10000}
#'   \item{red}{red reflectance, in 1/10000}
#'   \item{solar.zenith.angle}{Solar zenith angle, in degrees}
#' }
#' @source downloaded using MODISTools package
"modis"
