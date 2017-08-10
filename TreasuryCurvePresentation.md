TreasuryCurvePresentation
========================================================
author: A.K. Patel
date: 8/10/2017
autosize: true

Treasury Yield Curve App
========================================================
The Treasury Curve App allows you to check two historical US Treasury yield curves.

- __Source Data__ -- US St. Louis Federal Reserve
- __Data Sets__ -- Input data includes historical data for US Treasury 2y, 5y, 7y, 10y and 30y bonds.
- __Computation method__ -- the yield is computed using the 5 available data set to construct a yield curve by calling spline function, using a simplistic "natural" method for curve construction.
- __Data History__ -- to limit space and computation requirement, data set is limited to 2012-08-06 to 2017-08-04

What is a Yield Curve
========================================================
A yield curve is a plot of maturity (x-axis) and yield (y-axis).  The resulting plot allows you to determine what a US Treasury bond would yield for all computed maturities.

Generally trade data is only available for actively traded maturities like the __2y, 5y, 7y, 10y and 30y__.

In order to construct a yield curve we use the trade data from actively traded securities to compute a theoretical yield for the maturities we don't observe.

Our yield curve is constructed from 1 to 30 year.  Though we don't have data on what a 14 year US Treasury bond would yield, we can compute the theoretical yield using a __spline()__ function.



Example of What a Yield Curve Looks Like
========================================================
![plot of chunk unnamed-chunk-2](TreasuryCurvePresentation-figure/unnamed-chunk-2-1.png)

How to use the app
========================================================
Compare yield curve from two historical dates

1. Select a date from the calendar for Yield Curve 1
2. Select the number of days from the slider to determine how many days to back when constructing Yield Curve 2.

<small>_The input datasets from the Federal Reserve are sitting in my Github account.  Hence it may take a few seconds to render the plot depending on internet speed._<small>
