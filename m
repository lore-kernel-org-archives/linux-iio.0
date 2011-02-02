Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:49638 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab1BBToG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Feb 2011 14:44:06 -0500
Date: Wed, 2 Feb 2011 11:42:42 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202194242.GA27065@kroah.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 02, 2011 at 08:21:08PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds a new trigger that can be invoked by writing
> the sysfs file: trigger_now. This approach can be valuable during
> automated testing or in situations, where other trigger methods
> are not applicable. For example no RTC or spare GPIOs.
> Last but not least we can allow user space applications to produce triggers.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

If you add a new sysfs file, you need to document it.  I'll not take
this patch as-is because of that.

> ---
>  drivers/staging/iio/trigger/Kconfig          |    6 ++
>  drivers/staging/iio/trigger/Makefile         |    1 +
>  drivers/staging/iio/trigger/iio-trig-sysfs.c |  108 ++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/trigger/iio-trig-sysfs.c
> 
> diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
> index d842a58..c185e47 100644
> --- a/drivers/staging/iio/trigger/Kconfig
> +++ b/drivers/staging/iio/trigger/Kconfig
> @@ -18,4 +18,10 @@ config IIO_GPIO_TRIGGER
>  	help
>  	  Provides support for using GPIO pins as IIO triggers.
>  
> +config IIO_SYSFS_TRIGGER
> +	tristate "SYSFS trigger"
> +	depends on SYSFS
> +	help
> +	  Provides support for using SYSFS entry as IIO triggers.

Why would you ever want to not have this enabled?  Why is it a config
option?  And shouldn't it depend on the IIO subsystem?



> +
>  endif # IIO_TRIGGER
> diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
> index 10aeca5..504b9c0 100644
> --- a/drivers/staging/iio/trigger/Makefile
> +++ b/drivers/staging/iio/trigger/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
>  obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
> +obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
> diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> new file mode 100644
> index 0000000..3434f3c
> --- /dev/null
> +++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> @@ -0,0 +1,108 @@
> +/*
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.

Are you sure you really mean "or later"?  Seriously, do your lawyers
agree that this is what they want to have happen to this file?

> + *
> + * iio-trig-sysfs.c

Don't put the file name in the file itself, that's pointless :)

> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> +MODULE_DESCRIPTION("Sysfs based trigger for the iio subsystem");
> +MODULE_LICENSE("GPL v2");

What is going to cause this module to be loaded in the system?  Are you
relying on userspace to load it if it "knows" it is needed?  That's
really not nice, we should trigger off of some type of hardware.

thanks,

greg k-h
