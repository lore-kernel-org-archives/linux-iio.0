Return-Path: <lars@metafoo.de>
Message-ID: <4EAD2A97.8090103@metafoo.de>
Date: Sun, 30 Oct 2011 11:44:39 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Greg Kroah-Hartman <gregkh@suse.de>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] Staging: iio/dac/ad5064.c: signedness bug in ad5064_read_raw()
References: <20111029072042.GC17780@elgon.mountain>
In-Reply-To: <20111029072042.GC17780@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/29/2011 09:20 AM, Dan Carpenter wrote:
> regulator_get_voltage() returns an int so "scale_uv" should be an
> int.  Making it unsigned here breaks the error handling.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

uhm, yes...

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> 
> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
> index 24279f2..3b14526 100644
> --- a/drivers/staging/iio/dac/ad5064.c
> +++ b/drivers/staging/iio/dac/ad5064.c
> @@ -280,8 +280,8 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad5064_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  	unsigned int vref;
> +	int scale_uv;
>  
>  	switch (m) {
>  	case 0:
