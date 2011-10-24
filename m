Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59991 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab1JXNmx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 09:42:53 -0400
Message-ID: <4EA56B63.60905@cam.ac.uk>
Date: Mon, 24 Oct 2011 14:42:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2] iio:staging: Add documentation for IIO_EVENT_CODE
References: <1319463592-19710-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319463592-19710-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/11 14:39, Lars-Peter Clausen wrote:
> Document the different parameters of the IIO_EVENT_CODE macro and friends.
> 
> While we are at it standardise the name of channel type parameter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

I'll pick this one up as well.
> 
> ---
> Changes since v1:
> 	* Standardise channel type parameter name
> 	* Remove redundant elements from the channel number description of
> 	  macros for non-differential channels.
> ---
>  drivers/staging/iio/events.h |   37 +++++++++++++++++++++++++++++++++----
>  1 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index 389c781..7cf9306 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -40,6 +40,18 @@ enum iio_event_direction {
>  	IIO_EV_DIR_FALLING,
>  };
>  
> +/**
> + * IIO_EVENT_CODE() - create event identifier
> + * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
> + * @diff:	Whether the event is for an differential channel or not.
> + * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
> + * @direction:	Direction of the event. Should be one of enum iio_event_direction.
> + * @type:	Type of the event. Should be one enum iio_event_type.
> + * @chan:	Channel number for non-differential channels.
> + * @chan1:	First channel number for differential channels.
> + * @chan2:	Second channel number for differential channels.
> + */
> +
>  #define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
>  		       type, chan, chan1, chan2)			\
>  	(((u64)type << 56) | ((u64)diff << 55) |			\
> @@ -51,12 +63,29 @@ enum iio_event_direction {
>  #define IIO_EV_BIT(type, direction)			\
>  	(1 << (type*IIO_EV_DIR_MAX + direction))
>  
> -#define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
> +/**
> + * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
> + * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
> + * @number:	Channel number.
> + * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
> + * @type:	Type of the event. Should be one enum iio_event_type.
> + * @direction:	Direction of the event. Should be one of enum iio_event_direction.
> + */
> +
> +#define IIO_MOD_EVENT_CODE(chan_type, number, modifier,		\
>  			   type, direction)				\
> -	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
> +	IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
> +
> +/**
> + * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
> + * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
> + * @number:	Channel number.
> + * @type:	Type of the event. Should be one enum iio_event_type.
> + * @direction:	Direction of the event. Should be one of enum iio_event_direction.
> + */
>  
> -#define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
> -	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
> +#define IIO_UNMOD_EVENT_CODE(chan_type, number, type, direction)	\
> +	IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
>  
>  #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
>  

