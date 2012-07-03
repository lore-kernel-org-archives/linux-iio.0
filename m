Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56055 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2GCTkv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 15:40:51 -0400
Message-ID: <4FF34AC0.2050809@kernel.org>
Date: Tue, 03 Jul 2012 20:40:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Request threaded-only IRQs with IRQF_ONESHOT
References: <1341219285-2941-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1341219285-2941-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2012 09:54 AM, Lars-Peter Clausen wrote:
> Since commit 1c6c69525b ("genirq: Reject bogus threaded irq requests") threaded
> IRQs without a primary handler need to be requested with IRQF_ONESHOT, otherwise
> the request will fail. This patch adds the IRQF_ONESHOT to IIO drivers where it
> is missing.
> 
ouch.  Thanks for clearing these up.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged into fixes
> ---
>  drivers/staging/iio/accel/sca3000_core.c |    2 +-
>  drivers/staging/iio/adc/ad7816.c         |    2 +-
>  drivers/staging/iio/adc/adt7310.c        |    5 +++--
>  drivers/staging/iio/adc/adt7410.c        |    5 +++--
>  drivers/staging/iio/cdc/ad7150.c         |    6 ++++--
>  5 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 6ec5c20..c218d71 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -1189,7 +1189,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
>  		ret = request_threaded_irq(spi->irq,
>  					   NULL,
>  					   &sca3000_event_handler,
> -					   IRQF_TRIGGER_FALLING,
> +					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					   "sca3000",
>  					   indio_dev);
>  		if (ret)
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 5356b09..c5fb947 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -402,7 +402,7 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
>  		ret = request_threaded_irq(spi_dev->irq,
>  					   NULL,
>  					   &ad7816_event_handler,
> -					   IRQF_TRIGGER_LOW,
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					   indio_dev->name,
>  					   indio_dev);
>  		if (ret)
> diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
> index e5f1ed7..44dcf63 100644
> --- a/drivers/staging/iio/adc/adt7310.c
> +++ b/drivers/staging/iio/adc/adt7310.c
> @@ -778,7 +778,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
>  		ret = request_threaded_irq(spi_dev->irq,
>  					   NULL,
>  					   &adt7310_event_handler,
> -					   irq_flags,
> +					   irq_flags | IRQF_ONESHOT,
>  					   indio_dev->name,
>  					   indio_dev);
>  		if (ret)
> @@ -790,7 +790,8 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
>  		ret = request_threaded_irq(adt7310_platform_data[0],
>  					   NULL,
>  					   &adt7310_event_handler,
> -					   adt7310_platform_data[1],
> +					   adt7310_platform_data[1] |
> +					   IRQF_ONESHOT,
>  					   indio_dev->name,
>  					   indio_dev);
>  		if (ret)
> diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
> index 917b692..a2defe6 100644
> --- a/drivers/staging/iio/adc/adt7410.c
> +++ b/drivers/staging/iio/adc/adt7410.c
> @@ -742,7 +742,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
>  		ret = request_threaded_irq(client->irq,
>  					   NULL,
>  					   &adt7410_event_handler,
> -					   IRQF_TRIGGER_LOW,
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					   id->name,
>  					   indio_dev);
>  		if (ret)
> @@ -754,7 +754,8 @@ static int __devinit adt7410_probe(struct i2c_client *client,
>  		ret = request_threaded_irq(adt7410_platform_data[0],
>  					   NULL,
>  					   &adt7410_event_handler,
> -					   adt7410_platform_data[1],
> +					   adt7410_platform_data[1] |
> +					   IRQF_ONESHOT,
>  					   id->name,
>  					   indio_dev);
>  		if (ret)
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index a16d1a2..6a40414 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -585,7 +585,8 @@ static int __devinit ad7150_probe(struct i2c_client *client,
>  					   NULL,
>  					   &ad7150_event_handler,
>  					   IRQF_TRIGGER_RISING |
> -					   IRQF_TRIGGER_FALLING,
> +					   IRQF_TRIGGER_FALLING |
> +					   IRQF_ONESHOT,
>  					   "ad7150_irq1",
>  					   indio_dev);
>  		if (ret)
> @@ -598,7 +599,8 @@ static int __devinit ad7150_probe(struct i2c_client *client,
>  					   NULL,
>  					   &ad7150_event_handler,
>  					   IRQF_TRIGGER_RISING |
> -					   IRQF_TRIGGER_FALLING,
> +					   IRQF_TRIGGER_FALLING |
> +					   IRQF_ONESHOT,
>  					   "ad7150_irq2",
>  					   indio_dev);
>  		if (ret)
> 


