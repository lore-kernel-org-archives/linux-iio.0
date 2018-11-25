Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeKYVuU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 16:50:20 -0500
Date: Sun, 25 Nov 2018 10:59:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: replaced kfifo by
 triggered_buffer
Message-ID: <20181125105926.4730a798@archlinux>
In-Reply-To: <20181122125347.sn2oqrw7fyb4corf@smtp.gmail.com>
References: <20181122125347.sn2oqrw7fyb4corf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Nov 2018 10:53:47 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Previously, there was an implicit creation of a kfifo which was replaced
> by a call to triggered_buffer_setup, which is already implemented in iio
> infrastructure.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

I'm a little surprised that this would work without screaming a lot as 
it will register an interrupt with no handlers. Do you have this
device to test?  It's rapidly heading in the direction of too complex
a driver to fix without test hardware.  Also, semantically this change
is not sensible as it implies an operating mode which the driver
is not using.

There are fundamental questions about how we handle an autotriggered
sweep that need answering before this driver can move forwards.
It needs some concept of a higher level trigger rather than a per
sample one like we typically use in IIO.

The main focus in the short term should be around defining that ABI
as it may fundamentally change the structure of the driver.
If you want to take this on (and it'll be a big job I think!) then
it may be possible to source some hardware to support that effort.

Thanks,

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/Kconfig    |  2 +-
>  .../staging/iio/impedance-analyzer/ad5933.c   | 25 ++++---------------
>  2 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
> index dd97b6bb3fd0..d0af5aa55dc0 100644
> --- a/drivers/staging/iio/impedance-analyzer/Kconfig
> +++ b/drivers/staging/iio/impedance-analyzer/Kconfig
> @@ -7,7 +7,7 @@ config AD5933
>  	tristate "Analog Devices AD5933, AD5934 driver"
>  	depends on I2C
>  	select IIO_BUFFER
> -	select IIO_KFIFO_BUF
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices Impedance Converter,
>  	  Network Analyzer, AD5933/4, provides direct access via sysfs.
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index f9bcb8310e21..edb8b540bbf1 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -20,7 +20,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  /* AD5933/AD5934 Registers */
>  #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
> @@ -615,22 +615,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
>  	.postdisable = ad5933_ring_postdisable,
>  };
>  
> -static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> -{
> -	struct iio_buffer *buffer;
> -
> -	buffer = iio_kfifo_allocate();
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
> -	/* Ring buffer functions - here trigger setup related */
> -	indio_dev->setup_ops = &ad5933_ring_setup_ops;
> -
> -	return 0;
> -}
> -
>  static void ad5933_work(struct work_struct *work)
>  {
>  	struct ad5933_state *st = container_of(work,
> @@ -744,7 +728,8 @@ static int ad5933_probe(struct i2c_client *client,
>  	indio_dev->channels = ad5933_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
>  
> -	ret = ad5933_register_ring_funcs_and_init(indio_dev);
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL, NULL,
> +					 &ad5933_ring_setup_ops);

The absence of either of the interrupt related callbacks made me
wonder what is going on here.  The upshot is that this device
isn't operating in a triggered buffer style at all so we really
shouldn't be using that infrastructure - even if it's convenient.

It'll allocate an interrupt with neither a top half nor a thread
function. I'm not sure what the core will do about that but it
seems unlikely to be happy about it!


>  	if (ret)
>  		goto error_disable_reg;
>  
> @@ -759,7 +744,7 @@ static int ad5933_probe(struct i2c_client *client,
>  	return 0;
>  
>  error_unreg_ring:
> -	iio_kfifo_free(indio_dev->buffer);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -772,7 +757,7 @@ static int ad5933_remove(struct i2c_client *client)
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_kfifo_free(indio_dev->buffer);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	regulator_disable(st->reg);
>  
>  	return 0;
