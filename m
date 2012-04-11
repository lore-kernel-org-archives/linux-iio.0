Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1054 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751508Ab2DKLle (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:41:34 -0400
Message-ID: <4F856E83.4060708@metafoo.de>
Date: Wed, 11 Apr 2012 13:44:03 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 08/14] staging:iio:adc:ad7298 unwind use of IIO_CHAN macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-9-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/staging/iio/adc/ad7298_core.c |   63 +++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
> index 8dd6aa9..0cdde18 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c
> +++ b/drivers/staging/iio/adc/ad7298_core.c
> @@ -22,34 +22,43 @@
>  
>  #include "ad7298.h"
>  
> +#define AD7298_V_CHAN(index)						\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = index,					\
> +		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
> +		.address = index,					\
> +		.scan_index = index,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 12,					\
> +			.storagebits = 16,				\
> +		},							\
> +	}
> +
>  static struct iio_chan_spec ad7298_channels[] = {
> -	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
> -		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> -		 9, AD7298_CH_TEMP, IIO_ST('s', 32, 32, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 0, 0, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 1, 1, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 2, 2, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 3, 3, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 4, 4, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 5, 5, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 6, 6, IIO_ST('u', 12, 16, 0), 0),
> -	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
> -		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -		 7, 7, IIO_ST('u', 12, 16, 0), 0),
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> +		.address = 9,
> +		.scan_index = AD7298_CH_TEMP,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +		},
> +	},
> +	AD7298_V_CHAN(0),
> +	AD7298_V_CHAN(1),
> +	AD7298_V_CHAN(2),
> +	AD7298_V_CHAN(3),
> +	AD7298_V_CHAN(4),
> +	AD7298_V_CHAN(5),
> +	AD7298_V_CHAN(6),
> +	AD7298_V_CHAN(7),
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  

