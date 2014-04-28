# Not functional yet, just needed a public repo to test on a remote server

---

## Mapping all the addresses

### Dependencies
- [https://github.com/ericfischer/datamaps](Datamaps dependencies)
- ~6 GB of disk space
- time/patience/cpu powwa

####Usage
- `make <zoom>`
For example: `make 14`

This will download the latest openaddresses-processed data, merge it to a
single file, convert it to datamaps format, create tiles to the specified
zoom level, and package those tiles into an mbtiles for uploading to
[mapbox.com](http://mapbox.com).

If you already have a directory of openaddresses data, put it in this
directory and name it `addresses`. This will skip the download step.

#### Preview
Want to preview your tiles?
- `pushd tiles3; python -m SimpleHTTPServer; popd`
- open preview.html in your browser
