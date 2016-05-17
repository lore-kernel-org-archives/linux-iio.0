Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 17 May 2016 11:00:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [patch] iio: humidity: Remove a stray unlock
Message-ID: <20160517080051.GB11011@mwanda>
References: <20160517073133.GA10872@mwanda>
 <4586F61A4A291F4DA44D32824E7C0F4023597A48@IRSMSX109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4023597A48@IRSMSX109.ger.corp.intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 17, 2016 at 07:43:21AM +0000, Breana, Tiberiu A wrote:
> That one must have slipped by during development versions.
> You might also want to add am2315 in the patch title.

Yeah.  I'll resend.

I obviously just mindlessly cut and pasted that from the earlier patch:
Fixes: 0d96d5ead3f7 ('iio: humidity: Add triggered buffer support for AM2315')
That patch also has the wrong subject line because it was just copied
from the first patch 366a3270c1c5 ('iio: humidity: Add support for
AM2315').

And just a few minutes ago I was giving another new driver its own
prefix.  But even though I thought--more than I should have--about
what the author wanted to use as a prefix for his driver, I still
probably read his mind incorrectly.

In other words, we need to start with the correct prefix from square
one:  iio: humidity: am2315: Add support for AM2315

regards,
dan carpenter
