Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1072 "EHLO
	smtp-out-105.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751667Ab2DKLuI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 07:50:08 -0400
Message-ID: <4F857080.2050605@metafoo.de>
Date: Wed, 11 Apr 2012 13:52:32 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 11/14] staging:iio:gyro:adis16260 unwind use of IIO_CHAN
 macro.
References: <1334089310-22576-1-git-send-email-jic23@kernel.org> <1334089310-22576-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-12-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2012 10:21 PM, Jonathan Cameron wrote:
> This macro is being removed to simplify ongoing maintenance
> so we need to unwind and remaining users.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Looks good.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/staging/iio/gyro/adis16260_core.c |   89 +++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 8f6af47..92f024e 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -389,30 +389,71 @@ enum adis16260_channel {
>  };
>  #define ADIS16260_GYRO_CHANNEL_SET(axis, mod)				\
>  	struct iio_chan_spec adis16260_channels_##axis[] = {		\
> -		IIO_CHAN(IIO_ANGL_VEL, 1, 0, 0, NULL, 0, mod,		\
> -			 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |	\
> -			 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
> -			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> -			 gyro, ADIS16260_SCAN_GYRO,			\
> -			 IIO_ST('s', 14, 16, 0), 0),			\
> -		IIO_CHAN(IIO_ANGL, 1, 0, 0, NULL, 0, mod,		\
> -			 0,						\
> -			 angle, ADIS16260_SCAN_ANGL,			\
> -			 IIO_ST('u', 14, 16, 0), 0),			\
> -		IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,			\
> -			 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |		\
> -			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> -			 temp, ADIS16260_SCAN_TEMP,			\
> -			 IIO_ST('u', 12, 16, 0), 0),			\
> -		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,		\
> -			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> -			 in_supply, ADIS16260_SCAN_SUPPLY,		\
> -			 IIO_ST('u', 12, 16, 0), 0),			\
> -		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,		\
> -			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> -			 in_aux, ADIS16260_SCAN_AUX_ADC,		\
> -			 IIO_ST('u', 12, 16, 0), 0),			\
> -		IIO_CHAN_SOFT_TIMESTAMP(5)				\
> +		{							\
> +			.type = IIO_ANGL_VEL,				\
> +			.modified = 1,					\
> +			.channel2 = mod,				\
> +			.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
> +			IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |		\
> +			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> +			.address = gyro,				\
> +			.scan_index = ADIS16260_SCAN_GYRO,		\
> +			.scan_type = {					\
> +				.sign = 's',				\
> +				.realbits = 14,				\
> +				.storagebits = 16,			\
> +			},						\
> +		}, {							\
> +			.type = IIO_ANGL,				\
> +			.modified = 1,					\
> +			.channel2 = mod,				\
> +			.address = angle,				\
> +			.scan_index = ADIS16260_SCAN_ANGL,		\
> +			.scan_type = {					\
> +				.sign = 'u',				\
> +				.realbits = 14,				\
> +				.storagebits = 16,			\
> +			},						\
> +		}, {							\
> +			.type = IIO_TEMP,				\
> +			.indexed = 1,					\
> +			.channel = 0,					\
> +			.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
> +			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
> +			.address = temp,				\
> +			.scan_index = ADIS16260_SCAN_TEMP,		\
> +			.scan_type = {					\
> +				.sign = 'u',				\
> +				.realbits = 12,				\
> +				.storagebits = 16,			\
> +			},						\
> +		}, {							\
> +			.type = IIO_VOLTAGE,				\
> +			.indexed = 1,					\
> +			.channel = 0,					\
> +			.extend_name = "supply",			\
> +			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
> +			.address = in_supply,				\
> +			.scan_index = ADIS16260_SCAN_SUPPLY,		\
> +			.scan_type = {					\
> +				.sign = 'u',				\
> +				.realbits = 12,				\
> +				.storagebits = 16,			\
> +			},						\
> +		}, {							\
> +			.type = IIO_VOLTAGE,				\
> +			.indexed = 1,					\
> +			.channel = 1,					\
> +			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
> +			.address = in_aux,				\
> +			.scan_index = ADIS16260_SCAN_AUX_ADC,		\
> +			.scan_type = {					\
> +				.sign = 'u',				\
> +				.realbits = 12,				\
> +				.storagebits = 16,			\
> +			},						\
> +		},							\
> +		IIO_CHAN_SOFT_TIMESTAMP(5),				\
>  	}
>  
>  static const ADIS16260_GYRO_CHANNEL_SET(x, IIO_MOD_X);

