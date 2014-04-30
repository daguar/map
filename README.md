## a map of openaddresses

### Dependencies
- [Datamaps dependencies](https://github.com/ericfischer/datamaps)
- ~6 GB of disk space
- time/patience/cpu powwa

####Usage
- `make`

This will download the latest openaddresses-processed data, merge it to a
single file, convert it to datamaps format, create tiles to the specified
zoom level, and package those tiles into an mbtiles for uploading to
[mapbox.com](http://mapbox.com).

Read the Makefile to skip certain steps.

If you already have a directory of openaddresses data, put it in this
directory and name it `addresses`. This will skip the download step.

#### Preview
Want to preview your tiles locally?
- `pushd tiles; python -m SimpleHTTPServer; popd`
- open preview.html in your browser
