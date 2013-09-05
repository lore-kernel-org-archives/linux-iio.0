Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 5 Sep 2013 21:15:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marek Vasut <marex@denx.de>
Cc: =?iso-8859-1?Q?J=FCrgen?= Beisert <jbe@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
Message-ID: <20130905181556.GU19256@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <201309051216.18305.jbe@pengutronix.de>
 <20130905104256.GK6329@mwanda>
 <201309051251.39877.marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <201309051251.39877.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since I work in staging I review hundreds of churn patches per cycle.
One thing which helps me is my rename_rev.pl script (attached).

So if I get a patch like the one I'm about to send which introduces
lradc_reg_set/clear() functions, then I can do this:

cat diff | rename_rev.pl -ea 's/,\n/,/' | \
	rename_rev.pl -e 's/writel\((.*?),\s+lradc->base \+ (.*?) .*SET\)/lradc_reg_set(lradc, $1, $2)/' \
		      -e 's/writel\((.*?),\s+lradc->base \+ (.*?) .*CLR\)/lradc_reg_clear(lradc, $1, $2)/'

It simplifies the patch down to its most minimal form.

I should probably automate the first part which strips out some
line breaks...  I'll post a new version of rename_rev.pl to LKML soon.

regards,
dan carpenter


--MGYHOYXEY6WxJCY8
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="rename_rev.pl"

#!/usr/bin/perl

# This is a tool to help review variable rename patches. The goal is
# to strip out the automatic sed renames and the white space changes
# and leaves the interesting code changes.
#
# Example 1: A patch renames openInfo to open_info:
#     cat diff | rename_review.pl openInfo open_info
#
# Example 2: A patch swaps the first two arguments to some_func():
#     cat diff | rename_review.pl \
#                    -e 's/some_func\((.*?),(.*?),/some_func\($2, $1,/'
#
# Example 3: A patch removes the xkcd_ prefix from some but not all the
# variables.  Instead of trying to figure out which variables were renamed
# just remove the prefix from them all:
#     cat diff | rename_review.pl -ea 's/xkcd_//g'
#
# Example 4: A patch renames 20 CamelCase variables.  To review this let's
# just ignore all case changes and all '_' chars.
#     cat diff | rename_review -ea 'tr/[A-Z]/[a-z]/' -ea 's/_//g'
#
# The other arguments are:
# -nc removes comments
# -ns removes '\' chars if they are at the end of the line.

use strict;
use File::Temp qw/ :mktemp  /;

sub usage() {
    print "usage: cat diff | $0 old new old new old new...\n";
    print "   or: cat diff | $0 -e 's/old/new/g'\n";
    print " -e : execute on old lines\n";
    print " -ea: execute on all lines\n";
    print " -nc: no comments\n";
    print " -nb: no unneeded braces\n";
    print " -ns: no slashes at the end of a line\n";
    exit(1);
}
my @subs;
my @cmds;
my $strip_comments;
my $strip_braces;
my $strip_slashes;

sub filter($) {
    my $_ = shift();
    my $old = 0;
    if ($_ =~ /^-/) {
        $old = 1;
    }
    # remove the first char
    s/^[ +-]//;
    if ($strip_comments) {
        s/\/\*.*?\*\///g;
        s/\/\/.*//;
    }
    foreach my $cmd (@cmds) {
        if ($old || $cmd->[0] =~ /^-ea$/) {
		eval $cmd->[1];
	}
    }
    foreach my $sub (@subs) {
	if ($old) {
		s/$sub->[0]/$sub->[1]/g;
	}
    }
    return $_;
}

while (my $param1 = shift()) {
    if ($param1 =~ /^-nc$/) {
        $strip_comments = 1;
        next;
    }
    if ($param1 =~ /^-nb$/) {
        $strip_braces = 1;
        next;
    }
    if ($param1 =~ /^-ns$/) {
        $strip_slashes = 1;
        next;
    }
    my $param2 = shift();
    if ($param2 =~ /^$/) {
	usage();
    }
    if ($param1 =~ /^-e(a|)$/) {
        push @cmds, [$param1, $param2];
	next;
    }
    push @subs, [$param1, $param2];
}

my ($oldfh, $oldfile) = mkstemp("/tmp/oldXXXXX");
my ($newfh, $newfile) = mkstemp("/tmp/newXXXXX");

while (<>) {
    if ($_ =~ /^(---|\+\+\+)/) {
	next;
    }
    my $output = filter($_);
    if ($_ =~ /^-/) {
	print $oldfh $output;
	next;
    }
    if ($_ =~ /^\+/) {
	print $newfh $output;
	next;
    }
    print $oldfh $output;
    print $newfh $output;
}

my $hunk;
my $old_txt;
my $new_txt;

open diff, "diff -uw $oldfile $newfile |";
while (<diff>) {
    if ($_ =~ /^(---|\+\+\+)/) {
	next;
    }

    if ($_ =~ /^@/) {
        if ($strip_comments) {
            $old_txt =~ s/\/\*.*?\*\///g;
            $new_txt =~ s/\/\*.*?\*\///g;
        }
        if ($strip_braces) {
            $old_txt =~ s/{([^;{]*?);}/$1;/g;
            $new_txt =~ s/{([^;{]*?);}/$1;/g;
	    # this is a hack because i don't know how to replace nested
	    # unneeded curly braces.
            $old_txt =~ s/{([^;{]*?);}/$1;/g;
            $new_txt =~ s/{([^;{]*?);}/$1;/g;
	}

       if ($old_txt ne $new_txt) {
 	    print $hunk;
	    print $_;
	}
	$hunk = "";
	$old_txt = "";
	$new_txt = "";
	next;
    }

    $hunk = $hunk . $_;

    if ($strip_slashes) {
	s/\\$//;
    }

    if ($_ =~ /^-/) {
	s/-//;
	s/[ \t\n]//g;
	$old_txt = $old_txt . $_;
	next;
    }
    if ($_ =~ /^\+/) {
	s/\+//;
	s/[ \t\n]//g;
	$new_txt = $new_txt . $_;
	next;
    }
    if ($_ =~ /^ /) {
	s/^ //;
	s/[ \t\n]//g;
	$old_txt = $old_txt . $_;
	$new_txt = $new_txt . $_;
    }
}
if ($old_txt ne $new_txt) {
    if ($strip_comments) {
        $old_txt =~ s/\/\*.*?\*\///g;
        $new_txt =~ s/\/\*.*?\*\///g;
    }
    if ($strip_braces) {
        $old_txt =~ s/{([^;{]*?);}/$1;/g;
        $new_txt =~ s/{([^;{]*?);}/$1;/g;
        $old_txt =~ s/{([^;{]*?);}/$1;/g;
        $new_txt =~ s/{([^;{]*?);}/$1;/g;
    }

    print $hunk;
}

unlink($oldfile);
unlink($newfile);

--MGYHOYXEY6WxJCY8--
