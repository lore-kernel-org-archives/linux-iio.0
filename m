Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47223 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbbHONus (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 09:50:48 -0400
Subject: Re: [PATCH 1/2] iio: Move callback buffer to its own module
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1439564095-7352-1-git-send-email-lars@metafoo.de>
 <1439564095-7352-2-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF43B5.5020604@kernel.org>
Date: Sat, 15 Aug 2015 14:50:45 +0100
MIME-Version: 1.0
In-Reply-To: <1439564095-7352-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/15 15:54, Lars-Peter Clausen wrote:
> Currently the IIO callback buffer implementation is directly built into the
> IIO core module when enabled. Given that the callback buffer module is
> standalone functionallity there is really no reason to do this. So move it
> to its own module.
> 
> Also rename the source to follow the standard IIO module naming convention
> as well as add a license notice to the file.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
I originally kept this in the core because it is so trivial and we
were actually thinking about rolling all the buffers back in to the core
modules at the time (doesn't make sense any more) but I suppose it
is more logical to split it out really ;)

So sure, why not.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.
> ---
>  drivers/iio/Kconfig                                   |  2 +-
>  drivers/iio/Makefile                                  |  2 +-
>  drivers/iio/{buffer_cb.c => industrialio-buffer-cb.c} | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>  rename drivers/iio/{buffer_cb.c => industrialio-buffer-cb.c} (89%)
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4011eff..b52c8a3 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -21,7 +21,7 @@ config IIO_BUFFER
>  if IIO_BUFFER
>  
>  config IIO_BUFFER_CB
> -	bool "IIO callback buffer used for push in-kernel interfaces"
> +	tristate "IIO callback buffer used for push in-kernel interfaces"
>  	help
>  	  Should be selected by any drivers that do in-kernel push
>  	  usage.  That is, those where the data is pushed to the consumer.
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2..09d8ec5 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -6,8 +6,8 @@ obj-$(CONFIG_IIO) += industrialio.o
>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
> -industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>  
> +obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
>  obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>  obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>  
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/industrialio-buffer-cb.c
> similarity index 89%
> rename from drivers/iio/buffer_cb.c
> rename to drivers/iio/industrialio-buffer-cb.c
> index 1648e6e..323079c 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/industrialio-buffer-cb.c
> @@ -1,4 +1,12 @@
> +/* The industrial I/O callback buffer
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -124,3 +132,7 @@ struct iio_channel
>  	return cb_buffer->channels;
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_cb_get_channels);
> +
> +MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
> +MODULE_DESCRIPTION("Industrial I/O callback buffer");
> +MODULE_LICENSE("GPL");
> 

