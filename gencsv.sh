RANDOM=$$
i=0
: ${limit:=9}
for i in `seq $i $limit`
do
	echo $i, $RANDOM
done >./inputFile
