Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56944 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbbHVVoN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 22 Aug 2015 17:44:13 -0400
Message-ID: <55D8ED25.4040409@gmx.de>
Date: Sat, 22 Aug 2015 23:44:05 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Nicola Corna <nicola@corna.info>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio:humidity:si7020: replaced bitmask on
 humidity values with range check
References: <1440266488-21507-1-git-send-email-nicola@corna.info>
In-Reply-To: <1440266488-21507-1-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Nicola Corna schrieb am 22.08.2015 um 20:01:
> The maximum possible value for the relative humidity is 55575 (100%RH).
> This value, if shifted right by 2 bits, uses 14 bits and masking it with
> a 12 bit mask removes 2 meaningful bits.
> The masking has been replaced with a range check that sets the minimum
> value at 786 (0%RH) and the maximum at 13894 (100%RH).
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>

Might be discussable, if we want the upper boundary to be rounded down,
so we just barely reach 100% rather than slightly exceeding it (in numbers,
that is 99,998 vs 100,006). Using 13893 might be the better value. Other
than that (and a typo in the comment) looking good, so:
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/humidity/si7020.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index fa3b809..d27e2f2 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -57,8 +57,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		*val = ret >> 2;
> +		/*
> +		 * Humidity values can sligthly exceed the 0-100%RH

Typo: slightly

> +		 * range and should be corrected by software
> +		 */
>  		if (chan->type == IIO_HUMIDITYRELATIVE)
> -			*val &= GENMASK(11, 0);
> +			clamp_val(*val, 786, 13894);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_TEMP)
> 

