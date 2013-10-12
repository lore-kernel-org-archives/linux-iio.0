Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-035.synserver.de ([212.40.185.35]:1233 "EHLO
	smtp-out-035.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3JLJy3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 05:54:29 -0400
Message-ID: <52591CCB.7010001@metafoo.de>
Date: Sat, 12 Oct 2013 11:56:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, michael.hennerich@analog.com,
	gregkh@linuxfoundation.org, sachin.kamat@linaro.org,
	yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4350: add missing clk_disable_unprepare()
 on error in adf4350_probe()
References: <CAPgLHd_jFVRUj4RYUi_Z-bw=+zM+YrKbvRPz-Dhiw0eCuQXKDw@mail.gmail.com>
In-Reply-To: <CAPgLHd_jFVRUj4RYUi_Z-bw=+zM+YrKbvRPz-Dhiw0eCuQXKDw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/2013 08:46 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return
> from adf4350_probe() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Lars-Peter CLausen <lars@metafoo.de>

Thanks.

> ---
>  drivers/iio/frequency/adf4350.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index a7b30be..52605c0 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -525,8 +525,10 @@ static int adf4350_probe(struct spi_device *spi)
>  	}
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (indio_dev == NULL)
> -		return -ENOMEM;
> +	if (indio_dev == NULL) {
> +		ret =  -ENOMEM;

Here is a extra space. Jonathan can you clean this up when applying the
patch? Thanks.

> +		goto error_disable_clk;
> +	}
>  
>  	st = iio_priv(indio_dev);
>  
> 

