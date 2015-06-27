Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:49926 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbbF0NfX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jun 2015 09:35:23 -0400
Message-ID: <558EA68F.9090601@gmx.de>
Date: Sat, 27 Jun 2015 15:35:11 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, jic23@kernel.org,
	pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v5 2/5] iio: ltr501: Add integration time support
References: <cover.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com> <d30093a19faa74ad8092169105309a535ef59e04.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d30093a19faa74ad8092169105309a535ef59e04.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Kuppuswamy Sathyanarayanan schrieb am 19.04.2015 um 11:10:
> Added support to modify and read ALS integration time.

Hi,
maybe I checked the wrong datasheet [1], but I come to a different conclusion.
Please see my comments inline.

[1] http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/S_110_LTR-501ALS-01_PrelimDS_ver1%5B1%5D.pdf

> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/iio/light/ltr501.c | 90 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index e2f7354..8092604 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -28,6 +28,7 @@
>  
>  #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
>  #define LTR501_PS_CONTR 0x81 /* PS operation mode */
> +#define LTR501_ALS_MEAS_RATE 0x85 /* ALS integ time, measurement rate*/
>  #define LTR501_PART_ID 0x86
>  #define LTR501_MANUFAC_ID 0x87
>  #define LTR501_ALS_DATA1 0x88 /* 16-bit, little endian */
> @@ -49,11 +50,17 @@
>  
>  #define LTR501_REGMAP_NAME "ltr501_regmap"
>  
> +static const int int_time_mapping[] = {100000, 50000, 200000, 400000};

The prefix is missing at the instance above and below here.

> +
> +static const struct reg_field reg_field_it =
> +				REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
> +
>  struct ltr501_data {
>  	struct i2c_client *client;
>  	struct mutex lock_als, lock_ps;
>  	u8 als_contr, ps_contr;
>  	struct regmap *regmap;
> +	struct regmap_field *reg_it;
>  };
>  
>  static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
> @@ -74,6 +81,58 @@ static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
>  	return -EIO;
>  }
>  
> +static int ltr501_set_it_time(struct ltr501_data *data, int it)
> +{
> +	int ret, i, index = -1, status;
> +
> +	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
> +		if (int_time_mapping[i] == it) {
> +			index = i;
> +			break;
> +		}
> +	}
> +	/* Make sure integ time index is valid */
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (status & LTR501_CONTR_ALS_GAIN_MASK) {

According to the description on page 17, if ALS Gain is set Dynamic Range 1
is selected. So, as mentioned on page 20, valid index values would be 0, 2
and 3 (meaning invalid value is 1).

> +		/*
> +		 * 200 ms and 400 ms integ time can only be
> +		 * used in dynamic range 1
> +		 */
> +		if (index > 1)
> +			return -EINVAL;
> +	} else

Coding style guidelines prefer to put the else-part in {}, if the if-part
is in {}.
Anyway, my interpretation of the datasheet suggests that this part expects
Dynamic Range 2 to be selected. Valid values are: 0 and 1 (invalid are 2
and 3).

Thanks,
Hartmut

> +		/* 50 ms integ time can only be used in dynamic range 2 */
> +		if (index == 1)
> +			return -EINVAL;
> +
> +	return regmap_field_write(data->reg_it, index);
> +}
> +
> +/* read int time in micro seconds */
> +static int ltr501_read_it_time(struct ltr501_data *data, int *val, int *val2)
> +{
> +	int ret, index;
> +
> +	ret = regmap_field_read(data->reg_it, &index);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Make sure integ time index is valid */
> +	if (index < 0 || index >= ARRAY_SIZE(int_time_mapping))
> +		return -EINVAL;
> +
> +	*val2 = int_time_mapping[index];
> +	*val = 0;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
>  static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
>  {
>  	int ret;
> @@ -121,7 +180,8 @@ static int ltr501_read_ps(struct ltr501_data *data)
>  static const struct iio_chan_spec ltr501_channels[] = {
>  	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0),
>  	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
> -				 BIT(IIO_CHAN_INFO_SCALE)),
> +				 BIT(IIO_CHAN_INFO_SCALE) |
> +				 BIT(IIO_CHAN_INFO_INT_TIME)),
>  	{
>  		.type = IIO_PROXIMITY,
>  		.address = LTR501_PS_DATA,
> @@ -196,6 +256,13 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			return ltr501_read_it_time(data, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  	return -EINVAL;
>  }
> @@ -246,16 +313,30 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			if (val != 0)
> +				return -EINVAL;
> +			mutex_lock(&data->lock_als);
> +			i = ltr501_set_it_time(data, val2);
> +			mutex_unlock(&data->lock_als);
> +			return i;
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  	return -EINVAL;
>  }
>  
>  static IIO_CONST_ATTR(in_proximity_scale_available, "1 0.25 0.125 0.0625");
>  static IIO_CONST_ATTR(in_intensity_scale_available, "1 0.005");
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.05 0.1 0.2 0.4");
>  
>  static struct attribute *ltr501_attributes[] = {
>  	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -404,6 +485,13 @@ static int ltr501_probe(struct i2c_client *client,
>  	mutex_init(&data->lock_als);
>  	mutex_init(&data->lock_ps);
>  
> +	data->reg_it = devm_regmap_field_alloc(&client->dev, regmap,
> +					       reg_field_it);
> +	if (IS_ERR(data->reg_it)) {
> +		dev_err(&client->dev, "Integ time reg field init failed.\n");
> +		return PTR_ERR(data->reg_it);
> +	}
> +
>  	ret = regmap_read(data->regmap, LTR501_PART_ID, &partid);
>  	if (ret < 0)
>  		return ret;
> 

