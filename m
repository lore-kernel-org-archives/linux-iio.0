Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdGAJ74 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 05:59:56 -0400
Date: Sat, 1 Jul 2017 10:59:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Allow open drain with anything
Message-ID: <20170701105953.75141cf1@kernel.org>
In-Reply-To: <20170629115704.20717-1-linus.walleij@linaro.org>
References: <20170629115704.20717-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Jun 2017 13:57:04 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> Open drain should work fine with rising or high level IRQs,
> this code was due to some misunderstanding on my part.
Me too ;)

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Reported-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/gyro/mpu3050-core.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 2be2a5d287e6..e0d241a9aa30 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1063,11 +1063,6 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  	case IRQF_TRIGGER_RISING:
>  		dev_info(&indio_dev->dev,
>  			 "pulse interrupts on the rising edge\n");
> -		if (mpu3050->irq_opendrain) {
> -			dev_info(&indio_dev->dev,
> -				 "rising edge incompatible with open drain\n");
> -			mpu3050->irq_opendrain = false;
> -		}
>  		break;
>  	case IRQF_TRIGGER_FALLING:
>  		mpu3050->irq_actl = true;
> @@ -1078,11 +1073,6 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  		mpu3050->irq_latch = true;
>  		dev_info(&indio_dev->dev,
>  			 "interrupts active high level\n");
> -		if (mpu3050->irq_opendrain) {
> -			dev_info(&indio_dev->dev,
> -				 "active high incompatible with open drain\n");
> -			mpu3050->irq_opendrain = false;
> -		}
>  		/*
>  		 * With level IRQs, we mask the IRQ until it is processed,
>  		 * but with edge IRQs (pulses) we can queue several interrupts

