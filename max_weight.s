/******************************************************************************
* file: max_weight.s
* author: Venkatesh Ravipati
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
.bss

@ DATA SECTION
.data
data_start: .word 0x205A15E3, 0x256C8700;
data_end:   .word 0x295468F2;

Output: 
NUM: .word     0x0;
WEIGHT: .word  0x0;

@ TEXT section
.text

.globl _main

_main:
	LDR r1, =data_start;//loading data start address to r1
	LDR r2, =data_end; 	//loading data end address to r2
	LDR r3, =NUM;		//laoding NUM address to store the max-weight number
	LDR r4, =WEIGHT;	//loading WEIGHT address to store max weight;
LOOP:
	LDR r9, [r1];		//load data in r1 location to r9
	MOV r7, #1;	        //initialization r7 to 1 for shift operations, shift mask
	MOV r8, #0;	        //initialization r8 to 0
WT:	CMP r7,#0;			// compare shift mask to 0
	BEQ AB				// if mask is 0, loop is done, branch to update data
	AND r10, r9, r7;	// AND mask and data
	LSL r7, r7, #1; 	// update mask 
	CMP r10, #0;		// compare the output of AND with #0
	BEQ WT;				// if 0, the bit correspond to mask is 0, branch to check for the next bit
	ADD r8, r8, #1;		// update the bit counter
	B WT				// branch to check for the next bit
AB:
	LDR r7, [r4];		//load current max weight to r7
	CMP r8, r7;         //compare new weight with current max weight
	BMI CONT			//if new weight is less then the current max, branch to update to look for new number
	STR r8, [r4];		//update the current max weight
	STR r9, [r3];		//update the current max NUM
CONT:
	ADD r1, r1, #4		//increment counter to load next number
	CMP r2, r1;			//check if counter reaches the end of data
	BMI END;			//if counter reaches end, exit
	B LOOP				//else loop to get next number
END:NOP	
	
      

        //@ you can write your own code here
