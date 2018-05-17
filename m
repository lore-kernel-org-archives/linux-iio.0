Return-Path: <SRS0=xqpZ=IE=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2] Add support for external reference voltage through the
 regulator framework
To: Silvan Murer <silvan.murer@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <1526415250.32235.17.camel@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <37a86fef-2097-cc02-56e4-9c3ffbe393e3@metafoo.de>
Date: Thu, 17 May 2018 13:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <1526415250.32235.17.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/15/2018 10:14 PM, Silvan Murer wrote:
> Add support for external reference voltage through the regulator framework.
> 
> Signed-off-by: Silvan Murer <silvan.murer@gmail.com>

Looks good, thanks.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Just two tiny whitespace issues.

[...]
>  enum ltc2632_supported_device_ids {
> @@ -90,7 +96,7 @@ static int ltc2632_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = chip_info->vref_mv;
> +		*val =  st->vref_mv;

Extra space after the '='.

>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
> @@ -247,6 +253,45 @@ static int ltc2632_probe(struct spi_device *spi)
>  	chip_info = (struct ltc2632_chip_info *)
>  			spi_get_device_id(spi)->driver_data;
>  
> +	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (PTR_ERR(st->vref_reg) == -ENODEV) {
> +		/* use internal reference voltage */
> +		st->vref_reg = NULL;
> +		st->vref_mv = chip_info->vref_mv;
> +
> +		ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
> +				0, 0, 0);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"Set internal reference command failed, %d\n",
> +				ret);
> +			return ret;
> +		}
> +	} else if (IS_ERR(st->vref_reg)) {
> +		dev_err(&spi->dev,
> +				"Error getting voltage reference regulator\n");
> +			return PTR_ERR(st->vref_reg);

Extra tab before the 'return'.

> +	} else {
> +		/* use external reference voltage */
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"enable reference regulator failed, %d\n",
> +				ret);
> +			return ret;
> +		}
> +		st->vref_mv = regulator_get_voltage(st->vref_reg) / 1000;
> +
> +		ret = ltc2632_spi_write(spi, LTC2632_CMD_EXTERNAL_REFER,
> +				0, 0, 0);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"Set external reference command failed, %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
[...]
