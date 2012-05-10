Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41806 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab2EJIJS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 04:09:18 -0400
Message-ID: <4FAB77A3.2020507@kernel.org>
Date: Thu, 10 May 2012 09:09:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/3] iio: core: introduce dB scle: IIO_VAL_INT_PLUS_MICRO_DB
References: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/9/2012 11:36 AM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
All looks fine and sensible cleaning up whilst you were at it.
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/iio/industrialio-core.c |   19 +++++++++++++------
>   include/linux/iio/types.h       |    1 +
>   2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 72e33b8..e799d35 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -306,26 +306,33 @@ static ssize_t iio_read_channel_info(struct device *dev,
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>   	int val, val2;
> +	bool scale_db = false;
>   	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
>   					&val,&val2, this_attr->address);
>
>   	if (ret<  0)
>   		return ret;
>
> -	if (ret == IIO_VAL_INT)
> +	switch (ret) {
> +	case IIO_VAL_INT:
>   		return sprintf(buf, "%d\n", val);
> -	else if (ret == IIO_VAL_INT_PLUS_MICRO) {
> +	case IIO_VAL_INT_PLUS_MICRO_DB:
> +		scale_db = true;
> +	case IIO_VAL_INT_PLUS_MICRO:
>   		if (val2<  0)
> -			return sprintf(buf, "-%d.%06u\n", val, -val2);
> +			return sprintf(buf, "-%d.%06u%s\n", val, -val2,
> +				scale_db ? " dB" : "");
>   		else
> -			return sprintf(buf, "%d.%06u\n", val, val2);
> -	} else if (ret == IIO_VAL_INT_PLUS_NANO) {
> +			return sprintf(buf, "%d.%06u%s\n", val, val2,
> +				scale_db ? " dB" : "");
> +	case IIO_VAL_INT_PLUS_NANO:
>   		if (val2<  0)
>   			return sprintf(buf, "-%d.%09u\n", val, -val2);
>   		else
>   			return sprintf(buf, "%d.%09u\n", val, val2);
> -	} else
> +	default:
>   		return 0;
> +	}
>   }
>
>   static ssize_t iio_write_channel_info(struct device *dev,
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a471fd5..1b073b1 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -50,5 +50,6 @@ enum iio_modifier {
>   #define IIO_VAL_INT 1
>   #define IIO_VAL_INT_PLUS_MICRO 2
>   #define IIO_VAL_INT_PLUS_NANO 3
> +#define IIO_VAL_INT_PLUS_MICRO_DB 4
>
>   #endif /* _IIO_TYPES_H_ */

