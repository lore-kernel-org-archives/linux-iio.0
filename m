Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55639 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbbILJTw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 05:19:52 -0400
Subject: Re: [RFC v4 2/4] iio: resistance: add IIO_RESISTANCE channel type
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1441866654-10381-1-git-send-email-mranostay@gmail.com>
 <1441866654-10381-3-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F3EE37.5030304@kernel.org>
Date: Sat, 12 Sep 2015 10:19:51 +0100
MIME-Version: 1.0
In-Reply-To: <1441866654-10381-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/15 07:30, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 48080b7..0f683ed 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1466,3 +1466,10 @@ KernelVersion:	4.3
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled no offset etc.) precentage reading of a substance.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
> +KernelVersion:	4.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no offset etc.) resistance reading in ohms.
Actually a comment that applies to the previous patch as well. 
The reading should only be in ohms after the application offset and scale. 
Note how that is described for some of the other attributes.
E.g. Units after the application of offset and scale are ohms.

If you want to output directly in ohms (typically either because the hardware
actually outputs in the relevant unit - or the transform is non linear) then
use the processed version (rather confusingly - we lifted it from hwmon, 
called _input which if is probably the worst bit of our ABI with hindsight!)


> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 58a60a1..d61a363 100644
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
> index c5a0e3f..d58319c 100644
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

