Return-Path: <lars@metafoo.de>
Message-ID: <4EAD2AB4.1010009@metafoo.de>
Date: Sun, 30 Oct 2011 11:45:08 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] Staging: iio/dac/ad5360.c: signedness bug in ad5360_read_raw()
References: <20111029072106.GD17780@elgon.mountain>
In-Reply-To: <20111029072106.GD17780@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/29/2011 09:21 AM, Dan Carpenter wrote:
> ad5360_get_channel_vref() returns an int and scale_uv should be the
> same.  Making it unsigned here breaks the error handling.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
> index 72d0f3f..cfeea72 100644
> --- a/drivers/staging/iio/dac/ad5360.c
> +++ b/drivers/staging/iio/dac/ad5360.c
> @@ -371,8 +371,8 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad5360_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  	unsigned int ofs_index;
> +	int scale_uv;
>  	int ret;
>  
>  	switch (m) {
