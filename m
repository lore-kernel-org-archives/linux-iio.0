Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55720 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbbAAMNa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:13:30 -0500
Message-ID: <54A539E8.5060100@kernel.org>
Date: Thu, 01 Jan 2015 12:13:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 3/3] iio: accel: Annotate Kconfig entries with module
 name information
References: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com> <1419965875-4298-4-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965875-4298-4-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:57, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: please write a paragraph that describes the config symbol fully
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git.

Thanks,
> ---
>  drivers/iio/accel/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 9b9be87..402a3a5 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -43,6 +43,9 @@ config HID_SENSOR_ACCEL_3D
>  	  Say yes here to build support for the HID SENSOR
>  	  accelerometers 3D.
>  
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-sensor-accel-3d.
> +
>  config IIO_ST_ACCEL_3AXIS
>  	tristate "STMicroelectronics accelerometers 3-Axis Driver"
>  	depends on (I2C || SPI_MASTER) && SYSFS
> @@ -80,6 +83,9 @@ config KXSD9
>  	  Say yes here to build support for the Kionix KXSD9 accelerometer.
>  	  Currently this only supports the device via an SPI interface.
>  
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called kxsd9.
> +
>  config MMA8452
>  	tristate "Freescale MMA8452Q Accelerometer Driver"
>  	depends on I2C
> 

