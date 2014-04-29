all: openaddresses.mbtiles

clean:
	rm -rf addresses datamaps mbutil openaddresses-merge data.dm encoded-dm tiles

latest-addresses.zip:
	curl -o latest-addresses.zip 'http://s3.amazonaws.com/openaddresses/openaddresses-processed.zip'

addresses: latest-addresses.zip
	unzip -d addresses latest-addresses.zip

datamaps:
	git clone https://github.com/ericfischer/datamaps.git
	make -C datamaps/

mbutil:
	git clone https://github.com/mapbox/mbutil.git

addresses/merge.csv: addresses openaddresses-merge
	sh openaddresses-merge/merge.sh addresses/

openaddresses-merge:
	git clone https://github.com/openaddresses/openaddresses-merge.git

data.dm: datamaps addresses/merge.csv
	bash datamap.sh addresses/merge.csv >> data.dm

encoded-dm: data.dm
	cat data.dm | ./datamaps/encode -o encoded-dm -z 18

tiles: encoded-dm
	datamaps/enumerate -z0 -Z12 encoded-dm/ | xargs -L1 -P4 datamaps/render -B 12:0.5:1 -t 0 -o tiles/ -m

openaddresses.mbtiles: tiles
	mbutil/mb-util tiles openaddresses.mbtiles
