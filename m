Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752888AbeCQUtB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 16:49:01 -0400
Date: Sat, 17 Mar 2018 20:48:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio: adc: ad7791: implement IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <20180317204856.1e878e13@archlinux>
In-Reply-To: <20180312120654.1806-2-alexandru.ardelean@analog.com>
References: <20180312120654.1806-1-alexandru.ardelean@analog.com>
        <20180312120654.1806-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Mar 2018 14:06:54 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Now that the old read/write frequency sysfs attrs have been removed, we
> have a clean slate to implement IIO_CHAN_INFO_SAMP_FREQ.
> 
> This driver also pre-dates IIO_CHAN_INFO_SAMP_FREQ, and this change
> implements this behavior.
> 
> The `ad7791_write_raw` would have overlapped quite a bit with the old
> read/write frequency functions, making things a bit harder to follow.
> 
> Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement
> IIO_CHAN_INFO_SAMP_FREQ")
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7791.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index 03a5f7d6cb0c..a9ff0695ddf7 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -153,6 +153,17 @@ struct ad7791_state {
>  	const struct ad7791_chip_info *info;
>  };
>  
> +static const int ad7791_sample_freq_avail[8][2] = {
> +	[AD7791_FILTER_RATE_120] =  { 120, 0 },
> +	[AD7791_FILTER_RATE_100] =  { 100, 0 },
> +	[AD7791_FILTER_RATE_33_3] = { 33,  300000 },
> +	[AD7791_FILTER_RATE_20] =   { 20,  0 },
> +	[AD7791_FILTER_RATE_16_6] = { 16,  600000 },
> +	[AD7791_FILTER_RATE_16_7] = { 16,  700000 },
> +	[AD7791_FILTER_RATE_13_3] = { 13,  300000 },
> +	[AD7791_FILTER_RATE_9_5] =  { 9,   500000 },
> +};
> +
>  static struct ad7791_state *ad_sigma_delta_to_ad7791(struct ad_sigma_delta *sd)
>  {
>  	return container_of(sd, struct ad7791_state, sd);
> @@ -202,6 +213,7 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7791_state *st = iio_priv(indio_dev);
>  	bool unipolar = !!(st->mode & AD7791_MODE_UNIPOLAR);
> +	unsigned int rate;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -239,11 +251,53 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
>  			*val2 = chan->scan_type.realbits - 1;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rate = st->filter & AD7791_FILTER_RATE_MASK;
> +		*val = ad7791_sample_freq_avail[rate][0];
> +		*val2 = ad7791_sample_freq_avail[rate][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  
>  	return -EINVAL;
>  }
>  
> +static int ad7791_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct ad7791_state *st = iio_priv(indio_dev);
> +	int ret, i;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
> +			if (ad7791_sample_freq_avail[i][0] == val &&
> +			    ad7791_sample_freq_avail[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(ad7791_sample_freq_avail)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		st->filter &= ~AD7791_FILTER_RATE_MASK;
> +		st->filter |= i;
> +		ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
> +				sizeof(st->filter),
> +				st->filter);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("120 100 33.3 20 16.7 16.6 13.3 9.5");
>  
>  static struct attribute *ad7791_attributes[] = {
> @@ -257,12 +311,14 @@ static const struct attribute_group ad7791_attribute_group = {
>  
>  static const struct iio_info ad7791_info = {
>  	.read_raw = &ad7791_read_raw,
> +	.write_raw = &ad7791_write_raw,
>  	.attrs = &ad7791_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
>  
>  static const struct iio_info ad7791_no_filter_info = {
>  	.read_raw = &ad7791_read_raw,
> +	.write_raw = &ad7791_write_raw,
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
>  

