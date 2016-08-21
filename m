Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52115 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbcHUPSs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 11:18:48 -0400
Subject: Re: [PATCH v2 1/2] staging: iio: vcnl4000: Add IR current adjust
 support
To: Pratik Prajapati <pratik.prajapati12@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1469444249-2124-1-git-send-email-pratik.prajapati12@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ceb858df-d824-e6e8-9d8b-dc05c8507ad4@kernel.org>
Date: Sun, 21 Aug 2016 16:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <1469444249-2124-1-git-send-email-pratik.prajapati12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/16 11:57, Pratik Prajapati wrote:
> Signed-off-by: Pratik Prajapati <pratik.prajapati12@gmail.com>
Sorry it took me so long to get to this. Wading back through my
emails post holiday still.

Small issue in the documentation.

Jonathan
> ---
> Changes v1 -> v2:
>   - documented current_led files in ABI 
>   - masked value while writing to led register
>   - added blank line before last return
>   - removed redundant return
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 13 ++++++
>  drivers/iio/light/vcnl4000.c            | 77 ++++++++++++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index fee35c0..7129be6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1579,3 +1579,16 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled no offset etc.) electric conductivity reading that
>  		can be processed to siemens per meter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_led_raw
> +KernelVersion:	4.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This controls the current to an IR LED.
It's controlling an output is it not? Rather than monitoring the current
through the LED.

Should be out_current_led_raw

Actually I think the issue is only in the docs as it looks right in the
code.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_led_scale
> +KernelVersion:	4.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the conversion factor from the standard unit
> +		to device specific unit.
out_ again.
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 360b6e9..dcf7a6f 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -3,6 +3,7 @@
>   * light and proximity sensor
>   *
>   * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
> + * Copyright (C) 2016 Pratik Prajapati <pratik.prajapati12@gmail.com>
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -11,7 +12,6 @@
>   * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
>   *
>   * TODO:
> - *   allow to adjust IR current
>   *   proximity threshold and event handling
>   *   periodic ALS/proximity measurement (VCNL4010/20)
>   *   interrupts (VCNL4010/20)
> @@ -46,6 +46,10 @@
>  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
>  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
>  
> +/* Bit mask for LED_CURRENT register */
> +#define VCNL4000_LED_CURRENT_MASK	0x3F
> +#define VCNL4000_LED_CURRENT_MAX	20
> +
>  struct vcnl4000_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> @@ -111,9 +115,43 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
>  	}, {
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -	}
> +	}, {
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.extend_name = "led",
> +		.output = 1,
> +		.scan_index = -1,
> +	},
>  };
>  
> +static int vcnl4000_write_led_current_raw(struct vcnl4000_data *data, int val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val > VCNL4000_LED_CURRENT_MAX)
> +		return -ERANGE;
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_LED_CURRENT,
> +			VCNL4000_LED_CURRENT_MASK & val);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4000_read_led_current_raw(struct vcnl4000_data *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_LED_CURRENT);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret &= VCNL4000_LED_CURRENT_MASK;
> +}
> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -138,23 +176,50 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  			if (ret < 0)
>  				return ret;
>  			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			ret = vcnl4000_read_led_current_raw(data);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}
> +
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type != IIO_LIGHT)
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			*val = 0;
> +			*val2 = 250000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_CURRENT:
> +			/* Output register is in 10s of milliamps */
> +			*val = 10;
> +			return IIO_VAL_INT;
> +		default:
>  			return -EINVAL;
> +		}
>  
> -		*val = 0;
> -		*val2 = 250000;
> -		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int vcnl4000_write_raw(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					int val, int val2, long mask)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	if (mask == IIO_CHAN_INFO_RAW && chan->type == IIO_CURRENT)
> +		return vcnl4000_write_led_current_raw(data, val);
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info vcnl4000_info = {
>  	.read_raw = vcnl4000_read_raw,
> +	.write_raw = vcnl4000_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

