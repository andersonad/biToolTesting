#!/bin/bash

curl -O https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/historical/n38w123/USGS_1_n38w123_20220810.tif
raster2pgsql -c -C -I -M -F -Y -t auto -s 4326 USGS_1_n38w123_20220810.tif san_fran_elevations > sanfranelevations.sql
