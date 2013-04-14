Return-Path: <lars@metafoo.de>
Message-ID: <516A9F6C.70906@metafoo.de>
Date: Sun, 14 Apr 2013 14:22:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio:Add an IIO_VAL_INTO_PLUS_PICO return type for
 read_raw callbacks.
References: <1365938625-21778-1-git-send-email-jic23@kernel.org> <1365938625-21778-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1365938625-21778-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/14/2013 01:23 PM, Jonathan Cameron wrote:
> For now not added to the write_raw handling as no usecase yet exists
> and it would involve a more substantial reworking of the string
> processing code to handle it cleanly.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/industrialio-core.c | 5 +++++
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e145931..40ef037 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -393,6 +393,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  			return sprintf(buf, "-%d.%09u\n", val, -val2);
>  		else
>  			return sprintf(buf, "%d.%09u\n", val, val2);
> +	case IIO_VAL_INT_PLUS_PICO:
> +		if (val2 < 0)
> +			return sprintf(buf, "-%d.%012u\n", val, -val2);
> +		else
> +			return sprintf(buf, "-%d.%012u\n", val, val2);

This one shouldn't have the minus sign.

>  	case IIO_VAL_FRACTIONAL:
>  		tmp = div_s64((s64)val * 1000000000LL, val2);
>  		val2 = do_div(tmp, 1000000000LL);
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 88bf0f0..27e78a6 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -58,6 +58,7 @@ enum iio_modifier {
>  #define IIO_VAL_INT_PLUS_MICRO 2
>  #define IIO_VAL_INT_PLUS_NANO 3
>  #define IIO_VAL_INT_PLUS_MICRO_DB 4
> +#define IIO_VAL_INT_PLUS_PICO 5
>  #define IIO_VAL_FRACTIONAL 10
>  #define IIO_VAL_FRACTIONAL_LOG2 11
>  
