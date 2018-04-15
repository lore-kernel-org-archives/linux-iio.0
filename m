Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeDOPf0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:35:26 -0400
Date: Sun, 15 Apr 2018 16:35:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] staging: iio: ad7746: Add comments
Message-ID: <20180415163520.3480439f@archlinux>
In-Reply-To: <1523637411-8531-11-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-11-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:47 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Add comments to clarify some of the calculations made, specially when
> reading or writing values.
> 
Mostly good, but a few minor comments.

Jonathan

> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 05506bf9..ef0ebb5 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -429,6 +429,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> +		/* 2^16 in micro */
I'm not seeing the connection...  what is 2^16?

>  		val = (val2 * 1024) / 15625;
>  
>  		switch (chan->type) {
> @@ -554,6 +555,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto out;
>  
> +		/*
> +		 * Either for Capacitance, Voltage or Temperature,
> +		 * the 0x000000 code represents negative full scale,
> +		 * the 0x800000 code represents zero scale, and
> +		 * the 0xFFFFFF code represents positive full scale.
> +		 */
> +
>  		*val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
>  
>  		switch (chan->type) {
> @@ -565,7 +573,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  			*val = (*val * 125) / 256;
>  			break;
>  		case IIO_VOLTAGE:
> -			if (chan->channel == 1) /* supply_raw*/
> +
> +			/*
> +			 * The voltage from the VDD pin is internally
> +			 * attenuated by 6.
> +			 */
> +
> +			if (chan->channel == 1) /* supply_raw */
>  				*val = *val * 6;
>  			break;
>  		default:
> @@ -606,6 +620,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> +
> +		/*
> +		 * CAPDAC Scale = 21pF_typ / 127
> +		 * CIN Scale = 8.192pF / 2^24
> +		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
> +		 */
I don't think the following blank line does much other than make
it less clear what the comment is about.

Same in other locations. Allow the absence of a blank line on one
side of the comment to indicate it's association.


> +
>  		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
>  					  [chan->differential]) * 338646;
>  
> @@ -614,13 +635,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_CAPACITANCE:
> -			/* 8.192pf / 2^24 */
> +			/* CIN Scale: 8.192pf / 2^24 */
>  			*val =  0;
>  			*val2 = 488;
>  			ret = IIO_VAL_INT_PLUS_NANO;
>  			break;
>  		case IIO_VOLTAGE:
> -			/* 1170mV / 2^23 */
> +			/* VIN Scale: 1170mV / 2^23 */
>  			*val = 1170;
>  			*val2 = 23;
>  			ret = IIO_VAL_FRACTIONAL_LOG2;
> @@ -674,7 +695,8 @@ static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
>  	unsigned int tmp;
>  	int ret;
>  
> -	/* The default excitation outputs are not inverted, it should be stated
> +	/*
> +	 * The default excitation outputs are not inverted, it should be stated
>  	 * in the dt if needed.
>  	 */
>  
> @@ -685,7 +707,7 @@ static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
>  	ret = of_property_read_u32(np, "adi,exclvl", &tmp);
>  	if (ret || tmp > 3) {
>  		dev_warn(dev, "Wrong exclvl value, using default\n");
> -		pdata->exclvl = 3; /* default value */
> +		pdata->exclvl = 3;
>  	} else {
>  		pdata->exclvl = tmp;
>  	}

