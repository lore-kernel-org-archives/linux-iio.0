Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52617 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcDQJY1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 05:24:27 -0400
Subject: Re: [PATCH v2 2/5] max44000: Initial support for proximity reading
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1460400449.git.leonard.crestez@intel.com>
 <1887658e9667257b1b43ed82c58a4155fb0e85fb.1460400449.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57135649.7060305@kernel.org>
Date: Sun, 17 Apr 2016 10:24:25 +0100
MIME-Version: 1.0
In-Reply-To: <1887658e9667257b1b43ed82c58a4155fb0e85fb.1460400449.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 19:52, Crestez Dan Leonard wrote:
> The proximity sensor relies on sending pulses to an external IR led and
> it is disabled by default on powerup. The driver will enable it with a
> default power setting.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/iio/light/max44000.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index 707cc24..39853ff 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -59,6 +59,11 @@
>   */
>  #define MAX44000_REG_CFG_RX_DEFAULT 0xf0
>  
> +/* REG_TX bits */
> +#define MAX44000_LED_CURRENT_MASK	0xf
> +#define MAX44000_LED_CURRENT_MAX	11
> +#define MAX44000_LED_CURRENT_DEFAULT	6
> +
>  #define MAX44000_ALSDATA_OVERFLOW	0x4000
>  
>  #define MAX44000_REGMASK_READABLE ( \
> @@ -111,6 +116,12 @@ static const struct iio_chan_spec max44000_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					    BIT(IIO_CHAN_INFO_INT_TIME),
Where did INT_TIME for the ambient light channel sneak in from?
Astray from patch 4?
> +	},
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  };
> @@ -142,11 +153,23 @@ static int max44000_read_alsval(struct max44000_data *data)
>  	return regval;
>  }
>  
> +static int max44000_write_led_current_raw(struct max44000_data *data, int val)
> +{
> +	/* Maybe we should clamp the value instead? */
> +	if (val < 0 || val > MAX44000_LED_CURRENT_MAX)
> +		return -ERANGE;
> +	if (val >= 8)
> +		val += 4;
> +	return regmap_write_bits(data->regmap, MAX44000_REG_CFG_TX,
> +				 MAX44000_LED_CURRENT_MASK, val);
> +}
> +
>  static int max44000_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
>  {
>  	struct max44000_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
>  	int ret;
>  
>  	switch (mask) {
> @@ -161,6 +184,15 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
>  			*val = ret;
>  			return IIO_VAL_INT;
>  
> +		case IIO_PROXIMITY:
> +			mutex_lock(&data->lock);
> +			ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			*val = regval;
> +			return IIO_VAL_INT;
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -279,8 +311,18 @@ static int max44000_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	/* Reset CFG bits to ALS-only mode and no interrupts */
> -	reg = MAX44000_CFG_TRIM | MAX44000_CFG_MODE_ALS_GIR;
> +	/*
> +	 * By default the LED pulse used for the proximity sensor is disabled.
> +	 * Set a middle value so that we get some sort of valid data by default.
> +	 */
> +	ret = max44000_write_led_current_raw(data, MAX44000_LED_CURRENT_DEFAULT);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to write init config: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Reset CFG bits to ALS_PRX mode which allows easy reading of both values. */
> +	reg = MAX44000_CFG_TRIM | MAX44000_CFG_MODE_ALS_PRX;
>  	ret = regmap_write(data->regmap, MAX44000_REG_CFG_MAIN, reg);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed to write init config: %d\n", ret);
> 

