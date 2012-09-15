Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35075 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab2IOJNu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Sep 2012 05:13:50 -0400
Message-ID: <505446CD.1010706@kernel.org>
Date: Sat, 15 Sep 2012 10:13:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	Milo Kim <Milo.Kim@ti.com>,
	anish kumar <anish198519851985@gmail.com>
Subject: Re: [PATCH 2/4] iio: Introduce a new fractional value type
References: <1347636104-3419-1-git-send-email-lars@metafoo.de> <1347636104-3419-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1347636104-3419-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/14/2012 04:21 PM, Lars-Peter Clausen wrote:
> Currently IIO uses a decimal fixed point representations for real type numbers.
> This patch introduces a new representation for rational type numbers. The number
> will be expressed by specifying a numerator and denominator. For converting a
> raw value to a processed value multiply it by the numerator and divide it by the
> denominator.
> 
> The reasoning for introducing this new type is that for a lot of devices the
> scale can be represented easily by a fractional number, but it is not possible
> to represent it as fixed point number without rounding.  E.g. for a simple DAC
> the scale is often the reference voltage divided by the number of possible
> values (Usually 2**n_bits - 1). Each driver currently implements the conversion
> of this fraction to a fixed point number on its own.
> 
> Also when it comes to the in-kernel interface this allows to directly use the
> fractional factors to convert a raw value to a processed value. This should on
> one hand require less instructions and on the other hand increase the
> precession.
precession -> precision (fixed in merge)
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged to togreg branch of iio.git
> ---
>  drivers/iio/industrialio-core.c |    6 ++++++
>  include/linux/iio/types.h       |    1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0499330..6eb24db 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -366,6 +366,7 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	unsigned long long tmp;
>  	int val, val2;
>  	bool scale_db = false;
>  	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
> @@ -391,6 +392,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  			return sprintf(buf, "-%d.%09u\n", val, -val2);
>  		else
>  			return sprintf(buf, "%d.%09u\n", val, val2);
> +	case IIO_VAL_FRACTIONAL:
> +		tmp = div_s64((s64)val * 1000000000LL, val2);
> +		val2 = do_div(tmp, 1000000000LL);
> +		val = tmp;
> +		return sprintf(buf, "%d.%09u\n", val, val2);
>  	default:
>  		return 0;
>  	}
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 44e3977..5c647ec 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -57,5 +57,6 @@ enum iio_modifier {
>  #define IIO_VAL_INT_PLUS_MICRO 2
>  #define IIO_VAL_INT_PLUS_NANO 3
>  #define IIO_VAL_INT_PLUS_MICRO_DB 4
> +#define IIO_VAL_FRACTIONAL 10
>  
>  #endif /* _IIO_TYPES_H_ */
> 
