Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35294 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1EKPpq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2011 11:45:46 -0400
Message-ID: <4DCAAFC4.7080701@cam.ac.uk>
Date: Wed, 11 May 2011 16:48:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/6] IIO-work: meter: ade7758: Update trigger to the new
 API
References: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,

Thanks for doing this so quickly.

I've bashed the various patches into the iio-onwards master branch.
It required a few trivial back ports the forward ports again to maintain
building all the way through the core changes.  Nothing significant, but
you may want to take a quick look to make sure the result is right!
(I've just pushed so usual delay before it hits the front end machines).

Now all I need to do is persuade someone to pick up the irq exports
that are needed for the second half of the tree...  I'd like to push it
in one go because the main benefits of the chan spec stuff only make sense
once the irq related changes and buffer simplifications are there as well.

(of course I'm still open to reviews / acks, particularly wrt to the core
changes).

Thanks,

Jonathan

I've acked / signed off on all of these depending on whether I did any
significant munging on them...

> Update trigger to the new API.
> Add file comment/license header.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/meter/ade7758_trigger.c |   43 ++++++++++----------------
>  1 files changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index 0adfcc6..f792ccd 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -1,3 +1,11 @@
> +/*
> + * ADE7758 Poly Phase Multifunction Energy Metering IC driver
> + *
> + * Copyright 2010-2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/mutex.h>
> @@ -19,20 +27,10 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
>  {
>  	disable_irq_nosync(irq);
>  	iio_trigger_poll(private, iio_get_time_ns());
> +
>  	return IRQ_HANDLED;
>  }
>  
> -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> -
> -static struct attribute *ade7758_trigger_attrs[] = {
> -	&dev_attr_name.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ade7758_trigger_attr_group = {
> -	.attrs = ade7758_trigger_attrs,
> -};
> -
>  /**
>   * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
>   **/
> @@ -53,6 +51,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  static int ade7758_trig_try_reen(struct iio_trigger *trig)
>  {
>  	struct ade7758_state *st = trig->private_data;
> +
>  	enable_irq(st->us->irq);
>  	/* irq reenabled so success! */
>  	return 0;
> @@ -63,43 +62,36 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>  	int ret;
>  	struct ade7758_state *st = indio_dev->dev_data;
>  
> -
> -	st->trig = iio_allocate_trigger();
> +	st->trig = iio_allocate_trigger("%s-dev%d",
> +		      spi_get_device_id(st->us)->name,
> +		      indio_dev->id);
>  	if (st->trig == NULL) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> +
>  	ret = request_irq(st->us->irq,
>  			  ade7758_data_rdy_trig_poll,
> -			  IRQF_TRIGGER_FALLING, "ade7758",
> +			  IRQF_TRIGGER_LOW,
> +			  spi_get_device_id(st->us)->name,
>  			  st->trig);
>  	if (ret)
>  		goto error_free_trig;
>  
> -	st->trig->name = kasprintf(GFP_KERNEL,
> -				"ade7758-dev%d",
> -				indio_dev->id);
> -	if (!st->trig->name) {
> -		ret = -ENOMEM;
> -		goto error_free_irq;
> -	}
>  	st->trig->dev.parent = &st->us->dev;
>  	st->trig->owner = THIS_MODULE;
>  	st->trig->private_data = st;
>  	st->trig->set_trigger_state = &ade7758_data_rdy_trigger_set_state;
>  	st->trig->try_reenable = &ade7758_trig_try_reen;
> -	st->trig->control_attrs = &ade7758_trigger_attr_group;
>  	ret = iio_trigger_register(st->trig);
>  
>  	/* select default trigger */
>  	indio_dev->trig = st->trig;
>  	if (ret)
> -		goto error_free_trig_name;
> +		goto error_free_irq;
>  
>  	return 0;
>  
> -error_free_trig_name:
> -	kfree(st->trig->name);
>  error_free_irq:
>  	free_irq(st->us->irq, st->trig);
>  error_free_trig:
> @@ -113,7 +105,6 @@ void ade7758_remove_trigger(struct iio_dev *indio_dev)
>  	struct ade7758_state *state = indio_dev->dev_data;
>  
>  	iio_trigger_unregister(state->trig);
> -	kfree(state->trig->name);
>  	free_irq(state->us->irq, state->trig);
>  	iio_free_trigger(state->trig);
>  }

