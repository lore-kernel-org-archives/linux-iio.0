Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJR1i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 12:27:38 -0500
Date: Sun, 10 Dec 2017 17:27:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>
Subject: Re: [PATCH v1 3/7] iio: adc: ina2xx: Remove unneeded dummy read to
 clear CNVR flag
Message-ID: <20171210172733.4adaae77@archlinux>
In-Reply-To: <ed9716c7-5e15-461a-985c-eea93257928c@rwthex-w2-a.rwth-ad.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <ed9716c7-5e15-461a-985c-eea93257928c@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 18:41:48 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Although the datasheet states the CNVR flag is cleared by reading the
> BUS_VOLTAGE register, it is actually cleared by reading any of the
> voltage/current/power registers.
> 
> The behaviour has been confirmed by TI support:
> http://e2e.ti.com/support/amplifiers/current-shunt-monitors/f/931/p/647053/2378282
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

I haven't checked the code thoroughly so there may well be something stopping it
but have you checked the case where the only channel enabled is the timestamp?

Obviously it makes little sense, but IIRC there is nothing in the core preventing
that happening.

Jonathan
> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 8c8120406f52..b027d485398b 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -705,7 +705,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	int bit, ret, i = 0;
>  	s64 time_a, time_b;
>  	unsigned int alert;
> -	int cnvr_need_clear = 0;
>  
>  	time_a = iio_get_time_ns(indio_dev);
>  
> @@ -730,7 +729,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  				ret = regmap_read(chip->regmap,
>  						  INA2XX_BUS_VOLTAGE, &alert);
>  				alert &= INA219_CNVR;
> -				cnvr_need_clear = alert;
>  			}
>  
>  			if (ret < 0)
> @@ -752,18 +750,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  			return ret;
>  
>  		data[i++] = val;
> -
> -		if (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_POWER)
> -			cnvr_need_clear = 0;
> -	}
> -
> -	/* Dummy read on INA219 power register to clear CNVR flag */
> -	if (cnvr_need_clear && chip->config->chip_id == ina219) {
> -		unsigned int val;
> -
> -		ret = regmap_read(chip->regmap, INA2XX_POWER, &val);
> -		if (ret < 0)
> -			return ret;
>  	}
>  
>  	time_b = iio_get_time_ns(indio_dev);

