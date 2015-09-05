Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41395 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbIEP5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 11:57:06 -0400
Subject: Re: [RFC v1 2/4] iio: resistance: add IIO_RESISTANCE channel type
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
 <1441432406-4761-3-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB10D1.1080502@kernel.org>
Date: Sat, 5 Sep 2015 16:57:05 +0100
MIME-Version: 1.0
In-Reply-To: <1441432406-4761-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/15 06:53, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a3803a1..1084659 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1469,3 +1469,9 @@ Description:
>  		Raw (unscaled no offset etc.) concentration reading of data like
>  		CO2 or VOC (Volatile Organic Compounds) substances with or without
>  		ppm (Part Per Million) or ppb (Parts Per Billion) channel modifiers.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
> +KernelVersion:	4.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) resistance reading in ohms.
Fair enough I guess, though I would presume this is really a current measurement
at a known voltage.  Still measuring it as a resistance does save having to
specify the particular voltage so looks good to me.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ea9e31a..862c066 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -76,6 +76,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_DISTANCE] = "distance",
>  	[IIO_VELOCITY] = "velocity",
>  	[IIO_CONCENTRATION] = "concentration",
> +	[IIO_RESISTANCE] = "resistance",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index dfb8b8c..22edd4d 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -36,6 +36,7 @@ enum iio_chan_type {
>  	IIO_DISTANCE,
>  	IIO_VELOCITY,
>  	IIO_CONCENTRATION,
> +	IIO_RESISTANCE,
>  };
>  
>  enum iio_modifier {
> 

