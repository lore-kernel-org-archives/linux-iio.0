Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47020 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbcFZN5F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 09:57:05 -0400
Subject: Re: [PATCH 1/1] drivers:iio:light:isl29125: added macros for sensing
 range
To: Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"k.kozlowski@samsung.com" <k.kozlowski@samsung.com>
References: <KL1PR04MB12053135303C2DFF58F70CB2802E0@KL1PR04MB1205.apcprd04.prod.outlook.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cd4fd8f2-a44a-abd5-5d6b-9d8618d435ac@kernel.org>
Date: Sun, 26 Jun 2016 14:56:59 +0100
MIME-Version: 1.0
In-Reply-To: <KL1PR04MB12053135303C2DFF58F70CB2802E0@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/06/16 12:16, Bijosh Thykkoottathil wrote:
> Added macros for sensing range as the corresponding magic numbers
> were used at multiple places.
>    - SENSING_RANGE_0 for 375 lux full range
>    - SENSING_RANGE_1 for 10k lux full range
> 
> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
Hi Bijosh,

Macros are great for making cases of 'magic numbers' more readable.
However here we are wrapping up 'real' numbers in macros that actually
obscure what they are...

Now the fact they are used twice does make it a little more worthwhile.
Peter, what do you think?  Your driver so up to you ;)
*one buck passed*
> ---
>  drivers/iio/light/isl29125.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index e2945a2..83a5a7a 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -44,6 +44,9 @@
>  #define ISL29125_MODE_B 0x3
>  #define ISL29125_MODE_RGB 0x5
>  
> +#define SENSING_RANGE_0 5722   /* 375 lux full range */
> +#define SENSING_RANGE_1 152590 /* 10k lux full range */
> +
>  #define ISL29125_MODE_RANGE BIT(3)
>  
>  #define ISL29125_STATUS_CONV BIT(1)
> @@ -140,9 +143,9 @@ static int isl29125_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		if (data->conf1 & ISL29125_MODE_RANGE)
> -			*val2 = 152590; /* 10k lux full range */
> +			*val2 = SENSING_RANGE_1; /* 10k lux full range */
>  		else
> -			*val2 = 5722; /* 375 lux full range */
> +			*val2 = SENSING_RANGE_0; /* 375 lux full range */
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
> @@ -158,9 +161,9 @@ static int isl29125_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		if (val != 0)
>  			return -EINVAL;
> -		if (val2 == 152590)
> +		if (val2 == SENSING_RANGE_1)
>  			data->conf1 |= ISL29125_MODE_RANGE;
> -		else if (val2 == 5722)
> +		else if (val2 == SENSING_RANGE_0)
>  			data->conf1 &= ~ISL29125_MODE_RANGE;
>  		else
>  			return -EINVAL;
> 

