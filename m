Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52005 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbbITSzS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 14:55:18 -0400
Subject: Re: [PATCH v5 1/4] iio: chemical: Add IIO_CONCENTRATION channel type
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1442201174-10975-1-git-send-email-mranostay@gmail.com>
 <1442201174-10975-2-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FF0113.4020107@kernel.org>
Date: Sun, 20 Sep 2015 19:55:15 +0100
MIME-Version: 1.0
In-Reply-To: <1442201174-10975-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/09/15 04:26, Matt Ranostay wrote:
> There are air quality sensors that report data back in parts per million
> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
> or another common pollutant.
> 
> This patchset adds an IIO_CONCENTRATION type that returns a percentage
> of substance because no other channels types fit this use case.
> Modifiers for IIO_MOD_CO2 and IIO_MOD_VOC gas types are defined.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  drivers/iio/industrialio-core.c         |  3 +++
>  include/uapi/linux/iio/types.h          |  3 +++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 42d360f..682c070 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1459,3 +1459,14 @@ Description:
>  		measurements and return the average value as output data. Each
>  		value resulted from <type>[_name]_oversampling_ratio measurements
>  		is considered as one sample for <type>[_name]_sampling_frequency.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
> +KernelVersion:	4.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) percentage reading of a substance.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b3fcc2c..8eb6064 100644
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
> +	[IIO_MOD_CO2] = "co2",
> +	[IIO_MOD_VOC] = "voc",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 2f8b117..1e4c4e3 100644
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
> +	IIO_MOD_CO2,
> +	IIO_MOD_VOC,
>  };
>  
>  enum iio_event_type {
> 

