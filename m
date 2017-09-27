Return-Path: <SRS0=fi2I=A4=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: dummy: evgen: use irq_sim
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170926164910.31137-1-brgl@bgdev.pl>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <187e45bf-03ac-1847-de43-92806c36e8ab@metafoo.de>
Date: Wed, 27 Sep 2017 19:12:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170926164910.31137-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/26/2017 06:49 PM, Bartosz Golaszewski wrote:
> Switch to using the recently added interrupt simulator for dummy irqs.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Thanks for doing this.

[...]
>  static int iio_dummy_evgen_create(void)
>  {
> -	int ret, i;
> +	int ret;
>  
>  	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
>  	if (!iio_evgen)
>  		return -ENOMEM;
>  
> -	iio_evgen->base = irq_alloc_descs(-1, 0, IIO_EVENTGEN_NO, 0);
> -	if (iio_evgen->base < 0) {
> -		ret = iio_evgen->base;
> -		kfree(iio_evgen);
> +	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
> +	if (ret)

What happened to the kfree(iio_evgen)?

>  		return ret;
> -	}
> -	iio_evgen->chip.name = iio_evgen_name;
> -	iio_evgen->chip.irq_mask = &iio_dummy_event_irqmask;
> -	iio_evgen->chip.irq_unmask = &iio_dummy_event_irqunmask;
> -	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
> -		irq_set_chip(iio_evgen->base + i, &iio_evgen->chip);
> -		irq_set_handler(iio_evgen->base + i, &handle_simple_irq);
> -		irq_modify_status(iio_evgen->base + i,
> -				  IRQ_NOREQUEST | IRQ_NOAUTOEN,
> -				  IRQ_NOPROBE);
> -	}
> -	init_irq_work(&iio_evgen->handler.work, iio_dummy_work_handler);
> +
> +	iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
I saw you introduced irq_sim_baseirq(), to get rid of ->base. But as far as
I can see the only remaining places where we need the base is to do the
reverse lookup from IRQ to index. It would be nice if the irq_sim had a
function for that, then we wouldn't have to know about the base at all.

>  	mutex_init(&iio_evgen->lock);
> +
>  	return 0;
>  }
>  
> @@ -132,15 +79,17 @@ int iio_dummy_evgen_get_irq(void)
>  		return -ENODEV;
>  
>  	mutex_lock(&iio_evgen->lock);
> -	for (i = 0; i < IIO_EVENTGEN_NO; i++)
> +	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
>  		if (!iio_evgen->inuse[i]) {
> -			ret = iio_evgen->base + i;
> +			ret = irq_sim_irqnum(&iio_evgen->irq_sim, i);
>  			iio_evgen->inuse[i] = true;
>  			break;
>  		}
> +	}
>  	mutex_unlock(&iio_evgen->lock);
>  	if (i == IIO_EVENTGEN_NO)
>  		return -ENOMEM;
> +
>  	return ret;
>  }
