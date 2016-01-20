Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38743 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcATOWB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2016 09:22:01 -0500
Date: Wed, 20 Jan 2016 17:21:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Bhumika Goyal <bhumirks@gmail.com>, jic23@kernel.org,
	devel@driverdev.osuosl.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH 1/2] staging:iio:adc:added space around '-'
Message-ID: <20160120142137.GC6370@mwanda>
References: <cover.1452878721.git.bhumirks@gmail.com>
 <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
 <56995378.1010204@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56995378.1010204@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 15, 2016 at 09:15:52PM +0100, Lars-Peter Clausen wrote:
> On 01/15/2016 08:42 PM, Bhumika Goyal wrote:
> > This patch adds apace around '-' operator.Found using checkpatch.pl
> > 
> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index f45ebed..0c73bce 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -744,14 +744,14 @@ out:
> >  }
> >  
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > -		in_voltage-voltage_thresh_low_value,
> > +		in_voltage - voltage_thresh_low_value,
> 
> Hi,
> 
> Thanks for patch. But when sending cleanup patches like this please make
> sure that you a) understand what the code does and how your change affects
> it and b) as a bare minimum of testing perform a compile test, if possible
> also do functional testing.
> 
> The patch as it is, is neither semantically nor syntactically correct. As an
> exercise please make sure you understand why.

Ugh!

It took me a long time to figure out the bug in this patch...  Why does
that filename have a mix of dashes and underscores?  Too late to fix it
now...  :/

regards,
dan carpenter

