Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15477 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeGQIoj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jul 2018 04:44:39 -0400
Date: Tue, 17 Jul 2018 10:12:00 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix up casting in
 at91_adc_read_info_raw()
Message-ID: <20180717081200.gxg6fxvzlgycudo5@M43218.corp.atmel.com>
References: <20180709110658.bjtebvyinfqjrzbr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180709110658.bjtebvyinfqjrzbr@kili.mountain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 09, 2018 at 02:06:59PM +0300, Dan Carpenter wrote:
> This code is problematic because we're supposed to be writing an int but
> we instead write to only the high 16 bits.  This doesn't work on big
> endian systems, and there is a potential that the bottom 16 bits are
> used without being initialized.
> 
> Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

This patch sounds good and as it has been tested by Eugen:
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks Dan and Eugen.

> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e02f7d1c86bc..d5ea84cf6460 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1296,6 +1296,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  	u32 cor = 0;
> +	u16 tmp_val;
>  	int ret;
>  
>  	/*
> @@ -1309,7 +1310,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  
>  		ret = at91_adc_read_position(st, chan->channel,
> -					     (u16 *)val);
> +					     &tmp_val);
> +		*val = tmp_val;
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
> @@ -1322,7 +1324,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  
>  		ret = at91_adc_read_pressure(st, chan->channel,
> -					     (u16 *)val);
> +					     &tmp_val);
> +		*val = tmp_val;
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
