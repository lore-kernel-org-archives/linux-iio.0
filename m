Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47060 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab2IHJpW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Sep 2012 05:45:22 -0400
Message-ID: <504B13B1.6080202@kernel.org>
Date: Sat, 08 Sep 2012 10:45:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 04/10] staging:iio:ad7476: Rework reference voltage handling
References: <1347021872-7885-1-git-send-email-lars@metafoo.de> <1347021872-7885-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2012 01:44 PM, Lars-Peter Clausen wrote:
> Slightly rework the reference voltage handling for the ad7476 driver. Now the only
> way to specify a external reference voltage is to use the regulator API,
> previously it was possible to use either platform_data or the regulator API. The
> new way is more consistent with what other drivers do.
> 
> Also do not ignore errors when requesting the regulator, since this will cope
> very poorly with e.g. deferred probing.
> 

The approach of using platform data is an old one from the days when the
regulator framework was relatively new and little used.  Now days it probably
makes sense to kill that off in the drivers that use it in favour of insisting
people use a fixed regulator to do the same job...

If anyone wants to pick up the job of clearing this out of the other drivers
that still have it then feel free!

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/ad7476.h      |   11 +------
>  drivers/staging/iio/adc/ad7476_core.c |   56 +++++++++++++++------------------
>  2 files changed, 26 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
> index c4f1150..4ed5494 100644
> --- a/drivers/staging/iio/adc/ad7476.h
> +++ b/drivers/staging/iio/adc/ad7476.h
> @@ -10,16 +10,8 @@
>  
>  #define RES_MASK(bits)	((1 << (bits)) - 1)
>  
> -/*
> - * TODO: struct ad7476_platform_data needs to go into include/linux/iio
> - */
> -
> -struct ad7476_platform_data {
> -	u16				vref_mv;
> -};
> -
>  struct ad7476_chip_info {
> -	u16				int_vref_mv;
> +	unsigned int			int_vref_uv;
>  	struct iio_chan_spec		channel[2];
>  };
>  
> @@ -27,7 +19,6 @@ struct ad7476_state {
>  	struct spi_device		*spi;
>  	const struct ad7476_chip_info	*chip_info;
>  	struct regulator		*reg;
> -	u16				int_vref_mv;
>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
>  	/*
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index c97300b..42523e6 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -40,7 +40,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad7476_state *st = iio_priv(indio_dev);
> -	unsigned int scale_uv;
> +	int scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -57,10 +57,16 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->int_vref_mv * 1000)
> -			>> st->chip_info->channel[0].scan_type.realbits;
> -		*val =  scale_uv/1000;
> -		*val2 = (scale_uv%1000)*1000;
> +		if (!st->chip_info->int_vref_uv) {
> +			scale_uv = regulator_get_voltage(st->reg);
> +			if (scale_uv < 0)
> +				return scale_uv;
> +		} else {
> +			scale_uv = st->chip_info->int_vref_uv;
> +		}
> +		scale_uv >>= chan->scan_type.realbits;
> +		*val =  scale_uv / 1000;
> +		*val2 = (scale_uv % 1000) * 1000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
> @@ -96,7 +102,7 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>  	[ID_AD7495] = {
>  		.channel[0] = AD7476_CHAN(12),
>  		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> -		.int_vref_mv = 2500,
> +		.int_vref_uv = 2500000,
>  	},
>  };
>  
> @@ -107,10 +113,9 @@ static const struct iio_info ad7476_info = {
>  
>  static int __devinit ad7476_probe(struct spi_device *spi)
>  {
> -	struct ad7476_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7476_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret, voltage_uv = 0;
> +	int ret;
>  
>  	indio_dev = iio_device_alloc(sizeof(*st));
>  	if (indio_dev == NULL) {
> @@ -118,25 +123,18 @@ static int __devinit ad7476_probe(struct spi_device *spi)
>  		goto error_ret;
>  	}
>  	st = iio_priv(indio_dev);
> +	st->chip_info =
> +		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> +
>  	st->reg = regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
> -		ret = regulator_enable(st->reg);
> -		if (ret)
> -			goto error_put_reg;
> -
> -		voltage_uv = regulator_get_voltage(st->reg);
> +		ret = PTR_ERR(st->reg);
> +		goto error_ret;
>  	}
> -	st->chip_info =
> -		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
> -	if (st->chip_info->int_vref_mv)
> -		st->int_vref_mv = st->chip_info->int_vref_mv;
> -	else if (pdata && pdata->vref_mv)
> -		st->int_vref_mv = pdata->vref_mv;
> -	else if (voltage_uv)
> -		st->int_vref_mv = voltage_uv / 1000;
> -	else
> -		dev_warn(&spi->dev, "reference voltage unspecified\n");
> +	ret = regulator_enable(st->reg);
> +	if (ret)
> +		goto error_put_reg;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -169,11 +167,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
>  error_ring_unregister:
>  	ad7476_ring_cleanup(indio_dev);
>  error_disable_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> +	regulator_disable(st->reg);
>  error_put_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_put(st->reg);
> +	regulator_put(st->reg);
>  	iio_device_free(indio_dev);
>  
>  error_ret:
> @@ -187,10 +183,8 @@ static int __devexit ad7476_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	ad7476_ring_cleanup(indio_dev);
> -	if (!IS_ERR(st->reg)) {
> -		regulator_disable(st->reg);
> -		regulator_put(st->reg);
> -	}
> +	regulator_disable(st->reg);
> +	regulator_put(st->reg);
>  	iio_device_free(indio_dev);
>  
>  	return 0;
> 
