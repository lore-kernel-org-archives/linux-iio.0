Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbdLQLyD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Dec 2017 06:54:03 -0500
Date: Sun, 17 Dec 2017 11:53:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>
Subject: Re: [PATCH v1 4/7] iio: adc: ina2xx: Do not udelay for several
 seconds
Message-ID: <20171217115358.2d22ba3e@archlinux>
In-Reply-To: <44807977-8b46-4678-b8e5-440ff8208062@rwthex-w2-a.rwth-ad.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <44807977-8b46-4678-b8e5-440ff8208062@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 18:41:49 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> The conversion time can be up to 16 seconds (8 ms per channel, 2 channels,
> 1024 times averaging).
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied
> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index b027d485398b..2621a34ee5c6 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -764,7 +764,7 @@ static int ina2xx_capture_thread(void *data)
>  	struct iio_dev *indio_dev = data;
>  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>  	int sampling_us = SAMPLING_PERIOD(chip);
> -	int buffer_us;
> +	int buffer_us, delay_us;
>  
>  	/*
>  	 * Poll a bit faster than the chip internal Fs, in case
> @@ -778,8 +778,10 @@ static int ina2xx_capture_thread(void *data)
>  		if (buffer_us < 0)
>  			return buffer_us;
>  
> -		if (sampling_us > buffer_us)
> -			udelay(sampling_us - buffer_us);
> +		if (sampling_us > buffer_us) {
> +			delay_us = sampling_us - buffer_us;
> +			usleep_range(delay_us, (delay_us * 3) >> 1);
> +		}
>  
>  	} while (!kthread_should_stop());
>  

