#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use Encode qw(encode);
use DBI;

# SQLが書かれたファイルを読み込む
my $filename = 'test.txt';
open( my $FH, "<:utf8", $filename ) or die;
my $text = do { local $/; <$FH> };

# INSERT ～ ; を配列に格納する
my @insert_array = $text =~ /INSERT.*?;/gsm;

# SQLを実行する
my $database = 'YOUR_DATA_BASE';
my $hostname = 'YOUR_DB_HOST';
my $user     = 'YOUR_USER_NAME';
my $password = 'YOUR_PASSWORD';

my $dbh = DBI->connect(
    "DBI:mysql:$database:$hostname",
    $user,
    $password,
    {
        AutoCommit           => 1,
        PrintError           => 0,
        RaiseError           => 1,
        ShowErrorStatement   => 1,
        AutoInactiveDestroy  => 1,
        mysql_enable_utf8    => 1,
        mysql_auto_reconnect => 0,
    }
) or die "cannot connect to MySQL: $DBI::errstr";

foreach my $sql (@insert_array) {
    my $sth = $dbh->prepare( encode( 'utf8', $sql ) );
    $sth->execute();
}

say "mission complete!!";
