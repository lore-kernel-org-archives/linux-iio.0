Return-Path: <lars@metafoo.de>
Message-ID: <52EB6EF4.9020203@metafoo.de>
Date: Fri, 31 Jan 2014 10:37:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
 Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: dac: ad7303: remove an unneeded check
References: <20140130115849.GI12734@elgon.mountain>
In-Reply-To: <20140130115849.GI12734@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/30/2014 12:58 PM, Dan Carpenter wrote:
> "ret" is zero here.  There is no need to check again.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index d0505fd22ef4..fa2810032968 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -92,7 +92,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>  	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
>  
>  	mutex_unlock(&indio_dev->mlock);
> -	return ret ? ret : len;
> +	return len;
>  }
>  
>  static int ad7303_get_vref(struct ad7303_state *st,
> 
