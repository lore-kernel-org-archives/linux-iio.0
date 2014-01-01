Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46263 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbaAAND3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2014 08:03:29 -0500
Message-ID: <52C4121F.2020700@kernel.org>
Date: Wed, 01 Jan 2014 13:03:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH]staging:iio:ad799x use devm_request_threaded_irq
References: <52C00CC5.3030209@gmx.de>
In-Reply-To: <52C00CC5.3030209@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 29/12/13 11:51, Hartmut Knaack wrote:
> Move to devm_request_threaded_irq to make device-removal easier, and also fix
> error_free_irq, which did not check if an irq was requested at all.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Hi Hartmut,

Please break this into two patches - the first fixing the irq check 
(whilst it will go away in the second patch - we will probably want to 
push the fix to stable, and can't do that with the other change in here).

On the devm_request_threaded_irq usage, this is often considered 
dangerous as it changes the ordering of resource freeing so that it
doesn't match that of allocation.  Here I think you are fine, but
haven't looked into that closely yet.

Lars, do you think this is a good idea?
(any chance you are planning to get this driver out of staging any time 
soon? :)
> ---
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index e32a555..bc886f6 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -573,24 +573,23 @@ static int ad799x_probe(struct i2c_client *client,
>   		goto error_disable_reg;
>
>   	if (client->irq > 0) {
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
>   		if (ret)
>   			goto error_cleanup_ring;
>   	}
>   	ret = iio_device_register(indio_dev);
>   	if (ret)
> -		goto error_free_irq;
> +		goto error_cleanup_ring;
>
>   	return 0;
>
> -error_free_irq:
> -	free_irq(client->irq, indio_dev);
>   error_cleanup_ring:
>   	ad799x_ring_cleanup(indio_dev);
>   error_disable_reg:
> @@ -606,8 +605,6 @@ static int ad799x_remove(struct i2c_client *client)
>   	struct ad799x_state *st = iio_priv(indio_dev);
>
>   	iio_device_unregister(indio_dev);
> -	if (client->irq > 0)
> -		free_irq(client->irq, indio_dev);
>
>   	ad799x_ring_cleanup(indio_dev);
>   	if (!IS_ERR(st->reg))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
