Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50719 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab2FHMLP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jun 2012 08:11:15 -0400
Message-ID: <4FD1EBDE.8000202@cam.ac.uk>
Date: Fri, 08 Jun 2012 13:11:10 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCG v3 1/9] staging:iio: Add helper function for initializing
 triggered buffers
References: <1339145332-26811-1-git-send-email-lars@metafoo.de> <1339157593-15821-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1339157593-15821-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/8/2012 1:13 PM, Lars-Peter Clausen wrote:
> Add a helper function for executing the common tasks which are usually involved
> in setting up a simple software ringbuffer. It will allocate the buffer,
> allocate the pollfunc and register the buffer.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Other than the patch title...

Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
> Changes since v2:
> 	* Add missing header...
>
> 	I've only resent this one patch for v3 since all the others are unchanged.
>
> Changes since v1:
> 	* Move function declarations to their own header
> 	* Mention that iio_triggered_buffer_setup should usually be called right
> 	  before iio_device_register
> 	* Minor code cleanups
> ---
>   drivers/iio/Kconfig                         |    7 ++
>   drivers/iio/Makefile                        |    1 +
>   drivers/iio/industrialio-triggered-buffer.c |  110 +++++++++++++++++++++++++++
>   include/linux/iio/triggered_buffer.h        |   15 ++++
>   4 files changed, 133 insertions(+)
>   create mode 100644 drivers/iio/industrialio-triggered-buffer.c
>   create mode 100644 include/linux/iio/triggered_buffer.h
>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 103349f..612073f 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -30,6 +30,13 @@ config IIO_KFIFO_BUF
>   	  no buffer events so it is up to userspace to work out how
>   	  often to read from the buffer.
>
> +config IIO_TRIGGERED_BUFFER
> +	tristate
> +	select IIO_TRIGGER
> +	select IIO_KFIFO_BUF
> +	help
> +	  Provides helper functions for setting up triggered buffers.
> +
>   endif # IIO_BUFFER
>
>   config IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index c38fa2a..34309ab 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -7,6 +7,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>   industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>   industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>
> +obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>   obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>
>   obj-y += adc/
> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
> new file mode 100644
> index 0000000..a462a57
> --- /dev/null
> +++ b/drivers/iio/industrialio-triggered-buffer.c
> @@ -0,0 +1,110 @@
> + /*
> + * Copyright (c) 2012 Analog Devices, Inc.
> + *  Author: Lars-Peter Clausen<lars@metafoo.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/export.h>
> +#include<linux/module.h>
> +#include<linux/iio/iio.h>
> +#include<linux/iio/buffer.h>
> +#include<linux/iio/kfifo_buf.h>
> +#include<linux/iio/triggered_buffer.h>
> +#include<linux/iio/trigger_consumer.h>
> +
> +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> +	.preenable =&iio_sw_buffer_preenable,
> +	.postenable =&iio_triggered_buffer_postenable,
> +	.predisable =&iio_triggered_buffer_predisable,
> +};
> +
> +/**
> + * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
> + * @indio_dev:		IIO device structure
> + * @pollfunc_bh:	Function which will be used as pollfunc bottom half
> + * @pollfunc_th:	Function which will be used as pollfunc top half
> + * @setup_ops:		Buffer setup functions to use for this device.
> + *			If NULL the default setup functions for triggered
> + *			buffers will be used.
> + *
> + * This function combines some common tasks which will normally be performed
> + * when setting up a triggered buffer. It will allocate the buffer and the
> + * pollfunc, as well as register the buffer with IIO core.
> + *
> + * Before calling this function the indio_dev structure should already be
> + * completely initialized but not yet registered. In practice this means that
> + * this function should be called right before iio_device_register().
> + *
> + * To free the resources allocated by this function
> + * iio_triggered_buffer_cleanup() should be called.
> + */
> +int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
> +	irqreturn_t (*pollfunc_bh)(int irq, void *p),
> +	irqreturn_t (*pollfunc_th)(int irq, void *p),
> +	const struct iio_buffer_setup_ops *setup_ops)
> +{
> +	int ret;
> +
> +	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> +	if (!indio_dev->buffer) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
> +						 pollfunc_th,
> +						 IRQF_ONESHOT,
> +						 indio_dev,
> +						 "%s_consumer%d",
> +						 indio_dev->name,
> +						 indio_dev->id);
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_kfifo_free;
> +	}
> +
> +	/* Ring buffer functions - here trigger setup related */
> +	if (setup_ops)
> +		indio_dev->setup_ops = setup_ops;
> +	else
> +		indio_dev->setup_ops =&iio_triggered_buffer_setup_ops;
> +
> +	/* Flag that polled ring buffering is possible */
> +	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> +
> +	ret = iio_buffer_register(indio_dev,
> +				  indio_dev->channels,
> +				  indio_dev->num_channels);
> +	if (ret)
> +		goto error_dealloc_pollfunc;
> +
> +	return 0;
> +
> +error_dealloc_pollfunc:
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +error_kfifo_free:
> +	iio_kfifo_free(indio_dev->buffer);
> +error_ret:
> +	return ret;
> +}
> +EXPORT_SYMBOL(iio_triggered_buffer_setup);
> +
> +/**
> + * iio_triggered_buffer_cleanup() - Free resources allocated by iio_triggered_buffer_setup()
> + * @indio_dev: IIO device structure
> + */
> +void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
> +{
> +	iio_buffer_unregister(indio_dev);
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +	iio_kfifo_free(indio_dev->buffer);
> +}
> +EXPORT_SYMBOL(iio_triggered_buffer_cleanup);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen<lars@metafoo.de>");
> +MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
> new file mode 100644
> index 0000000..c378ebe
> --- /dev/null
> +++ b/include/linux/iio/triggered_buffer.h
> @@ -0,0 +1,15 @@
> +#ifndef _LINUX_IIO_TRIGGERED_BUFFER_H_
> +#define _LINUX_IIO_TRIGGERED_BUFFER_H_
> +
> +#include<linux/interrupt.h>
> +
> +struct iio_dev;
> +struct iio_buffer_setup_ops;
> +
> +int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
> +	irqreturn_t (*pollfunc_bh)(int irq, void *p),
> +	irqreturn_t (*pollfunc_th)(int irq, void *p),
> +	const struct iio_buffer_setup_ops *setup_ops);
> +void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
> +
> +#endif

