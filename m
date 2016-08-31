Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55466 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbcHaT6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2016 15:58:46 -0400
Subject: Re: [PATCH 12/17] iio: accel: kxsd9: Add triggered buffer handling
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-13-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0496aae9-fc54-1852-5527-1099a1a79e7e@kernel.org>
Date: Wed, 31 Aug 2016 20:58:40 +0100
MIME-Version: 1.0
In-Reply-To: <1471354423-19186-13-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 14:33, Linus Walleij wrote:
> As is custom with all modern sensors, add a clever burst mode
> that will just stream out values from the sensor and provide it
> to userspace to do the proper offsetting and scaling.
> 
> This is the result when tested with an HRTimer trigger:
> 
> $ generic_buffer -a -c 10 -n kxsd9 -t foo
> /sys/bus/iio/devices/iio:device1 foo
> 0.371318 0.718680 9.869872 1795.000000 97545896129
> -0.586922 0.179670 9.378775 2398.000000 97555864721
> -0.299450 0.179670 10.348992 2672.000000 97565874055
> 0.371318 0.335384 11.103606 2816.000000 97575883240
> 0.179670 0.574944 10.540640 2847.000000 97585862351
> 0.335384 0.754614 9.953718 2840.000000 97595872425
> 0.179670 0.754614 10.732288 2879.000000 97605882351
> 0.000000 0.754614 10.348992 2872.000000 97615891832
> -0.730658 0.574944 9.570422 2831.000000 97625871536
> 0.000000 1.137910 10.732288 2872.000000 97635881610
> 
> Columns shown are x, y, z acceleration, so a positive acceleration
> of ~9.81 (shaky due to bad calibration) along the z axis. The
> fourth column is the AUX IN which is floating on this system,
> it seems to float up to the 2.85V VDD voltage.
> 
> To be able to cleanup the triggered buffer, we need to add .remove()
> callbacks to the I2C and SPI subdrivers and call back into an
> exported .remove() callback in the core.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
One issue inline. Otherwise:

Tested-by: Jonathan Cameron <jic23@kernel.org>

