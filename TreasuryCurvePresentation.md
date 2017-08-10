TreasuryCurvePresentation
========================================================
author: A.K. Patel
date: 8/10/2017
autosize: true

Compare Two US Treasury Yield Curves App
========================================================
The Treasury Curve App allows you to check historical US Treasury yield curves.  You can compare two yield curves at a time.

- Source Data -- US St. Louis Federal Reserve
- Data Sets -- Input data includes historical data for US Treasury 2y, 5y, 7y, 10y and 30y bonds.
- Computation method -- the yield is computed using the 5 available data set to construct a yield curve by calling spline function, using a simplistic "natural" method for curve construction.
- Data History -- to limit space and computation requirement, data set is limited to 2012-08-06 to 2017-08-04

What is a Yield Curve
========================================================
A yield curve is a plot of maturity (x-axis) and yield (y-axis).  The resulting plot allows you to determine what a US Treasury bond would yield for all computed maturities.

Generally trade data is only available for actively traded maturities like the 2y, 5y, 7y, 10y and 30y.

In order to construct a yield curve we use the trade data from actively traded securities to compute a theoretical yield for the maturities we don't observe.

Our yield curve is constructed from 1 to 30 year.  Though we don't have data on what a 14 year US Treasury bond would yield, we can compute the theoretical yield using a spline function.



Example of What a Yield Curve Looks Like
========================================================

![plot of chunk unnamed-chunk-2](TreasuryCurvePresentation-figure/unnamed-chunk-2-1.png)

How to use the app
========================================================
Compare yield curve from two historical dates

1. Select a date from the calendar for Yield Curve 1
2. Select the number of days you want to look back from Yield Curve 1 to construct the second Yield Curve two

_The input datasets from the Federal Reserve are sitting in my Github account.  Hence it may take a few seconds to render the plot depending on internet speed._
