Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47517 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab1JXNNj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 09:13:39 -0400
Message-ID: <4EA5648A.3080905@cam.ac.uk>
Date: Mon, 24 Oct 2011 14:13:46 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio:staging: Add documentation for IIO_EVENT_CODE
References: <1319461509-17434-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319461509-17434-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/11 14:05, Lars-Peter Clausen wrote:
> Document the different parameters of the IIO_EVENT_CODE macro and friends.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> I'm adding this to get a clear definition of what each field is for, because
> currently there are somewhat contradicting usages of this macro. So I'm not
> quite sure if this is the correct documentation.
What you have is certainly what has intended.

Only suggestion is to perhaps standardise naming as chan_type rather than
having both that and channel_class for the same thing?
> 
> ---
>  drivers/staging/iio/events.h |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index 389c781..520a20e 100644
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
> @@ -51,10 +63,27 @@ enum iio_event_direction {
>  #define IIO_EV_BIT(type, direction)			\
>  	(1 << (type*IIO_EV_DIR_MAX + direction))
>  
> +/**
> + * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
> + * @channelclass: Type of the channel. Should be one of enum iio_chan_type.
Ooops, I hadn't registered the different naming in here. I'd be inclined
to make this chan_type as well - might as well role it into this set.
> + * @number:	Channel number for non-differential channels.
True, but given we can't have modified differential channels anyway perhaps
doesn't need to be stated here?
> + * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
> + * @type:	Type of the event. Should be one enum iio_event_type.
> + * @direction:	Direction of the event. Should be one of enum iio_event_direction.
> + */
> +
>  #define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
>  			   type, direction)				\
>  	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
>  
> +/**
> + * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
> + * @channelclass: Type of the channel. Should be one of enum iio_chan_type.
same with naming here - switch it to chan_type.
> + * @number:	Channel number for non-differential channels.
> + * @type:	Type of the event. Should be one enum iio_event_type.
> + * @direction:	Direction of the event. Should be one of enum iio_event_direction.
> + */
> +
>  #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
>  	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
>  

