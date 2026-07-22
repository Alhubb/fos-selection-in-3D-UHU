#!/bin/bash

READS_DIR="/home/alasdair/reads"
OUTDIR="/home/alasdair/spades/"

mkdir -p "$OUTDIR"

for R1 in "$READS_DIR"/*_1_trimmed.fastq.gz; do

    R2="${R1/_1_trimmed/_2_trimmed}"

    SAMPLE=$(basename "$R1" | sed 's/_1_trimmed.*//')

    echo "=== Assembling $SAMPLE ==="

    SAMPLE_OUT="$OUTDIR/${SAMPLE}_spades"
    mkdir -p "$SAMPLE_OUT"

    spades.py \
        --isolate \
        --cov-cutoff auto \
        -k 21,33,55,77,99,127 \
        -1 "$R1" \
        -2 "$R2" \
        -o "$SAMPLE_OUT"

    echo "=== Finished $SAMPLE ==="
    echo
done
