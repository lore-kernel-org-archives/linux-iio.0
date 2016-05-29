Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34174 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbcE2TEN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:04:13 -0400
Subject: Re: [PATCH v3 2/3] iio: electricalconductivity: add
 IIO_ELECTRICALCONDUCTIVITY type
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1464150560-1186-1-git-send-email-mranostay@gmail.com>
 <1464150560-1186-3-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7d8e14fc-f33c-a61e-0552-ddcfc49ecf52@kernel.org>
Date: Sun, 29 May 2016 20:04:11 +0100
MIME-Version: 1.0
In-Reply-To: <1464150560-1186-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 05:29, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to ignore it.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index df44998..e7f590c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1565,3 +1565,10 @@ Description:
>  		* X is in the plane of the propellers, perpendicular to Y axis,
>  		  and positive towards the starboard side of the UAV ;
>  		* Z is perpendicular to propellers plane and positive upwards.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_electricalconductivity_raw
> +KernelVersion:	4.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) electric conductivity reading that
> +		can be processed to siemens per meter.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e6319a9..2a85bd8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -80,6 +80,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_RESISTANCE] = "resistance",
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
> +	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index b0916fc..22e5e58 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -39,6 +39,7 @@ enum iio_chan_type {
>  	IIO_RESISTANCE,
>  	IIO_PH,
>  	IIO_UVINDEX,
> +	IIO_ELECTRICALCONDUCTIVITY,
>  };
>  
>  enum iio_modifier {
> 

