Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53665 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJVRLk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:11:40 -0400
Subject: Re: [PATCH 13/13] staging:iio:ad7606: Move buffer code to main source
 file
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-14-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <df5cf37f-79e7-c813-0f9e-7a1ad30af30b@kernel.org>
Date: Sat, 22 Oct 2016 18:11:38 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-14-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:07, Lars-Peter Clausen wrote:
> Currently the ad7606 buffer handling code resides in its own source file.
> But this file contains only 4 small functions of which half are just
> wrappers around other functions. Buffer support is also always enabled for
> this driver, so move them over to the main source file. This reduces the
> amount of boilerplate code.
> 
> Also rename the main function from ad7606_core.c to ad7606.c since there is
> only a single file now.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.  

A nice bit of cleanup work. It'll stop me moaning about the other
ADI drivers you made the error of taking responsibility for that
are still in staging ;) (for a week or so anyway)

Jonathan
> ---
>  drivers/staging/iio/adc/Makefile                   |  1 -
>  .../staging/iio/adc/{ad7606_core.c => ad7606.c}    | 49 +++++++++++++--
>  drivers/staging/iio/adc/ad7606.h                   |  5 --
>  drivers/staging/iio/adc/ad7606_ring.c              | 69 ----------------------
>  4 files changed, 44 insertions(+), 80 deletions(-)
>  rename drivers/staging/iio/adc/{ad7606_core.c => ad7606.c} (88%)
>  delete mode 100644 drivers/staging/iio/adc/ad7606_ring.c
> 
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 3cdd83c..ac09485 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -2,7 +2,6 @@
>  # Makefile for industrial I/O ADC drivers
>  #
>  
> -ad7606-y := ad7606_core.o ad7606_ring.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
>  obj-$(CONFIG_AD7606) += ad7606.o
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606.c
> similarity index 88%
> rename from drivers/staging/iio/adc/ad7606_core.c
> rename to drivers/staging/iio/adc/ad7606.c
> index 4ef6cb4..010c6e1 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -21,10 +21,12 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include "ad7606.h"
>  
> -int ad7606_reset(struct ad7606_state *st)
> +static int ad7606_reset(struct ad7606_state *st)
>  {
>  	if (st->gpio_reset) {
>  		gpiod_set_value(st->gpio_reset, 1);
> @@ -36,7 +38,7 @@ int ad7606_reset(struct ad7606_state *st)
>  	return -ENODEV;
>  }
>  
> -int ad7606_read_samples(struct ad7606_state *st)
> +static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels;
>  	u16 *data = st->data;
> @@ -69,6 +71,41 @@ int ad7606_read_samples(struct ad7606_state *st)
>  	return st->bops->read_block(st->dev, num, data);
>  }
>  
> +static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct ad7606_state *st = iio_priv(pf->indio_dev);
> +
> +	gpiod_set_value(st->gpio_convst, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
> + * @work_s:	the work struct through which this was scheduled
> + *
> + * Currently there is no option in this driver to disable the saving of
> + * timestamps within the ring.
> + * I think the one copy of this at a time was to avoid problems if the
> + * trigger was set far too high and the reads then locked up the computer.
> + **/
> +static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
> +{
> +	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
> +						poll_work);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	int ret;
> +
> +	ret = ad7606_read_samples(st);
> +	if (ret == 0)
> +		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +						   iio_get_time_ns(indio_dev));
> +
> +	gpiod_set_value(st->gpio_convst, 0);
> +	iio_trigger_notify_done(indio_dev->trig);
> +}
> +
>  static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -385,6 +422,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st->base_address = base_address;
>  	st->range = 5000;
>  	st->oversampling = 1;
> +	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
>  
>  	st->reg = devm_regulator_get(dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
> @@ -427,7 +465,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = ad7606_register_ring_funcs_and_init(indio_dev);
> +	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
> +					 NULL, NULL);
>  	if (ret)
>  		goto error_free_irq;
>  
> @@ -439,7 +478,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  
>  	return 0;
>  error_unregister_ring:
> -	ad7606_ring_cleanup(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  error_free_irq:
>  	free_irq(irq, indio_dev);
> @@ -457,7 +496,7 @@ int ad7606_remove(struct device *dev, int irq)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	ad7606_ring_cleanup(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	free_irq(irq, indio_dev);
>  	if (!IS_ERR(st->reg))
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index f5f85fa..746f955 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -61,8 +61,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops);
>  int ad7606_remove(struct device *dev, int irq);
> -int ad7606_reset(struct ad7606_state *st);
> -int ad7606_read_samples(struct ad7606_state *st);
>  
>  enum ad7606_supported_device_ids {
>  	ID_AD7606_8,
> @@ -70,9 +68,6 @@ enum ad7606_supported_device_ids {
>  	ID_AD7606_4
>  };
>  
> -int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev);
> -void ad7606_ring_cleanup(struct iio_dev *indio_dev);
> -
>  #ifdef CONFIG_PM_SLEEP
>  extern const struct dev_pm_ops ad7606_pm_ops;
>  #define AD7606_PM_OPS (&ad7606_pm_ops)
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> deleted file mode 100644
> index 68d72b1..0000000
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/*
> - * Copyright 2011-2012 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - *
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/gpio.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
> -
> -#include "ad7606.h"
> -
> -static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> -{
> -	struct iio_poll_func *pf = p;
> -	struct ad7606_state *st = iio_priv(pf->indio_dev);
> -
> -	gpiod_set_value(st->gpio_convst, 1);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
> - * @work_s:	the work struct through which this was scheduled
> - *
> - * Currently there is no option in this driver to disable the saving of
> - * timestamps within the ring.
> - * I think the one copy of this at a time was to avoid problems if the
> - * trigger was set far too high and the reads then locked up the computer.
> - **/
> -static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
> -{
> -	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
> -						poll_work);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> -	int ret;
> -
> -	ret = ad7606_read_samples(st);
> -	if (ret == 0)
> -		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> -						   iio_get_time_ns(indio_dev));
> -
> -	gpiod_set_value(st->gpio_convst, 0);
> -	iio_trigger_notify_done(indio_dev->trig);
> -}
> -
> -int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> -{
> -	struct ad7606_state *st = iio_priv(indio_dev);
> -
> -	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
> -
> -	return iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
> -					  NULL, NULL);
> -}
> -
> -void ad7606_ring_cleanup(struct iio_dev *indio_dev)
> -{
> -	iio_triggered_buffer_cleanup(indio_dev);
> -}
> 

