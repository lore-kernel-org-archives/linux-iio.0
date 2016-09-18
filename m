Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49702 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbcIRLU6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 07:20:58 -0400
Subject: Re: [PATCH] iio: adc: ti-adc161s626: add regulator support
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1474003940-13039-1-git-send-email-matt@ranostay.consulting>
Cc: Matt Ranostay <matt@ranostay.consulting>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <94a9a2ae-9b25-d19d-5914-ee572602de2c@kernel.org>
Date: Sun, 18 Sep 2016 12:20:54 +0100
MIME-Version: 1.0
In-Reply-To: <1474003940-13039-1-git-send-email-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/09/16 06:32, Matt Ranostay wrote:
> Allow IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET attributes for
> processing by checking voltage from a regulator.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Comments inline.
> ---
>  .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |  2 +
>  drivers/iio/adc/ti-adc161s626.c                    | 60 ++++++++++++++++++----
>  2 files changed, 51 insertions(+), 11 deletions(-)
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
> index f94b69f9c288..d192951056cf 100644
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
> @@ -191,10 +212,22 @@ static int ti_adc_probe(struct spi_device *spi)
>  		break;
>  	}
>  
> +	data->ref = devm_regulator_get(&spi->dev, "vdda");
> +	if (!IS_ERR(data->ref)) {
> +		ret = regulator_enable(data->ref);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regulator_get_voltage(data->ref);
> +		if (ret < 0)
> +			goto error_regulator_disable;
> +	} else
> +		return IS_ERR(data->ref);
This is an overly complex way of organizing things.
Check the error and return first.

Then the good path just becomes normal flow.

There is also the irritating case of the regulator not being specified.
Then we get a dummy which is fine until we ask it what voltage it
is supplying..

In that case I think we get a return -EINVAL.  
I'd have no trouble with us returning -EINVAL on an attempt to read
the scale attribute if the regulator isn't specified, but refusing to
probe seems harsh.  Particularly as before this support was added it
would have probed fine.
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  					 ti_adc_trigger_handler, NULL);
>  	if (ret)
> -		return ret;
> +		goto error_regulator_disable;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> @@ -205,15 +238,20 @@ static int ti_adc_probe(struct spi_device *spi)
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

