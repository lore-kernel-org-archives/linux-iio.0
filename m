Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-104.synserver.de ([212.40.185.104]:1196 "EHLO
	smtp-out-104.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab3AaJf0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 04:35:26 -0500
Message-ID: <510A3B17.9020304@metafoo.de>
Date: Thu, 31 Jan 2013 10:36:23 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
Subject: Re: [PATCH] iio: gyro: Add itg3200
References: <1345192038-5665-1-git-send-email-not@iis.fhg.de> <1359471547-32178-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1359471547-32178-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2013 03:59 PM, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> ---
[...]
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 612073f..7b54702 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -57,6 +57,7 @@ config IIO_CONSUMERS_PER_TRIGGER
>  
>  source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
> +source "drivers/iio/gyro/Kconfig"
>  source "drivers/iio/light/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/dac/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 34309ab..30858b5 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>  
>  obj-y += adc/
>  obj-y += amplifiers/
> +obj-y += gyro/
>  obj-y += light/
>  obj-y += frequency/
>  obj-y += dac/
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> new file mode 100644
> index 0000000..185f85d
> --- /dev/null
> +++ b/drivers/iio/gyro/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# IIO Digital Gyroscope Sensor drivers configuration
> +#
> +menu "Digital gyroscope sensors"
> +
> +config ITG3200
> +	tristate "InvenSense ITG3200 Digital 3-Axis Gyroscope I2C driver"
> +	depends on I2C
> +	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
> +	help
> +	  Say yes here to add support for the InvenSense ITG3200 digital
> +	  3-axis gyroscope sensor.
> +
> +endmenu
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> new file mode 100644
> index 0000000..2049a5d
> --- /dev/null
> +++ b/drivers/iio/gyro/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for industrial I/O gyroscope sensor drivers
> +#
> +
> +itg3200-y               := itg3200_core.o
> +itg3200-$(CONFIG_IIO_BUFFER) += itg3200_buffer.o itg3200_trigger.o
> +obj-$(CONFIG_ITG3200)   += itg3200.o

We already have the gyro subfolder in the current IIO tree, so the changes
above won't apply cleanly.

- Lars
