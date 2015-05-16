Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52999 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbEPJ4f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2015 05:56:35 -0400
Message-ID: <55571450.3060903@kernel.org>
Date: Sat, 16 May 2015 10:56:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: adis16400: Report pressure channel scale
References: <1431703118-32676-1-git-send-email-lars@metafoo.de> <1431703118-32676-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1431703118-32676-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/05/15 16:18, Lars-Peter Clausen wrote:
> Add the scale for the pressure channel, which is currently missing.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Fixes: 76ada52f7f5d ("iio:adis16400: Add support for the adis16448")
Applied to the fixes branch of iio.git and marked for stable.
> ---
>  drivers/iio/imu/adis16400_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index fa795dc..8de6427 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -405,6 +405,11 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  			*val = st->variant->temp_scale_nano / 1000000;
>  			*val2 = (st->variant->temp_scale_nano % 1000000);
>  			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_PRESSURE:
> +			/* 20 uBar = 0.002kPascal */
> +			*val = 0;
> +			*val2 = 2000;
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
> 

