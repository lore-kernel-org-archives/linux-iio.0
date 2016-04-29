Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44427 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcD2LZG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 07:25:06 -0400
Date: Fri, 29 Apr 2016 13:24:59 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Tiberiu Breana <tiberiu.a.breana@intel.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: Add triggered buffer support for
 BMA220
In-Reply-To: <1461928076-22076-3-git-send-email-tiberiu.a.breana@intel.com>
Message-ID: <alpine.DEB.2.02.1604291320170.23132@pmeerw.net>
References: <1461928076-22076-1-git-send-email-tiberiu.a.breana@intel.com> <1461928076-22076-3-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

comments below

> ---
>  drivers/iio/accel/bma220_spi.c | 67 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 440e045..d3c8bd6 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -11,9 +11,12 @@
>  #include <linux/acpi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/spi/spi.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define BMA220_REG_ID				0x00
>  #define BMA220_REG_ACCEL_X			0x02
> @@ -37,6 +40,14 @@
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 6,						\
> +		.storagebits = 8,					\
> +		.shift = BMA220_DATA_SHIFT,				\
> +		.endianness = IIO_CPU,					\
> +	},								\
>  }
>  
>  static IIO_CONST_ATTR(in_accel_scale_available, BMA220_SCALE_AVAILABLE);
> @@ -57,12 +68,15 @@ static const int bma220_scale_table[][4] = {
>  struct bma220_data {
>  	struct spi_device *spi_device;
>  	u8 range;
> +	struct mutex lock;
> +	s8 buffer[16]; /* 2x8-bit channels + 6x8 padding + 8x8 timestamp */

3x8-bit channels? x,y,z?

>  };
>  
>  static const struct iio_chan_spec bma220_channels[] = {
>  	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
>  	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
>  	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
>  static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
> @@ -70,6 +84,42 @@ static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
>  	return spi_w8r8(spi, reg | BMA220_READ_MASK);
>  }
>  
> +static irqreturn_t bma220_trigger_handler(int irq, void *p)
> +{
> +	int i;
> +	int ret;
> +	int bit;
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	struct spi_device *spi = data->spi_device;
> +	u8 tx_buf = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
> +	u8 rx_buf[3];

alignment requirements for SPI?

> +
> +	/* Do a bulk read, then pick out what we need. */
> +	mutex_lock(&data->lock);
> +	ret = spi_write_then_read(spi, &tx_buf, sizeof(tx_buf),
> +					rx_buf, sizeof(rx_buf));
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		goto err;
> +	}
> +
> +	i = 0;
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			      indio_dev->masklength) {
> +		data->buffer[i] = rx_buf[i];

this doesn't work the index of rx_buf must depend on bit

> +		i++;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   pf->timestamp);

what does the mutex actually protect?
buffer is used outside the mutex here

> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static int bma220_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -155,6 +205,7 @@ static int bma220_probe(struct spi_device *spi)
>  	data = iio_priv(indio_dev);
>  	data->spi_device = spi;
>  	spi_set_drvdata(spi, indio_dev);
> +	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->info = &bma220_info;
> @@ -167,11 +218,22 @@ static int bma220_probe(struct spi_device *spi)
>  	if (ret != BMA220_CHIP_ID)
>  		return -ENODEV;
>  
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					 bma220_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(&data->spi_device->dev,
> +			"iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&spi->dev, "iio_device_register failed\n");
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		return ret;
> +	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int bma220_remove(struct spi_device *spi)
> @@ -180,6 +242,7 @@ static int bma220_remove(struct spi_device *spi)
>  	struct bma220_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
>  }
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
