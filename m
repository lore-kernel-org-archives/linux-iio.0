Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-102.synserver.de ([212.40.185.102]:1135 "EHLO
	smtp-out-102.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab3GEKbh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 06:31:37 -0400
Message-ID: <51D6A0A6.2020200@metafoo.de>
Date: Fri, 05 Jul 2013 12:32:06 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	jic23@kernel.org, marex@denx.de, fabio.estevam@freescale.com
Subject: Re: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-3-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-3-git-send-email-hector.palacios@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 10:30 AM, Hector Palacios wrote:
> Some LRADC channels have a fixed pre-divider, and all can have enabled
> an optional divisor by two which allows a maximum input voltage of
> VDDIO - 50mV.
> 
> This patch
>  - adds the scaling info flag to all channels
>  - adds a lookup table with max reference voltage per channel
>    (where the fixed pre-dividers apply)
>  - allows to read the scaling attribute (computed from the Vref)
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>

Looks good, one minor issue.

[...]
> -
> -	/* Validate the channel if it doesn't intersect with reserved chans. */
> -	bitmap_set(&mask, chan->channel, 1);
> -	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
> -	if (ret)
> -		return -EINVAL;

This will conflict with Marek's "iio: mxs-lradc: Remove useless check in
read_raw", can you apply Marek's patch to your tree and rebase this series
on-top of it?

> +
> +/*
> + * Raw I/O operations
> + */
> +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> +			const struct iio_chan_spec *chan,
> +			int *val, int *val2, long m)
> +{
> +	struct mxs_lradc *lradc = iio_priv(iio_dev);
> +	int ret;
> +
> +	/*
> +	 * See if there is no buffered operation in progress. If there is, simply
> +	 * bail out. This can be improved to support both buffered and raw IO at
> +	 * the same time, yet the code becomes horribly complicated. Therefore I
> +	 * applied KISS principle here.
> +	 */
> +	ret = mutex_trylock(&lradc->lock);
> +	if (!ret)
> +		return -EBUSY;

I think the locking in this driver needs some re-work (in a separate patch).
There is really no reason why you shouldn't be able to query the scale while
the device is running in buffered mode. The common idiom to protect against
concurrent buffer mode and raw access is to take the indio_dev->mlock in
read_raw, check iio_buffer_enabled(), if it returns true, unlock the lock
and return -EBUSY. Otherwise continue to read the raw value.

> +
> +	/* Check for invalid channel */
> +	if (chan->channel > LRADC_MAX_TOTAL_CHANS
> +		ret = -EINVAL;

This looks wrong. The code will still continue to read and value or the
scale and overwrite 'ret'. The original code did check this condition before
taking the lock and did return an error. But on the other hand the condition
will never be true anyway since you have no channels where the chan value is
larger than MAX_TOTAL_CHANS, so maybe just drop this completely.

> +
> +	switch(m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = mxs_lradc_read_single(iio_dev, chan, val, val2, m);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = lradc->vref_mv[chan->channel];
> +		*val2 = chan->scan_type.realbits;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
>  	mutex_unlock(&lradc->lock);
>  
>  	return ret;
