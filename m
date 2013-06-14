Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46554 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab3FOJo5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jun 2013 05:44:57 -0400
Message-ID: <51BB81FD.5020305@kernel.org>
Date: Fri, 14 Jun 2013 21:50:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/7] staging:iio:ad7291: Use IIO_VAL_FRACTIONAL_LOG2
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/14/2013 04:58 PM, Lars-Peter Clausen wrote:
> This is a bit more straight forward and also allows better precession when using
> the an in-kernel consumer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/adc/ad7291.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index d088c66..a3a3a2f 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -456,7 +456,6 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad7291_chip_info *chip = iio_priv(indio_dev);
> -	unsigned int scale_uv;
>  	u16 regval;
>  	s16 signval;
>  
> @@ -513,10 +512,9 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			scale_uv = (chip->int_vref_mv * 1000) >> AD7291_BITS;
> -			*val =  scale_uv / 1000;
> -			*val2 = (scale_uv % 1000) * 1000;
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			*val = chip->int_vref_mv;
> +			*val2 = AD7291_BITS;
> +			return IIO_VAL_FRACTIONAL_LOG2;
>  		case IIO_TEMP:
>  			/*
>  			 * One LSB of the ADC corresponds to 0.25 deg C.
> 
