# coin-counter
A SFOS app for counting the value of conins on a plate

The app takes a picture of the coins and extracts the coins from the picture by means of OHTUS thresholding and contour matching. Subsequent, the value of the coins is determined by the ratio of the detected coins. Finally, it returs the sum of all coins on the plate.
