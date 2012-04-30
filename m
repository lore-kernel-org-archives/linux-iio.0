Return-Path: <lars@metafoo.de>
Message-ID: <4F9EDAAD.50703@metafoo.de>
Date: Mon, 30 Apr 2012 20:32:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: joseph daniel <josephdanielwalter@gmail.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wolfram Sang <w.sang@pengutronix.de>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/iio/meter: fix the coding style problem
References: <1335810080-30717-1-git-send-email-josephdanielwalter@gmail.com>
In-Reply-To: <1335810080-30717-1-git-send-email-josephdanielwalter@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/30/2012 08:21 PM, joseph daniel wrote:
> Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
> ---
>  Please consider this patch, previous one is wrong because my
>  tabspace in vim was 4, instead 8. sorry..
> 
>  drivers/staging/iio/meter/ade7854-i2c.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 1e1faa0..ba97d6e 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -195,7 +195,10 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	if (ret)
>  		goto out;
>  
> -	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
> +	*val =  (st->rx[0] << 24) |
> +		(st->rx[1] << 16) |
> +		(st->rx[2] << 8)  |
> +		 st->rx[3];

Nack. In my opinion this doesn't make the code more readable. 80 chars per line
should be though of as a softlimit.

But this looks like something that could use be32_to_cpu though.

>  out:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