Jonathan
> ---
>  drivers/iio/accel/Kconfig     |  2 +
>  drivers/iio/accel/kxsd9-i2c.c |  6 +++
>  drivers/iio/accel/kxsd9-spi.c |  6 +++
>  drivers/iio/accel/kxsd9.c     | 93 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/iio/accel/kxsd9.h     |  1 +
>  5 files changed, 102 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index ab1c87ce07ed..cd69353989cf 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -96,6 +96,8 @@ config IIO_ST_ACCEL_SPI_3AXIS
>  
>  config KXSD9
>  	tristate "Kionix KXSD9 Accelerometer Driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the Kionix KXSD9 accelerometer.
>  	  It can be accessed using an (optional) SPI or I2C interface.
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 2c910755288d..4aaa27d0aa32 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -30,6 +30,11 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>  				  i2c->name);
>  }
>  
> +static int kxsd9_i2c_remove(struct i2c_client *client)
> +{
> +	return kxsd9_common_remove(&client->dev);
> +}
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id kxsd9_of_match[] = {
>  	{ .compatible = "kionix,kxsd9", },
> @@ -52,6 +57,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
>  		.of_match_table = of_match_ptr(kxsd9_of_match),
>  	},
>  	.probe		= kxsd9_i2c_probe,
> +	.remove		= kxsd9_i2c_remove,
>  	.id_table	= kxsd9_i2c_id,
>  };
>  module_i2c_driver(kxsd9_i2c_driver);
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> index 04dbc6f94e7d..c5af51b7dd7e 100644
> --- a/drivers/iio/accel/kxsd9-spi.c
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -29,6 +29,11 @@ static int kxsd9_spi_probe(struct spi_device *spi)
>  				  spi_get_device_id(spi)->name);
>  }
>  
> +static int kxsd9_spi_remove(struct spi_device *spi)
> +{
> +	return kxsd9_common_remove(&spi->dev);
> +}
> +
>  static const struct spi_device_id kxsd9_spi_id[] = {
>  	{"kxsd9", 0},
>  	{ },
> @@ -40,6 +45,7 @@ static struct spi_driver kxsd9_spi_driver = {
>  		.name = "kxsd9",
>  	},
>  	.probe = kxsd9_spi_probe,
> +	.remove = kxsd9_spi_remove,
>  	.id_table = kxsd9_spi_id,
>  };
>  module_spi_driver(kxsd9_spi_driver);
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 152042ef3e3c..78afbe05710e 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -12,8 +12,6 @@
>   * I have a suitable wire made up.
>   *
>   * TODO:	Support the motion detector
> - *		Uses register address incrementing so could have a
> - *		heavily optimized ring buffer access function.
>   */
>  
>  #include <linux/device.h>
> @@ -24,6 +22,9 @@
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #include "kxsd9.h"
>  
> @@ -41,9 +42,11 @@
>  
>  /**
>   * struct kxsd9_state - device related storage
> + * @dev: pointer to the parent device
>   * @map: regmap to the device
>   */
>  struct kxsd9_state {
> +	struct device *dev;
>  	struct regmap *map;
>  };
>  
> @@ -155,7 +158,35 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  error_ret:
>  	return ret;
>  };
> -#define KXSD9_ACCEL_CHAN(axis)						\
> +
> +static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
> +{
> +	const struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
> +	/* 4 * 16bit values AND timestamp */
> +	__be16 hw_values[8];
> +
> +	ret = regmap_bulk_read(st->map,
> +			       KXSD9_REG_X,
> +			       &hw_values,
> +			       8);
> +	if (ret) {
> +		dev_err(st->dev,
> +			"error reading data\n");
> +		return ret;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev,
> +					   hw_values,
> +					   iio_get_time_ns(indio_dev));
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#define KXSD9_ACCEL_CHAN(axis, index)						\
>  	{								\
>  		.type = IIO_ACCEL,					\
>  		.modified = 1,						\
> @@ -164,16 +195,35 @@ error_ret:
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>  					BIT(IIO_CHAN_INFO_OFFSET),	\
>  		.address = KXSD9_REG_##axis,				\
> +		.scan_index = index,					\
> +		.scan_type = {                                          \
> +			.sign = 'u',					\
> +			.realbits = 12,					\
> +			.storagebits = 16,				\
> +			.shift = 4,					\
> +			.endianness = IIO_BE,				\
> +		},							\
>  	}
>  
>  static const struct iio_chan_spec kxsd9_channels[] = {
> -	KXSD9_ACCEL_CHAN(X), KXSD9_ACCEL_CHAN(Y), KXSD9_ACCEL_CHAN(Z),
> +	KXSD9_ACCEL_CHAN(X, 0),
> +	KXSD9_ACCEL_CHAN(Y, 1),
> +	KXSD9_ACCEL_CHAN(Z, 2),
>  	{
>  		.type = IIO_VOLTAGE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.indexed = 1,
>  		.address = KXSD9_REG_AUX,
> -	}
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.shift = 4,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
>  static const struct attribute_group kxsd9_attribute_group = {
> @@ -197,6 +247,9 @@ static const struct iio_info kxsd9_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +/* Four channels apart from timestamp, scan mask = 0x0f */
> +static const unsigned long kxsd9_scan_masks[] = { 0xf, 0 };
> +
>  int kxsd9_common_probe(struct device *parent,
>  		       struct regmap *map,
>  		       const char *name)
> @@ -210,6 +263,7 @@ int kxsd9_common_probe(struct device *parent,
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	st->dev = parent;
>  	st->map = map;
>  
>  	indio_dev->channels = kxsd9_channels;
> @@ -218,13 +272,40 @@ int kxsd9_common_probe(struct device *parent,
>  	indio_dev->dev.parent = parent;
>  	indio_dev->info = &kxsd9_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = kxsd9_scan_masks;
>  
>  	kxsd9_power_up(st);
>  
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 iio_pollfunc_store_time,
> +					 kxsd9_trigger_handler,
> +					 NULL);
> +	if (ret) {
> +		dev_err(parent, "triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
>  	ret = devm_iio_device_register(parent, indio_dev);
>  	if (ret)
> -		return ret;
> +		goto err_cleanup_buffer;
> +
> +	dev_set_drvdata(parent, indio_dev);
>  
>  	return 0;
> +
> +err_cleanup_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(kxsd9_common_probe);
> +
> +int kxsd9_common_remove(struct device *parent)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(parent);
> +
> +	iio_triggered_buffer_cleanup(indio_dev);
Race as you are removing the buffer whilst the userspaces
are still exposed.
Don't use devm_iio_device_register...

Jonathan
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(kxsd9_common_remove);
> diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
> index ef3dbbf70b98..19131a7a692c 100644
> --- a/drivers/iio/accel/kxsd9.h
> +++ b/drivers/iio/accel/kxsd9.h
> @@ -7,3 +7,4 @@
>  int kxsd9_common_probe(struct device *parent,
>  		       struct regmap *map,
>  		       const char *name);
> +int kxsd9_common_remove(struct device *parent);
> 

