Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52631 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcDQJ0D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 05:26:03 -0400
Subject: Re: [PATCH v2 3/5] max44000: Support controlling LED current output
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1460400449.git.leonard.crestez@intel.com>
 <714878e6e21dd65d9be2c91a3b2a583ca25e5930.1460400449.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571356A9.2060900@kernel.org>
Date: Sun, 17 Apr 2016 10:26:01 +0100
MIME-Version: 1.0
In-Reply-To: <714878e6e21dd65d9be2c91a3b2a583ca25e5930.1460400449.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 19:52, Crestez Dan Leonard wrote:
> This is exposed as an output channel with "led" as an extend_name.
> 
> Other sensors also have support for controlling an external LED. It's
> not clear that simply exposing an undecorated output channel is the
> correct approach.
Agreed that this is still unclear.  Lets go with this for now, we can always
add an additional interface to control it if we come to a firm conclusion on
this in the future.

This patch looks good to me.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/iio/light/max44000.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index 39853ff..662a45b 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -124,6 +124,13 @@ static const struct iio_chan_spec max44000_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  	},
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.extend_name = "led",
> +		.output = 1,
> +	},
>  };
>  
>  static int max44000_read_alsval(struct max44000_data *data)
> @@ -164,6 +171,20 @@ static int max44000_write_led_current_raw(struct max44000_data *data, int val)
>  				 MAX44000_LED_CURRENT_MASK, val);
>  }
>  
> +static int max44000_read_led_current_raw(struct max44000_data *data)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MAX44000_REG_CFG_TX, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval &= MAX44000_LED_CURRENT_MASK;
> +	if (regval >= 8)
> +		regval -= 4;
> +	return regval;
> +}
> +
>  static int max44000_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
> @@ -193,12 +214,26 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
>  			*val = regval;
>  			return IIO_VAL_INT;
>  
> +		case IIO_CURRENT:
> +			mutex_lock(&data->lock);
> +			ret = max44000_read_led_current_raw(data);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret;
> +			return IIO_VAL_INT;
> +
>  		default:
>  			return -EINVAL;
>  		}
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_CURRENT:
> +			/* Output register is in 10s of miliamps */
> +			*val = 10;
> +			return IIO_VAL_INT;
> +
>  		case IIO_LIGHT:
>  			*val = 1;
>  			*val2 = MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2;
> @@ -213,9 +248,27 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int max44000_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct max44000_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask == IIO_CHAN_INFO_RAW && chan->type == IIO_CURRENT) {
> +		mutex_lock(&data->lock);
> +		ret = max44000_write_led_current_raw(data, val);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info max44000_info = {
>  	.driver_module		= THIS_MODULE,
>  	.read_raw		= max44000_read_raw,
> +	.write_raw		= max44000_write_raw,
>  };
>  
>  static bool max44000_readable_reg(struct device *dev, unsigned int reg)
> 

