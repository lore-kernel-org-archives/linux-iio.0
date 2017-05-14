Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 92-243-34-74.adsl.nanet.at ([92.243.34.74]:33862 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdENLj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 07:39:26 -0400
Date: Sun, 14 May 2017 11:29:45 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        simran singhal <singhalsimran0@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: pressure: zpa2326: report interrupted case as
 failure
Message-ID: <20170514112945.GB13143@osadl.at>
References: <1494751435-14189-1-git-send-email-der.herr@hofr.at>
 <alpine.DEB.2.20.1705141146060.1876@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.DEB.2.20.1705141146060.1876@vps.pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 14, 2017 at 11:46:58AM +0200, Peter Meerwald-Stadler wrote:
> 
> > If the timeout-case prints a warning message then probably the interrupted
> > case should also. Further, wait_for_completion_interruptible_timeout()
> > returns long not int. 
> > 
> > Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
> > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> 
> this is actually a v2, looks good to me

yup - I was just not clear if I should have marked is as V2
as not only the subject did change (simply because my first
assumption that the control-flow was buggy was wrong) and if
it would have been marked as V2 with no equivalent original
Patch would that make much sense ?

If it does, I´ll resend with a V2 tag and ref to the original
(wrong) Patch.

Thanks for the review 

> 
> > ---
> > 
> > The original control-flow was technically not wrong just confusing and a bit 
> > complicated. Not clear if reporting the interrupted case actually is useful,
> > but given that the timeout is relatively long (200ms) it is not that unlikely
> > so differentiating the cases seems helpful.
> > 
> > Patch was compile-tested with: x86_64_defconfig + CONFIG_IIO=m, CONFIG_ZPA2326=m
> > 
> > Patch is against v4.11 (localversion-next is next-20170512)
> > 
> >  drivers/iio/pressure/zpa2326.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> > index e58a0ad..617926f 100644
> > --- a/drivers/iio/pressure/zpa2326.c
> > +++ b/drivers/iio/pressure/zpa2326.c
> > @@ -867,12 +867,13 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
> >  {
> >  	int          ret;
> >  	unsigned int val;
> > +	long     timeout;
> >  
> >  	zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt");
> >  
> > -	ret = wait_for_completion_interruptible_timeout(
> > +	timeout = wait_for_completion_interruptible_timeout(
> >  		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
> > -	if (ret > 0)
> > +	if (timeout > 0)
> >  		/*
> >  		 * Interrupt handler completed before timeout: return operation
> >  		 * status.
> > @@ -882,13 +883,15 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
> >  	/* Clear all interrupts just to be sure. */
> >  	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
> >  
> > -	if (!ret)
> > +	if (!timeout) {
> >  		/* Timed out. */
> > +		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
> > +			     timeout);
> >  		ret = -ETIME;
> > -
> > -	if (ret != -ERESTARTSYS)
> > -		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
> > -			     ret);
> > +	} else if (timeout < 0) {
> > +		zpa2326_warn(indio_dev, "wait for one shot interrupt canceled");
> > +		ret = -ERESTARTSYS;
> > +	}
> >  
> >  	return ret;
> >  }
> > 
> 
> -- 
>
thx!
hofrat 
