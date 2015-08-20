Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:51937 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbbHTUto (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 16:49:44 -0400
Message-ID: <55D63D5E.8050000@gmx.de>
Date: Thu, 20 Aug 2015 22:49:34 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Nicola Corna <nicola@corna.info>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio:humidity:si7020: replaced bitmask on
 humidity values with range check
References: <1440079909-1337-1-git-send-email-nicola@corna.info>
In-Reply-To: <1440079909-1337-1-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Nicola Corna schrieb am 20.08.2015 um 16:11:
> The maximum possible value for the relative humidity is 55575 (100%RH).
> This value, if shifted right by 2 bits, uses 14 bits and masking it with
> a 12 bit mask removes 2 meaningful bits.
> The masking has been replaced with a range check that sets the minimum
> value at 3194 (0%RH) and the maximum at 55575 (100%RH).

Hmm, I guess the mask should have been applied for bits 13:2, but your
solution confirms better to the data sheet. Just one essential detail:
The raw sensor data has already been divided by 4 when you do the boundary
check. So, you need to divide the boundaries, as well.
Btw, you can make this a one-liner using clamp_val, check it out: [1]

[1]http://lxr.free-electrons.com/source/include/linux/kernel.h#L795

> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
> ---
>  drivers/iio/humidity/si7020.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index fa3b809..62fdbcf 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -57,8 +57,16 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		*val = ret >> 2;
> -		if (chan->type == IIO_HUMIDITYRELATIVE)
> -			*val &= GENMASK(11, 0);
> +		/*
> +		 * Humidity values can sligthly exceed the 0-100%RH
> +		 * range and should be corrected by software
> +		 */
> +		if (chan->type == IIO_HUMIDITYRELATIVE) {
> +			if (*val < 3194) /* 0%RH */
> +				*val = 3194;
> +			else if (*val > 55575) /* 100%RH */
> +				*val = 55575;
> +		}
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_TEMP)
> 

