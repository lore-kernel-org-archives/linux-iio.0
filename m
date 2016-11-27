Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42657 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbcK0PmM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 10:42:12 -0500
Subject: Re: [PATCH v2 6/7] IIO: add STM32 IIO timer driver
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-7-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3e2bce3d-c607-d397-487f-2439a0ba7b0b@kernel.org>
Date: Sun, 27 Nov 2016 15:42:04 +0000
MIME-Version: 1.0
In-Reply-To: <1480000463-9625-7-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I delved into the datasheet after trying to figure this out, so I think
I now sort of understand your intent, but please do answer the questions
inline.

On 24/11/16 15:14, Benjamin Gaignard wrote:
> Timers IPs can be used to generate triggers for other IPs like
> DAC, ADC or other timers.
> Each trigger may result of timer internals signals like counter enable,
> reset or edge, this configuration could be done through "master_mode"
> device attribute.
> 
> A timer device could be triggered by other timers, we use the trigger
> name and is_stm32_iio_timer_trigger() function to distinguish them
> and configure IP input switch.
The presence of an IIO device in here was a suprise.. What is it actually for?

I think this needs some examples of usage to make it clear what the aim is.

I was basically expecting to see a driver instantiating one iio trigger
per timer that can act as a trigger.  Those would each have sampling frequency
controls and basica enable / disable.

I'm seeing something much more complex here so additional explanation is
needed.
> 
> Timer may also decide on which event (edge, level) they could
> be activated by a trigger, this configuration is done by writing in
> "slave_mode" device attribute.
Really?  Sounds like magic numbers in sysfs which is never a good idea.
Please document those attributes / or break them up into elements that
don't require magic numbers.

> 
> Since triggers could also be used by DAC or ADC their names are defined
> in include/dt-bindings/iio/timer/st,stm32-iio-timer.h so those IPs will be able
> to configure themselves in valid_trigger function
> 
> Trigger have a "sampling_frequency" attribute which allow to configure
> timer sampling frequency without using pwm interface
> 
> version 2:
> - keep only one compatible
Hmm. I'm not sure I like this as such.  We are actually dealing with lots
of instances of a hardware block with only a small amount of shared
infrastrcuture (which is classic mfd teritory). So to my mind we
should have a separate device for each.

> - use st,input-triggers-names and st,output-triggers-names
>   to know which triggers are accepted and/or create by the device
I'm not following why we have this cascade setup?

These are triggers, not devices in the IIO context.  We need some detailed
description of why you have it setup like this. This would include the
ABI with examples of how you are using it.

Basically I don't currently understand what you are doing :(


Thanks,

