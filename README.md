structRNAfinder
===============
StructRNAfinder is designed to analyse data originated from transcriptome and genome projects. So, as a input it is required the sequences in Fasta format, as well  a covariance model (CM format) related to the secondary structures used for comparison.
StructRNAfinder integrates two third-part softwares and inhouse scripts that allows to perform noncoding RNA annotation based on secondary structure inference. This tool generates a friendly output of the obtained results of each step.
This program is optimized to use the covariance model available in the Rfam databases. This mean that the generated output uses other complementary files, annotations and information extracted from that database. However, it do not exclude the possibility of using other covariance models as input,  since the tool main pipeline is conserved, the unique difference is in the step of generating the html final reports. This option is useful for comparative genomics analysis, as well implementing CMs originated by other softwares than Infernal. 

***Installation***

To see more detail about the installation procedure please
see the INSTALL file.

To install structRNAfinder and requirement, type in termin-
al located in structRNAfinder folder:

	*sudo sh install.sh*

And follow the instructions.

***Summary of available tools***

*Infernal software*: tool for searching DNA sequence databas-
es for RNA structure and sequence similarities (Nawrocki a-
nd Eddy, 2013)

*RNAfold software*: is a tool for predict secondary structur-
es of single stranded RNA or DNA sequences calculating free
energy necessary to perform the structure (Lorenz et al., 
2011).

*structRNAfinder*: it is the main script the of StructRNAfin-
der. It performs all the analysis by calling other subscri-
pts related to each comparison.

*SRF_Infernal2table*: it generates a tab delimited file with
the information related to selected hits for secondary str-
uctures based on covariance models comparisons against pri-
mary sequences performed by Infernal.

*SRF_extractMature*: this script extracts the mature sequence
of the best hits filtered previously. The output is genera-
ted in two files in Fasta format, one with the complete se-
quence and another with the mature sequence of selected hi-
ts.

*SRF_taxonomy*: use the Krona tools (Ondov et al., 2011) to 
generate dynamic graphics with the taxonomic assignation of
all secondary structure based on each RNA famlify taxonomic
distribution.

*SRF_generateHtml*: integrates all the results previously ob-
tained with additional information extracted from Rfam dat-
abase for each hit in a friendly output in html format.  

*SRF_generateHtmlOther*: integrates all the result previously
obtained to generate the output like a friendly html format.
This program only is used for databases different to Rfam. 

*SRF_generateJS*: generates JavaScript files necessary to pr-
oduce the summary chart on the html final report.

***Comments, criticisms and suggestions***

Please, feel free to contact us in case of comments, criti-
cisms and suggestions at: vinicius.coutinho@umayor.cl or by
accessing directly our GitHub page at: 
*https://github.com/viniciusmaracaja/structRNAfinder*
