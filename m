Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39982 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3INKPL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 06:15:11 -0400
Message-ID: <5234454D.8070505@kernel.org>
Date: Sat, 14 Sep 2013 12:15:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adjd_s311: Use INT_TIME channel info
References: <1378653659-15665-1-git-send-email-pmeerw@pmeerw.net> <1378653659-15665-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378653659-15665-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/13 16:20, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

While we are here, Hardware gain is not being correctly used here.  That is only
documented for output devices. For input it probably corresponds to calibscale
but I haven't looked in any real detail.  Ah well, this is in the ABI now
so even if we fix it we'll have to carry this interface for quite some time anyway.

Jonathan
> ---
>  drivers/iio/light/adjd_s311.c |   72 ++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index 23cff79..8853251 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -114,43 +114,6 @@ static int adjd_s311_read_data(struct iio_dev *indio_dev, u8 reg, int *val)
>  	return 0;
>  }
>  
> -static ssize_t adjd_s311_read_int_time(struct iio_dev *indio_dev,
> -	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> -{
> -	struct adjd_s311_data *data = iio_priv(indio_dev);
> -	s32 ret;
> -
> -	ret = i2c_smbus_read_word_data(data->client,
> -		ADJD_S311_INT_REG(chan->address));
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%d\n", ret & ADJD_S311_INT_MASK);
> -}
> -
> -static ssize_t adjd_s311_write_int_time(struct iio_dev *indio_dev,
> -	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
> -	 size_t len)
> -{
> -	struct adjd_s311_data *data = iio_priv(indio_dev);
> -	unsigned long int_time;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 10, &int_time);
> -	if (ret)
> -		return ret;
> -
> -	if (int_time > ADJD_S311_INT_MASK)
> -		return -EINVAL;
> -
> -	ret = i2c_smbus_write_word_data(data->client,
> -		ADJD_S311_INT_REG(chan->address), int_time);
> -	if (ret < 0)
> -		return ret;
> -
> -	return len;
> -}
> -
>  static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -186,25 +149,16 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct iio_chan_spec_ext_info adjd_s311_ext_info[] = {
> -	{
> -		.name = "integration_time",
> -		.read = adjd_s311_read_int_time,
> -		.write = adjd_s311_write_int_time,
> -	},
> -	{ }
> -};
> -
>  #define ADJD_S311_CHANNEL(_color, _scan_idx) { \
>  	.type = IIO_INTENSITY, \
>  	.modified = 1, \
>  	.address = (IDX_##_color), \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> -		BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
> +		BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
> +		BIT(IIO_CHAN_INFO_INT_TIME), \
>  	.channel2 = (IIO_MOD_LIGHT_##_color), \
>  	.scan_index = (_scan_idx), \
>  	.scan_type = IIO_ST('u', 10, 16, 0), \
> -	.ext_info = adjd_s311_ext_info, \
>  }
>  
>  static const struct iio_chan_spec adjd_s311_channels[] = {
> @@ -236,6 +190,18 @@ static int adjd_s311_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		*val = ret & ADJD_S311_CAP_MASK;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = i2c_smbus_read_word_data(data->client,
> +			ADJD_S311_INT_REG(chan->address));
> +		if (ret < 0)
> +			return ret;
> +		*val = 0;
> +		/*
> +		 * not documented, based on measurement:
> +		 * 4095 LSBs correspond to roughly 4 ms
> +		 */
> +		*val2 = ret & ADJD_S311_INT_MASK;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
>  }
> @@ -245,16 +211,20 @@ static int adjd_s311_write_raw(struct iio_dev *indio_dev,
>  			       int val, int val2, long mask)
>  {
>  	struct adjd_s311_data *data = iio_priv(indio_dev);
> -	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		if (val < 0 || val > ADJD_S311_CAP_MASK)
>  			return -EINVAL;
>  
> -		ret = i2c_smbus_write_byte_data(data->client,
> +		return i2c_smbus_write_byte_data(data->client,
>  			ADJD_S311_CAP_REG(chan->address), val);
> -		return ret;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0 || val2 < 0 || val2 > ADJD_S311_INT_MASK)
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_word_data(data->client,
> +			ADJD_S311_INT_REG(chan->address), val2);
>  	}
>  	return -EINVAL;
>  }
> 
