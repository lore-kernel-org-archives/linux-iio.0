Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36493 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbcLBNyN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2016 08:54:13 -0500
Received: by mail-wm0-f45.google.com with SMTP id g23so17542239wme.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2016 05:54:12 -0800 (PST)
Date: Fri, 2 Dec 2016 13:57:20 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 6/7] IIO: add STM32 timer trigger driver
Message-ID: <20161202135720.GM2683@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-7-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1480673842-20804-7-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 02 Dec 2016, Benjamin Gaignard wrote:

> Timers IPs can be used to generate triggers for other IPs like
> DAC, ADC or other timers.
> Each trigger may result of timer internals signals like counter enable,
> reset or edge, this configuration could be done through "master_mode"
> device attribute.
> 
> A timer device could be triggered by other timers, we use the trigger
> name and is_stm32_iio_timer_trigger() function to distinguish them
> and configure IP input switch.
> 
> Timer may also decide on which event (edge, level) they could
> be activated by a trigger, this configuration is done by writing in
> "slave_mode" device attribute.
> 
> Since triggers could also be used by DAC or ADC their names are defined
> in include/dt-bindings/iio/timer/st,stm32-iio-timer.h so those IPs will be able
> to configure themselves in valid_trigger function
> 
> Trigger have a "sampling_frequency" attribute which allow to configure
> timer sampling frequency without using pwm interface
> 
> version 3:
> - change compatible to "st,stm32-timer-trigger"
> - fix attributes access right
> - use string instead of int for master_mode and slave_mode
> - document device attributes in sysfs-bus-iio-timer-stm32
> 
> version 2:
> - keep only one compatible
> - use st,input-triggers-names and st,output-triggers-names
>   to know which triggers are accepted and/or create by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  47 ++
>  drivers/iio/Kconfig                                |   2 +-
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/timer/Kconfig                          |  15 +
>  drivers/iio/timer/Makefile                         |   1 +
>  drivers/iio/timer/stm32-timer-trigger.c            | 477 +++++++++++++++++++++
>  drivers/iio/trigger/Kconfig                        |   1 -
>  .../iio/timer/st,stm32-timer-triggers.h            |  60 +++
>  include/linux/iio/timer/stm32-timer-trigger.h      |  16 +
>  9 files changed, 618 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>  create mode 100644 drivers/iio/timer/Kconfig
>  create mode 100644 drivers/iio/timer/Makefile
>  create mode 100644 drivers/iio/timer/stm32-timer-trigger.c
>  create mode 100644 include/dt-bindings/iio/timer/st,stm32-timer-triggers.h
>  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> new file mode 100644
> index 0000000..b70bb2a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -0,0 +1,47 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/master_mode_available
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list possible master modes which are:
> +		- "reset"     :	The UG bit from the TIMx_EGR register is used as trigger output (TRGO).
> +		- "enable"    : The Counter Enable signal CNT_EN is used as trigger output.
> +		- "update"    : The update event is selected as trigger output.
> +				For instance a master timer can then be used as a prescaler for a slave timer.
> +		- "compare_pulse" : The trigger output send a positive pulse when the CC1IF flag is to be set.
> +		- "OC1REF"    : OC1REF signal is used as trigger output.
> +		- "OC2REF"    : OC2REF signal is used as trigger output.
> +		- "OC3REF"    : OC3REF signal is used as trigger output.
> +		- "OC4REF"    : OC4REF signal is used as trigger output.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/master_mode
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current master modes.
> +		Writing set the master mode
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slave_mode_available
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list possible slave modes which are:
> +		- "disabled"  : The prescaler is clocked directly by the internal clock.
> +		- "encoder_1" : Counter counts up/down on TI2FP1 edge depending on TI1FP2 level.
> +		- "encoder_2" : Counter counts up/down on TI1FP2 edge depending on TI2FP1 level.
> +		- "encoder_3" : Counter counts up/down on both TI1FP1 and TI2FP2 edges depending
> +				on the level of the other input.
> +		- "reset"     : Rising edge of the selected trigger input reinitializes the counter
> +				and generates an update of the registers.
> +		- "gated"     : The counter clock is enabled when the trigger input is high.
> +				The counter stops (but is not reset) as soon as the trigger becomes low.
> +				Both start and stop of the counter are controlled.
> +		- "trigger"   : The counter starts at a rising edge of the trigger TRGI (but it is not
> +				reset). Only the start of the counter is controlled.
> +		- "external_clock": Rising edges of the selected trigger (TRGI) clock the counter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slave_mode
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current slave mode.
> +		Writing set the slave mode
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
> index 0000000..149a917
> --- /dev/null
> +++ b/drivers/iio/timer/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# Timers drivers
> +
> +menu "Timers"
> +
> +config IIO_STM32_TIMER_TRIGGER
> +	tristate "stm32 timer trigger"

