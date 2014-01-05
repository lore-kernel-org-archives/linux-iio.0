Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-019.synserver.de ([212.40.185.19]:1032 "EHLO
	smtp-out-079.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751112AbaAEQFZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jan 2014 11:05:25 -0500
Message-ID: <52C982DB.1010703@metafoo.de>
Date: Sun, 05 Jan 2014 17:05:47 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V2 2/2]staging:iio:ad799x fix error_free_irq, use devm_request_threaded_irq
References: <52C49EED.5000206@gmx.de>
In-Reply-To: <52C49EED.5000206@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/2014 12:04 AM, Hartmut Knaack wrote:
> Move to devm_request_threaded_irq to make device-removal easier.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

I'm not a fan of devm_request_threaded_irq() since it makes it easy to get
things wrong. But well.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 3deb390..bc886f6 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -573,25 +573,23 @@ static int ad799x_probe(struct i2c_client *client,
>  		goto error_disable_reg;
>  
>  	if (client->irq > 0) {
> -		ret = request_threaded_irq(client->irq,
> -					   NULL,
> -					   ad799x_event_handler,
> -					   IRQF_TRIGGER_FALLING |
> -					   IRQF_ONESHOT,
> -					   client->name,
> -					   indio_dev);
> +		ret = devm_request_threaded_irq(&client->dev,
> +						client->irq,
> +						NULL,
> +						ad799x_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						client->name,
> +						indio_dev);
>  		if (ret)
>  			goto error_cleanup_ring;
>  	}
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_irq;
> +		goto error_cleanup_ring;
>  
>  	return 0;
>  
> -error_free_irq:
> -	if (client->irq > 0)
> -		free_irq(client->irq, indio_dev);
>  error_cleanup_ring:
>  	ad799x_ring_cleanup(indio_dev);
>  error_disable_reg:
> @@ -607,8 +605,6 @@ static int ad799x_remove(struct i2c_client *client)
>  	struct ad799x_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (client->irq > 0)
> -		free_irq(client->irq, indio_dev);
>  
>  	ad799x_ring_cleanup(indio_dev);
>  	if (!IS_ERR(st->reg))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

