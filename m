Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49090 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1HXOFG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 10:05:06 -0400
Message-ID: <4E5506FC.9060401@cam.ac.uk>
Date: Wed, 24 Aug 2011 15:13:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/5] iio: ad7152: Miscellaneous fixes and touch-up
References: <1314189956-26511-1-git-send-email-michael.hennerich@analog.com> <1314189956-26511-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314189956-26511-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/24/11 13:45, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Remove unused define.
> Introduce cached SETUP variables.
> Wait until calibration finished. (Device returns to idle state)
> IIO_CHAN_INFO_CALIBSCALE_SEPARATE use proper scales. (range 1.0 to 1.99999)
> i2c_smbus word transactions expect low byte first, therefore swap bytes.
> CAPDIFF is bit in SETUP not CFG.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

merged into iio-blue.git

Thanks,
> ---
>  drivers/staging/iio/adc/ad7152.c |   77 ++++++++++++++++++++++++--------------
>  1 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
> index b0db745..0f653f5 100644
> --- a/drivers/staging/iio/adc/ad7152.c
> +++ b/drivers/staging/iio/adc/ad7152.c
> @@ -51,6 +51,7 @@
>  #define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
>  #define AD7152_SETUP_RANGE_1pF		(2 << 6)
>  #define AD7152_SETUP_RANGE_4pF		(3 << 6)
> +#define AD7152_SETUP_RANGE(x)		((x) << 6)
>  
>  /* Config Register Bit Designations (AD7152_REG_CFG) */
>  #define AD7152_CONF_CH2EN		(1 << 3)
> @@ -65,8 +66,6 @@
>  #define AD7152_CAPDAC_DACEN		(1 << 7)
>  #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
>  
> -#define AD7152_MAX_CONV_MODE		6
> -
>  enum {
>  	AD7152_DATA,
>  	AD7152_OFFS,
> @@ -84,7 +83,8 @@ struct ad7152_chip_info {
>  	 * Capacitive channel digital filter setup;
>  	 * conversion time/update rate setup per channel
>  	 */
> -	u8  filter_rate_setup;
> +	u8	filter_rate_setup;
> +	u8	setup[2];
>  };
>  
>  static inline ssize_t ad7152_start_calib(struct device *dev,
> @@ -97,7 +97,7 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
>  	struct ad7152_chip_info *chip = iio_priv(dev_info);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	bool doit;
> -	int ret;
> +	int ret, timeout = 10;
>  
>  	ret = strtobool(buf, &doit);
>  	if (ret < 0)
> @@ -114,8 +114,14 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
>  	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
>  	if (ret < 0)
>  		return ret;
> -	/* Unclear on period this should be set for or whether it flips back
> -	 * to idle automatically */
> +
> +	do {
> +		mdelay(20);
> +		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
> +		if (ret < 0)
> +			return ret;
> +	} while ((ret == regval) && timeout--);
> +
>  	return len;
>  }
>  static ssize_t ad7152_start_offset_calib(struct device *dev,
> @@ -123,7 +129,6 @@ static ssize_t ad7152_start_offset_calib(struct device *dev,
>  					 const char *buf,
>  					 size_t len)
>  {
> -
>  	return ad7152_start_calib(dev, attr, buf, len,
>  				  AD7152_CONF_MODE_OFFS_CAL);
>  }
> @@ -221,11 +226,14 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
>  
>  	switch (mask) {
>  	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
> -		if ((val < 0) | (val > 0xFFFF))
> +		if (val != 1)
>  			return -EINVAL;
> +
> +		val = (val2 * 1024) / 15625;
> +
>  		ret = i2c_smbus_write_word_data(chip->client,
>  				ad7152_addresses[chan->channel][AD7152_GAIN],
> -				val);
> +				swab16(val));
>  		if (ret < 0)
>  			return ret;
>  
> @@ -236,7 +244,7 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
>  			return -EINVAL;
>  		ret = i2c_smbus_write_word_data(chip->client,
>  				ad7152_addresses[chan->channel][AD7152_OFFS],
> -				val);
> +				swab16(val));
>  		if (ret < 0)
>  			return ret;
>  
> @@ -247,14 +255,13 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
>  		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
>  			if (val2 <= ad7152_scale_table[i])
>  				break;
> -		ret = i2c_smbus_read_byte_data(chip->client,
> -				ad7152_addresses[chan->channel][AD7152_SETUP]);
> -		if (ret < 0)
> -			return ret;
> -		if ((ret & 0xC0) != i)
> -			ret = i2c_smbus_write_byte_data(chip->client,
> +
> +		chip->setup[chan->channel] &= ~AD7152_SETUP_RANGE_4pF;
> +		chip->setup[chan->channel] |= AD7152_SETUP_RANGE(i);
> +
> +		ret = i2c_smbus_write_byte_data(chip->client,
>  				ad7152_addresses[chan->channel][AD7152_SETUP],
> -				(ret & ~0xC0) | i);
> +				chip->setup[chan->channel]);
>  		if (ret < 0)
>  			return ret;
>  		else
> @@ -274,18 +281,30 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
>  	switch (mask) {
>  	case 0:
>  		/* First set whether in differential mode */
> +
> +		regval = chip->setup[chan->channel];
> +
>  		if (chan->differential)
> -			regval = AD7152_SETUP_CAPDIFF;
> +			chip->setup[chan->channel] |= AD7152_SETUP_CAPDIFF;
> +		else
> +			chip->setup[chan->channel] &= ~AD7152_SETUP_CAPDIFF;
>  
> +		if (regval != chip->setup[chan->channel]) {
> +			ret = i2c_smbus_write_byte_data(chip->client,
> +				ad7152_addresses[chan->channel][AD7152_SETUP],
> +				chip->setup[chan->channel]);
> +			if (ret < 0)
> +				return ret;
> +		}
>  		/* Make sure the channel is enabled */
> -		if (chan->address == 0)
> -			regval |= AD7152_CONF_CH1EN;
> +		if (chan->channel == 0)
> +			regval = AD7152_CONF_CH1EN;
>  		else
> -			regval |= AD7152_CONF_CH2EN;
> +			regval = AD7152_CONF_CH2EN;
> +
>  		/* Trigger a single read */
>  		regval |= AD7152_CONF_MODE_SINGLE_CONV;
> -		ret = i2c_smbus_write_byte_data(chip->client,
> -				ad7152_addresses[chan->channel][AD7152_SETUP],
> +		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
>  				regval);
>  		if (ret < 0)
>  			return ret;
> @@ -296,24 +315,26 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
>  				ad7152_addresses[chan->channel][AD7152_DATA]);
>  		if (ret < 0)
>  			return ret;
> -		*val = ret;
> +		*val = swab16(ret);
>  
>  		return IIO_VAL_INT;
>  	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
> -		/* FIXME: Hmm. very small. it's 1+ 1/(2^16 *val) */
> +
>  		ret = i2c_smbus_read_word_data(chip->client,
>  				ad7152_addresses[chan->channel][AD7152_GAIN]);
>  		if (ret < 0)
>  			return ret;
> -		*val = ret;
> +		/* 1 + gain_val / 2^16 */
> +		*val = 1;
> +		*val2 = (15625 * swab16(ret)) / 1024;
>  
> -		return IIO_VAL_INT;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
>  		ret = i2c_smbus_read_word_data(chip->client,
>  				ad7152_addresses[chan->channel][AD7152_OFFS]);
>  		if (ret < 0)
>  			return ret;
> -		*val = ret;
> +		*val = swab16(ret);
>  
>  		return IIO_VAL_INT;
>  	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):

