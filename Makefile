all: addresses datamaps mbutil openaddresses-merge

latest-addresses.zip:
	curl -o latest-addresses.zip 'http://s3.amazonaws.com/openaddresses/openaddresses-processed.zip'

addresses: latest-addresses.zip
	unzip -d addresses latest-addresses.zip

datamaps:
	git clone https://github.com/ericfischer/datamaps.git
	make -C datamaps/

mbutil:
	git clone https://github.com/mapbox/mbutil.git
	mbutil/mb-util -https

openaddresses-merge:
	git clone https://github.com/openaddresses/openaddresses-merge.git
	sh openaddresses-merge/merge.sh addresses/
	# we now have addresses/merge.csv

# dm-data: merge
# 	while read line
# 	do
# 		IFS=', ' read -a split <<< "$line"
# 		echo "${split[1]},${split[0]}"
# 	done < $1

tiles:
	datamaps/enumerate -z0 -Z12 dir/ | xargs -L1 -P4 datamaps/render -B 11:0.5:1 -t 0 -o tiles/ -m
