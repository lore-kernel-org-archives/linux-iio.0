Return-Path: <SRS0=u8Kw=AP=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: iio: ad7192: Use the dedicated reset function
To: Stefan Popa <stefan.popa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e93ea83e-aa94-885b-4686-2e2873ef1efa@metafoo.de>
Date: Thu, 14 Sep 2017 15:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/14/2017 03:50 PM, Stefan Popa wrote:
> SPI host drivers can use DMA to transfer data, so the buffer should be properly allocated.
> Keeping it on the stack could cause an undefined behavior.
> 
> The dedicated reset function solves this issue.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  drivers/staging/iio/adc/ad7192.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de..6150d27 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -223,11 +223,9 @@ static int ad7192_setup(struct ad7192_state *st,
>  	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
>  	unsigned long long scale_uv;
>  	int i, ret, id;
> -	u8 ones[6];
>  
>  	/* reset the serial interface */
> -	memset(&ones, 0xFF, 6);
> -	ret = spi_write(st->sd.spi, &ones, 6);
> +	ret = ad_sd_reset(&st->sd, 48);
>  	if (ret < 0)
>  		goto out;
>  	usleep_range(500, 1000); /* Wait for at least 500us */
> 
