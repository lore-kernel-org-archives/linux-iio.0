Return-Path: <joe@perches.com>
Message-ID: <1454173334.7329.14.camel@perches.com>
Subject: Re: [PATCH 1/2] staging:iio:adc:added space around '-'
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 pmeerw@pmeerw.net,  Bhumika Goyal <bhumirks@gmail.com>
Date: Sat, 30 Jan 2016 09:02:14 -0800
In-Reply-To: <20160130151213.GC13219@mwanda>
References: <cover.1452878721.git.bhumirks@gmail.com>
	 <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
	 <56995378.1010204@metafoo.de> <20160120142137.GC6370@mwanda>
	 <56A4FD7F.6010800@kernel.org> <56A5068D.4080207@metafoo.de>
	 <56ACC4D2.8040802@kernel.org> <20160130151213.GC13219@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2016-01-30 at 18:12 +0300, Dan Carpenter wrote:
> We could make checkpatch.pl not complain if the line says checkpatch:
> on
> it.  It would look like this.
> 
> -               in_voltage-voltage_thresh_low_value,
> +               in_voltage-voltage_thresh_low_value, /* checkpatch:
> not math */
> 
> I suppose I could have made the explanation longer since the it won't
> complain about the 80 character limit...  What do yo/u guys think?

Maybe use a more generic thing like the checkpatch type

               in_voltage-voltage_thresh_low_value, /* checkpatch-SPACING */

Even so, it might uglify checkpatch code a lot to
check something like this per-line or per-block.

And that likely would have to be per line in the
code as checkpatch couldn't see when a patch block
addition occurs outside the scope of a comment.

I suppose inside checkpatch the "sub report {"
function could be extended to look at the specific
$rawline being tested for any "checkpatch" comment
and if so, test if it's the specific $type.