"STM32 Timer Trigger"

> +	depends on ARCH_STM32
> +	depends on OF

Are these build or run time dependencies?

If they are only run-time, add "|| COMPILE_TEST".

> +	select IIO_TRIGGERED_EVENT
> +	select MFD_STM32_GP_TIMER
> +	help
> +	  Select this option to enable stm32 timer trigger
> +
> +endmenu
> diff --git a/drivers/iio/timer/Makefile b/drivers/iio/timer/Makefile
> new file mode 100644
> index 0000000..4ad95ec9
> --- /dev/null
> +++ b/drivers/iio/timer/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
> diff --git a/drivers/iio/timer/stm32-timer-trigger.c b/drivers/iio/timer/stm32-timer-trigger.c
> new file mode 100644
> index 0000000..0c51601
> --- /dev/null
> +++ b/drivers/iio/timer/stm32-timer-trigger.c
> @@ -0,0 +1,477 @@
> +/*
> + * stm32-iio-timer.c

Swap this out for a description.

Filenames have a habit of becoming out-of-date.

> + * Copyright (C) STMicroelectronics 2016

'\n'

> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.

You don't need to put the "for" bit.  That's just what we do when
Linaro are writing drivers for other companies.  Your email address
says enough.

> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/timer/stm32-timer-trigger.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_event.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/stm32-gptimer.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME	"stm32-timer-trigger"

Just use the name in the correct places.  Defining device names is an
ugly practice IMHO.

> +#define MAX_MODES	8
> +
> +struct stm32_timer_trigger_dev {
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

What's with the '_' naming scheme?

> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct stm32_timer_trigger_dev *stm32 = iio_trigger_get_drvdata(trig);
> +	unsigned int freq;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &freq);
> +	if (ret)
> +		return ret;

No bounds checking required?

> +	stm32->sampling_frequency = freq;

Where is this value placed into the registers?

> +	return len;
> +}
> +
> +static ssize_t _read_frequency(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct stm32_timer_trigger_dev *stm32 = iio_trigger_get_drvdata(trig);
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
> +static IIO_DEV_ATTR_SAMP_FREQ(0660, _read_frequency, _store_frequency);
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

A lot of generic code here.

Are there macros that could help with this?

> +static char *master_mode_table[] = {
> +	"reset",
> +	"enable",
> +	"update",
> +	"compare_pulse",
> +	"OC1REF",
> +	"OC2REF",
> +	"OC3REF",
> +	"OC4REF"
> +};
> +
> +static

Why the line break here?

[and the ones below]

> +ssize_t _show_master_mode(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_timer_trigger_dev *stm32 = iio_priv(indio_dev);
> +	u32 cr2;
> +
> +	regmap_read(stm32->regmap, TIM_CR2, &cr2);
> +	cr2 = (cr2 >> 4) & 0x7;

Define these SHIFT and MASK values.

> +	return snprintf(buf, PAGE_SIZE, "%s\n", master_mode_table[cr2]);
> +}
> +
> +static
> +ssize_t _store_master_mode(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_timer_trigger_dev *stm32 = iio_priv(indio_dev);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
> +		if (!strncmp(master_mode_table[i], buf,
> +			     strlen(master_mode_table[i]))) {
> +			regmap_update_bits(stm32->regmap, TIM_CR2,
> +					   TIM_CR2_MMS, i << 4);

Define all of the SHIFT and MASK values in this set.

> +			return len;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_CONST_ATTR(master_mode_available,
> +	"reset enable update compare_pulse OC1REF OC2REF OC3REF OC4REF");
> +
> +static IIO_DEVICE_ATTR(master_mode, 0660,
> +		       _show_master_mode,
> +		       _store_master_mode,
> +		       0);
> +
> +static char *slave_mode_table[] = {
> +	"disabled",
> +	"encoder_1",
> +	"encoder_2",
> +	"encoder_3",
> +	"reset",
> +	"gated",
> +	"trigger",
> +	"external_clock",
> +};
> +
> +static
> +ssize_t _show_slave_mode(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_timer_trigger_dev *stm32 = iio_priv(indio_dev);
> +	u32 smcr;
> +
> +	regmap_read(stm32->regmap, TIM_SMCR, &smcr);
> +	smcr &= 0x7;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", slave_mode_table[smcr]);
> +}
> +
> +static
> +ssize_t _store_slave_mode(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_timer_trigger_dev *stm32 = iio_priv(indio_dev);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(slave_mode_table); i++) {
> +		if (!strncmp(slave_mode_table[i], buf,
> +			     strlen(slave_mode_table[i]))) {
> +			regmap_update_bits(stm32->regmap,
> +					   TIM_SMCR, TIM_SMCR_SMS, i);
> +			return len;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_CONST_ATTR(slave_mode_available,
> +       "disabled encoder_1 encoder_2 encoder_3 reset gated trigger external_clock");
> +
> +static IIO_DEVICE_ATTR(slave_mode, 0660,
> +		       _show_slave_mode,
> +		       _store_slave_mode,
> +		       0);
> +
> +static struct attribute *stm32_timer_attrs[] = {
> +	&iio_dev_attr_master_mode.dev_attr.attr,
> +	&iio_const_attr_master_mode_available.dev_attr.attr,
> +	&iio_dev_attr_slave_mode.dev_attr.attr,
> +	&iio_const_attr_slave_mode_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group stm32_timer_attr_group = {
> +	.attrs = stm32_timer_attrs,
> +};
> +
> +static int stm32_timer_start(struct stm32_timer_trigger_dev *stm32)
> +{
> +	unsigned long long prd, div;
> +	int prescaler = 0;
> +	u32 max_arr = 0xFFFF, cr1;

Since this is const, it'll be better of as a define.

> +	if (stm32->sampling_frequency == 0)
> +		return 0;

Is this okay?  Or is this an error?

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

Best to place a comment here.  Saves the reader having to work it out.

> +	if (prescaler > MAX_TIM_PSC) {
> +		dev_err(stm32->dev, "prescaler exceeds the maximum value\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check that we own the timer */
> +	regmap_read(stm32->regmap, TIM_CR1, &cr1);
> +	if ((cr1 & TIM_CR1_CEN) && !stm32->own_timer)
> +		return -EBUSY;

