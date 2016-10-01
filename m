Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45349 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbcJAQG6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 12:06:58 -0400
Subject: Re: [PATCH v5 1/2] iio: Implement counter channel type and info
 constants
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <cover.1475079578.git.vilhelm.gray@gmail.com>
 <3f3ed59f4dc5de28b7a78d8006030a39ea0485bb.1475079578.git.vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <655a0a10-c7be-d3ed-95d6-9a59a4622233@kernel.org>
Date: Sat, 1 Oct 2016 17:06:56 +0100
MIME-Version: 1.0
In-Reply-To: <3f3ed59f4dc5de28b7a78d8006030a39ea0485bb.1475079578.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/09/16 18:59, William Breathitt Gray wrote:
> Quadrature encoders, such as rotary encoders and linear encoders, are
> devices which are capable of encoding the relative position and
> direction of motion of a shaft. This patch introduces several IIO
> constants for supporting quadrature encoder counter devices.
> 
>   IIO_COUNT: Current count (main data provided by the counter device)
>   IIO_INDEX: Counter device index value
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied

Thanks,
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 18 ++++++++++++++++++
>  drivers/iio/industrialio-core.c         |  2 ++
>  include/uapi/linux/iio/types.h          |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index fee35c0..b8f220f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -329,6 +329,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1579,3 +1580,20 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled no offset etc.) electric conductivity reading that
>  		can be processed to siemens per meter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
> +KernelVersion:	4.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw counter device counts from channel Y. For quadrature
> +		counters, multiplication by an available [Y]_scale results in
> +		the counts of a single quadrature signal phase from channel Y.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
> +KernelVersion:	4.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw counter device index value from channel Y. This attribute
> +		provides an absolute positional reference (e.g. a pulse once per
> +		revolution) which may be used to home positional systems as
> +		required.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index fc340ed..649725b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -81,6 +81,8 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
> +	[IIO_COUNT] = "count",
> +	[IIO_INDEX] = "index",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 22e5e58..e54d14a 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -40,6 +40,8 @@ enum iio_chan_type {
>  	IIO_PH,
>  	IIO_UVINDEX,
>  	IIO_ELECTRICALCONDUCTIVITY,
> +	IIO_COUNT,
> +	IIO_INDEX,
>  };
>  
>  enum iio_modifier {
> 

