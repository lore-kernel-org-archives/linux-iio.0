Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:33634 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1CITaf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2011 14:30:35 -0500
Message-ID: <4D77D590.9090301@cam.ac.uk>
Date: Wed, 09 Mar 2011 19:31:28 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marten Svanfeldt <marten@intuitiveaerial.com>
CC: linux-iio@vger.kernel.org, michael.hennerich@analog.com
Subject: Re: [PATCH] IIO: trigger: New hrtimer based trigger driver
References: <4D70C8AA.4090300@cam.ac.uk> <1299679243-1318-2-git-send-email-marten@intuitiveaerial.com>
In-Reply-To: <1299679243-1318-2-git-send-email-marten@intuitiveaerial.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/11 14:00, Marten Svanfeldt wrote:
> This driver provide a way to utilize hrtimer as an IIO trigger source.
Looks quite nice.  Some comments inline. I know this is only a quick untested
example, but as I was reading anyway...

Obviously run checkpatch over it at some point.

Otherwise, nice clean little trigger driver.  After cleanup and
testing I would be happy to see this in IIO.  Never realised it
would be this simple :)

Thanks.

Jonathan
> 
> Signed-off-by: Marten Svanfeldt <marten@intuitiveaerial.com>
> ---
>  drivers/staging/iio/trigger/Kconfig            |    6 +
>  drivers/staging/iio/trigger/Makefile           |    2 +
>  drivers/staging/iio/trigger/iio-trig-hrtimer.c |  208 ++++++++++++++++++++++++
>  3 files changed, 216 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/trigger/iio-trig-hrtimer.c
> 
> diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
> index d842a58..35d676a 100644
> --- a/drivers/staging/iio/trigger/Kconfig
> +++ b/drivers/staging/iio/trigger/Kconfig
> @@ -18,4 +18,10 @@ config IIO_GPIO_TRIGGER
>  	help
>  	  Provides support for using GPIO pins as IIO triggers.
>  
> +config IIO_HRTIMER_TRIGGER
> +        tristate "hrtimer trigger"
Is it worth spelling out high resolution as not every person
who builds a kernel will know what hr stands for?
> +        help
> +          Provides support for using hrtimer as periodic IIO
> +          trigger.
> +
>  endif # IIO_TRIGGER
> diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
> index 10aeca5..d178c66 100644
> --- a/drivers/staging/iio/trigger/Makefile
> +++ b/drivers/staging/iio/trigger/Makefile
> @@ -4,3 +4,5 @@
>  
>  obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
>  obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
> +obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
Oops, I ought to resort these into alphabetical order at some point!
> +
> diff --git a/drivers/staging/iio/trigger/iio-trig-hrtimer.c b/drivers/staging/iio/trigger/iio-trig-hrtimer.c
> new file mode 100644
> index 0000000..16b5af5
> --- /dev/null
> +++ b/drivers/staging/iio/trigger/iio-trig-hrtimer.c
> @@ -0,0 +1,208 @@
> +/**
> + * The industrial I/O periodic hrtimer trigger driver
> + *
> + * Copyright (C) Intuitive Aerial AB
> + * Written by Marten Svanfeldt, marten@intuitiveaerial.com
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/hrtimer.h>
> +#include "../iio.h"
> +#include "../trigger.h"
> +
> +static LIST_HEAD(iio_hrtimer_trigger_list);
> +
> +struct iio_hrtimer_trig_info {
hmm.. I should rework the trigger allocation code to allow for this structure
to be directly embedded in another. Would make things a bit cleaner for you
and probably a number of other users.
> +	struct iio_trigger *trigger;
> +	unsigned int frequency;
> +	struct hrtimer timer;
> +};
> +
> +static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *timer)
> +{
> +	struct iio_hrtimer_trig_info *trig_info = container_of(timer, struct iio_hrtimer_trig_info, timer);
> +
> +	iio_trigger_poll(trig_info->trigger, 0);
Out of curiosity, how suceptible to drift is this?  I guess the timer doesn't take
into account the amout of time this function takes, e.g how late are we by the time
the timer is restarted?
> +	return HRTIMER_RESTART;
> +}
> +
> +static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_hrtimer_trig_info *trig_info = trig->private_data;
> +	if(trig_info->frequency == 0)
> +		return -EINVAL;
> +
> +	if(state) {
> +		hrtimer_start(&trig_info->timer,
> +				ktime_set(0, NSEC_PER_SEC/trig_info->frequency),
> +				HRTIMER_MODE_REL);
> +	} else {
> +		hrtimer_cancel(&trig_info->timer);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t iio_trig_hrtimer_read_freq(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_hrtimer_trig_info *trig_info = trig->private_data;
> +	return sprintf(buf, "%u\n", trig_info->frequency);
> +}
> +
> +static ssize_t iio_trig_hrtimer_write_freq(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf,
> +					   size_t len)
> +{
> +	struct iio_trigger *trig = dev_get_drvdata(dev);
> +	struct iio_hrtimer_trig_info *trig_info = trig->private_data;
> +	unsigned long val;
> +	int ret;
> +
> +	ret = strict_strtoul(buf, 10, &val);
> +	if(ret)
> +		goto error_ret;
> +
> +	trig_info->frequency = val;
Only applied on trigger being stopped and restarted I think?
Maybe return -EBUSY if the trigger is running to make this
obvious to userspace.
> +
> +	return len;
> +
> +error_ret:
> +	return ret;
> +}
> +
> +static IIO_TRIGGER_NAME_ATTR;
> +static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
> +		iio_trig_hrtimer_read_freq,
> +		iio_trig_hrtimer_write_freq);
> +
> +static struct attribute *iio_trig_hrtimer_attrs[] = {
> +	&dev_attr_name.attr,
> +	&dev_attr_frequency.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group iio_trig_hrtimer_attr_group = {
> +	.attrs = iio_trig_hrtimer_attrs,
> +};
> +
> +static int iio_trig_hrtimer_probe(struct platform_device *dev)
> +{
> +	char **pdata = dev->dev.platform_data;
> +	struct iio_hrtimer_trig_info *trig_info;
> +	struct iio_trigger *trig, *trig2;
> +
> +	int i, ret;
> +
while(pdata != NULL) then increment pdata pointer?
> +	for(i = 0;; i++) {
> +		if(pdata[i] == NULL)
> +			break;
> +
> +		trig = iio_allocate_trigger();
> +		if(!trig) {
> +			ret = -ENOMEM;
> +			goto err_free_completed_reg;
> +		}
> +		list_add(&trig->alloc_list, &iio_hrtimer_trigger_list);
> +
> +		trig_info = kzalloc(sizeof(struct iio_hrtimer_trig_info), GFP_KERNEL);
> +		if(!trig_info) {
> +			ret = -ENOMEM;
> +			goto err_put_trigger;
> +		}
> +		trig_info->trigger = trig;
> +		trig->private_data = trig_info;
> +		trig->owner = THIS_MODULE;
> +		trig->set_trigger_state = &iio_trig_hrtimer_set_state;
> +		trig->name = kasprintf(GFP_KERNEL, "hrtimer%s", pdata[i]);
> +		if(!trig->name) {
> +			ret = -ENOMEM;
> +			goto err_free_trig_info;
> +		}
> +
> +		// Setup a hrtimer
> +		hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		trig_info->timer.function = iio_trig_hrtimer_trig;
> +
> +		ret = iio_trigger_register(trig);
> +		if(ret)
> +			goto err_free_name;
> +	}
> +
> +	return 0;
> +err_free_name:
> +	kfree(trig->name);
> +err_free_trig_info:
> +	kfree(trig_info);
> +err_put_trigger:
> +	list_del(&trig->alloc_list);
> +	iio_put_trigger(trig);
> +err_free_completed_reg:
> +	list_for_each_entry_safe(trig,
> +				 trig2,
> +				 &iio_hrtimer_trigger_list,
> +				 alloc_list) {
> +		trig_info = trig->private_data;
> +		kfree(trig->name);
> +		kfree(trig_info);
> +		iio_trigger_unregister(trig);
> +	}
> +
> +	return ret;
> +}
> +
> +static int iio_trig_hrtimer_remove(struct platform_device *dev)
> +{
> +	struct iio_trigger *trig, *trig2;
> +	struct iio_hrtimer_trig_info *trig_info;
> +
> +	list_for_each_entry_safe(trig,
> +				 trig2,
> +				 &iio_hrtimer_trigger_list,
> +				 alloc_list) {
> +		trig_info = trig->private_data;
> +		hrtimer_cancel(&trig_info->timer);
> +		kfree(trig->name);
> +		kfree(trig_info);
> +		iio_trigger_unregister(trig);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver iio_trig_hrtimer_driver = {
> +	.driver = {
> +		.name = "iio_hrtimer_trigger",
> +		.owner = THIS_MODULE
> +	},
> +	.probe = iio_trig_hrtimer_probe,
> +	.remove = iio_trig_hrtimer_remove,
> +};
> +
> +static int __init iio_trig_hrtimer_init(void)
> +{
> +	return platform_driver_register(&iio_trig_hrtimer_driver);
> +}
> +
> +static void __exit iio_trig_hrtimer_exit(void)
> +{
> +	return platform_driver_unregister(&iio_trig_hrtimer_driver);
> +}
> +
> +module_init(iio_trig_hrtimer_init);
> +module_exit(iio_trig_hrtimer_exit);
> +MODULE_AUTHOR("Marten Svanfeldt <marten@intuitiveaerial.com>");
> +MODULE_DESCRIPTION("Periodic hrtimer trigger for the iio subsystem");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platofrm:iio-trig-hrtimer");
> +

