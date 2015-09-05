Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41366 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbIEPvH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 11:51:07 -0400
Subject: Re: [RFC v1 1/4] iio: chemical: Add IIO_CONCENTRATION channel type
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
 <1441432406-4761-2-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB0F68.8090908@kernel.org>
Date: Sat, 5 Sep 2015 16:51:04 +0100
MIME-Version: 1.0
In-Reply-To: <1441432406-4761-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/15 06:53, Matt Ranostay wrote:
> There are air quality sensors that report data back in parts per million
> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
> or another common pollutant.
> 
> This patchset adds an IIO_CONCENTRATION type and IIO_MOD_PPM/PPB modifiers
> because no other channels types fit this use case.
Fine with concentration, not with the modifiers. See below.

> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  drivers/iio/industrialio-core.c         |  3 +++
>  include/uapi/linux/iio/types.h          |  3 +++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 42d360f..a3803a1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1459,3 +1459,13 @@ Description:
>  		measurements and return the average value as output data. Each
>  		value resulted from <type>[_name]_oversampling_ratio measurements
>  		is considered as one sample for <type>[_name]_sampling_frequency.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ppm_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ppb_raw
> +KernelVersion:	4.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) concentration reading of data like
> +		CO2 or VOC (Volatile Organic Compounds) substances with or without
> +		ppm (Part Per Million) or ppb (Parts Per Billion) channel modifiers.
See below.  ppm  / ppb should not be modifiers. That's not what they are for.

> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b3fcc2c..ea9e31a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ENERGY] = "energy",
>  	[IIO_DISTANCE] = "distance",
>  	[IIO_VELOCITY] = "velocity",
> +	[IIO_CONCENTRATION] = "concentration",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -111,6 +112,8 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
>  	[IIO_MOD_I] = "i",
>  	[IIO_MOD_Q] = "q",
> +	[IIO_MOD_PPM] = "ppm",
> +	[IIO_MOD_PPB] = "ppb",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 2f8b117..dfb8b8c 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -35,6 +35,7 @@ enum iio_chan_type {
>  	IIO_ENERGY,
>  	IIO_DISTANCE,
>  	IIO_VELOCITY,
> +	IIO_CONCENTRATION,
>  };
>  
>  enum iio_modifier {
> @@ -72,6 +73,8 @@ enum iio_modifier {
>  	IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z,
>  	IIO_MOD_I,
>  	IIO_MOD_Q,
> +	IIO_MOD_PPM,
The use of modifiers is not about units.  Those should be well specified
in the ABI docs for the given channel type.  Hence I'd expect modifiers
for the type of chemical being detected not the unit.
PPB can be handled by PPM and a different return type
IIO_INT_PLUS_NANO etc.  If there isn't an appropriate return type for
the scale needed, then we can easily add more of those ;)

> +	IIO_MOD_PPB,
>  };
>  
>  enum iio_event_type {
> 

