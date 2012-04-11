Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1062 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754255Ab2DKJpe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 05:45:34 -0400
Message-ID: <4F85534B.6000809@metafoo.de>
Date: Wed, 11 Apr 2012 11:47:55 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 09/14] staging:iio:adc:ad7476 unwind use of IIO_CHAN macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-10-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/ad7476_core.c |   45 +++++++++++++++------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index 0c064d1..a703693 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -66,53 +66,50 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +#define AD7476_CHAN(bits, sh)					\

Since shift + bits is always 12 we can simplify this a bit more and make it
just take the number of bits and calculate the shift.

> +	{							\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = bits,				\
> +		.storagebits = 16,				\
> +		.shift = sh,					\
> +	},							\
> +}
