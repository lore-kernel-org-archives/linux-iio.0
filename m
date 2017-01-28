Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45248 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdA1MSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 07:18:13 -0500
Subject: Re: [PATCH] drivers:staging:iio:cdc: Style fix.
To: Anthony Brandon <anthony@amarulasolutions.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org
References: <1485177252-22447-1-git-send-email-anthony@amarulasolutions.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <827661e4-f936-6e1d-3a63-0f1691e0f395@kernel.org>
Date: Sat, 28 Jan 2017 12:18:11 +0000
MIME-Version: 1.0
In-Reply-To: <1485177252-22447-1-git-send-email-anthony@amarulasolutions.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/17 13:14, Anthony Brandon wrote:
> Align parameters to parentheses.
> 
> Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7150.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index c886751..ca72af3 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -610,27 +610,27 @@ static int ad7150_probe(struct i2c_client *client,
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> -					   NULL,
> -					   &ad7150_event_handler,
> -					   IRQF_TRIGGER_RISING |
> -					   IRQF_TRIGGER_FALLING |
> -					   IRQF_ONESHOT,
> -					   "ad7150_irq1",
> -					   indio_dev);
> +						NULL,
> +						&ad7150_event_handler,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"ad7150_irq1",
> +						indio_dev);
>  		if (ret)
>  			return ret;
>  	}
>  
>  	if (client->dev.platform_data) {
>  		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
> -					   client->dev.platform_data,
> -					   NULL,
> -					   &ad7150_event_handler,
> -					   IRQF_TRIGGER_RISING |
> -					   IRQF_TRIGGER_FALLING |
> -					   IRQF_ONESHOT,
> -					   "ad7150_irq2",
> -					   indio_dev);
> +						client->dev.platform_data,
> +						NULL,
> +						&ad7150_event_handler,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"ad7150_irq2",
> +						indio_dev);
>  		if (ret)
>  			return ret;
>  	}
> 

