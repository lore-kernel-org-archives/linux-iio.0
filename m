Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45430 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab3LCUMq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2013 15:12:46 -0500
Message-ID: <529E3B3D.9080204@kernel.org>
Date: Tue, 03 Dec 2013 20:12:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: Add support for humidity sensors
References: <E1VYf74-0000gd-5Z@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222030570.23009@pmeerw.net> <E1VYiDp-0000pb-1i@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222210230.23009@pmeerw.net> <E1VYjUo-0000uN-OY@stardust.g4.wien.funkfeuer.at> <5267E795.7030804@metafoo.de> <E1VZfrE-0000lZ-Ma@stardust.g4.wien.funkfeuer.at> <52909438.8000602@kernel.org> <E1VkHFl-00012T-4U@stardust.g4.wien.funkfeuer.at> <5292474A.8040101@kernel.org> <E1Vn8dG-0001HO-AJ@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1Vn8dG-0001HO-AJ@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/13 15:08, Harald Geyer wrote:
> There are already humidity sensors in the hwmon subsystem,
> so we use their unit (milli percent) here as well.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Applied to the togreg branch of iio.git (push out as testing for the
autobuilders to run against)
> ---
> 
> No changes since v2 except for
> KernelVersion: 3.14
> 
> No changes since v1.
> 
>  Documentation/ABI/testing/sysfs-bus-iio |   13 +++++++++++++
>  drivers/iio/industrialio-core.c         |    1 +
>  include/linux/iio/types.h               |    1 +
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b20e829..25aebeb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -197,6 +197,19 @@ Description:
>  		Raw pressure measurement from channel Y. Units after
>  		application of scale and offset are kilopascal.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
> +KernelVersion:	3.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw humidity measurement of air. Units after application of
> +		scale and offset are milli percent.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
> +KernelVersion:	3.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scaled humidity measurement in milli percent.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2fe88c1..acc911a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -69,6 +69,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ALTVOLTAGE] = "altvoltage",
>  	[IIO_CCT] = "cct",
>  	[IIO_PRESSURE] = "pressure",
> +	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4ac928e..084d882 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -29,6 +29,7 @@ enum iio_chan_type {
>  	IIO_ALTVOLTAGE,
>  	IIO_CCT,
>  	IIO_PRESSURE,
> +	IIO_HUMIDITYRELATIVE,
>  };
>  
>  enum iio_modifier {
> 
