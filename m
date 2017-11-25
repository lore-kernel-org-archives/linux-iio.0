Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbdKYRsw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 12:48:52 -0500
Date: Sat, 25 Nov 2017 17:48:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Brauchli <a.brauchli@elementarea.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: sgpxx: triggered buffer support
Message-ID: <20171125174848.2d3d5b74@archlinux>
In-Reply-To: <1511280689.12439.36.camel@elementarea.net>
References: <1511280689.12439.36.camel@elementarea.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 21 Nov 2017 17:11:29 +0100
Andreas Brauchli <a.brauchli@elementarea.net> wrote:

> Support triggered buffer for use with e.g. hrtimer for automated
> polling to ensure that the sensor's internal baseline is correctly
> updated independently of the use-case.

Given the really strict timing requirements for this device and slow
read rates, I wouldn't involve a triggered buffer at all, but actually
do it with a thread / timer within the initial driver.   The
sysfs interface is more than adequate for a 1Hz device so using
the buffered option is just adding unnecessary complexity...

I reviewed the code anyway.  Key thing is though the file would be
small, there should be a separate .c file for the buffered support
if you are going to make it optional. That way we don't get ifdefs
in the c file, but rather stubs provided in the header.

You could decide to add stubs to include/linux/iio/triggered_buffer.h
/buffer.h

and then use __maybe_unusued to mark your trigger function.
The compiler would drop it anyway and this would suppress build
warnings.  

However, I don't think this device wants to be supported via the
buffered interfaces at all.  More smartness needed in the core
driver to maintain the timing etc.

Jonathan
> 
> Triggered buffer support is only enabled when IIO_BUFFER is set.
> 
> Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> ---
>  drivers/iio/chemical/Kconfig |  3 +++
>  drivers/iio/chemical/sgpxx.c | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 4574dd687513..6710fbfc6451 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -42,12 +42,15 @@ config SENSIRION_SGPXX
>  	tristate "Sensirion SGPxx gas sensors"
>  	depends on I2C
>  	select CRC8
> +	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>  	help
>  	  Say Y here to build I2C interface support for the following
>  	  Sensirion SGP gas sensors:
>  	    * SGP30 gas sensor
>  	    * SGPC3 gas sensor
>  
> +	  Also select IIO_BUFFER to enable triggered buffers.
> +
>  	  To compile this driver as module, choose M here: the
>  	  module will be called sgpxx.
>  
> diff --git a/drivers/iio/chemical/sgpxx.c b/drivers/iio/chemical/sgpxx.c
> index aea55e41d4cc..025206448f73 100644
> --- a/drivers/iio/chemical/sgpxx.c
> +++ b/drivers/iio/chemical/sgpxx.c
> @@ -27,6 +27,10 @@
>  #include <linux/of_device.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#ifdef CONFIG_IIO_BUFFER
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#endif /* CONFIG_IIO_BUFFER */
>  #include <linux/iio/sysfs.h>
>  
>  #define SGP_WORD_LEN			2
> @@ -789,6 +793,26 @@ static const struct of_device_id sgp_dt_ids[] = {
>  	{ }
>  };
>  
> +#ifdef CONFIG_IIO_BUFFER

All this ifdef fun is rather messy.
Split it out to a separate file like most other drivers with
optional buffer support. 

General rule (more or less) of kernel drivers is that
any optional ifdef stuff should be in headers to provide stubs
when code isn't available, not down in the drivers making them
harder to read.

> +static irqreturn_t sgp_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct sgp_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = sgp_get_measurement(data, data->measure_iaq_cmd,
> +				  SGP_MEASURE_MODE_IAQ);
> +	if (!ret)
> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +						   &data->buffer.start,
> +						   pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +#endif /* CONFIG_IIO_BUFFER */
> +
>  static int sgp_probe(struct i2c_client *client,
>  		     const struct i2c_device_id *id)
>  {
> @@ -846,6 +870,17 @@ static int sgp_probe(struct i2c_client *client,
>  	indio_dev->channels = chip->channels;
>  	indio_dev->num_channels = chip->num_channels;
>  
> +#ifdef CONFIG_IIO_BUFFER
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 iio_pollfunc_store_time,
> +					 sgp_trigger_handler,
> +					 NULL);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to setup iio triggered buffer\n");
> +		goto fail_free;
> +	}
> +#endif /* CONFIG_IIO_BUFFER */
> +
>  	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (!ret)
>  		return ret;
> @@ -863,6 +898,9 @@ static int sgp_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
> +#ifdef CONFIG_IIO_BUFFER
> +	iio_triggered_buffer_cleanup(indio_dev);
> +#endif /* CONFIG_IIO_BUFFER */

I would prefer stubs being added to the header for this case to having
ifdefs in here.

>  	devm_iio_device_unregister(&client->dev, indio_dev);
>  	return 0;
>  }

