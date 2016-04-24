#!/usr/bin/perl
##by Li20150716;
##run 1000 times for: ./bootstrape_randomly_1000_TDI.pl .././kaks_normalized_expression_data_NSF_nso_strand-spec_Bur_0_exp_rpkm.txt;
use strict;
use warnings;
my $file=shift;

print  "time\tseedling_se_TDI\troot_se_TDI\tflower_se_TDI\tseedling_as_TDI\troot_as_TDI\tflower_as_TDI\n";
for my $i (1..1000){
   print "$i\t";
   #system("perl bootstrape_randomly_1000_phy.pl .././phylo_normalized_expression_data_NSF_nso_strand-spec_Bur_0_exp_rpkm.txt");
   system("perl bootstrape_randomly_1000_TDI.pl $file");

   wait;
   $i++;
}
