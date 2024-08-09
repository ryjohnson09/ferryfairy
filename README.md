
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ferryfairy <img src="man/figures/logo.png" align="right" height="138" alt="ferryfairy logo">

The goal of `ferryfairy` is to provide users with a set of wrapper
functions to make accessing data from the [public Seattle Ferry
API](https://wsdot.wa.gov/Ferries/API/Vessels/rest/help) and associated
weather API (<https://open-meteo.com/>) as simple as possible!

## Installation

You can install the development version of ferryfairy from
[GitHub](https://github.com/ryjohnson09/ferryfairy) with:

``` r
# install.packages("devtools")
devtools::install_github("ryjohnson09/ferryfairy")
```

## Setup

You will need an access code to access the Seattle Ferry API. Register
for an access code here: <https://www.wsdot.wa.gov/traffic/api/>. We
recommend storing your access code as an environment variable. To do
this, run `usethis::edit_r_environ()` and add a new line to your
`.Renviron` file as shown below:

``` r
WSDOT_ACCESS_CODE="add-your-access-code-here"
```

You may need to re-register as this access code does expire after a
certain amount of time.

## Example

