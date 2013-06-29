Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42063 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab3F2KIc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 06:08:32 -0400
Message-ID: <51CEB21B.9020308@kernel.org>
Date: Sat, 29 Jun 2013 11:08:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: fix Kconfig typos
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net> <1372022900-18670-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/23/2013 10:28 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
applied to togreg branch of iio.git. Thanks!
> ---
>  drivers/iio/Kconfig          | 2 +-
>  drivers/iio/pressure/Kconfig | 8 ++++----
>  drivers/iio/trigger/Kconfig  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 9af763a..be8e303 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -23,7 +23,7 @@ if IIO_BUFFER
>  config IIO_BUFFER_CB
>  boolean "IIO callback buffer used for push in-kernel interfaces"
>  	help
> -	  Should be selected by any drivers that do-inkernel push
> +	  Should be selected by any drivers that do in-kernel push
>  	  usage.  That is, those where the data is pushed to the consumer.
>  
>  config IIO_KFIFO_BUF
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 9427f01..3cba7f5 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -1,18 +1,18 @@
>  #
>  # Pressure drivers
>  #
> -menu "Pressure Sensors"
> +menu "Pressure sensors"
>  
>  config IIO_ST_PRESS
> -	tristate "STMicroelectronics pressures Driver"
> +	tristate "STMicroelectronics pressure sensor Driver"
>  	depends on (I2C || SPI_MASTER) && SYSFS
>  	select IIO_ST_SENSORS_CORE
>  	select IIO_ST_PRESS_I2C if (I2C)
>  	select IIO_ST_PRESS_SPI if (SPI_MASTER)
>  	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>  	help
> -	  Say yes here to build support for STMicroelectronics pressures:
> -	  LPS331AP.
> +	  Say yes here to build support for STMicroelectronics pressure
> +	  sensors: LPS331AP.
>  
>  	  This driver can also be built as a module. If so, will be created
>  	  these modules:
> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 360fd50..0a4a516 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -17,7 +17,7 @@ config IIO_SYSFS_TRIGGER
>  	depends on SYSFS
>  	select IRQ_WORK
>  	help
> -	  Provides support for using SYSFS entry as IIO triggers.
> +	  Provides support for using SYSFS entries as IIO triggers.
>  	  If unsure, say N (but it's safe to say "Y").
>  
>  	  To compile this driver as a module, choose M here: the
> 