What happens if the timer is already enabled and you do own it?

I guess this *re*-starts it?

> +	if (!stm32->own_timer) {
> +		stm32->own_timer = true;
> +		clk_enable(stm32->clk);
> +	}

At the very least you're going to require some shared locking here.

At best you should have a shared "device held" flag.

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
> +static int stm32_timer_stop(struct stm32_timer_trigger_dev *stm32)
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
> +	struct stm32_timer_trigger_dev *stm32 = iio_trigger_get_drvdata(trig);
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
> +	struct stm32_timer_trigger_dev *stm32 = private;
> +	u32 sr;
> +
> +	regmap_read(stm32->regmap, TIM_SR, &sr);
> +	regmap_write(stm32->regmap, TIM_SR, 0);
> +
> +	if ((sr & TIM_SR_UIF) && stm32->active_trigger)
> +		iio_trigger_poll(stm32->active_trigger);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_trigger_ops timer_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = stm32_set_trigger_state,
> +};
> +
> +static int stm32_setup_iio_triggers(struct stm32_timer_trigger_dev *stm32)
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
> + * is_stm32_timer_trigger
> + * @trig: trigger to be checked
> + *
> + * return true if the trigger is a valid stm32 iio timer trigger
> + * either return false
> + */
> +bool is_stm32_timer_trigger(struct iio_trigger *trig)
> +{
> +	return (trig->ops == &timer_trigger_ops);
> +}
> +EXPORT_SYMBOL(is_stm32_timer_trigger);
> +
> +static int stm32_validate_trigger(struct iio_dev *indio_dev,
> +				  struct iio_trigger *trig)
> +{
> +	struct stm32_timer_trigger_dev *dev = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!is_stm32_timer_trigger(trig))
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
> +static struct stm32_timer_trigger_dev *stm32_setup_iio_device(struct device *dev)
> +{
> +	struct iio_dev *indio_dev;
> +	int ret;

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct stm32_timer_trigger_dev));

Did you run checkpatch.pl?

> +	if (!indio_dev)
> +		return NULL;
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
> +	if (ret)
> +		return NULL;

Return ERR_PTR(ret).

> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		iio_triggered_event_cleanup(indio_dev);
> +		return NULL;

Return ERR_PTR(ret).

> +	}
> +
> +	return iio_priv(indio_dev);
> +}
> +
> +static int stm32_timer_trigger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stm32_timer_trigger_dev *stm32;
> +	struct stm32_gptimer_dev *mfd = dev_get_drvdata(pdev->dev.parent);
> +	int ret;
> +
> +	stm32 = stm32_setup_iio_device(dev);
> +	if (!stm32)
> +		return -ENOMEM;

Return stm32.

> +	stm32->dev = dev;
> +	stm32->regmap = mfd->regmap;
> +	stm32->clk = mfd->clk;
> +
> +	stm32->irq = platform_get_irq(pdev, 0);
> +	if (stm32->irq < 0)
> +		return -EINVAL;

return stm32->irq.

