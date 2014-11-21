structRNAfinder
===============

Introduction

StructRNAfinder is designed to analyse data originated from transcriptome and genome projects. So, as a input it is required the sequences in Fasta format, as well  a covariance model (CM format) related to the secondary structures used for comparison.
StructRNAfinder integrates two third-part softwares and inhouse scripts that allows to perform noncoding RNA annotation based on secondary structure inference. This tool generates a friendly output of the obtained results of each step.
This program is optimized to use the covariance model available in the Rfam databases. This mean that the generated output uses other complementary files, annotations and information extracted from that database. However, it do not exclude the possibility of using other covariance models as input,  since the tool main pipeline is conserved, the unique difference is in the step of generating the html final reports. This option is useful for comparative genomics analysis, as well implementing CMs originated by other softwares than Infernal. 

=========
