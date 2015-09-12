Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55612 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbbILJQd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 05:16:33 -0400
Subject: Re: [RFC v4 1/4] iio: chemical: Add IIO_CONCENTRATION channel type
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1441866654-10381-1-git-send-email-mranostay@gmail.com>
 <1441866654-10381-2-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F3ED70.4060306@kernel.org>
Date: Sat, 12 Sep 2015 10:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <1441866654-10381-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/15 07:30, Matt Ranostay wrote:
> There are air quality sensors that report data back in parts per million
> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
> or another common pollutant.
> 
> This patchset adds an IIO_CONCENTRATION type that returns a percentage
> of substance because no other channels types fit this use case.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Other than a typo inline looks good to me.
I think you can drop the RFC now :)
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 42d360f..48080b7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1459,3 +1459,10 @@ Description:
>  		measurements and return the average value as output data. Each
>  		value resulted from <type>[_name]_oversampling_ratio measurements
>  		is considered as one sample for <type>[_name]_sampling_frequency.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
> +KernelVersion:	4.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) precentage reading of a substance.
percentage
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b3fcc2c..58a60a1 100644
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
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 2f8b117..c5a0e3f 100644
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
> 

