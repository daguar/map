all: addresses datamaps mbutil addresses/merge.csv

clean:
	rm -rf addresses

latest-addresses.zip:
	curl -o latest-addresses.zip 'http://s3.amazonaws.com/openaddresses/openaddresses-processed.zip'

addresses: latest-addresses.zip
	unzip -d addresses latest-addresses.zip

datamaps:
	git clone https://github.com/ericfischer/datamaps.git
	make -C datamaps/

mbutil:
	git clone https://github.com/mapbox/mbutil.git
	mbutil/mb-util -h

addresses/merge.csv: openaddresses-merge
	sh openaddresses-merge/merge.sh addresses/

openaddresses-merge:
	git clone https://github.com/openaddresses/openaddresses-merge.git

data.dm: addresses/merge.csv
	sh datamaps.sh address/merge.csv >> data.dm

tiles:
	datamaps/enumerate -z0 -Z12 dir/ | xargs -L1 -P4 datamaps/render -B 11:0.5:1 -t 0 -o tiles/ -m
