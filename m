Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50349 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbbJDMGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 08:06:35 -0400
Subject: Re: [PATCH] Staging: iio: meter: Use devm functions
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <1443933272-23398-1-git-send-email-shraddha.6596@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56111645.3060004@kernel.org>
Date: Sun, 4 Oct 2015 13:06:29 +0100
MIME-Version: 1.0
In-Reply-To: <1443933272-23398-1-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/15 05:34, Shraddha Barke wrote:
> Introduce use of managed resource function devm_iio_trigger_alloc
> instead of iio_trigger_alloc and devm_request_irq instead of request_irq
> Remove corresponding calls to iio_trigger_free and free_irq in the probe
> and remove functions.
> The now unnecessary labels error_free_trig and err_free_irq are dropped.
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> --- 
> 
>  drivers/staging/iio/meter/ade7758_trigger.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index 5b35a7f..e313b37 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -63,21 +63,21 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>  	struct ade7758_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	st->trig = iio_trigger_alloc("%s-dev%d",
> -					spi_get_device_id(st->us)->name,
> -					indio_dev->id);
> +	st->trig = devm_iio_trigger_alloc(&indio_dev->id, "%s-dev%d",
> +					  spi_get_device_id(st->us)->name,
> +					  indio_dev->id);
>  	if (!st->trig) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
>  
> -	ret = request_irq(st->us->irq,
> -			  ade7758_data_rdy_trig_poll,
> -			  IRQF_TRIGGER_LOW,
> -			  spi_get_device_id(st->us)->name,
> -			  st->trig);
> +	ret = devm_request_irq(&indio_dev->dev, st->us->irq,
> +			       ade7758_data_rdy_trig_poll,
> +			       IRQF_TRIGGER_LOW,
> +			       spi_get_device_id(st->us)->name,
> +			       st->trig);
>  	if (ret)
> -		goto error_free_trig;
> +		goto error_ret
>  
>  	st->trig->dev.parent = &st->us->dev;
>  	st->trig->ops = &ade7758_trigger_ops;
> @@ -87,14 +87,10 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>  	/* select default trigger */
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  	if (ret)
> -		goto error_free_irq;
> +		goto error_ret;
>  
>  	return 0;
>  
> -error_free_irq:
> -	free_irq(st->us->irq, st->trig);
> -error_free_trig:
> -	iio_trigger_free(st->trig);
>  error_ret:
>  	return ret;
Whilst you are here, direct returns are preferred when there is no unwinding to do
so if you could just return the error from anywhere it does the goto error_ret
that would be great!

Thanks,

Jonathan
>  }
> @@ -104,6 +100,4 @@ void ade7758_remove_trigger(struct iio_dev *indio_dev)
>  	struct ade7758_state *st = iio_priv(indio_dev);
>  
>  	iio_trigger_unregister(st->trig);
> -	free_irq(st->us->irq, st->trig);
> -	iio_trigger_free(st->trig);
>  }
> 

