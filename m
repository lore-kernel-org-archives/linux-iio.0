Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeIPQjb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 12:39:31 -0400
Date: Sun, 16 Sep 2018 12:16:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] staging:iio:ad7606: update api calls to devm_* variants
Message-ID: <20180916121649.73a46c2f@archlinux>
In-Reply-To: <20180913095138.18427-1-alexandru.ardelean@analog.com>
References: <20180913095138.18427-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Sep 2018 12:51:38 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> No significant functional changes. This just replaces the code with devm_*
> that reduce the driver code, and simplifies some error code paths in the
> ad7606_probe() function.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Sometimes there are reasons why devm functions aren't used. They are almost
always about potential races in remove paths and that is definitely the case
here.  Suggestions inline on how to avoid that problem.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 87d5fb073c95..793de92f27ed 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -458,28 +458,25 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
> -	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
> -			  indio_dev);
> +	ret = devm_request_irq(dev, irq, ad7606_interrupt,
> +			       IRQF_TRIGGER_FALLING,
> +			       name, indio_dev);
You cannot safely mix devm and non devm setup.  In this case you end up
with an interesting race around when the regulator is turned off resulting
in the device being powered down before the interrupt is released.

Now, that might be fine, but it's really hard to be sure when reviewing so
as a rule of thumb we never allow non obvious ordering.

Now, one option for this is to use devm_add_action to automatically call
the cleanup in the right sequence when remove occurs.

>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
> -					 NULL, NULL);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &ad7606_trigger_handler,
> +					      NULL, NULL);
>  	if (ret)
> -		goto error_free_irq;
> +		goto error_disable_reg;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> -		goto error_unregister_ring;
> +		goto error_disable_reg;
Definitely not on this one.  The power will be cut before the interfaces
are removed.  That one is definitely going to be a nasty race condition!

>  
>  	dev_set_drvdata(dev, indio_dev);
>  
>  	return 0;
> -error_unregister_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -error_free_irq:
> -	free_irq(irq, indio_dev);
>  
>  error_disable_reg:
>  	regulator_disable(st->reg);
> @@ -492,10 +489,6 @@ int ad7606_remove(struct device *dev, int irq)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	free_irq(irq, indio_dev);
>  	regulator_disable(st->reg);
>  
>  	return 0;
