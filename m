Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36086 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1LJQ2S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2011 11:28:18 -0500
Message-ID: <4EE388A3.8030208@kernel.org>
Date: Sat, 10 Dec 2011 16:28:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: Re: [PATCH 1/2] staging:iio: Make sure all triggers have a trigger_ops
 for the owner field.
References: <1323531588-23293-1-git-send-email-jic23@kernel.org> <1323531588-23293-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1323531588-23293-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/2011 03:39 PM, Jonathan Cameron wrote:
> The core needs the owner field to prevent module removal whilst in use and
> uses it without confirming that the trigger_ops structure actually exists.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/ad7192.c |    6 +++++-
>  drivers/staging/iio/adc/ad7793.c |    5 +++++
>  2 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 66cc507..6114601 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -609,6 +609,10 @@ static irqreturn_t ad7192_data_rdy_trig_poll(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static struct iio_trigger_ops ad7192_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
>  static int ad7192_probe_trigger(struct iio_dev *indio_dev)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> @@ -621,7 +625,7 @@ static int ad7192_probe_trigger(struct iio_dev *indio_dev)
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> -
> +	st->trig->ops = &ad7192_trigger_ops;
>  	ret = request_irq(st->spi->irq,
>  			  ad7192_data_rdy_trig_poll,
>  			  IRQF_TRIGGER_LOW,
> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
> index 4047c5d..f33feee 100644
> --- a/drivers/staging/iio/adc/ad7793.c
> +++ b/drivers/staging/iio/adc/ad7793.c
> @@ -475,6 +475,10 @@ static irqreturn_t ad7793_data_rdy_trig_poll(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
Lets just pretend for the point of view of review that this variable
actually had the appropriate name.  Sorry about that..
> +static struct iio_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
>  static int ad7793_probe_trigger(struct iio_dev *indio_dev)
>  {
>  	struct ad7793_state *st = iio_priv(indio_dev);
> @@ -487,6 +491,7 @@ static int ad7793_probe_trigger(struct iio_dev *indio_dev)
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> +	st->trig->ops = &ad7793_trigger_ops;
>  
>  	ret = request_irq(st->spi->irq,
>  			  ad7793_data_rdy_trig_poll,

