Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:32904 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3GBMXn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:23:43 -0400
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
Date: Tue, 2 Jul 2013 14:03:57 +0200
Cc: linux-iio@vger.kernel.org, otavio@ossystems.com.br,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1372723722-13902-1-git-send-email-marex@denx.de> <51D2BCE5.8060602@free-electrons.com>
In-Reply-To: <51D2BCE5.8060602@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307021403.57543.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Alexandre Belloni,

> Dear Marek,
> 
> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
> how to reproduce it ?

The check is just redundant, it's not a bug.

> Regards,
> 
> On 02/07/2013 02:08, Marek Vasut wrote:
> > The removed check in the read_raw implementation was always true,
> > therefore remove it.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > 
> >  drivers/staging/iio/adc/mxs-lradc.c |    7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> > b/drivers/staging/iio/adc/mxs-lradc.c index d92c97a..c318eb6 100644
> > --- a/drivers/staging/iio/adc/mxs-lradc.c
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > @@ -234,7 +234,6 @@ static int mxs_lradc_read_raw(struct iio_dev
> > *iio_dev,
> > 
> >  {
> >  
> >  	struct mxs_lradc *lradc = iio_priv(iio_dev);
> >  	int ret;
> > 
> > -	unsigned long mask;
> > 
> >  	if (m != IIO_CHAN_INFO_RAW)
> >  	
> >  		return -EINVAL;
> > 
> > @@ -243,12 +242,6 @@ static int mxs_lradc_read_raw(struct iio_dev
> > *iio_dev,
> > 
> >  	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
> >  	
> >  		return -EINVAL;
> > 
> > -	/* Validate the channel if it doesn't intersect with reserved chans. */
> > -	bitmap_set(&mask, chan->channel, 1);
> > -	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
> > -	if (ret)
> > -		return -EINVAL;
> > -
> > 
> >  	/*
> >  	
> >  	 * See if there is no buffered operation in progess. If there is,
> >  	 simply * bail out. This can be improved to support both buffered and
> >  	 raw IO at

Best regards,
Marek Vasut
