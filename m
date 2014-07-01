Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:57489 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995AbaGAUZI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Jul 2014 16:25:08 -0400
Message-ID: <53B3191C.3050706@gmx.de>
Date: Tue, 01 Jul 2014 22:25:00 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Himangi Saraogi <himangi774@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:trigger: Introduce the use of devm_kzalloc
References: <20140701183858.GA2939@himangi-Dell>
In-Reply-To: <20140701183858.GA2939@himangi-Dell>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Himangi Saraogi schrieb:
> This patch introduces the use of the managed version of kzalloc and
> removes the kfrees in the probe and remove functions. Also, the labels
> are renamed to order them.
Since you are already on it, better drop label "out" and return the errorcode immediately after checking for errors.
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 16f1a06..cc858aa 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -182,7 +182,7 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  	unsigned int config;
>  	int ret;
>  
> -	st = kzalloc(sizeof(*st), GFP_KERNEL);
> +	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
>  	if (st == NULL) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -192,12 +192,12 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  	if (!st->irq) {
>  		dev_err(&pdev->dev, "No IRQs specified");
>  		ret = -ENODEV;
> -		goto out1;
> +		goto out;
>  	}
>  
>  	ret = iio_bfin_tmr_get_number(st->irq);
>  	if (ret < 0)
> -		goto out1;
> +		goto out;
>  
>  	st->timer_num = ret;
>  	st->t = &iio_bfin_timer_code[st->timer_num];
> @@ -205,7 +205,7 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  	st->trig = iio_trigger_alloc("bfintmr%d", st->timer_num);
>  	if (!st->trig) {
>  		ret = -ENOMEM;
> -		goto out1;
> +		goto out;
>  	}
>  
>  	st->trig->ops = &iio_bfin_tmr_trigger_ops;
> @@ -213,14 +213,14 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  	iio_trigger_set_drvdata(st->trig, st);
>  	ret = iio_trigger_register(st->trig);
>  	if (ret)
> -		goto out2;
> +		goto out1;
>  
>  	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
>  			  0, st->trig->name, st);
>  	if (ret) {
>  		dev_err(&pdev->dev,
>  			"request IRQ-%d failed", st->irq);
> -		goto out4;
> +		goto out2;
>  	}
>  
>  	config = PWM_OUT | PERIOD_CNT | IRQ_ENA;
> @@ -260,12 +260,10 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  	return 0;
>  out_free_irq:
>  	free_irq(st->irq, st);
> -out4:
> -	iio_trigger_unregister(st->trig);
>  out2:
> -	iio_trigger_put(st->trig);
> +	iio_trigger_unregister(st->trig);
>  out1:
> -	kfree(st);
> +	iio_trigger_put(st->trig);
>  out:
>  	return ret;
>  }
> @@ -280,7 +278,6 @@ static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
>  	free_irq(st->irq, st);
>  	iio_trigger_unregister(st->trig);
>  	iio_trigger_put(st->trig);
> -	kfree(st);
>  
>  	return 0;
>  }

