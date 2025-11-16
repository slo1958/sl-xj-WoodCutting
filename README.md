# sl-xj-WoodCutting


## Description

I created this (quick/dirty) project because I need to cut around 40 pieces of wood of different lengths out of standard pieces available at the nearby shop.

Did not want to waste to many wood and did not want to try to manually define a plan to cut the wood.


## Getting started
This model will 

- load a list of required items to cut
	- a label (expecting a string column named ‘Label’)
	- a length (expecting an integer column named ‘Value’)

Note that the input file uses different column names, see ‘Important’ at the end of this document.

- let the user define
	- the length of standard items (source item)
	- the measurement margin (a fixed value added to the loaded value to cover for errors)
	- the minimum length of a leftover to be considered for further cuts (useful leftover)
	- the maximum number of source items to use



#### Startup

<p align="center">
	<img src="Screenshots/sc-start-01.png">
</p>

#### Define the length of the items

<p align="center">
	<img src="Screenshots/sc-start-02.png">
</p>

#### Make sure the input file is on the desktop

<p align="center">
	<img src="Screenshots/sc-start-03.png">
</p>

## Results
 
The model produces

- a list of pieces (label and length) to cut out of each used standard wood
- the number of source items used (I.e. what you need to buy)
- the number of leftovers of which length is above the minimum length defined in input section (useful leftover)
- the total length of the useful leftovers 
- the number of required items not allocated either 
	- because the model ran out of source items or
	- because a required item is longer than the source items

The results can be saved as a .csv file, stored on the desktop.

#### Model run 
Note the measure margin is set to 3cm
<p align="center">
	<img src="Screenshots/sc-run-01.png">
</p>

#### Scroll down to get the results
<p align="center">
	<img src="Screenshots/sc-run-02.png">
</p>

#### If the user checks 'Save plan' before pressing Run an output file is created
<p align="center">
	<img src="Screenshots/sc-run-03.png">
</p>


<p align="center">
	<img src="Screenshots/sc-output-01.png">
</p>

#### The content of the file is the cut plan

<p align="center">
	<img src="Screenshots/sc-output-02.png">
</p>

This tool uses lib-data. The original version is available at https://github.com/slo1958/sl-xj-lib-data.git


## Usage

- Use the model to build a plan to cut the source items into the required items, note that ‘Nbr source items used’ gives the number of source items to buy
- Use to model to test the solution with different tolerances for required measures by adjusting ‘Measure margin’ (I usually try with 0cm, 3cm and 5cm)
- Use the model to test the number of source items and the total waste (total length leftover) by adjusting the ‘length of one source item’, based on availability (I usually test with 270cm, 300cm, 360cm since these are standard length here).

# IMPORTANT

- To test, don’t forget to move the filer WoodCut-input.csv  to the desktop folder.

- Input file and output file management are very basic, the app will crash if the input file is not available in the desktop folder

- The input file is expected to contain: 
	- a column named ‘cell label’, that is renamed to ‘label’ when input file is loaded
	- a column named ‘cell value’ that is converted to integer, named ‘Value’ when input file is loaded
	- rows where the converted value is zero are filtered out 

- The input file is loaded by method LoadRequirements 


#### Example input file

<p align="center">
	<img src="Screenshots/sc-input-01.png">
</p>




Comments welcome.




