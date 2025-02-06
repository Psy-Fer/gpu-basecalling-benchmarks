# GPU Basecalling Benchmarks

Choosing which GPU to use or buy for your nanopore basecalling can be tricky. There are lots of options for a wide range of budgets, from gaming cards like the RTX 3070, to the enterprise server cards like the H100.

Looking at the hardware specs does not always tell you the answer either, as there are plenty of reasons a card with less cuda cores could outperform a card with more, or the same with a difference in VRAM.

One of the most important aspects of choosing hardware, especially if you are looking to buy a card for basecalling purposes, is the price. One of the best metrics to look for is `$dollar/samples/second`, or `$/s/s`. This tells you the "bang for buck" rate of the card, and should allow users to figure out which card is best for them based on their budget.

In this repo, we will present a number of GPUs, benchmarked with dorado and a standard small dataset. We will also have benchmarks using our slow5-dorado tool, buttery-eel caller that uses dorado-server, which is what is found in MinKNOW, as well as some experimental methods, like basecalling with AMD cards.

If you have access to a GPU that is not present in our datasets and want to help us with more data, please download the example dataset (~11GB), and run the commands with the tools given in the methods section. Fill out the information present in the Pull Request template, so the results can be given some further context.

If you have any questions, find any bugs, see something wrong, or just want to discuss something, please create an issue.

We hope this is helpful to the community.

