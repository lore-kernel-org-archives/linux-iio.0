Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:48922 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbcGRWUX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jul 2016 18:20:23 -0400
Date: Tue, 19 Jul 2016 00:20:21 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: vcnl4000: Add IR current adjust support
In-Reply-To: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com>
Message-ID: <alpine.DEB.2.02.1607190016030.25263@pmeerw.net>
References: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Signed-off-by: Pratik Prajapati <pratik.prajapati12@gmail.com>

comments below; nice addition

it seems this patch clashes with the recent changes to this driver in 
iio-testing; can you rebase on top please?

I suggest to split out the transition to regmap in a separate patch

> ---
>  drivers/iio/light/vcnl4000.c | 119 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 116 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index c9d85bb..6b8b223 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -11,7 +11,6 @@
>   * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
>   *
>   * TODO:
> - *   allow to adjust IR current
>   *   proximity threshold and event handling
>   */
>  
> @@ -19,6 +18,7 @@
>  #include <linux/i2c.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -42,8 +42,14 @@
>  #define VCNL4000_AL_OD		0x10 /* start on-demand ALS measurement */
>  #define VCNL4000_PS_OD		0x08 /* start on-demand proximity measurement */
>  
> +/* Bit mask for LED_CURRENT register */
> +#define VCNL4000_LED_CURRENT_MASK	0x3F
> +#define VCNL4000_LED_CURRENT_MAX	20
> +
>  struct vcnl4000_data {
>  	struct i2c_client *client;
> +	struct mutex lock;
> +	struct regmap *regmap;
>  };
>  
>  static const struct i2c_device_id vcnl4000_id[] = {
> @@ -98,9 +104,36 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
>  	}, {
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.extend_name = "led",
> +		.output = 1,
> +		.scan_index = -1,
>  	}

end with a , maybe

>  };
>  
> +static int vcnl4000_write_led_current_raw(struct vcnl4000_data *data, int val)
> +{
> +	if (val < 0 || val > VCNL4000_LED_CURRENT_MAX)
> +		return -ERANGE;
> +	return regmap_write_bits(data->regmap, VCNL4000_LED_CURRENT,
> +		VCNL4000_LED_CURRENT_MASK, val);
> +}
> +
> +static int vcnl4000_read_led_current_raw(struct vcnl4000_data *data)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, VCNL4000_LED_CURRENT, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval &= VCNL4000_LED_CURRENT_MASK;
> +	return regval;
> +}
> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -127,15 +160,31 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				return ret;
>  			ret = IIO_VAL_INT;
>  			break;
> +		case IIO_CURRENT:
> +			mutex_lock(&data->lock);
> +			ret = vcnl4000_read_led_current_raw(data);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret;
> +			return IIO_VAL_INT;
>  		default:
>  			break;
>  		}
>  		break;
> +
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type == IIO_LIGHT) {
> +		switch (chan->type) {
> +		case IIO_LIGHT:
>  			*val = 0;
>  			*val2 = 250000;
> -			ret = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_CURRENT:
> +			/* Output register is in 10s of miliamps */

milliamps

> +			*val = 10;
> +			return IIO_VAL_INT;
> +		default:
> +			break;
>  		}
>  		break;
>  	default:
> @@ -145,11 +194,69 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int vcnl4000_write_raw(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					int val, int val2, long mask)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask == IIO_CHAN_INFO_RAW && chan->type == IIO_CURRENT) {
> +		mutex_lock(&data->lock);
> +		ret = vcnl4000_write_led_current_raw(data, val);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info vcnl4000_info = {
>  	.read_raw = vcnl4000_read_raw,
> +	.write_raw = vcnl4000_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static bool vcnl4000_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case VCNL4000_COMMAND:
> +	case VCNL4000_PROD_REV:
> +	case VCNL4000_LED_CURRENT:
> +	case VCNL4000_AL_PARAM:
> +	case VCNL4000_AL_RESULT_HI:
> +	case VCNL4000_AL_RESULT_LO:
> +	case VCNL4000_PS_RESULT_HI:
> +	case VCNL4000_PS_RESULT_LO:
> +	case VCNL4000_PS_MEAS_FREQ:
> +	case VCNL4000_PS_MOD_ADJ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool vcnl4000_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case VCNL4000_COMMAND:
> +	case VCNL4000_LED_CURRENT:
> +	case VCNL4000_AL_PARAM:
> +	case VCNL4000_PS_MEAS_FREQ:
> +	case VCNL4000_PS_MOD_ADJ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config vcnl4000_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= VCNL4000_PS_MOD_ADJ,
> +	.readable_reg	= vcnl4000_readable_reg,
> +	.writeable_reg	= vcnl4000_writeable_reg,
> +};
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -162,7 +269,13 @@ static int vcnl4000_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +	data->regmap = devm_regmap_init_i2c(client, &vcnl4000_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "regmap_init failed!\n");
> +		return PTR_ERR(data->regmap);
> +	}
>  	i2c_set_clientdata(client, indio_dev);
> +	mutex_init(&data->lock);
>  	data->client = client;
>  
>  	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
