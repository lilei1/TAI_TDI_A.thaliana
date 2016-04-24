#!/usr/bin/perl
##by Li20150716;
##randomly choose 1000 genes across ohylostrata with replacement and calculate their TAI and TDI, using the file of kaks_normalized_expression_data_NSF_nso_strand-spec_*_exp_rpkm.txt;
use strict;
use warnings;
use Statistics::R;
use List::Util 'shuffle';
open(EXP,  "<$ARGV[0]") or die "Could not open $ARGV[0]";
my @total_phy_exp;
my $header_exp = <EXP>;
foreach my $row (<EXP>){
chomp $row;
push @total_phy_exp, $row;
}
close (EXP);


my $max_number = $#total_phy_exp;
# R way 1
my @sub_sample;
my $R = Statistics::R->new();
$R->set('x', $max_number);
$R->run( q 'sample_for_perl = sample(0:x,25012,replace = TRUE)' );
my $Rsample = $R->get('sample_for_perl');
#print "\nR sample:\t\t", (time - $start),"sec\n";
foreach (@$Rsample){
push  @sub_sample, $total_phy_exp[$_];
#print "$total_phy_exp[$_]\n";
}
$R->stop();

my @matrix_exp =();
my $seedling_se = 0;
my $seedling_se_exp = 0;
my $seedling_as = 0;
my $seedling_as_exp = 0;
my $root_se = 0;
my $root_se_exp = 0;
my $root_as = 0;
my $root_as_exp = 0;
my $flower_se = 0;
my $flower_se_exp = 0;
my $flower_as = 0;
my $flower_as_exp = 0;
my $j=0;
foreach (@sub_sample){
my @rtemp2 = split(/\t/,$_);
 $matrix_exp[$j][0] = $rtemp2[0];
 $matrix_exp[$j][1] = $rtemp2[3];
 $matrix_exp[$j][2] = $rtemp2[5];
 $matrix_exp[$j][3] = $rtemp2[7];
 $matrix_exp[$j][4] = $rtemp2[9];
 $matrix_exp[$j][5] = $rtemp2[11];
 $matrix_exp[$j][6] = $rtemp2[13];

$seedling_se = $seedling_se + $matrix_exp[$j][0] * $matrix_exp[$j][1];
$seedling_as = $seedling_as + $matrix_exp[$j][0] * $matrix_exp[$j][2];

$root_se = $root_se + $matrix_exp[$j][0] * $matrix_exp[$j][3];
$root_as = $root_as + $matrix_exp[$j][0] * $matrix_exp[$j][4];

$flower_se = $flower_se + $matrix_exp[$j][0] * $matrix_exp[$j][5];
$flower_as = $flower_as + $matrix_exp[$j][0] * $matrix_exp[$j][6];

$seedling_se_exp = $seedling_se_exp +  $matrix_exp[$j][1];
$seedling_as_exp = $seedling_as_exp +  $matrix_exp[$j][2];

$root_se_exp = $root_se_exp + $matrix_exp[$j][3];
$root_as_exp = $root_as_exp + $matrix_exp[$j][4];

$flower_se_exp = $flower_se_exp + $matrix_exp[$j][5];
$flower_as_exp = $flower_as_exp + $matrix_exp[$j][6];

$j++;

}

my $seedling_se_TDI = $seedling_se / $seedling_se_exp;
my $seedling_as_TDI = $seedling_as / $seedling_as_exp;

my $root_se_TDI = $root_se / $root_se_exp;
my $root_as_TDI = $root_as / $root_as_exp;

my $flower_se_TDI = $flower_se / $flower_se_exp;
my $flower_as_TDI = $flower_as / $flower_as_exp;

#print  "seedling_se_TAI\troot_se_TAI\tflower_se_TAI\tseedling_as_TAI\troot_as_TAI\tflower_as_TAI\n";
print  "$seedling_se_TDI\t$root_se_TDI\t$flower_se_TDI\t$seedling_as_TDI\t$root_as_TDI\t$flower_as_TDI\n";
