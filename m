Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58748 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754753AbcIJQL7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 12:11:59 -0400
Subject: Re: [PATCH 1/2] iio: Implement counter channel type and info
 constants
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <cover.1473265537.git.vilhelm.gray@gmail.com>
 <6a27560d27e0554b632e68b017427b8697419a26.1473265537.git.vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <58fa70f5-5166-f07a-9eba-146d95b78f3a@kernel.org>
Date: Sat, 10 Sep 2016 17:11:56 +0100
MIME-Version: 1.0
In-Reply-To: <6a27560d27e0554b632e68b017427b8697419a26.1473265537.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/09/16 18:55, William Breathitt Gray wrote:
> Quadrature encoders, such as rotary encoders and linear encoders, are
> devices which are capable of encoding the relative position and
> direction of motion of a shaft. This patch introduces several IIO
> constants for supporting quadrature encoder counter devices.
This is interesting.  There is clearly an overlap in functionality with
the resolver drivers (which are all still hiding in staging
<gives Lars a gentle reminder>)
but the very nature of them is that we know the correspondence between
their output and a physical angle.

Here we have no way of knowing that.  The very nature of such systems
is they aren't always hardwired to a particular encoder so even in
embedded systems that translation probably isn't something we can
directly push into the device tree.

I wonder if ultimately we might want a consumer driver taking the
'counts' of a raw quadrature encoder interface and converting that
(with additional information provided either from DT or configfs)
to an angle etc. 

Job for another day ;)

I did wonder if we could 'abuse' the steps channel type to
avoid adding a new one (particularly as I've been eyeing up
some ST powerstep01 all in one stepper driver chips at work
and thinking they really should have a kernel driver ;)

Probably not though...

I think we need to think long and hard about the ABI for this
and try and make it a bit clearer / more generic in some ways
from the start.
> 
>   IIO_COUNT: Current count (main data provided by the counter device)
> 
>   IIO_CHAN_INFO_FLAGS: Counter flag states (e.g. underflows, overflows,
>                        errors, etc.)
Probably not suitable for an IIO_CHAN_INFO element.  There are lots
of things that hide in here that should be broken out separately
(and probably via ext_info elements at that).
>   IIO_CHAN_INFO_DIRECTION: Set high when counting up and reset low when
>                            counting down
Should indicate this in it's name.
IIO_CHAN_INFO_INCREASING perhaps?
>   IIO_CHAN_INFO_INDEX: Set high when index input is at active level
Hmm. might be something we want to do in a buffer at somepoint so
might want to be a channel type in it's own right..
>   IIO_CHAN_INFO_MODE: Count value encoding, counter range setting,
>                       quadrature phase mode, etc.
Another one where we are throwing lots of things into one hole.
Have separate ext_info elements instead breaking these out.

>   IIO_CHAN_INFO_PRESET: Counter preset value
Fair enough on this one.

>   IIO_CHAN_INFO_PRESET_EN: Set high to preset counter on signal (e.g.
>                            index input at active level)
Hmm. This needs more care as we probably want one ext_info element
that has values 'disabled', 'index high' etc.

> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 7 +++++++
>  include/linux/iio/iio.h         | 6 ++++++
>  include/uapi/linux/iio/types.h  | 1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0528a0c..bfdb09d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -81,6 +81,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
> +	[IIO_COUNT] = "count",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -151,6 +152,12 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>  	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>  	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
> +	[IIO_CHAN_INFO_FLAGS] = "flags",
> +	[IIO_CHAN_INFO_DIRECTION] = "direction",
> +	[IIO_CHAN_INFO_INDEX] = "index",
> +	[IIO_CHAN_INFO_MODE] = "mode",
> +	[IIO_CHAN_INFO_PRESET] = "preset",
> +	[IIO_CHAN_INFO_PRESET_EN] = "preset_enable",
>  };
>  
>  /**
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index b4a0679..13543fd 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -46,6 +46,12 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_DEBOUNCE_TIME,
>  	IIO_CHAN_INFO_CALIBEMISSIVITY,
>  	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> +	IIO_CHAN_INFO_FLAGS,
> +	IIO_CHAN_INFO_DIRECTION,
> +	IIO_CHAN_INFO_INDEX,
> +	IIO_CHAN_INFO_MODE,
> +	IIO_CHAN_INFO_PRESET,
> +	IIO_CHAN_INFO_PRESET_EN,
>  };
>  
>  enum iio_shared_by {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 22e5e58..e227039 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -40,6 +40,7 @@ enum iio_chan_type {
>  	IIO_PH,
>  	IIO_UVINDEX,
>  	IIO_ELECTRICALCONDUCTIVITY,
> +	IIO_COUNT,
>  };
>  
>  enum iio_modifier {
> 

