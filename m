Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 18 Jun 2012 17:28:18 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: Add helper function for initializing
 triggered buffers
Message-ID: <20120619002818.GA20240@kroah.com>
References: <1340037236-15685-1-git-send-email-lars@metafoo.de>
 <1340037236-15685-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340037236-15685-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 18, 2012 at 06:33:48PM +0200, Lars-Peter Clausen wrote:
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -7,6 +7,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  
> +obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o

That's a crazy module name, does it really need to be that big?  And in
a separate module?

Anyway, I've taken it, but why can't this just be merged into the iio.ko
main module?  Actually, why can't all of these different trigger and
buffer modules be part of the iio module?

>  obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o

Shouldn't this be iio_kfifo_buf?

thanks,

greg k-h
