Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45539 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753954AbcICRZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 13:25:33 -0400
Subject: Re: [PATCH 1/3] iio: trigger: helpers to determine own trigger
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2532a6d4-f607-bfe9-dccf-2161aeb867a5@kernel.org>
Date: Sat, 3 Sep 2016 18:24:49 +0100
MIME-Version: 1.0
In-Reply-To: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/16 09:27, Linus Walleij wrote:
> This adds a helper function to the IIO trigger framework:
> 
> iio_trigger_using_own(): for an IIO device, this tells
>   whether the device is using itself as a trigger.
>   This is true if the indio device:
>   (A) supplies a trigger and
>   (B) has assigned its own buffer poll function to use this
>       trigger.
> 
> This helper function is good when constructing triggered,
> buffered drivers that can either use its own hardware *OR*
> an external trigger such as a HRTimer or even the trigger from
> a totally different sensor.
> 
> Under such circumstances it is important to know for example
> if the timestamp from the same trigger hardware should be used
> when populating the buffer: if iio_trigger_using_own() is true,
> we can use this timestamp, else we need to pick a unique
> timestamp directly in the trigger handler.
> 
> For this to work of course IIO devices registering hardware
> triggers must follow the convention to set the parent device
> properly, as as well as setting the parent of the IIO device
> itself.
> 
> When a new poll function is attached, we check if the parent
> device of the IIO of the poll function is the same as the
> parent device of the trigger and in that case we conclude that
> the hardware is using itself as trigger.
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Looks good to me, but I'll hold back on this one until we
have your driver in.

Kick me if I forget about it.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-trigger.c | 16 ++++++++++++++++
>  include/linux/iio/trigger.h        | 11 +++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 7ad82fdd3e5b..866d86832c50 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -255,6 +255,14 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  			goto out_free_irq;
>  	}
>  
> +	/*
> +	 * Check if we just registered to our own trigger: we determine that
> +	 * this is the case if the IIO device and the trigger device share the
> +	 * same parent device.
> +	 */
> +	if (pf->indio_dev->dev.parent == trig->dev.parent)
> +		trig->attached_own_device = true;
I guess that's valid in all cases.  Was trying to think if we'd ever
have a more complex relationship but I don't think so...
> +
>  	return ret;
>  
>  out_free_irq:
> @@ -279,6 +287,8 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>  		if (ret)
>  			return ret;
>  	}
> +	if (pf->indio_dev->dev.parent == trig->dev.parent)
> +		trig->attached_own_device = false;
>  	iio_trigger_put_irq(trig, pf->irq);
>  	free_irq(pf->irq, pf);
>  	module_put(pf->indio_dev->info->driver_module);
> @@ -622,6 +632,12 @@ void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig)
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_trigger_free);
>  
> +bool iio_trigger_using_own(struct iio_dev *indio_dev)
> +{
> +	return indio_dev->trig->attached_own_device;
> +}
> +EXPORT_SYMBOL(iio_trigger_using_own);
> +
>  void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>  {
>  	indio_dev->groups[indio_dev->groupcounter++] =
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 1c9e028e0d4a..6e935ab0a47f 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -56,6 +56,9 @@ struct iio_trigger_ops {
>   * @subirqs:		[INTERN] information about the 'child' irqs.
>   * @pool:		[INTERN] bitmap of irqs currently in use.
>   * @pool_lock:		[INTERN] protection of the irq pool.
> + * @attached_own_device:[INTERN] if we are using our own device as trigger,
> + *			i.e. if we registered a poll function to the same
> + *			device as the one providing the trigger.
>   **/
>  struct iio_trigger {
>  	const struct iio_trigger_ops	*ops;
> @@ -73,6 +76,7 @@ struct iio_trigger {
>  	struct iio_subirq subirqs[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
>  	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
>  	struct mutex			pool_lock;
> +	bool				attached_own_device;
>  };
>  
>  
> @@ -145,6 +149,13 @@ irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
>  __printf(1, 2) struct iio_trigger *iio_trigger_alloc(const char *fmt, ...);
>  void iio_trigger_free(struct iio_trigger *trig);
>  
> +/**
> + * iio_trigger_using_own() - tells us if we use our own HW trigger ourselves
> + * @indio_dev:  device to check
> + */
> +bool iio_trigger_using_own(struct iio_dev *indio_dev);
> +
> +
>  #else
>  struct iio_trigger;
>  struct iio_trigger_ops;
> 

