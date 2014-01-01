Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47247 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbaAAOuv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2014 09:50:51 -0500
Message-ID: <52C42B4C.70403@kernel.org>
Date: Wed, 01 Jan 2014 14:50:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC 2/2] IIO : core: Introduce Quaternion types
References: <1387901990-3469-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1387901990-3469-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1387901990-3469-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 24/12/13 16:19, Srinivas Pandruvada wrote:
> Introduced IIO_VAL_QUATERNION and its formatting. Format used here:
> x:y:z:w
> In addition quat_rot is added to the channel type name specification and
> new modifier IIO_MOD_QUATERNION to the list of iio modifiers.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Not that this will want to go in as a precursor in a series with a 
driver implementing it.  Fine to propose it as an RFC but for a final
submission it is preferable to also have an example of it being used!
(immediately deals with the 'what is this for?'  question ;)
> ---
>   drivers/iio/industrialio-core.c | 5 +++++
>   include/linux/iio/types.h       | 3 +++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f0f2a1a..8b6a2fe 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -69,6 +69,7 @@ static const char * const iio_chan_type_name_spec[] = {
>   	[IIO_ALTVOLTAGE] = "altvoltage",
>   	[IIO_CCT] = "cct",
>   	[IIO_PRESSURE] = "pressure",
> +	[IIO_QUAT_ROT] = "quat_rot",
>   };
This is going to give some interesting naming...

in_quat_rot_quaternion_raw etc aren't exactly clear.

I think it's a channel type rather than a modifier, so
would go with

rotquaternion above and not have a modifier below... Note
the lack of underscore is similar to humidityrelative and
is done to make userspace processing easier by allowing a simple
tokenization based on the underscores.


>
>   static const char * const iio_modifier_names[] = {
> @@ -83,6 +84,7 @@ static const char * const iio_modifier_names[] = {
>   	[IIO_MOD_LIGHT_RED] = "red",
>   	[IIO_MOD_LIGHT_GREEN] = "green",
>   	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_QUATERNION] = "quaternion",
>   };
>
>   /* relies on pairs of these shared then separate */
> @@ -403,6 +405,9 @@ ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
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
