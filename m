Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58455 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759117Ab2JSRm6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:42:58 -0400
Message-ID: <5081783B.4020602@kernel.org>
Date: Fri, 19 Oct 2012 16:56:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 1/2] iio: Add a logarithmic fractional value type
References: <1350404979-29253-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1350404979-29253-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/2012 05:29 PM, Lars-Peter Clausen wrote:
> For ADCs or DACs the denominator for fractional types often is a power of two.
> In this case we can use a shift operation instead of the rather expensive 64 bit
> division. This patch adds a new fractional type which expects the denominator to
> be specified as the log2 of the actual denominator. E.g. for ADCs and DACs this
> will usually be the number of significant bits.
Only slight issue with this is that continual addition of these will eventually
make for a mess.  Having said that, this one is sensible and as you say
common.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Added to togreg branch of iio.git

> ---
>  drivers/iio/industrialio-core.c |    5 +++++
>  drivers/iio/inkern.c            |    3 +++
>  include/linux/iio/types.h       |    1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6eb24db..37650a7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -397,6 +397,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  		val2 = do_div(tmp, 1000000000LL);
>  		val = tmp;
>  		return sprintf(buf, "%d.%09u\n", val, val2);
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp = (s64)val * 1000000000LL >> val2;
> +		val2 = do_div(tmp, 1000000000LL);
> +		val = tmp;
> +		return sprintf(buf, "%d.%09u\n", val, val2);
>  	default:
>  		return 0;
>  	}
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index f2b78d4..2ee4450 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -314,6 +314,9 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  		*processed = div_s64(raw64 * (s64)scale_val * scale,
>  				     scale_val2);
>  		break;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		*processed = (raw64 * (s64)scale_val * scale) >> scale_val2;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 5c647ec..87b196a 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -58,5 +58,6 @@ enum iio_modifier {
>  #define IIO_VAL_INT_PLUS_NANO 3
>  #define IIO_VAL_INT_PLUS_MICRO_DB 4
>  #define IIO_VAL_FRACTIONAL 10
> +#define IIO_VAL_FRACTIONAL_LOG2 11
>  
>  #endif /* _IIO_TYPES_H_ */
> 
