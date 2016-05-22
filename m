Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52401 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbcEVTsA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:48:00 -0400
Subject: Re: [PATCH v2 2/3] iio: electricalconductivity: add
 IIO_ELECTRICALCONDUCTIVITY type
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1463709181-17528-1-git-send-email-mranostay@gmail.com>
 <1463709181-17528-3-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6ad02a26-6649-7987-df7c-80d5244d5a0d@kernel.org>
Date: Sun, 22 May 2016 20:47:57 +0100
MIME-Version: 1.0
In-Reply-To: <1463709181-17528-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/16 02:53, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index df44998..adfdf95 100644
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
> +		maps to microsiemens per centimeter.
Rather than seimens per m?  Seems like the units are a mess when measuring this and
we do in theory aim for the basic SI units where possible...

Otherwise, this looks fine to me.

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

