Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59065 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab3JXHfa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 03:35:30 -0400
Message-ID: <5268DBFD.6080108@kernel.org>
Date: Thu, 24 Oct 2013 09:36:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Add support for humidity sensors
References: <E1VYf44-0000gV-4n@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1VYf44-0000gV-4n@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/13 17:44, Harald Geyer wrote:
> There are already humidity sensors in the hwmon subsystem,
> so we use their unit (milli percent) here as well.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Reposting this unchanged (except for the kernel verion update in
> the ABI document) from the patch I sent two month ago, as I didn't
> get any feedback back then. 
It's fine (sorry should have said). I won't merge it until the accompanying driver is
ready to go.  Right now I'm leaving reviewing that to Peter who is doing a great job :)
(the driver looks more or less fine to me as well).

> 
>  Documentation/ABI/testing/sysfs-bus-iio |   13 +++++++++++++
>  drivers/iio/industrialio-core.c         |    1 +
>  include/linux/iio/types.h               |    1 +
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 39c8de0..76f8f08 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -197,6 +197,19 @@ Description:
>  		Raw pressure measurement from channel Y. Units after
>  		application of scale and offset are kilopascal.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
> +KernelVersion:	3.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw humidity measurement of air. Units after application of
> +		scale and offset are milli percent.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
> +KernelVersion:	3.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scaled humidity measurement in milli percent.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f95c697..5062987 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -66,6 +66,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ALTVOLTAGE] = "altvoltage",
>  	[IIO_CCT] = "cct",
>  	[IIO_PRESSURE] = "pressure",
> +	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 88bf0f0..f822b3d 100644
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
