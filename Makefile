all: openaddresses.mbtiles

clean:
	rm -rf encoded-dm tiles

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
	datamaps/enumerate -z1 -Z1 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 1:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z2 -Z2 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 2:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z3 -Z3 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 3:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z4 -Z4 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 4:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z5 -Z5 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 5:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z6 -Z6 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 6:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z7 -Z7 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 7:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z8 -Z8 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 8:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z9 -Z9 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 9:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z10 -Z10 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 10:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z11 -Z11 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 11:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z12 -Z12 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 12:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z13 -Z13 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 13:0.5:1 -t 0 -o tiles/
	datamaps/enumerate -z14 -Z14 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 14:0.5:1.05 -t 0 -o tiles/
	datamaps/enumerate -z15 -Z15 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 15:0.5:1.1 -t 0 -o tiles/
	datamaps/enumerate -z16 -Z16 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 16:0.5:1.2 -t 0 -o tiles/
	datamaps/enumerate -z17 -Z17 encoded-dm/ | xargs -L1 -P8 datamaps/render -B 17:0.5:1.3 -t 0 -o tiles/

openaddresses.mbtiles: tiles
	mbutil/mb-util tiles openaddresses.mbtiles
