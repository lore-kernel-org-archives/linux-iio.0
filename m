Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45170 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2KQLRv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Nov 2012 06:17:51 -0500
Message-ID: <50A7725D.9080008@kernel.org>
Date: Sat, 17 Nov 2012 11:17:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 2/5] staging:iio:ad7298: Rework regulator handling
References: <1352985328-24322-1-git-send-email-lars@metafoo.de> <1352985328-24322-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1352985328-24322-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/15/2012 01:15 PM, Lars-Peter Clausen wrote:
> Rework the regulator handling of the driver to match more closely what we do in
> other drivers. Make the regulator non-optional if a external reference is used.
> Also dispose the option of specifying the reference voltage via platform data.
Added to togreg branch of iio.git.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/ad7298.h      | 12 ++++------
>  drivers/staging/iio/adc/ad7298_core.c | 44 +++++++++++++++++++++--------------
>  2 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
> index 0ce9031..6523e01 100644
> --- a/drivers/staging/iio/adc/ad7298.h
> +++ b/drivers/staging/iio/adc/ad7298.h
> @@ -26,19 +26,17 @@
>  
>  #define RES_MASK(bits)	((1 << (bits)) - 1)
>  
> -/*
> - * TODO: struct ad7298_platform_data needs to go into include/linux/iio
> - */
> -
> +/**
> + * struct ad7298_platform_data - Platform data for the ad7298 ADC driver
> + * @ext_ref: Whether to use an external reference voltage.
> + **/
>  struct ad7298_platform_data {
> -	/* External Vref voltage applied */
> -	u16				vref_mv;
> +	bool ext_ref;
>  };
>  
>  struct ad7298_state {
>  	struct spi_device		*spi;
>  	struct regulator		*reg;
> -	u16				int_vref_mv;
>  	unsigned			ext_ref;
>  	struct spi_transfer		ring_xfer[10];
>  	struct spi_transfer		scan_single_xfer[3];
> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
> index 67082ad..6dd696f 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c
> +++ b/drivers/staging/iio/adc/ad7298_core.c
> @@ -130,7 +130,7 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad7298_state *st = iio_priv(indio_dev);
> -	unsigned int scale_uv;
> +	int scale_mv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -155,10 +155,17 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
> -			*val =  scale_uv / 1000;
> -			*val2 = (scale_uv % 1000) * 1000;
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			if (st->ext_ref) {
> +				scale_mv = regulator_get_voltage(st->reg);
> +				if (scale_mv < 0)
> +					return scale_mv;
> +				scale_mv /= 1000;
> +			} else {
> +				scale_mv = AD7298_INTREF_mV;
> +			}
> +			*val =  scale_mv;
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
>  		case IIO_TEMP:
>  			*val =  1;
>  			*val2 = 0;
> @@ -180,16 +187,23 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  {
>  	struct ad7298_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7298_state *st;
> -	int ret;
>  	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
> +	int ret;
>  
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = regulator_get(&spi->dev, "vcc");
> -	if (!IS_ERR(st->reg)) {
> +	if (pdata && pdata->ext_ref)
> +		st->ext_ref = AD7298_EXTREF;
> +
> +	if (st->ext_ref) {
> +		st->reg = regulator_get(&spi->dev, "vref");
> +		if (IS_ERR(st->reg)) {
> +			ret = PTR_ERR(st->reg);
> +			goto error_free;
> +		}
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			goto error_put_reg;
> @@ -222,13 +236,6 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
>  	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
>  
> -	if (pdata && pdata->vref_mv) {
> -		st->int_vref_mv = pdata->vref_mv;
> -		st->ext_ref = AD7298_EXTREF;
> -	} else {
> -		st->int_vref_mv = AD7298_INTREF_mV;
> -	}
> -
>  	ret = ad7298_register_ring_funcs_and_init(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;
> @@ -242,11 +249,12 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  error_cleanup_ring:
>  	ad7298_ring_cleanup(indio_dev);
>  error_disable_reg:
> -	if (!IS_ERR(st->reg))
> +	if (st->ext_ref)
>  		regulator_disable(st->reg);
>  error_put_reg:
> -	if (!IS_ERR(st->reg))
> +	if (st->ext_ref)
>  		regulator_put(st->reg);
> +error_free:
>  	iio_device_free(indio_dev);
>  
>  	return ret;
> @@ -259,7 +267,7 @@ static int __devexit ad7298_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	ad7298_ring_cleanup(indio_dev);
> -	if (!IS_ERR(st->reg)) {
> +	if (st->ext_ref) {
>  		regulator_disable(st->reg);
>  		regulator_put(st->reg);
>  	}
> 
