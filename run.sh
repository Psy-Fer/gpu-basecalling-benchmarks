#!/bin/bash

MODEL=dna_r10.4.1_e8.2_400bps_sup@v4.2.0
SLOW5_DORADO_LINK="https://github.com/hiruna72/slow5-dorado/releases/download/v0.3.4/slow5-dorado-v0.3.4-x86_64-linux.tar.gz"
SLOW5_DORADO_NAME=slow5-dorado-v0.3.4-x86_64-linux.tar.gz
DATA_LINK=https://slow5.bioinf.science/hg2_prom_5khz_chr22
DATA_NAME=PGXXXX230339_reads_chr22.blow5
OUT_FILE=out.fastq
DEVICE=cuda:0

die () {
    echo >&2 "$@"
    exit 1
}

test -e ${SLOW5_DORADO_NAME} && rm ${SLOW5_DORADO_NAME}
test -e ${DATA_NAME} && rm ${DATA_NAME}
test -e ${OUT_FILE} && rm ${OUT_FILE}
test -d slow5-dorado && rm -r slow5-dorado

wget ${DATA_LINK} -O ${DATA_NAME} || die "Failed to download data"
wget ${SLOW5_DORADO_LINK} -O ${SLOW5_DORADO_NAME} || die "Failed to download slow5-dorado"
tar xf ${SLOW5_DORADO_NAME} || die "Failed to extract slow5-dorado"
rm ${SLOW5_DORADO_NAME}

cd slow5-dorado/ || die "Failed to cd to slow5-dorado"
mkdir models || die "Failed to create models directory"
cd models || die "Failed to cd to models"
../bin/slow5-dorado download --model ${MODEL} || die "Failed to download model"
cd ../../ || die "Failed to cd back"

/usr/bin/time -v slow5-dorado/bin/slow5-dorado basecaller --device=${DEVICE} slow5-dorado/models/"$MODEL" --emit-fastq "$DATA_NAME" > "$OUT_FILE" || die "Failed to basecall"
