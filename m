Return-Path: <lars@metafoo.de>
Message-ID: <55DF2F67.3000209@metafoo.de>
Date: Thu, 27 Aug 2015 17:40:23 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>, jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC] iio: ppm: Add IIO_PPM channel type
References: <1440657930-14871-1-git-send-email-mranostay@gmail.com>
In-Reply-To: <1440657930-14871-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/27/2015 08:45 AM, Matt Ranostay wrote:
> There are air quality sensors that report data back in parts per million
> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
> or another common pollutant.
> 
> This patchset adds an IIO_PPM type because no other channels types fit
> this use case.

Hm, I'm not sure if parts-per-million is a good channel type. It's more of a
scale. The type would be concentration. But that still doesn't tell us what
is actually being measured. Concentration is always something of unit Y per
unit of X. Knowing Y and X is in my opinion important to makes sense of the
data. I'm not sure how to express these though.

Maybe a modifier for what is measured and then define that the rest of the
units cancel out. Like CO2 concentration is CO2 molecules per molecule so
you'd just end up with CO2 for the modiifer and use the scale to define
whether it is %, ‰, ppm, ppb, ppt.

Given that concentration will not be larger than 1 it makes sense to use
something small as the standard unit and then use the scale factor to scale
up or down.

E.g. lets say we make ppm the standard unit, then a scale 1 means ppm,
0.0001 means ppb, 1000 means ‰, 10000 means % and so on.

- Lars

> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 42d360f..79366a3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1459,3 +1459,10 @@ Description:
>  		measurements and return the average value as output data. Each
>  		value resulted from <type>[_name]_oversampling_ratio measurements
>  		is considered as one sample for <type>[_name]_sampling_frequency.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_ppm_raw
> +KernelVersion:	4.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) parts per million measure reading
> +		of data like CO2 or VOC (Volatile Organic Compounds) substances.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b3fcc2c..65285c7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ENERGY] = "energy",
>  	[IIO_DISTANCE] = "distance",
>  	[IIO_VELOCITY] = "velocity",
> +	[IIO_PPM] = "ppm",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 2f8b117..7113f9b 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -35,6 +35,7 @@ enum iio_chan_type {
>  	IIO_ENERGY,
>  	IIO_DISTANCE,
>  	IIO_VELOCITY,
> +	IIO_PPM,
>  };
>  
>  enum iio_modifier {
> 
