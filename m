Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1096 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752327Ab2DKLkW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:40:22 -0400
Message-ID: <4F856E3B.8070809@metafoo.de>
Date: Wed, 11 Apr 2012 13:42:51 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 04/14] staging:iio:accel:adis16209 unwind use of IIO_CHAN
 macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-5-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Note the addition of extend_name = "supply" for the supply voltage
> adc.  This brings this driver into line with the other adis parts.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

The cocci patch disagrees on one occasion, but I think that's an bug in the
original driver.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/staging/iio/accel/adis16209_core.c |  135 ++++++++++++++++++++--------
>  1 file changed, 100 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index a98715f..02c003f 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -408,41 +408,106 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static struct iio_chan_spec adis16209_channels[] = {
> [...]
> -	IIO_CHAN(IIO_ROT, 0, 1, 0, NULL, 0, IIO_MOD_X,
> -		    0,
> -		    rot, ADIS16209_SCAN_ROT,
> -		    IIO_ST('s', 14, 16, 0), 0),

> +	}, {
> +		.type = IIO_ROT,
> +		.modified = 1,

This one had indexed set instead of modified, which doesn't make any sense.
May be worth noting this in the changelog though.

> +		.channel2 = IIO_MOD_X,
> +		.address = rot,
> +		.scan_index = ADIS16209_SCAN_ROT,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 14,
> +			.storagebits = 16,
> +		},
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(8)
>  };
>  