Jonathan
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/iio/Kconfig                                |   2 +-
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/timer/Kconfig                          |  15 +
>  drivers/iio/timer/Makefile                         |   1 +
>  drivers/iio/timer/stm32-iio-timer.c                | 448 +++++++++++++++++++++
>  drivers/iio/trigger/Kconfig                        |   1 -
>  include/dt-bindings/iio/timer/st,stm32-iio-timer.h |  23 ++
>  include/linux/iio/timer/stm32-iio-timers.h         |  16 +
>  8 files changed, 505 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iio/timer/Kconfig
>  create mode 100644 drivers/iio/timer/Makefile
>  create mode 100644 drivers/iio/timer/stm32-iio-timer.c
>  create mode 100644 include/dt-bindings/iio/timer/st,stm32-iio-timer.h
>  create mode 100644 include/linux/iio/timer/stm32-iio-timers.h
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 6743b18..2de2a80 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -90,5 +90,5 @@ source "drivers/iio/potentiometer/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
> -
> +source "drivers/iio/timer/Kconfig"
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 87e4c43..b797c08 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -32,4 +32,5 @@ obj-y += potentiometer/
>  obj-y += pressure/
>  obj-y += proximity/
>  obj-y += temperature/
> +obj-y += timer/
>  obj-y += trigger/
> diff --git a/drivers/iio/timer/Kconfig b/drivers/iio/timer/Kconfig
> new file mode 100644
> index 0000000..7a73bc6
> --- /dev/null
> +++ b/drivers/iio/timer/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# Timers drivers
> +
> +menu "Timers"
> +
> +config IIO_STM32_TIMER
> +	tristate "stm32 iio timer"
> +	depends on ARCH_STM32
> +	depends on OF
> +	select IIO_TRIGGERED_EVENT
> +	select MFD_STM32_GP_TIMER
> +	help
> +	  Select this option to enable stm32 timers hardware IPs
> +
> +endmenu
> diff --git a/drivers/iio/timer/Makefile b/drivers/iio/timer/Makefile
> new file mode 100644
> index 0000000..a360c9f
> --- /dev/null
> +++ b/drivers/iio/timer/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_IIO_STM32_TIMER) += stm32-iio-timer.o
> diff --git a/drivers/iio/timer/stm32-iio-timer.c b/drivers/iio/timer/stm32-iio-timer.c
> new file mode 100644
> index 0000000..35f2687
> --- /dev/null
> +++ b/drivers/iio/timer/stm32-iio-timer.c
> @@ -0,0 +1,448 @@
> +/*
> + * stm32-iio-timer.c
> + *
> + * Copyright (C) STMicroelectronics 2016
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/timer/stm32-iio-timers.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_event.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/stm32-gptimer.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "stm32-iio-timer"
> +
> +struct stm32_iio_timer_dev {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	int irq;
> +	bool own_timer;
> +	unsigned int sampling_frequency;
> +	struct iio_trigger *active_trigger;
> +};
> +
> +static ssize_t _store_frequency(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct stm32_iio_timer_dev *stm32 = iio_trigger_get_drvdata(trig);
> +	unsigned int freq;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &freq);
> +	if (ret)
> +		return ret;
> +
> +	stm32->sampling_frequency = freq;
> +
> +	return len;
> +}
> +
> +static ssize_t _read_frequency(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct stm32_iio_timer_dev *stm32 = iio_trigger_get_drvdata(trig);
> +	unsigned long long freq = stm32->sampling_frequency;
> +	u32 psc, arr, cr1;
> +
> +	regmap_read(stm32->regmap, TIM_CR1, &cr1);
> +	regmap_read(stm32->regmap, TIM_PSC, &psc);
> +	regmap_read(stm32->regmap, TIM_ARR, &arr);
> +
> +	if (psc && arr && (cr1 & TIM_CR1_CEN)) {
> +		freq = (unsigned long long)clk_get_rate(stm32->clk);
> +		do_div(freq, psc);
> +		do_div(freq, arr);
> +	}
> +
> +	return sprintf(buf, "%d\n", (unsigned int)freq);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +			      _read_frequency,
> +			      _store_frequency);
> +
> +static struct attribute *stm32_trigger_attrs[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group stm32_trigger_attr_group = {
> +	.attrs = stm32_trigger_attrs,
> +};
> +
> +static const struct attribute_group *stm32_trigger_attr_groups[] = {
> +	&stm32_trigger_attr_group,
> +	NULL,
> +};
> +
> +static
> +ssize_t _show_master_mode(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_iio_timer_dev *stm32 = iio_priv(indio_dev);
> +	u32 cr2;
> +
> +	regmap_read(stm32->regmap, TIM_CR2, &cr2);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", (cr2 >> 4) & 0x7);
> +}
> +
> +static
> +ssize_t _store_master_mode(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_iio_timer_dev *stm32 = iio_priv(indio_dev);
> +	u8 mode;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 10, &mode);
> +	if (ret)
> +		return ret;
> +
> +	if (mode > 0x7)
> +		return -EINVAL;
> +
> +	regmap_update_bits(stm32->regmap, TIM_CR2, TIM_CR2_MMS, mode << 4);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(master_mode, S_IRUGO | S_IWUSR,
> +		       _show_master_mode,
> +		       _store_master_mode,
> +		       0);
> +
> +static
> +ssize_t _show_slave_mode(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_iio_timer_dev *stm32 = iio_priv(indio_dev);
> +	u32 smcr;
> +
> +	regmap_read(stm32->regmap, TIM_SMCR, &smcr);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", smcr & 0x3);
> +}
> +
> +static
> +ssize_t _store_slave_mode(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_iio_timer_dev *stm32 = iio_priv(indio_dev);
> +	u8 mode;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 10, &mode);
> +	if (ret)
> +		return ret;
> +
> +	if (mode > 0x7)
> +		return -EINVAL;
How is something called slave mode going to be fed a number between 0 and 7?
Rule of thumb is no magic numbers in sysfs and right now this is looking
rather cryptic to say the least!
> +
> +	regmap_update_bits(stm32->regmap, TIM_SMCR, TIM_SMCR_SMS, mode);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(slave_mode, S_IRUGO | S_IWUSR,
There is an iritating move (in terms of noise it's generating) to use values
directly instead fo these defines.  Still if you don't fix it here I'll only
get a patch 'fixing' it soon after...

> +		       _show_slave_mode,
> +		       _store_slave_mode,
> +		       0);
> +
> +static struct attribute *stm32_timer_attrs[] = {
> +	&iio_dev_attr_master_mode.dev_attr.attr,
> +	&iio_dev_attr_slave_mode.dev_attr.attr,
New ABI so must be documented under Documentation/ABI/testing/sysfs-bus-iio-*

> +	NULL,
> +};
> +
> +static const struct attribute_group stm32_timer_attr_group = {
> +	.attrs = stm32_timer_attrs,
> +};
> +
> +static int stm32_timer_start(struct stm32_iio_timer_dev *stm32)
> +{
> +	unsigned long long prd, div;
> +	int prescaler = 0;
> +	u32 max_arr = 0xFFFF, cr1;
> +
> +	if (stm32->sampling_frequency == 0)
> +		return 0;
> +
> +	/* Period and prescaler values depends of clock rate */
> +	div = (unsigned long long)clk_get_rate(stm32->clk);
> +
> +	do_div(div, stm32->sampling_frequency);
> +
> +	prd = div;
> +
> +	while (div > max_arr) {
> +		prescaler++;
> +		div = prd;
> +		do_div(div, (prescaler + 1));
> +	}
> +	prd = div;
> +
> +	if (prescaler > MAX_TIM_PSC) {
> +		dev_err(stm32->dev, "prescaler exceeds the maximum value\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check that we own the timer */
> +	regmap_read(stm32->regmap, TIM_CR1, &cr1);
> +	if ((cr1 & TIM_CR1_CEN) && !stm32->own_timer)
> +		return -EBUSY;
> +
> +	if (!stm32->own_timer) {
> +		stm32->own_timer = true;
> +		clk_enable(stm32->clk);
> +	}
> +
> +	regmap_write(stm32->regmap, TIM_PSC, prescaler);
> +	regmap_write(stm32->regmap, TIM_ARR, prd - 1);
> +	regmap_update_bits(stm32->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
> +
> +	/* Force master mode to update mode */
> +	regmap_update_bits(stm32->regmap, TIM_CR2, TIM_CR2_MMS, 0x20);
> +
> +	/* Make sure that registers are updated */
> +	regmap_update_bits(stm32->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> +
> +	/* Enable interrupt */
> +	regmap_write(stm32->regmap, TIM_SR, 0);
> +	regmap_update_bits(stm32->regmap, TIM_DIER, TIM_DIER_UIE, TIM_DIER_UIE);
> +
> +	/* Enable controller */
> +	regmap_update_bits(stm32->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
> +
> +	return 0;
> +}
> +
> +static int stm32_timer_stop(struct stm32_iio_timer_dev *stm32)
> +{
> +	if (!stm32->own_timer)
> +		return 0;
> +
> +	/* Stop timer */
> +	regmap_update_bits(stm32->regmap, TIM_DIER, TIM_DIER_UIE, 0);
> +	regmap_update_bits(stm32->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +	regmap_write(stm32->regmap, TIM_PSC, 0);
> +	regmap_write(stm32->regmap, TIM_ARR, 0);
> +
> +	clk_disable(stm32->clk);
> +
> +	stm32->own_timer = false;
> +	stm32->active_trigger = NULL;
> +
> +	return 0;
> +}
> +
> +static int stm32_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct stm32_iio_timer_dev *stm32 = iio_trigger_get_drvdata(trig);
> +
> +	stm32->active_trigger = trig;
> +
> +	if (state)
> +		return stm32_timer_start(stm32);
> +	else
> +		return stm32_timer_stop(stm32);
> +}
> +
> +static irqreturn_t stm32_timer_irq_handler(int irq, void *private)
> +{
> +	struct stm32_iio_timer_dev *stm32 = private;
> +	u32 sr;
> +
> +	regmap_read(stm32->regmap, TIM_SR, &sr);
> +	regmap_write(stm32->regmap, TIM_SR, 0);
> +
> +	if ((sr & TIM_SR_UIF) && stm32->active_trigger)
> +		iio_trigger_poll(stm32->active_trigger);
This is acting like a trigger cascading off another trigger?

Normally this interrupt handler would be directly associated with the
trigger hardware - in this case the timer.
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_trigger_ops timer_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = stm32_set_trigger_state,
> +};
> +
> +static int stm32_setup_iio_triggers(struct stm32_iio_timer_dev *stm32)
> +{
> +	int ret;
> +	struct property *p;
> +	const char *cur = NULL;
> +
> +	p = of_find_property(stm32->dev->of_node,
> +			     "st,output-triggers-names", NULL);
> +
> +	while ((cur = of_prop_next_string(p, cur)) != NULL) {
> +		struct iio_trigger *trig;
> +
> +		trig = devm_iio_trigger_alloc(stm32->dev, "%s", cur);
> +		if  (!trig)
> +			return -ENOMEM;
> +
> +		trig->dev.parent = stm32->dev->parent;
> +		trig->ops = &timer_trigger_ops;
> +		trig->dev.groups = stm32_trigger_attr_groups;
> +		iio_trigger_set_drvdata(trig, stm32);
> +
> +		ret = devm_iio_trigger_register(stm32->dev, trig);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * is_stm32_iio_timer_trigger
> + * @trig: trigger to be checked
> + *
> + * return true if the trigger is a valid stm32 iio timer trigger
> + * either return false
> + */
> +bool is_stm32_iio_timer_trigger(struct iio_trigger *trig)
> +{
> +	return (trig->ops == &timer_trigger_ops);
> +}
> +EXPORT_SYMBOL(is_stm32_iio_timer_trigger);
> +
> +static int stm32_validate_trigger(struct iio_dev *indio_dev,
> +				  struct iio_trigger *trig)
> +{
> +	struct stm32_iio_timer_dev *dev = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!is_stm32_iio_timer_trigger(trig))
> +		return -EINVAL;
> +
> +	ret = of_property_match_string(dev->dev->of_node,
> +				       "st,input-triggers-names",
> +				       trig->name);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	regmap_update_bits(dev->regmap, TIM_SMCR, TIM_SMCR_TS, ret << 4);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info stm32_trigger_info = {
> +	.driver_module = THIS_MODULE,
> +	.validate_trigger = stm32_validate_trigger,
> +	.attrs = &stm32_timer_attr_group,
> +};
> +
> +static struct stm32_iio_timer_dev *stm32_setup_iio_device(struct device *dev)
> +{
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct stm32_iio_timer_dev));
> +	if (!indio_dev)
> +		return NULL;
This is 'unusual'.  Why does a trigger driver need an iio_dev at all?
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &stm32_trigger_info;
> +	indio_dev->modes = INDIO_EVENT_TRIGGERED;
> +	indio_dev->num_channels = 0;
> +	indio_dev->dev.of_node = dev->of_node;
> +
> +	ret = iio_triggered_event_setup(indio_dev,
> +					NULL,
> +					stm32_timer_irq_handler);
So the iio_dev exists to provide the ability to fire this interrupt from
another trigger?  Why do you want to do this?
> +	if (ret)
> +		return NULL;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		iio_triggered_event_cleanup(indio_dev);
> +		return NULL;
> +	}
> +
> +	return iio_priv(indio_dev);
> +}
> +
> +static int stm32_iio_timer_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stm32_iio_timer_dev *stm32;
> +	struct stm32_gptimer_dev *mfd = dev_get_drvdata(pdev->dev.parent);
> +	int ret;
> +
> +	stm32 = stm32_setup_iio_device(dev);
> +	if (!stm32)
> +		return -ENOMEM;
> +
> +	stm32->dev = dev;
> +	stm32->regmap = mfd->regmap;
> +	stm32->clk = mfd->clk;
> +
> +	stm32->irq = platform_get_irq(pdev, 0);
> +	if (stm32->irq < 0)
> +		return -EINVAL;
> +
> +	ret = devm_request_irq(stm32->dev, stm32->irq,
> +			       stm32_timer_irq_handler, IRQF_SHARED,
> +			       "iiotimer_event", stm32);
> +	if (ret)
> +		return ret;
> +
> +	ret = stm32_setup_iio_triggers(stm32);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, stm32);
> +
> +	return 0;
> +}
> +
> +static int stm32_iio_timer_remove(struct platform_device *pdev)
> +{
> +	struct stm32_iio_timer_dev *stm32 = platform_get_drvdata(pdev);
> +
> +	iio_triggered_event_cleanup((struct iio_dev *)stm32);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id stm32_trig_of_match[] = {
> +	{
> +		.compatible = "st,stm32-iio-timer",
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
> +
> +static struct platform_driver stm32_iio_timer_driver = {
> +	.probe = stm32_iio_timer_probe,
> +	.remove = stm32_iio_timer_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = stm32_trig_of_match,
> +	},
> +};
> +module_platform_driver(stm32_iio_timer_driver);
> +
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_DESCRIPTION("STMicroelectronics STM32 iio timer driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 809b2e7..f2af4fe 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -46,5 +46,4 @@ config IIO_SYSFS_TRIGGER
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iio-trig-sysfs.
> -
Clear this out...
>  endmenu
> diff --git a/include/dt-bindings/iio/timer/st,stm32-iio-timer.h b/include/dt-bindings/iio/timer/st,stm32-iio-timer.h
> new file mode 100644
> index 0000000..d39bf16
> --- /dev/null
> +++ b/include/dt-bindings/iio/timer/st,stm32-iio-timer.h
> @@ -0,0 +1,23 @@
> +/*
> + * st,stm32-iio-timer.h
> + *
> + * Copyright (C) STMicroelectronics 2016
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef _DT_BINDINGS_IIO_TIMER_H_
> +#define _DT_BINDINGS_IIO_TIMER_H_
> +
> +#define TIM1_TRGO	"tim1_trgo"
> +#define TIM2_TRGO	"tim2_trgo"
> +#define TIM3_TRGO	"tim3_trgo"
> +#define TIM4_TRGO	"tim4_trgo"
> +#define TIM5_TRGO	"tim5_trgo"
> +#define TIM6_TRGO	"tim6_trgo"
> +#define TIM7_TRGO	"tim7_trgo"
> +#define TIM8_TRGO	"tim8_trgo"
> +#define TIM9_TRGO	"tim9_trgo"
> +#define TIM12_TRGO	"tim12_trgo"
> +
> +#endif
> diff --git a/include/linux/iio/timer/stm32-iio-timers.h b/include/linux/iio/timer/stm32-iio-timers.h
> new file mode 100644
> index 0000000..5d1b86c
> --- /dev/null
> +++ b/include/linux/iio/timer/stm32-iio-timers.h
> @@ -0,0 +1,16 @@
> +/*
> + * stm32-iio-timers.h
> + *
> + * Copyright (C) STMicroelectronics 2016
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef _STM32_IIO_TIMERS_H_
> +#define _STM32_IIO_TIMERS_H_
> +
> +#include <dt-bindings/iio/timer/st,stm32-iio-timer.h>
> +
> +bool is_stm32_iio_timer_trigger(struct iio_trigger *trig);
> +
> +#endif
> 

