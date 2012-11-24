Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33223 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab2KXKcB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Nov 2012 05:32:01 -0500
Message-ID: <50B0A21F.3060105@kernel.org>
Date: Sat, 24 Nov 2012 10:31:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 06/11] staging:iio:ad7793: Rework regulator handling
References: <1353515236-21843-1-git-send-email-lars@metafoo.de> <1353515236-21843-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1353515236-21843-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/21/2012 04:27 PM, Lars-Peter Clausen wrote:
> Rework the regulator handling of the driver to match more closely what we do in
> other drivers. Make the regulator non-optional if a external reference is used.
> Also dispose the option of specifying the reference voltage via platform data.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
This one curriously had 2 lines of fuzz.  Ah well.

Added to togreg branch of iio.git
> ---
>  drivers/staging/iio/adc/ad7793.c | 44 ++++++++++++++++++++++++----------------
>  drivers/staging/iio/adc/ad7793.h |  3 ---
>  2 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
> index 8b08693..1aa8e88 100644
> --- a/drivers/staging/iio/adc/ad7793.c
> +++ b/drivers/staging/iio/adc/ad7793.c
> @@ -111,7 +111,8 @@ static int ad7793_calibrate_all(struct ad7793_state *st)
>  }
>  
>  static int ad7793_setup(struct iio_dev *indio_dev,
> -	const struct ad7793_platform_data *pdata)
> +	const struct ad7793_platform_data *pdata,
> +	unsigned int vref_mv)
>  {
>  	struct ad7793_state *st = iio_priv(indio_dev);
>  	int i, ret = -1;
> @@ -175,7 +176,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  
>  	/* Populate available ADC input ranges */
>  	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> -		scale_uv = ((u64)st->int_vref_mv * 100000000)
> +		scale_uv = ((u64)vref_mv * 100000000)
>  			>> (st->chip_info->channels[0].scan_type.realbits -
>  			(!!(st->conf & AD7793_CONF_UNIPOLAR) ? 0 : 1));
>  		scale_uv >>= i;
> @@ -463,7 +464,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
>  	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7793_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret, voltage_uv = 0;
> +	int ret, vref_mv = 0;
>  
>  	if (!pdata) {
>  		dev_err(&spi->dev, "no platform data?\n");
> @@ -483,25 +484,31 @@ static int __devinit ad7793_probe(struct spi_device *spi)
>  
>  	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
>  
> -	st->reg = regulator_get(&spi->dev, "vcc");
> -	if (!IS_ERR(st->reg)) {
> +	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
> +		st->reg = regulator_get(&spi->dev, "refin");
> +		if (IS_ERR(st->reg)) {
> +			ret = PTR_ERR(st->reg);
> +			goto error_device_free;
> +		}
> +
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			goto error_put_reg;
>  
> -		voltage_uv = regulator_get_voltage(st->reg);
> +		vref_mv = regulator_get_voltage(st->reg);
> +		if (vref_mv < 0) {
> +			ret = vref_mv;
> +			goto error_disable_reg;
> +		}
> +
> +		vref_mv /= 1000;
> +	} else {
> +		vref_mv = 1170; /* Build-in ref */
>  	}
>  
>  	st->chip_info =
>  		&ad7793_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
> -	if (pdata && pdata->vref_mv)
> -		st->int_vref_mv = pdata->vref_mv;
> -	else if (voltage_uv)
> -		st->int_vref_mv = voltage_uv / 1000;
> -	else
> -		st->int_vref_mv = 1170; /* Build-in ref */
> -
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->dev.parent = &spi->dev;
> @@ -515,7 +522,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = ad7793_setup(indio_dev, pdata);
> +	ret = ad7793_setup(indio_dev, pdata, vref_mv);
>  	if (ret)
>  		goto error_remove_trigger;
>  
> @@ -528,12 +535,12 @@ static int __devinit ad7793_probe(struct spi_device *spi)
>  error_remove_trigger:
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  error_disable_reg:
> -	if (!IS_ERR(st->reg))
> +	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
>  		regulator_disable(st->reg);
>  error_put_reg:
> -	if (!IS_ERR(st->reg))
> +	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
>  		regulator_put(st->reg);
> -
> +error_device_free:
>  	iio_device_free(indio_dev);
>  
>  	return ret;
> @@ -541,13 +548,14 @@ error_put_reg:
>  
>  static int __devexit ad7793_remove(struct spi_device *spi)
>  {
> +	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct ad7793_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  
> -	if (!IS_ERR(st->reg)) {
> +	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
>  		regulator_disable(st->reg);
>  		regulator_put(st->reg);
>  	}
> diff --git a/drivers/staging/iio/adc/ad7793.h b/drivers/staging/iio/adc/ad7793.h
> index 9e90590..7f6acac 100644
> --- a/drivers/staging/iio/adc/ad7793.h
> +++ b/drivers/staging/iio/adc/ad7793.h
> @@ -182,7 +182,6 @@ enum ad7793_excitation_current {
>  
>  /**
>   * struct ad7793_platform_data - AD7793 platform data
> - * @vref_mv: Reference voltage in milli-Volt
>   * @clock_src: Clock source selection
>   * @burnout_current: If set to true the 100nA burnout current is enabled.
>   * @boost_enable: Enable boost for the bias voltage generator.
> @@ -195,8 +194,6 @@ enum ad7793_excitation_current {
>   * @current_source_direction: Excitation current direction selection
>   */
>  struct ad7793_platform_data {
> -	u16 vref_mv;
> -
>  	enum ad7793_clock_source clock_src;
>  	bool burnout_current;
>  	bool boost_enable;
> 
