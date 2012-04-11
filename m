Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1241 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752612Ab2DKLq7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:46:59 -0400
Message-ID: <4F856FC4.5090902@metafoo.de>
Date: Wed, 11 Apr 2012 13:49:24 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 10/14] staging:iio:accel:ad7780 unwind use of IIO_CHAN
 macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-11-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Looks good, but it might makes sense to add a macro here, because the two
channel specs only differ in the number of realbits (and shift).

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/staging/iio/adc/ad7780.c |   30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index a13e58c..4f0a6c9 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -126,14 +126,32 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  	[ID_AD7780] = {
> -		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -				    IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -				    0, 0, IIO_ST('s', 24, 32, 8), 0),
> +		.channel = {
> +			.type = IIO_VOLTAGE,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 24,
> +				.storagebits = 32,
> +				.shift = 8,
> +			},
> +		},
>  	},
>  	[ID_AD7781] = {
> -		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -				    IIO_CHAN_INFO_SCALE_SHARED_BIT,
> -				    0, 0, IIO_ST('s', 20, 32, 12), 0),
> +		.channel = {
> +			.type = IIO_VOLTAGE,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 20,
> +				.storagebits = 32,
> +				.shift = 12,
> +			},
> +		},
>  	},
>  };
>  