> +	ret = devm_request_irq(stm32->dev, stm32->irq,
> +			       stm32_timer_irq_handler, IRQF_SHARED,
> +			       "timer_event", stm32);
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
> +static int stm32_timer_trigger_remove(struct platform_device *pdev)
> +{
> +	struct stm32_timer_trigger_dev *stm32 = platform_get_drvdata(pdev);
> +
> +	iio_triggered_event_cleanup((struct iio_dev *)stm32);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id stm32_trig_of_match[] = {
> +	{
> +		.compatible = "st,stm32-timer-trigger",
> +	},
> +};

Make this one line.

	{ .compatible = "st,stm32-timer-trigger" },

> +MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
> +
> +static struct platform_driver stm32_timer_trigger_driver = {
> +	.probe = stm32_timer_trigger_probe,
> +	.remove = stm32_timer_trigger_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,

Yuk!

> +		.of_match_table = stm32_trig_of_match,
> +	},
> +};
> +module_platform_driver(stm32_timer_trigger_driver);
> +
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_DESCRIPTION("STMicroelectronics STM32 timer trigger driver");
> +MODULE_LICENSE("GPL");

I thought this was "GPL v2"?

> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 809b2e7..f2af4fe 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -46,5 +46,4 @@ config IIO_SYSFS_TRIGGER
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iio-trig-sysfs.
> -
>  endmenu
> diff --git a/include/dt-bindings/iio/timer/st,stm32-timer-triggers.h b/include/dt-bindings/iio/timer/st,stm32-timer-triggers.h
> new file mode 100644
> index 0000000..a13db63
> --- /dev/null
> +++ b/include/dt-bindings/iio/timer/st,stm32-timer-triggers.h
> @@ -0,0 +1,60 @@
> +/*
> + * st,stm32-timer-triggers.h
> + * Copyright (C) STMicroelectronics 2016
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */

Same comments as the top header.

> +#ifndef _DT_BINDINGS_STM32_TIMER_TRIGGERS_H_
> +#define _DT_BINDINGS_STM32_TIMER_TRIGGERS_H_
> +
> +#define TIM1_TRGO	"tim1_trgo"
> +#define TIM1_CH1	"tim1_ch1"
> +#define TIM1_CH2	"tim1_ch2"
> +#define TIM1_CH3	"tim1_ch3"
> +#define TIM1_CH4	"tim1_ch4"
> +
> +#define TIM2_TRGO	"tim2_trgo"
> +#define TIM2_CH1	"tim2_ch1"
> +#define TIM2_CH2	"tim2_ch2"
> +#define TIM2_CH3	"tim2_ch3"
> +#define TIM2_CH4	"tim2_ch4"
> +
> +#define TIM3_TRGO	"tim3_trgo"
> +#define TIM3_CH1	"tim3_ch1"
> +#define TIM3_CH2	"tim3_ch2"
> +#define TIM3_CH3	"tim3_ch3"
> +#define TIM3_CH4	"tim3_ch4"
> +
> +#define TIM4_TRGO	"tim4_trgo"
> +#define TIM4_CH1	"tim4_ch1"
> +#define TIM4_CH2	"tim4_ch2"
> +#define TIM4_CH3	"tim4_ch3"
> +#define TIM4_CH4	"tim4_ch4"
> +
> +#define TIM5_TRGO	"tim5_trgo"
> +#define TIM5_CH1	"tim5_ch1"
> +#define TIM5_CH2	"tim5_ch2"
> +#define TIM5_CH3	"tim5_ch3"
> +#define TIM5_CH4	"tim5_ch4"
> +
> +#define TIM6_TRGO	"tim6_trgo"
> +
> +#define TIM7_TRGO	"tim7_trgo"
> +
> +#define TIM8_TRGO	"tim8_trgo"
> +#define TIM8_CH1	"tim8_ch1"
> +#define TIM8_CH2	"tim8_ch2"
> +#define TIM8_CH3	"tim8_ch3"
> +#define TIM8_CH4	"tim8_ch4"
> +
> +#define TIM9_TRGO	"tim9_trgo"
> +#define TIM9_CH1	"tim9_ch1"
> +#define TIM9_CH2	"tim9_ch2"
> +
> +#define TIM12_TRGO	"tim12_trgo"
> +#define TIM12_CH1	"tim12_ch1"
> +#define TIM12_CH2	"tim12_ch2"

Grim!

uint8 valid_timers[]   = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 12 };
uint8 valid_channels[] = { 0, 1, 2, 3, 4 };

> +#endif
> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
> new file mode 100644
> index 0000000..c22fb3b
> --- /dev/null
> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
> @@ -0,0 +1,16 @@
> +/*
> + * stm32-timer-trigger.h
> + * Copyright (C) STMicroelectronics 2016
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */

Same comments as the top header.

> +#ifndef _STM32_TIMER_TRIGGER_H_
> +#define _STM32_TIMER_TRIGGER_H_
> +
> +#include <dt-bindings/iio/timer/st,stm32-timer-triggers.h>
> +
> +bool is_stm32_timer_trigger(struct iio_trigger *trig);
> +
> +#endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
