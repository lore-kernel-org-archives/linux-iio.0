Return-Path: <lars@metafoo.de>
Message-ID: <52C9823C.6030606@metafoo.de>
Date: Sun, 05 Jan 2014 17:03:08 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V2 1/2]staging:iio:ad799x fix error_free_irq, use devm_request_threaded_irq
References: <52C49F06.3010505@gmx.de>
In-Reply-To: <52C49F06.3010505@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

On 01/02/2014 12:04 AM, Hartmut Knaack wrote:
> Only free an IRQ in error_free_irq, if it has been requested previously.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index e32a555..3deb390 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -590,7 +590,8 @@ static int ad799x_probe(struct i2c_client *client,
>  	return 0;
>  
>  error_free_irq:
> -	free_irq(client->irq, indio_dev);
> +	if (client->irq > 0)
> +		free_irq(client->irq, indio_dev);
>  error_cleanup_ring:
>  	ad799x_ring_cleanup(indio_dev);
>  error_disable_reg:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
