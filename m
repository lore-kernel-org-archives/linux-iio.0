Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 1/2] staging:iio:adc:added space around '-'
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>
References: <cover.1452878721.git.bhumirks@gmail.com>
 <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
 <56995378.1010204@metafoo.de> <20160120142137.GC6370@mwanda>
 <56A4FD7F.6010800@kernel.org> <56A5068D.4080207@metafoo.de>
 <56ACC4D2.8040802@kernel.org> <20160130151213.GC13219@mwanda>
Cc: devel@driverdev.osuosl.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 Bhumika Goyal <bhumirks@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56ACD39A.1040003@metafoo.de>
Date: Sat, 30 Jan 2016 16:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <20160130151213.GC13219@mwanda>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 01/30/2016 04:12 PM, Dan Carpenter wrote:
> We could make checkpatch.pl not complain if the line says checkpatch: on
> it.  It would look like this.
> 
> -               in_voltage-voltage_thresh_low_value,
> +               in_voltage-voltage_thresh_low_value, /* checkpatch: not math */
> 
> I suppose I could have made the explanation longer since the it won't
> complain about the 80 character limit...  What do you guys think?

We could add it as a temporary way to silence the checker. But it feels a
bit ugly, there is really no reason why this shouldn't be a string, other
than that the current device attr macros don't support that.

- Lars
