Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58782 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbcJCUQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 16:16:37 -0400
Subject: Re: [PATCH v2] staging: iio: cdc: ad7152: Implement
 IIO_CHAN_INFO_SAMP_FREQ attribute
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20161001181713.GA32327@sayli-HP-15-Notebook-PC>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <89ddb988-1ed7-25ad-8030-62bc63c88b51@kernel.org>
Date: Mon, 3 Oct 2016 21:16:33 +0100
MIME-Version: 1.0
In-Reply-To: <20161001181713.GA32327@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/16 19:17, sayli karnik wrote:
> Attributes that were once privately defined become standard with time and
> hence a special global define is used. Hence update driver ad7152 to use
> IIO_CHAN_INFO_SAMP_FREQ which is a global define instead of
> IIO_DEV_ATTR_SAMP_FREQ. Using IIO_CHAN_INFO_SAMP_FREQ has some advantages like
> it can be accessed by in-kernel consumers and it also reduces the code size.
> 
> Move functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
> IIO_CHAN_INFO_SAMP_FREQ to implement the sampling_frequency attribute.
> Modify ad7152_read_raw() and ad7152_write_raw() to allow reading and
> writing the element as well.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
Looking pretty good and a nice explanation.

One tiny little change (see inline) would make it even better.

Thanks,

Jonathan
> ---
> Changes in v2:
> Give a more detailed explanation
> Remove null check for val in ad7152_write_raw_samp_freq()
> Merged two stucture variable initialisations into one statement in ad7152_read_raw_samp_freq()
> Set ret to IIO_VAL_INT in ad7152_read_raw() when mask equals IIO_CHAN_INFO_SAMP_FREQ and ret>=0
> 
>  drivers/staging/iio/cdc/ad7152.c | 119 ++++++++++++++++++++++-----------------
>  1 file changed, 68 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 485d0a5..3a66e3a 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -165,63 +165,12 @@ static const unsigned char ad7152_filter_rate_table[][2] = {
>  	{200, 5 + 1}, {50, 20 + 1}, {20, 50 + 1}, {17, 60 + 1},
>  };
>  
> -static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7152_chip_info *chip = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%d\n",
> -		       ad7152_filter_rate_table[chip->filter_rate_setup][0]);
> -}
> -
> -static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7152_chip_info *chip = iio_priv(indio_dev);
> -	u8 data;
> -	int ret, i;
> -
> -	ret = kstrtou8(buf, 10, &data);
> -	if (ret < 0)
> -		return ret;
> -
> -	for (i = 0; i < ARRAY_SIZE(ad7152_filter_rate_table); i++)
> -		if (data >= ad7152_filter_rate_table[i][0])
> -			break;
> -
> -	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
> -		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
> -
> -	mutex_lock(&indio_dev->mlock);
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -			AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
> -	if (ret < 0) {
> -		mutex_unlock(&indio_dev->mlock);
> -		return ret;
> -	}
> -
> -	chip->filter_rate_setup = i;
> -	mutex_unlock(&indio_dev->mlock);
> -
> -	return len;
> -}
> -
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
> -		ad7152_show_filter_rate_setup,
> -		ad7152_store_filter_rate_setup);
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("200 50 20 17");
>  
>  static IIO_CONST_ATTR(in_capacitance_scale_available,
>  		      "0.000061050 0.000030525 0.000015263 0.000007631");
>  
>  static struct attribute *ad7152_attributes[] = {
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
>  	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
>  	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
> @@ -247,6 +196,53 @@ static const int ad7152_scale_table[] = {
>  	30525, 7631, 15263, 61050
>  };
>  
> +/**
> + * read_raw handler for IIO_CHAN_INFO_SAMP_FREQ
> + *
> + * lock must be held
> + **/
> +static int ad7152_read_raw_samp_freq(struct device *dev, int *val)
> +{
> +	struct ad7152_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> +
> +	*val = ad7152_filter_rate_table[chip->filter_rate_setup][0];
> +
> +	return 0;
> +}
> +
> +/**
> + * write_raw handler for IIO_CHAN_INFO_SAMP_FREQ
> + *
> + * lock must be held
> + **/
> +static int ad7152_write_raw_samp_freq(struct device *dev, int val)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7152_chip_info *chip = iio_priv(indio_dev);
> +	u8 data;
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7152_filter_rate_table); i++)
> +		if (data >= ad7152_filter_rate_table[i][0])
> +			break;
> +
> +	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
> +		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	ret = i2c_smbus_write_byte_data(chip->client,
> +					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
> +	if (ret < 0) {
> +		mutex_unlock(&indio_dev->mlock);
Drop the unlock in this error path and use the one at the exit point 
instead.

Also, if it had made sense to have this goto out here, it would have
been cleaner to return immediately.  Some C coding conventions argue
in favour of a single exit point.  In kernel conventions we tend
to go for a single unwind point for anything that needs unwinding.
If there is nothing, then an immediate return.
> +		goto out;
> +	}
> +
> +	chip->filter_rate_setup = i;
Move out to here.
> +	mutex_unlock(&indio_dev->mlock);
> +
> +out:
> +	return ret;
> +}
>  static int ad7152_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val,
> @@ -309,6 +305,16 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
>  
>  		ret = 0;
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val2)
> +			return -EINVAL;
> +
> +		ret = ad7152_write_raw_samp_freq(&indio_dev->dev, val);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -403,6 +409,13 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = IIO_VAL_INT_PLUS_NANO;
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ad7152_read_raw_samp_freq(&indio_dev->dev, val);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = IIO_VAL_INT;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -440,6 +453,7 @@ static const struct iio_chan_spec ad7152_channels[] = {
>  		BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  		BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	}, {
>  		.type = IIO_CAPACITANCE,
>  		.differential = 1,
> @@ -450,6 +464,7 @@ static const struct iio_chan_spec ad7152_channels[] = {
>  		BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  		BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	}, {
>  		.type = IIO_CAPACITANCE,
>  		.indexed = 1,
> @@ -458,6 +473,7 @@ static const struct iio_chan_spec ad7152_channels[] = {
>  		BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  		BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	}, {
>  		.type = IIO_CAPACITANCE,
>  		.differential = 1,
> @@ -468,6 +484,7 @@ static const struct iio_chan_spec ad7152_channels[] = {
>  		BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |
>  		BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	}
>  };
>  /*
> 

