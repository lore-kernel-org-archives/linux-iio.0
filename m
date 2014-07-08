Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56185 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaGHSJG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 14:09:06 -0400
Message-ID: <53BC3445.1060308@kernel.org>
Date: Tue, 08 Jul 2014 19:11:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/6] staging:iio:ad7291 fix coding style
References: <53BBD0CB.3000701@gmx.de>
In-Reply-To: <53BBD0CB.3000701@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/14 12:06, Hartmut Knaack wrote:
> Fix indention and comment style.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index c08b258..f5d29ef 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -31,7 +31,6 @@
>    * is in the read mask.
>    *
>    * The noise-delayed bit as per datasheet suggestion is always enabled.
> - *
>    */
>
>   /*
> @@ -163,7 +162,8 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
>   }
>
>   static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
> -	enum iio_event_direction dir, enum iio_event_info info)
> +					 enum iio_event_direction dir,
> +					 enum iio_event_info info)
>   {
>   	unsigned int offset;
>
> @@ -180,14 +180,14 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
>
>   	switch (info) {
>   	case IIO_EV_INFO_VALUE:
> -			if (dir == IIO_EV_DIR_FALLING)
> -					return AD7291_DATA_HIGH(offset);
> -			else
> -					return AD7291_DATA_LOW(offset);
> +		if (dir == IIO_EV_DIR_FALLING)
> +			return AD7291_DATA_HIGH(offset);
> +		else
> +			return AD7291_DATA_LOW(offset);
>   	case IIO_EV_INFO_HYSTERESIS:
> -			return AD7291_HYST(offset);
> +		return AD7291_HYST(offset);
>   	default:
> -			break;
> +		break;
>   	}
>   	return 0;
>   }
> @@ -204,7 +204,7 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
>   	u16 uval;
>
>   	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(chan, dir, info),
> -		&uval);
> +			      &uval);
>   	if (ret < 0)
>   		return ret;
>
> @@ -235,7 +235,7 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
>   	}
>
>   	return ad7291_i2c_write(chip, ad7291_threshold_reg(chan, dir, info),
> -		val);
> +				val);
>   }
>
>   static int ad7291_read_event_config(struct iio_dev *indio_dev,
> @@ -244,8 +244,10 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
>   				    enum iio_event_direction dir)
>   {
>   	struct ad7291_chip_info *chip = iio_priv(indio_dev);
> -	/* To be enabled the channel must simply be on. If any are enabled
> -	   we are in continuous sampling mode */
> +	/*
> +	 * To be enabled the channel must simply be on. If any are enabled
> +	 * we are in continuous sampling mode
> +	 */
>
>   	switch (chan->type) {
>   	case IIO_VOLTAGE:
> @@ -342,7 +344,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>   			}
>   			/* Read voltage */
>   			ret = i2c_smbus_read_word_swapped(chip->client,
> -						       AD7291_VOLTAGE);
> +							  AD7291_VOLTAGE);
>   			if (ret < 0) {
>   				mutex_unlock(&chip->state_lock);
>   				return ret;
> @@ -353,7 +355,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>   		case IIO_TEMP:
>   			/* Assumes tsense bit of command register always set */
>   			ret = i2c_smbus_read_word_swapped(chip->client,
> -						       AD7291_T_SENSE);
> +							  AD7291_T_SENSE);
>   			if (ret < 0)
>   				return ret;
>   			*val = sign_extend32(ret, 11);
> @@ -363,7 +365,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>   		}
>   	case IIO_CHAN_INFO_AVERAGE_RAW:
>   		ret = i2c_smbus_read_word_swapped(chip->client,
> -					       AD7291_T_AVERAGE);
> +						  AD7291_T_AVERAGE);
>   			if (ret < 0)
>   				return ret;
>   			*val = sign_extend32(ret, 11);
> @@ -458,7 +460,7 @@ static const struct iio_info ad7291_info = {
>   };
>
>   static int ad7291_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +			const struct i2c_device_id *id)
>   {
>   	struct ad7291_platform_data *pdata = client->dev.platform_data;
>   	struct ad7291_chip_info *chip;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

