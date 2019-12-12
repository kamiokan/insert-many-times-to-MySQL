#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use Encode qw(encode);

# SQLが書かれたファイルを読み込む
my $filename = 'test.txt';
open( my $FH, "<:utf8", $filename ) or die;
my $text = do { local $/; <$FH> };

# INSERT ～ ; を配列に格納する
my @insert_array = $text =~ /INSERT.*?;/gsm;

use Data::Dumper;
say Dumper @insert_array;
