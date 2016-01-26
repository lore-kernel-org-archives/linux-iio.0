Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:33681 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964834AbcAZQCN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 11:02:13 -0500
Date: Tue, 26 Jan 2016 17:02:11 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Daniel Baluta <daniel.baluta@intel.com>
cc: jic23@kernel.org, tduszyns@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: ms5611: Add triggered buffer
 support
In-Reply-To: <1453823348-23074-3-git-send-email-daniel.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1601261657090.24513@pmeerw.net>
References: <1453823348-23074-1-git-send-email-daniel.baluta@intel.com> <1453823348-23074-3-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Jan 2016, Daniel Baluta wrote:

> This will be used together with an external trigger (e.g hrtimer
> based software trigger).
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  drivers/iio/pressure/Kconfig       |  1 +
>  drivers/iio/pressure/ms5611.h      |  1 +
>  drivers/iio/pressure/ms5611_core.c | 71 ++++++++++++++++++++++++++++++++++++--
>  drivers/iio/pressure/ms5611_i2c.c  |  7 ++++
>  drivers/iio/pressure/ms5611_spi.c  |  8 +++++
>  5 files changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index e8f60db..48c3741 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -69,6 +69,7 @@ config MPL3115
>  
>  config MS5611
>  	tristate "Measurement Specialties MS5611 pressure sensor driver"
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to build support for the Measurement Specialties
>  	  MS5611, MS5607 pressure and temperature sensors.
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index 23b93c7..2d70dd6 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -52,5 +52,6 @@ struct ms5611_state {
>  };
>  
>  int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type);
> +int ms5611_remove(struct iio_dev *indio_dev);
>  
>  #endif /* _MS5611_H */
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 6cf0e55..f7d364f 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -17,6 +17,9 @@
>  #include <linux/iio/iio.h>
>  #include <linux/delay.h>
>  
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include "ms5611.h"
>  
>  static bool ms5611_prom_is_valid(u16 *prom, size_t len)
> @@ -173,6 +176,31 @@ static int ms5611_reset(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static irqreturn_t ms5611_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +	s32 buf[4], pressure, temp;

a comment would be good explaining why 4 s32 are allocated while only the 
first two entries are used (because of timestamp)

> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = ms5611_read_temp_and_pressure(indio_dev, &temp, &pressure);
> +	mutex_unlock(&st->lock);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (test_bit(0, indio_dev->active_scan_mask))
> +		buf[0] = pressure;
> +	if (test_bit(1, indio_dev->active_scan_mask))
> +		buf[1] = temp;

I think this is wrong; what if only temp is active?, it should go into 
buf[0] then

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);

maybe a newline here...

> +err:
> +	iio_trigger_notify_done(indio_dev->trig);

and here

> +	return IRQ_HANDLED;
> +}
> +
>  static int ms5611_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -232,12 +260,27 @@ static const struct iio_chan_spec ms5611_channels[] = {
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_SCALE),
> -	}
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(3),

index should be 2 for timestamp

>  };
>  
>  static const struct iio_info ms5611_info = {
> @@ -274,10 +317,34 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type)
>  	if (ret < 0)
>  		return ret;
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +					 ms5611_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to register iio device\n");
> +		goto err_buffer_cleanup;
> +	}
> +
> +	return 0;

some newlines around here please

> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	return ret;
>  }
>  EXPORT_SYMBOL(ms5611_probe);
>  
> +int ms5611_remove(struct iio_dev *indio_dev)
> +{
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	return 0;
> +}
> +EXPORT_SYMBOL(ms5611_remove);
> +
>  MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
>  MODULE_DESCRIPTION("MS5611 core driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 245797d..42706a8 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -99,6 +99,7 @@ static int ms5611_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
>  	st->reset = ms5611_i2c_reset;
>  	st->read_prom_word = ms5611_i2c_read_prom_word;
>  	st->read_adc_temp_and_pressure = ms5611_i2c_read_adc_temp_and_pressure;
> @@ -107,6 +108,11 @@ static int ms5611_i2c_probe(struct i2c_client *client,
>  	return ms5611_probe(indio_dev, &client->dev, id->driver_data);
>  }
>  
> +static int ms5611_i2c_remove(struct i2c_client *client)
> +{
> +	return ms5611_remove(i2c_get_clientdata(client));
> +}
> +
>  static const struct i2c_device_id ms5611_id[] = {
>  	{ "ms5611", MS5611 },
>  	{ "ms5607", MS5607 },
> @@ -120,6 +126,7 @@ static struct i2c_driver ms5611_driver = {
>  	},
>  	.id_table = ms5611_id,
>  	.probe = ms5611_i2c_probe,
> +	.remove = ms5611_i2c_remove,
>  };
>  module_i2c_driver(ms5611_driver);
>  
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index aaa0c4b..c4bf4e8 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -90,6 +90,8 @@ static int ms5611_spi_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	spi_set_drvdata(spi, indio_dev);
> +
>  	spi->mode = SPI_MODE_0;
>  	spi->max_speed_hz = 20000000;
>  	spi->bits_per_word = 8;
> @@ -107,6 +109,11 @@ static int ms5611_spi_probe(struct spi_device *spi)
>  			    spi_get_device_id(spi)->driver_data);
>  }
>  
> +static int ms5611_spi_remove(struct spi_device *spi)
> +{
> +	return ms5611_remove(spi_get_drvdata(spi));
> +}
> +
>  static const struct spi_device_id ms5611_id[] = {
>  	{ "ms5611", MS5611 },
>  	{ "ms5607", MS5607 },
> @@ -120,6 +127,7 @@ static struct spi_driver ms5611_driver = {
>  	},
>  	.id_table = ms5611_id,
>  	.probe = ms5611_spi_probe,
> +	.remove = ms5611_spi_remove,
>  };
>  module_spi_driver(ms5611_driver);
>  
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
