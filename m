Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40810 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab3GEQ4C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 12:56:02 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
Date: Fri, 5 Jul 2013 18:56:00 +0200
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <51D6A0A6.2020200@metafoo.de> <51D6EB06.3050705@digi.com>
In-Reply-To: <51D6EB06.3050705@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307051856.00645.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hector,

> Dear Lars,
> 
> On 07/05/2013 12:32 PM, Lars-Peter Clausen wrote:
> > On 07/05/2013 10:30 AM, Hector Palacios wrote:
> >> Some LRADC channels have a fixed pre-divider, and all can have enabled
> >> an optional divisor by two which allows a maximum input voltage of
> >> VDDIO - 50mV.
> >> 
> >> This patch
> >> 
> >>   - adds the scaling info flag to all channels
> >>   - adds a lookup table with max reference voltage per channel
> >>   
> >>     (where the fixed pre-dividers apply)
> >>   
> >>   - allows to read the scaling attribute (computed from the Vref)
> >> 
> >> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > 
> > Looks good, one minor issue.
> > 
> > [...]
> > 
> >> -
> >> -	/* Validate the channel if it doesn't intersect with reserved chans.
> >> */ -	bitmap_set(&mask, chan->channel, 1);
> >> -	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
> >> -	if (ret)
> >> -		return -EINVAL;
> > 
> > This will conflict with Marek's "iio: mxs-lradc: Remove useless check in
> > read_raw", can you apply Marek's patch to your tree and rebase this
> > series on-top of it?
> 
> Yes, sorry, I missed Marek's patch when preparing this series.
> 
> >> +
> >> +/*
> >> + * Raw I/O operations
> >> + */
> >> +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> >> +			const struct iio_chan_spec *chan,
> >> +			int *val, int *val2, long m)
> >> +{
> >> +	struct mxs_lradc *lradc = iio_priv(iio_dev);
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * See if there is no buffered operation in progress. If there is,
> >> simply +	 * bail out. This can be improved to support both buffered and
> >> raw IO at +	 * the same time, yet the code becomes horribly
> >> complicated. Therefore I +	 * applied KISS principle here.
> >> +	 */
> >> +	ret = mutex_trylock(&lradc->lock);
> >> +	if (!ret)
> >> +		return -EBUSY;
> > 
> > I think the locking in this driver needs some re-work (in a separate
> > patch). There is really no reason why you shouldn't be able to query the
> > scale while the device is running in buffered mode. The common idiom to
> > protect against concurrent buffer mode and raw access is to take the
> > indio_dev->mlock in read_raw, check iio_buffer_enabled(), if it returns
> > true, unlock the lock and return -EBUSY. Otherwise continue to read the
> > raw value.
> 
> Actually I didn't touch this code. It's the original code by Marek.
> It appears as difference because I moved part of the code into a function
> called mxs_lradc_read_single() for clarity.
> @Marek, will you look at this suggestion?

Feel free to implement it, I fully agree with the comment. I will gladly review 
it.

> >> +
> >> +	/* Check for invalid channel */
> >> +	if (chan->channel > LRADC_MAX_TOTAL_CHANS
> >> +		ret = -EINVAL;
> > 
> > This looks wrong. The code will still continue to read and value or the
> > scale and overwrite 'ret'. The original code did check this condition
> > before taking the lock and did return an error. But on the other hand
> > the condition will never be true anyway since you have no channels where
> > the chan value is larger than MAX_TOTAL_CHANS, so maybe just drop this
> > completely.
> 
> Same here. This is Marek's original code that was moved. I agree that the
> check is redundant.
> @Marek, will you take care of it as well?

The patch should be rather easy, so feel free to take care of it.

Best regards,
Marek Vasut
