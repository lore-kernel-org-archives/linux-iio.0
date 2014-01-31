Return-Path: <lars@metafoo.de>
Message-ID: <52EB6F18.5070202@metafoo.de>
Date: Fri, 31 Jan 2014 10:38:32 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Sachin Kamat <sachin.kamat@linaro.org>,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio:imu:adis16400 remove an unneeded check
References: <20140130115914.GJ12734@elgon.mountain>
In-Reply-To: <20140130115914.GJ12734@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/30/2014 12:59 PM, Dan Carpenter wrote:
> We know "ret" is zero here so there is no need to check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 368660dfe135..411586f49dae 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -281,7 +281,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
>  	st->variant->set_freq(st, val);
>  	mutex_unlock(&indio_dev->mlock);
>  
> -	return ret ? ret : len;
> +	return len;
>  }
>  
>  /* Power down the device */
> 
