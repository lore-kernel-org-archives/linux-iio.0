Return-Path: <knaack.h@gmx.de>
Message-ID: <5598020C.1060305@gmx.de>
Date: Sat, 04 Jul 2015 17:55:56 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
 linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2] iio: light: STK3310: un-invert proximity values
References: <1435753920-22825-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1435753920-22825-1-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Tiberiu Breana schrieb am 01.07.2015 um 14:32:
> In accordance with the recent proximity ABI changes,
> STK3310's proximity readings should be un-inversed
> in order to return low values for far-away objects
> and high values for close ones.
> 
> As consequences of this change, iio event directions
> have been switched and maximum proximity sensor
> reference values have also been adjusted in accordance
> with the real readings.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
> v2: Updated the commit message to better reflect all changes
> ---
>  drivers/iio/light/stk3310.c | 53 +++++++++++++++------------------------------
>  1 file changed, 17 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index e79b9d8..b7ec2a5 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -43,7 +43,6 @@
>  #define STK3311_CHIP_ID_VAL			0x1D
>  #define STK3310_PSINT_EN			0x01
>  #define STK3310_PS_MAX_VAL			0xFFFF
> -#define STK3310_THRESH_MAX			0xFFFF
>  
>  #define STK3310_DRIVER_NAME			"stk3310"
>  #define STK3310_REGMAP_NAME			"stk3310_regmap"
> @@ -84,15 +83,13 @@ static const struct reg_field stk3310_reg_field_flag_psint =
>  				REG_FIELD(STK3310_REG_FLAG, 4, 4);
>  static const struct reg_field stk3310_reg_field_flag_nf =
>  				REG_FIELD(STK3310_REG_FLAG, 0, 0);
> -/*
> - * Maximum PS values with regard to scale. Used to export the 'inverse'
> - * PS value (high values for far objects, low values for near objects).
> - */
> +
> +/* Estimate maximum proximity values with regard to measurement scale. */
>  static const int stk3310_ps_max[4] = {
> -	STK3310_PS_MAX_VAL / 64,
> -	STK3310_PS_MAX_VAL / 16,
> -	STK3310_PS_MAX_VAL /  4,
> -	STK3310_PS_MAX_VAL,
> +	STK3310_PS_MAX_VAL / 640,
> +	STK3310_PS_MAX_VAL / 160,
> +	STK3310_PS_MAX_VAL /  40,
> +	STK3310_PS_MAX_VAL /  10
>  };
>  
>  static const int stk3310_scale_table[][2] = {
> @@ -128,14 +125,14 @@ static const struct iio_event_spec stk3310_events[] = {
>  	/* Proximity event */
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_FALLING,
> +		.dir = IIO_EV_DIR_RISING,
>  		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>  				 BIT(IIO_EV_INFO_ENABLE),
>  	},
>  	/* Out-of-proximity event */
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_RISING,
> +		.dir = IIO_EV_DIR_FALLING,
>  		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>  				 BIT(IIO_EV_INFO_ENABLE),
>  	},
> @@ -205,23 +202,16 @@ static int stk3310_read_event(struct iio_dev *indio_dev,
>  	u8 reg;
>  	u16 buf;
>  	int ret;
> -	unsigned int index;
>  	struct stk3310_data *data = iio_priv(indio_dev);
>  
>  	if (info != IIO_EV_INFO_VALUE)
>  		return -EINVAL;
>  
> -	/*
> -	 * Only proximity interrupts are implemented at the moment.
> -	 * Since we're inverting proximity values, the sensor's 'high'
> -	 * threshold will become our 'low' threshold, associated with
> -	 * 'near' events. Similarly, the sensor's 'low' threshold will
> -	 * be our 'high' threshold, associated with 'far' events.
> -	 */
> +	/* Only proximity interrupts are implemented at the moment. */
>  	if (dir == IIO_EV_DIR_RISING)
> -		reg = STK3310_REG_THDL_PS;
> -	else if (dir == IIO_EV_DIR_FALLING)
>  		reg = STK3310_REG_THDH_PS;
> +	else if (dir == IIO_EV_DIR_FALLING)
> +		reg = STK3310_REG_THDL_PS;
>  	else
>  		return -EINVAL;
>  
> @@ -232,8 +222,7 @@ static int stk3310_read_event(struct iio_dev *indio_dev,
>  		dev_err(&data->client->dev, "register read failed\n");
>  		return ret;
>  	}
> -	regmap_field_read(data->reg_ps_gain, &index);
> -	*val = swab16(stk3310_ps_max[index] - buf);
> +	*val = swab16(buf);
>  
>  	return IIO_VAL_INT;
>  }
> @@ -257,13 +246,13 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	if (dir == IIO_EV_DIR_RISING)
> -		reg = STK3310_REG_THDL_PS;
> -	else if (dir == IIO_EV_DIR_FALLING)
>  		reg = STK3310_REG_THDH_PS;
> +	else if (dir == IIO_EV_DIR_FALLING)
> +		reg = STK3310_REG_THDL_PS;
>  	else
>  		return -EINVAL;
>  
> -	buf = swab16(stk3310_ps_max[index] - val);
> +	buf = swab16(val);
>  	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
>  	if (ret < 0)
>  		dev_err(&client->dev, "failed to set PS threshold!\n");
> @@ -334,14 +323,6 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		}
>  		*val = swab16(buf);
> -		if (chan->type == IIO_PROXIMITY) {
> -			/*
> -			 * Invert the proximity data so we return low values
> -			 * for close objects and high values for far ones.
> -			 */
> -			regmap_field_read(data->reg_ps_gain, &index);
> -			*val = stk3310_ps_max[index] - *val;
> -		}
>  		mutex_unlock(&data->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
> @@ -581,8 +562,8 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
>  	}
>  	event = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
>  				     IIO_EV_TYPE_THRESH,
> -				     (dir ? IIO_EV_DIR_RISING :
> -					    IIO_EV_DIR_FALLING));
> +				     (dir ? IIO_EV_DIR_FALLING :
> +					    IIO_EV_DIR_RISING));
>  	iio_push_event(indio_dev, event, data->timestamp);
>  
>  	/* Reset the interrupt flag */
> 
