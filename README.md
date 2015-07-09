# isomirDB
managing MIRNA data

Requirements:
1:	You need to have tcl tk 8.6 or later installed in your computer. Should work with 8.4 but not sure about graphics proportions.

2:	All software has the default paths as per github structure

Steps to be done:
1:	Execute vTcl-FASTAdiv.tcl by double click or typing "wish vTcl-FASTAdiv.tcl" in the terminal console
	Select the big database TXT file (default)
	Select the virtual output file  (default). Only the path of the folder and the name will be used adding a sufix for each specie. The output folder will be cleared of any files before the program starts to generate the .fa and .fax files

2:	Execute the miraligner.jar program with the runMiralignerBatch.sh script. It is needed the to pass two arguments, the folder with the .fa files and the output folder for all .mirna files. All folder path should have the "/" character at the end.

	You can execute runMiralignerBatchAuto.sh script without any arguments for default folder configuration.

3:	Run the vTcl_MIRNAadv.tcl to read the .mirna files generated in the step before. (double click or "wish vTcl_MIRNAadv.tcl" in terminal console)


