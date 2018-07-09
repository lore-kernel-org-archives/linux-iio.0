Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:64569 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeGIL0F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2018 07:26:05 -0400
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix up casting in
 at91_adc_read_info_raw()
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20180709110658.bjtebvyinfqjrzbr@kili.mountain>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <bd530537-1e5a-cf92-fd9b-b9caa04e56b7@microchip.com>
Date: Mon, 9 Jul 2018 14:22:40 +0300
MIME-Version: 1.0
In-Reply-To: <20180709110658.bjtebvyinfqjrzbr@kili.mountain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 09.07.2018 14:06, Dan Carpenter wrote:
> This code is problematic because we're supposed to be writing an int but
> we instead write to only the high 16 bits.  This doesn't work on big
> endian systems, and there is a potential that the bottom 16 bits are
> used without being initialized.

Hi Dan,

Thanks for the patch.
Please correct me if I'm wrong, the caller of this function should mask 
out the unused bits w.r.t. the channel spec ?

Indeed there may be an issue if we actually write the data to the wrong 
16 bit part of the 32 bit integer.

Would be safer to check for the endianess and write the proper part of 
the int ? (macros that do the magic for us - cpu_to_le etc.), or we rely 
on the compiler to do it for us as it looks in your code ?

Another option is to pass the int directly and do the ugly task inside 
the read_position/pressure functions, I am not sure which one looks better

Thanks,
Eugen

> 
> Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e02f7d1c86bc..d5ea84cf6460 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1296,6 +1296,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>   {
>   	struct at91_adc_state *st = iio_priv(indio_dev);
>   	u32 cor = 0;
> +	u16 tmp_val;
>   	int ret;
>   
>   	/*
> @@ -1309,7 +1310,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>   		mutex_lock(&st->lock);
>   
>   		ret = at91_adc_read_position(st, chan->channel,
> -					     (u16 *)val);
> +					     &tmp_val);
> +		*val = tmp_val;
>   		mutex_unlock(&st->lock);
>   		iio_device_release_direct_mode(indio_dev);
>   
> @@ -1322,7 +1324,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>   		mutex_lock(&st->lock);
>   
>   		ret = at91_adc_read_pressure(st, chan->channel,
> -					     (u16 *)val);
> +					     &tmp_val);
> +		*val = tmp_val;
>   		mutex_unlock(&st->lock);
>   		iio_device_release_direct_mode(indio_dev);
>   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
