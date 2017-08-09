Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbdHIOcd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:32:33 -0400
Date: Wed, 9 Aug 2017 15:30:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ccs811: Add triggered buffer support
Message-ID: <20170809153019.5afa6852@archlinux>
In-Reply-To: <1501587518-12665-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1501587518-12665-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  1 Aug 2017 14:38:38 +0300
Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com> wrote:

> A software trigger such as hrtimer can be used to capture the data
> that will be stored in the buffer.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Alison Schofield <amsfield22@gmail.com>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Sorry for the slow response. I'm over in China and running rather behind
with everything.

A few points inline.

Jonathan
> ---
>  drivers/iio/chemical/Kconfig  |  2 ++
>  drivers/iio/chemical/ccs811.c | 61 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 4d799b5..5cb5be7 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -24,6 +24,8 @@ config ATLAS_PH_SENSOR
>  config CCS811
>  	tristate "AMS CCS811 VOC sensor"
>  	depends on I2C
> +    select IIO_BUFFER
> +    select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to build I2C interface support for the AMS
>  	  CCS811 VOC (Volatile Organic Compounds) sensor
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index cba2180..d5f989f 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -22,6 +22,9 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/module.h>
> 
>  #define CCS811_STATUS		0x00
> @@ -77,25 +80,44 @@ struct ccs811_data {
>  	{
>  		.type = IIO_CURRENT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				      BIT(IIO_CHAN_INFO_SCALE)
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = -1,
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				      BIT(IIO_CHAN_INFO_SCALE)
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = -1,
>  	}, {
>  		.type = IIO_CONCENTRATION,
>  		.channel2 = IIO_MOD_CO2,
>  		.modified = 1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_OFFSET) |
> -				      BIT(IIO_CHAN_INFO_SCALE)
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
> +			.endianness = IIO_BE,
> +		},
>  	}, {
>  		.type = IIO_CONCENTRATION,
>  		.channel2 = IIO_MOD_VOC,
>  		.modified = 1,
>  		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
> -				       BIT(IIO_CHAN_INFO_SCALE)
> +				       BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
No need to state a shift of 0.  It's the obvious default and
will be true anyway due to the c specification which states un
specified fields in a structure that uses this type of assignment
must be zeroed.
> +			.endianness = IIO_BE,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
> 
>  /*
> @@ -254,6 +276,29 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
>  	.driver_module = THIS_MODULE,
>  };
> 
> +static irqreturn_t ccs811_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +	s16 buf[8]; /* s16 eCO2 + s16 TVOC + padding + 8 byte timestamp */
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +					    CCS811_ALG_RESULT_DATA, 4,
> +					    (u8 *)&buf);
Why do you need to take the lock?  I'm not certainly what you are protecting
here. buf is local and the i2c side of things is serialized.
> +	if (ret == 4)
> +		iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +						   iio_get_time_ns(indio_dev));
> +
> +	mutex_unlock(&data->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int ccs811_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -306,6 +351,14 @@ static int ccs811_probe(struct i2c_client *client,
>  	indio_dev->channels = ccs811_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);
> 
> +	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					      NULL, ccs811_trigger_handler,
> +					      NULL);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "triggered buffer setup failed\n");
> +		return ret;
> +	}
This results in the remove order not being the opposite of probe.
If you can safely move this before the setup call then it would
be fine like this.  If not you should use the non devm version.

Thanks,

Jonathan
> +
>  	return iio_device_register(indio_dev);
>  }
> 
> --
> 1.9.1
> 

