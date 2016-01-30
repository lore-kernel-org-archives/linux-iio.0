Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53617 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbcA3QR0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:17:26 -0500
Subject: Re: [PATCH v5 2/3] iio: ph: add IIO_PH channel type
To: Matt Ranostay <mranostay@gmail.com>
References: <1453862071-1610-1-git-send-email-mranostay@gmail.com>
 <1453862071-1610-3-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACE214.3090908@kernel.org>
Date: Sat, 30 Jan 2016 16:17:24 +0000
MIME-Version: 1.0
In-Reply-To: <1453862071-1610-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/16 02:34, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 0439c2a..86ba8d6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1491,3 +1491,10 @@ Description:
>  		This ABI is especially applicable for humidity sensors
>  		to heatup the device and get rid of any condensation
>  		in some humidity environment
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_ph_raw
> +KernelVersion:	4.5
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) pH reading of a substance as a negative
> +		base-10 logarithm of hydrodium ions in a litre of water.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index af7cc1e..70cb7eb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -77,6 +77,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_VELOCITY] = "velocity",
>  	[IIO_CONCENTRATION] = "concentration",
>  	[IIO_RESISTANCE] = "resistance",
> +	[IIO_PH] = "ph",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 7c63bd6..c077617 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -37,6 +37,7 @@ enum iio_chan_type {
>  	IIO_VELOCITY,
>  	IIO_CONCENTRATION,
>  	IIO_RESISTANCE,
> +	IIO_PH,
>  };
>  
>  enum iio_modifier {
> 

