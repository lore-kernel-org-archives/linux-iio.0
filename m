Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36582 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbaBRI2Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:28:25 -0500
Message-ID: <530319CE.1030805@kernel.org>
Date: Tue, 18 Feb 2014 08:29:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	maxime.ripard@free-electrons.com
Subject: Re: [PATCH 3/4] IIO: core: Introduce Quaternion types
References: <1390194142-25058-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1390194142-25058-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1390194142-25058-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/14 05:02, Srinivas Pandruvada wrote:
> Introduced IIO_VAL_QUATERNION and its formatting. Format used here:
> x:y:z:w
> In addition IIO_QUAT_ROT is added to the channel type and name.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Since reviewing the interface for the ecap driver the other day I've been
wondering if a new channel is the right approach here. In that driver
I pointed out that modifiers can result in different units for the output.
I'm not sure we want to do that in general, but perhaps here it makes
sense?

So we would have a quaternion modifier (treating it the same as an axis)
giving us attributes like

in_rot_quaternion_raw

etc.

Would this be prefereable to the approach here of having new channel type
to cover it?  That is do we want the channel type to always specify the
representation, or do we allow it to be done through the modifier?
We have let in relativehumidity as a type which arguably could
have been humidity and a relative modifier.  Perhaps we are better just
going with these compound types.  They don't really restrict us, but just
feel a little untidy.

Also, Srinivas - whatever we end up with needs documenting in
Documentation/ABI/testing/sysfs-bus-iio

Whilst looking at this I notice we confusingly have both rot and angl
channel types. Are they actually different?  Conceptually devices tend
to be thought of as measuring one or the other - so you'd probably
never describe an inclinometer as measuring rotation.  Hmm.. As it is now been
in the ABI for some time we are pretty much stuck with this.
> ---
>   drivers/iio/industrialio-core.c | 4 ++++
>   include/linux/iio/types.h       | 3 +++
>   2 files changed, 7 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f8b730a..267b0a0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -69,6 +69,7 @@ static const char * const iio_chan_type_name_spec[] = {
>   	[IIO_ALTVOLTAGE] = "altvoltage",
>   	[IIO_CCT] = "cct",
>   	[IIO_PRESSURE] = "pressure",
> +	[IIO_QUAT_ROT] = "rotquaternion",
>   };
>
>   static const char * const iio_modifier_names[] = {
> @@ -403,6 +404,9 @@ ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
>   		vals[1] = do_div(tmp, 1000000000LL);
>   		vals[0] = tmp;
>   		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
> +	case IIO_VAL_QUATERNION:
> +		return sprintf(buf, "%d:%d:%d:%d\n", vals[0], vals[1], vals[2],
> +							vals[3]);
>   	default:
>   		return 0;
>   	}
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4ac928e..878db0e 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -29,6 +29,7 @@ enum iio_chan_type {
>   	IIO_ALTVOLTAGE,
>   	IIO_CCT,
>   	IIO_PRESSURE,
> +	IIO_QUAT_ROT,
>   };
>
>   enum iio_modifier {
> @@ -52,6 +53,7 @@ enum iio_modifier {
>   	IIO_MOD_LIGHT_RED,
>   	IIO_MOD_LIGHT_GREEN,
>   	IIO_MOD_LIGHT_BLUE,
> +	IIO_MOD_QUATERNION,
>   };
>
>   enum iio_event_type {
> @@ -78,6 +80,7 @@ enum iio_event_direction {
>   #define IIO_VAL_INT_PLUS_MICRO 2
>   #define IIO_VAL_INT_PLUS_NANO 3
>   #define IIO_VAL_INT_PLUS_MICRO_DB 4
> +#define IIO_VAL_QUATERNION 5
>   #define IIO_VAL_FRACTIONAL 10
>   #define IIO_VAL_FRACTIONAL_LOG2 11
>
>

