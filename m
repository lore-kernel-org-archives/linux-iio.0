Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57008 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcGCJU2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 05:20:28 -0400
Subject: Re: [PATCH v2] drivers:iio:light:isl29125: added macros for sensing
 range
To: Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"k.kozlowski@samsung.com" <k.kozlowski@samsung.com>
References: <KL1PR04MB1205FC759593484E11F486A280210@KL1PR04MB1205.apcprd04.prod.outlook.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6f811ba2-32b4-941c-c9c5-3955147667b0@kernel.org>
Date: Sun, 3 Jul 2016 10:20:26 +0100
MIME-Version: 1.0
In-Reply-To: <KL1PR04MB1205FC759593484E11F486A280210@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 16:37, Bijosh Thykkoottathil wrote:
> Added macros for sensing range as the corresponding magic numbers
> were used at multiple places.
>    - ISL29125_SENSING_RANGE_0 for 375 lux full range
>    - ISL29125_SENSING_RANGE_1 for 10k lux full range
> 
> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
Applied to the togreg branch of iio.git. Initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/isl29125.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index e2945a2..d0aa802 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -44,6 +44,9 @@
>  #define ISL29125_MODE_B 0x3
>  #define ISL29125_MODE_RGB 0x5
>  
> +#define ISL29125_SENSING_RANGE_0 5722   /* 375 lux full range */
> +#define ISL29125_SENSING_RANGE_1 152590 /* 10k lux full range */
> +
>  #define ISL29125_MODE_RANGE BIT(3)
>  
>  #define ISL29125_STATUS_CONV BIT(1)
> @@ -140,9 +143,9 @@ static int isl29125_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		if (data->conf1 & ISL29125_MODE_RANGE)
> -			*val2 = 152590; /* 10k lux full range */
> +			*val2 = ISL29125_SENSING_RANGE_1; /*10k lux full range*/
>  		else
> -			*val2 = 5722; /* 375 lux full range */
> +			*val2 = ISL29125_SENSING_RANGE_0; /*375 lux full range*/
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
> @@ -158,9 +161,9 @@ static int isl29125_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		if (val != 0)
>  			return -EINVAL;
> -		if (val2 == 152590)
> +		if (val2 == ISL29125_SENSING_RANGE_1)
>  			data->conf1 |= ISL29125_MODE_RANGE;
> -		else if (val2 == 5722)
> +		else if (val2 == ISL29125_SENSING_RANGE_0)
>  			data->conf1 &= ~ISL29125_MODE_RANGE;
>  		else
>  			return -EINVAL;
> 

