# MSMG Data - Python Engineer Recruitment Test
Thank you for taking the time to apply to Moneysupermarket Group as a Data Engineer!

## Process

The next stage of the interview process involves some live code pairing.
To prepare for this, you have 2 options, pick which ever option you are most comfortable with:

### Option 1. Prepare only
- Read and understand the [Problem Statement](#problem-statement)
- Set up your favourite IDE with the [sample code](./file_splitter/__main__.py).
- Make sure you know how the code works and you know how to run it with different arguments
- Think about how you plan on implementing a solution to the problem

In the code pairing session, we will start coding the solution 

### Option 2. Spend an hour or two implementing a solution
- Complete all the above steps in 'Option 1. Prepare only'
- Start coding your solution 

In the code pairing session, we will talk about what you have done so far, then continue coding or add a new feature.



## Problem Statement

Your task is to write a command line application that splits a single large csv file into many smaller files.

If your program was invoked as follows, it should read the input file `demo_input_mlb_players.csv`, 
and split it into many output files in the directory `output`. 
None of the files in the output directory should be greater than 500 bytes in size or 100 lines long.

```bash
./file-splitter --input-file demo_input_mlb_players.csv --output-dir output/ --max-bytes 500 --max-lines 100
```

The output file names should have a part number appended to them. 
For example, running the above would result in the generation of the following files:

```
output/demo_input_mlb_players-part0.csv
output/demo_input_mlb_players-part1.csv
output/demo_input_mlb_players-part2.csv
...
```


## Top tips

At MSMG we value code that is functional, simple to read and review, and demonstrates best practice.

You should complete this assignment in Python. 
A sample project with the arguments parsed is provided. 
If you would like to parse the arguments differently this is fine.
Please dont use heavy-weight data processing frameworks (spark / beam / pandas), where this could be done in a few lines, we'd like you to show off your python skills.

We judge based on the following things:
* Code readability
* Code well architected / separated
* Testing of key parts 
* Code maintainability, can it be extended
* Code performance
