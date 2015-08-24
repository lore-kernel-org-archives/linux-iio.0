Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50912 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbHXSl3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2015 14:41:29 -0400
Subject: Re: [PATCH v4 1/2] iio: humidity: si7020: replaced bitmask on
 humidity values with range check
To: Nicola Corna <nicola@corna.info>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1440363979-4845-1-git-send-email-nicola@corna.info>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55DB6556.9020401@kernel.org>
Date: Mon, 24 Aug 2015 19:41:26 +0100
MIME-Version: 1.0
In-Reply-To: <1440363979-4845-1-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/15 22:06, Nicola Corna wrote:
> The maximum possible value for the relative humidity is 55575 (100%RH).
> This value, if shifted right by 2 bits, uses 14 bits and masking it with
> a 12 bit mask removes 2 meaningful bits.
> The masking has been replaced with a range check that sets the minimum
> value at 786 (0%RH) and the maximum at 13893 (99.998%RH).
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  drivers/iio/humidity/si7020.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index fa3b809..12128d1 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -57,8 +57,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		*val = ret >> 2;
> +		/*
> +		 * Humidity values can slightly exceed the 0-100%RH
> +		 * range and should be corrected by software
> +		 */
>  		if (chan->type == IIO_HUMIDITYRELATIVE)
> -			*val &= GENMASK(11, 0);
> +			*val = clamp_val(*val, 786, 13893);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_TEMP)
> 

