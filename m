Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbdJHOil (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 10:38:41 -0400
Date: Sun, 8 Oct 2017 12:57:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: Implement counter channel specification and
 IIO_SIGNAL constant
Message-ID: <20171008125734.3506965f@archlinux>
In-Reply-To: <14129e5a8b64502496690bf9743888ab67dc4e8c.1507220144.git.vilhelm.gray@gmail.com>
References: <cover.1507220144.git.vilhelm.gray@gmail.com>
        <14129e5a8b64502496690bf9743888ab67dc4e8c.1507220144.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  5 Oct 2017 14:13:30 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Counters are IIO devices that are exposed via a generic counter
> interface consisting of one or more counter signals (IIO_SIGNAL) linked
> to one or more counter values (IIO_COUNT).
> 
> This patch introduces the IIO_SIGNAL constant which represents a counter
> device signal line. Additionally, a new "counter" member is added to
> struct iio_chan_spec, with relevant support, to indicate that a channel
> is part of a counter.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

I have a feeling this support could be useful more generically
than just for counters.    There are other cases where a couple
of different input signals are combined to give one result and
we don't currently represent that combination.

A complex example would be differential channels where we have
some elements specific to the individual lines (the ability to
apply front end PGA type effects separately) - Not sure I've
seen one of these though ;)

Simpler case is light sensors - two light sensors are combined to
provide an illuminance output (one is typically all wavelengths and
one is infrared only - as we want to remove that from signal).

Some of these devices have multiple sensor inputs and right now
we don't make it clear which ones feed which illuminance values
and we should do.

Now this introduces another issue - those channels are indexed
and modified so already using both channel and channel2.

So... Do we ever need to represent provide the 'counter' element
in an event, (which is where we are short on space in the ABI)?
I don't think we do as channel is unique anyway (I think) so
this isn't a problem.

If not - define a new element to take this index rather than
overloading channel2 (again).

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 14 +++++++++++++-
>  include/linux/iio/iio.h         |  2 ++
>  include/uapi/linux/iio/types.h  |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 7a5aa127c52e..ee508f2070a7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_COUNT] = "count",
>  	[IIO_INDEX] = "index",
>  	[IIO_GRAVITY]  = "gravity",
> +	[IIO_SIGNAL] = "signal",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -989,7 +990,18 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  			break;
>  
>  		case IIO_SEPARATE:
> -			if (chan->indexed)
> +			if (chan->counter) {
> +				if (!chan->indexed) {
> +					WARN(1, "Counter channels must be indexed\n");
> +					ret = -EINVAL;
> +					goto error_free_full_postfix;
> +				}
> +				name = kasprintf(GFP_KERNEL, "%s%d-%d_%s",

Hmm. - has a meaning in IIO already - perhaps we need a different symbol to represent
this grouping concept?

> +						    iio_chan_type_name_spec[chan->type],
> +						    chan->channel,
> +						    chan->channel2,
> +						    full_postfix);
> +			} else if (chan->indexed)

Ultimately probably want to cover the various shared cases as well.

>  				name = kasprintf(GFP_KERNEL, "%s_%s%d_%s",
>  						    iio_direction[chan->output],
>  						    iio_chan_type_name_spec[chan->type],
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 50cae8504256..9f949dd74b60 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -263,6 +263,7 @@ struct iio_event_spec {
>   *			attributes but not for event codes.
>   * @output:		Channel is output.
>   * @differential:	Channel is differential.
> + * @counter:		Channel is part of a counter.
>   */
>  struct iio_chan_spec {
>  	enum iio_chan_type	type;
> @@ -295,6 +296,7 @@ struct iio_chan_spec {
>  	unsigned		indexed:1;
>  	unsigned		output:1;
>  	unsigned		differential:1;
> +	unsigned		counter:1;
>  };
>  
>  
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index ffafd6c25a48..313899652ca7 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -43,6 +43,7 @@ enum iio_chan_type {
>  	IIO_COUNT,
>  	IIO_INDEX,
>  	IIO_GRAVITY,
> +	IIO_SIGNAL,
>  };
>  
>  enum iio_modifier {

