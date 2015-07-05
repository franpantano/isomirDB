# isomirDB
managing MIRNA data

Steps to be done:
1:	Execute vTcl-FASTAdiv.tcl
	Select the big database TXT file
	Select the virtual output file, as only the path of the folder and the name will be used adding a sufix for each specie. The output folder will be cleared of any files before the program starts to generate the .fa files

2:	Execute the miraligner.jar program with the runMiralignerBatch.sh script. It is needed the to pass two arguments, the folder with the .fa files and the output folder for all .mirna files. All folder path should have the "/" character at the end.

3:	Run the vTcl_MIRNAadv.tcl to read the .mirna files generated in the step before.


