Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34743 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938857AbcIYIYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 04:24:12 -0400
Subject: Re: [PATCH v2] iio: adc: ti-adc161s626: add regulator support
To: Matt Ranostay <mranostay@gmail.com>
References: <1474238535-16455-1-git-send-email-matt@ranostay.consulting>
Cc: linux-iio@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2fb0ae94-1b1d-bfda-57a7-577e435ce016@kernel.org>
Date: Sun, 25 Sep 2016 09:24:07 +0100
MIME-Version: 1.0
In-Reply-To: <1474238535-16455-1-git-send-email-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/09/16 23:42, Matt Ranostay wrote:
> Allow IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET attributes for
> processing by checking voltage from a regulator.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Applied to the togreg branch of iio.git. Pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
> Changes from v1:
> * don't error out from getting dummy regulator
> 
>  .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |  2 +
>  drivers/iio/adc/ti-adc161s626.c                    | 55 +++++++++++++++++-----
>  2 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
> index 2bdad2d13d6f..0a50ee9541c8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>   - compatible: Should be "ti,adc141s626" or "ti,adc161s626"
>   - reg: spi chip select number for the device
> + - vdda-supply: supply voltage to VDDA pin
>  
>  Recommended properties:
>   - spi-max-frequency: Definition as per
> @@ -11,6 +12,7 @@ Recommended properties:
>  Example:
>  adc@0 {
>  	compatible = "ti,adc161s626";
> +	vdda-supply = <&vdda_fixed>;
>  	reg = <0>;
>  	spi-max-frequency = <4300000>;
>  };
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> index f94b69f9c288..4836a0d7aef5 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -27,6 +27,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define TI_ADC_DRV_NAME	"ti-adc161s626"
>  
> @@ -39,7 +40,9 @@ static const struct iio_chan_spec ti_adc141s626_channels[] = {
>  	{
>  		.type = IIO_VOLTAGE,
>  		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 's',
> @@ -54,7 +57,9 @@ static const struct iio_chan_spec ti_adc161s626_channels[] = {
>  	{
>  		.type = IIO_VOLTAGE,
>  		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 's',
> @@ -68,6 +73,8 @@ static const struct iio_chan_spec ti_adc161s626_channels[] = {
>  struct ti_adc_data {
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
> +	struct regulator *ref;
> +
>  	u8 read_size;
>  	u8 shift;
>  
> @@ -135,18 +142,32 @@ static int ti_adc_read_raw(struct iio_dev *indio_dev,
>  	struct ti_adc_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +		ret = ti_adc_read_measurement(data, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
>  
> -	ret = ti_adc_read_measurement(data, chan, val);
> -	iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  
> -	if (!ret)
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(data->ref);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret / 1000;
> +		*val2 = chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 1 << (chan->scan_type.realbits - 1);
> +		return IIO_VAL_INT;
> +	}
>  
>  	return 0;
>  }
> @@ -191,10 +212,17 @@ static int ti_adc_probe(struct spi_device *spi)
>  		break;
>  	}
>  
> +	data->ref = devm_regulator_get(&spi->dev, "vdda");
> +	if (!IS_ERR(data->ref)) {
> +		ret = regulator_enable(data->ref);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  					 ti_adc_trigger_handler, NULL);
>  	if (ret)
> -		return ret;
> +		goto error_regulator_disable;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> @@ -205,15 +233,20 @@ static int ti_adc_probe(struct spi_device *spi)
>  error_unreg_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
> +error_regulator_disable:
> +	regulator_disable(data->ref);
> +
>  	return ret;
>  }
>  
>  static int ti_adc_remove(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ti_adc_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	regulator_disable(data->ref);
>  
>  	return 0;
>  }
> 

