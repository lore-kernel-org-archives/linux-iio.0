Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1043 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751125Ab2DKLW5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:22:57 -0400
Message-ID: <4F856A25.9020101@metafoo.de>
Date: Wed, 11 Apr 2012 13:25:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 05/14] staging:iio:accel:adis16240 unwind use of IIO_CHAN
 macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-6-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/accel/adis16240_core.c |  103 ++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
> index 17f77fe..43da947 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -468,33 +468,82 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static struct iio_chan_spec adis16240_channels[] = {
> [...]
> -	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
> -		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> -		 temp, ADIS16240_SCAN_TEMP,
> -		 IIO_ST('u', 10, 16, 0), 0),
> [...]
> +	}, {
> +		.type = IIO_ACCEL,

IIO_TEMP

> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> +		.address = temp,
> +		.scan_index = ADIS16240_SCAN_TEMP,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 10,
> +			.storagebits = 16,
> +		},
