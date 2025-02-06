# GPU Basecalling Benchmarks

Choosing which GPU to use or buy for your nanopore basecalling can be tricky. There are lots of options for a wide range of budgets, from gaming cards like the RTX 3070, to the enterprise server cards like the H100.

Looking at the hardware specs does not always tell you the answer either, as there are plenty of reasons a card with less cuda cores could outperform a card with more, or the same with a difference in VRAM.

One of the most important aspects of choosing hardware, especially if you are looking to buy a card for basecalling purposes, is the price. One of the best metrics to look for is `$dollar/samples/second`, or `$/s/s`. This tells you the "bang for buck" rate of the card, and should allow users to figure out which card is best for them based on their budget.

In this repo, we will present a number of GPUs, benchmarked with dorado and a standard small dataset. We will also have benchmarks using our slow5-dorado tool, buttery-eel caller that uses dorado-server, which is what is found in MinKNOW, as well as some experimental methods, like basecalling with AMD cards.

If you have access to a GPU that is not present in our datasets and want to help us with more data, please download the example dataset (~11GB), and run the commands with the tools given in the methods section. Fill out the information present in the Pull Request template, so the results can be given some further context.

If you have any questions, find any bugs, see something wrong, or just want to discuss something, please create an issue.

We hope this is helpful to the community.

# plots

samples per second - higher is better

<div style="width: 80%; height: 80%">
  
  ![](/img/samples_per_second.png)
  
</div>

log time - lower is better

<div style="width: 80%; height: 80%">
  
  ![](/img/log_time_v1.png)
  
</div>


# Methods

Make a directory to do all the work in
```
mkdir benchmarking
cd benchmarking
```

Download the dataset - ~11Gb
```
wget https://gtgseq.s3.amazonaws.com/misc/sub/ont-r10-5khz-dna/PGXXXX230339_reads_chr22.blow5
```

Download and un-tar slow5-dorado-0.3.4
```
wget https://github.com/hiruna72/slow5-dorado/releases/download/v0.3.4/slow5-dorado-v0.3.4-x86_64-linux.tar.gz
tar -zxf slow5-dorado-v0.3.4-x86_64-linux.tar.gz
mv slow5-dorado slow5-dorado-0.3.4
```

Download the model
```
./slow5-dorado-0.3.4/bin/slow5-dorado download --model dna_r10.4.1_e8.2_400bps_sup@v4.2.0
```

Set MODEL variable
```
MODEL=./dna_r10.4.1_e8.2_400bps_sup@v4.2.0
```

Run command with time
`-x cuda:#`should point to the device you are benchmarking
```
/usr/bin/time -v ./slow5-dorado-0.3.4/bin/slow5-dorado basecaller ${MODEL} ./PGXXXX230339_reads_chr22.blow5 -x cuda:0 --emit-fastq > ./reads.fastq
```

You will see something like this at the end. Submite this to us in the pull request.

```
/usr/bin/time -v ./slow5-dorado-0.3.4/bin/slow5-dorado basecaller ${MODEL} ./PGXXXX230339_reads_chr22.blow5 -x cuda:0 --emit-fastq > ./reads.fastq
[2025-02-06 13:28:40.512] [info] > Creating basecall pipeline
[2025-02-06 14:40:15.406] [info] > Simplex reads basecalled: 189928
[2025-02-06 14:40:15.406] [info] > Basecalled @ Samples/s: 2.835288e+06
[2025-02-06 14:40:15.647] [info] > Finished
	Command being timed: "./usr/bin/time -v ./slow5-dorado-0.3.4/bin/slow5-dorado basecaller ${MODEL} ./PGXXXX230339_reads_chr22.blow5 -x cuda:0 --emit-fastq > ./reads.fastq
	User time (seconds): 2204.02
	System time (seconds): 2300.99
	Percent of CPU this job got: 104%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:11:35
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 2756912
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 2887797
	Voluntary context switches: 1819362
	Involuntary context switches: 25997
	Swaps: 0
	File system inputs: 21026264
	File system outputs: 3603808
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
```
We will then extract the relevant information.


## Here is how it is done.

We are interested in this line

```
Elapsed (wall clock) time (h:mm:ss or m:ss): 1:11:35
```

Convert that to closest 0.5 min
```
1h, 11m, 35s
60 + 11 + 0.58 = 71.58
Rounding to closest rounds down
~71.5 minutes
```

We will add this to the data and re-make the plots with this info


# Acknowledgments

Genome Technologies Group
Rasmus Kirkegaard
...