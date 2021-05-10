biToolsTesting
---

A script which works with ephemeral pg to spin up an accessible postgresql db with a fire incident and iris dataset loaded for testing database visualization tools.

Requirements
---
**ephemeralpg**:
This gives access to the pg\_tmp command, which makes spinning up a throwaway postgresql server instance fast and painless, and is used by pg\_script.sh
https://github.com/eradman/ephemeralpg

**Postgresql**: If you want to use various versions for testing or otherwise, then I can recommend pgvm, which still works well despite being un-maintained for a long time.
https://github.com/guedes/pgvm

**PostGIS**:
You can install from your package manager unless you want to use different postgresql versions, in which case you will have to build postgis from source for the postgresql version you're using. You will need to install several dependencies.

For Ubuntu:
```
sudo apt install libxml2-dev libgeos-dev proj-bin libgdal-dev libjson-c-dev libprotobuf-c-dev protobuf-c-compiler
```

Then follow the compile and install instructions [here](http://postgis.net/source/) after downloading a postgis binary. **NOTE**: If you are using pgvm above, then you will need to compile/install postgis for each version of postgresql you plan to test against. It will automatically find and install itself according to the present version of pg\_config as dictated by your current pgvm use version.

Running
---
After installing the needed requirements, simply execute pg\_script.sh to spin up and persist a throwaway local instance of a postgis enabled postgres database with the datasets below included. When you exit the psql terminal, the cluster instance will be shut down and discarded 10 seconds later.

The server is accessible at whatever your ipv4 lan address is on your network, on port `5433`. database is `test` and user is your logged in username.

An easy way to get your ipv4 address for linux users is the command `hostname -I | awk '{print $1}'`

Data
---
fire\_incidents.csv comes from a subset of San Francisco's fire incidents data set, available from https://data.sfgov.org/Public-Safety/Fire-Incidents/wr8u-xric it contains time series events and point geometries.

iris.csv is the ubiquitous iris dataset used for teaching data exploration and visualization. There are plenty of places to find this, but here is a kaggle archived data source. https://www.kaggle.com/uciml/iris

jurisdictions.sql is derived from San Francisco's open data [Bay Region jurisdictions](https://opendata.mtc.ca.gov/datasets/9cf652ef5e3545faa2630a91070bf87c_0?geometry=-127.405%2C37.123%2C-117.337%2C38.640) using `shp2pgsql`.
