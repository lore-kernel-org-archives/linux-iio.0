Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdJHOii (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 10:38:38 -0400
Date: Sun, 8 Oct 2017 15:30:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: Introduce the generic counter interface
Message-ID: <20171008153050.71df3fdf@archlinux>
In-Reply-To: <ae131029e31c4ad54092dd247e411dd3929b0e2d.1507220144.git.vilhelm.gray@gmail.com>
References: <cover.1507220144.git.vilhelm.gray@gmail.com>
        <ae131029e31c4ad54092dd247e411dd3929b0e2d.1507220144.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  5 Oct 2017 14:13:44 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces the IIO generic counter interface for supporting
> counter devices. The generic counter interface serves as a catch-all to
> enable rudimentary support for devices that qualify as counters. More
> specific and apt counter interfaces may be developed on top of the
> generic counter interface, and those interfaces should be used by
> drivers when possible rather than the generic counter interface.

I think you probably want to avoid any additional layering and try to
push things down here (maybe with a few utility functions to simplify
common cases), but that's a question for another day!
> 
> In the context of the IIO generic counter interface, a counter is
> defined as a device that reports one or more "counter values" based on
> the state changes of one or more "counter signals" as evaluated by a
> defined "counter function."
> 
> The IIO generic counter interface piggybacks off of the IIO core. This
> is primarily used to leverage the existing sysfs setup: the IIO_COUNT
> channel attributes represent the Counter Value, while the IIO_SIGNAL
> channel attributes represent the Counter Signal; auxilary IIO_COUNT
> attributes represent the Counter Signal connections (Triggers) and their
> respective state change configurations which trigger an associated
> "counter function" evaluation.
> 
> The iio_counter_ops structure serves as a container for driver callbacks
> to communicate with the device; function callbacks are provided to read
> and write various Signals and Values, and set and get the "trigger mode"
> and "function mode" for various Triggers and Values respectively.
> 
> To support a counter device, a driver must first allocate the available
> Counter Signals via iio_counter_signal structures. These Signals should
> be stored as an array and set to the signals array member of an
> allocated iio_counter structure before the Counter is registered to the
> system.
> 
> Counter Values may be allocated via iio_counter_value structures, and
> respective Counter Signal associations (Triggers) made via
> iio_counter_trigger structures. Associated iio_counter_trigger
> structures are stored as an array and set to the the triggers array
> member of the respective iio_counter_value structure. These
> iio_counter_value structures are set to the values array member of an
> allocated iio_counter structure before the Counter is registered to the
> system.
> 
> A counter device is registered to the system by passing the respective
> initialized iio_counter structure to the iio_counter_register function;
> similarly, the iio_counter_unregister function unregisters the
> respective counter. The devm_iio_counter_register and
> iio_devm_iio_counter_unregister functions serve as device memory-managed
> versions of the iio_counter_register and iio_counter unregister
> functions respectively.

All the find by ids are the main complexity introduced by layering this
on IIO that you probably wouldn't have if it wasn't so layered.  Hmm.
I suggest inline that you could allow drivers to provide fast
versions of that search given they can probably infer it directly from
the index.  Might be something to ignore for now though in the interests
of initial simplicity.

Otherwise a few comments inline, but mostly this is coming together
pretty well.  I'm actually surprised the layering on top of IIO didn't
end up more painful than it did. It's not horrendous - which is not
to say you wouldn't be better breaking free of that entirely...
(I'm not sure either way).

I think the big remaining questions are around naming more than anything
else.  I don't like the name value when a user will think they are looking
for a counter.  If you use counter though the current use of counter needs
to change.

Trigger is also, as has been raised, a rather overloaded term. Not totally
obvious what a better term is but we shouldn't reuse that one...

I'll try and think of something if you have no luck!

Jonathan
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                        |   7 +
>  drivers/iio/Kconfig                |   8 +
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/counter/Kconfig        |   1 +
>  drivers/iio/industrialio-counter.c | 900 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/counter.h        | 166 +++++++
>  6 files changed, 1083 insertions(+)
>  create mode 100644 drivers/iio/industrialio-counter.c
>  create mode 100644 include/linux/iio/counter.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2281af4b41b6..8b7c37bed252 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6693,6 +6693,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
>  F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
>  F:	drivers/iio/adc/envelope-detector.c
>  
> +IIO GENERIC COUNTER INTERFACE
> +M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/industrialio-counter.c
> +F:	include/linux/iio/counter.h

Don't forget the directory the drivers are going in ;)
*laughs manically* 
> +
>  IIO MULTIPLEXER
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b3c8c6ef0dff..78e01f4f5937 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -30,6 +30,14 @@ config IIO_CONFIGFS
>  	  (e.g. software triggers). For more info see
>  	  Documentation/iio/iio_configfs.txt.
>  
> +config IIO_COUNTER
> +	bool "Enable IIO counter support"
> +	help
> +	  Provides IIO core support for counters. This API provides
> +	  a generic interface that serves as the building blocks to
> +	  create more complex counter interfaces. Rudimentary support
> +	  for counters is enabled.
> +
>  config IIO_TRIGGER
>  	bool "Enable triggered sampling support"
>  	help
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 93c769cd99bf..6427ff38f964 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_IIO) += industrialio.o
>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
> +industrialio-$(CONFIG_IIO_COUNTER) += industrialio-counter.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  
>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index 474e1ac4e7c0..c8becfe78e28 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -4,6 +4,7 @@
>  # When adding new entries keep the list in alphabetical order
>  
>  menu "Counters"
> +	depends on IIO_COUNTER
>  
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
> diff --git a/drivers/iio/industrialio-counter.c b/drivers/iio/industrialio-counter.c
> new file mode 100644
> index 000000000000..dfb982dae3a8
> --- /dev/null
> +++ b/drivers/iio/industrialio-counter.c
> @@ -0,0 +1,900 @@
> +/*
> + * Industrial I/O counter interface functions
> + * Copyright (C) 2017 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#include <linux/iio/counter.h>
> +
> +#define iio_priv_get_counter(_indio_dev) \
> +	(*(struct iio_counter **)iio_priv(_indio_dev))
> +
> +static struct iio_counter_signal *iio_counter_signal_find_by_id(
> +	const struct iio_counter *const counter, const int id)
> +{
> +	size_t i;
> +	struct iio_counter_signal *signal;
> +
> +	for (i = 0; i < counter->num_signals; i++) {
> +		signal = counter->signals + i;
> +		if (signal->id == id)
> +			return signal;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct iio_counter_trigger *iio_counter_trigger_find_by_id(
> +	const struct iio_counter_value *const value, const int id)
> +{
> +	size_t i;
> +	struct iio_counter_trigger *trigger;
> +
> +	for (i = 0; i < value->num_triggers; i++) {
> +		trigger = value->triggers + i;
> +		if (trigger->signal->id == id)
> +			return trigger;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct iio_counter_value *iio_counter_value_find_by_id(
> +	const struct iio_counter *const counter, const int id)
> +{
> +	size_t i;
> +	struct iio_counter_value *value;

In most cases this mapping will be entirely obvious to the
driver - perhaps provide an optional callback to let it
provide it directly without any searching?

We could always add this later though if we start getting
drivers with lots of instances of the various parts...

> +
> +	for (i = 0; i < counter->num_values; i++) {
> +		value = counter->values + i;
> +		if (value->id == id)
> +			return value;
> +	}
> +
> +	return NULL;
> +}
> +
> +static ssize_t iio_counter_signal_name_read(struct iio_dev *indio_dev,
> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	const struct iio_counter_signal *signal;
> +
> +	signal = iio_counter_signal_find_by_id(counter, chan->channel2);
> +	if (!signal)
> +		return -EINVAL;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", signal->name);
> +}
> +
> +static ssize_t iio_counter_value_name_read(struct iio_dev *indio_dev,
> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	const struct iio_counter_value *value;
> +
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);
> +	if (!value)
> +		return -EINVAL;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", value->name);

I mentioned before but I wonder if we can just push name down into
the chan spec itself in some fashion.  Whether to associate it with
existing datasheet_name or not is an open question however.

> +}
> +
> +static ssize_t iio_counter_value_triggers_read(struct iio_dev *indio_dev,
> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_value *value;
> +	size_t i;
> +	const struct iio_counter_trigger *trigger;
> +	ssize_t len = 0;
> +
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Print out a list of every Signal association to Value */
> +	for (i = 0; i < value->num_triggers; i++) {
> +		trigger = value->triggers + i;
> +		len += snprintf(buf + len, PAGE_SIZE - len, "%d\t%s\t%s\n",
> +			trigger->signal->id, trigger->signal->name,
> +			trigger->trigger_modes[trigger->mode]);
> +		if (len >= PAGE_SIZE)
> +			return -ENOMEM;
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t iio_counter_trigger_mode_read(struct iio_dev *indio_dev,
> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_value *value;
> +	struct iio_counter_trigger *trigger;
> +	const int signal_id = *(int *)((void *)priv);
> +	int mode;
> +
> +	if (!counter->ops->trigger_mode_get)
> +		return -EINVAL;
> +
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);
> +	if (!value)
> +		return -EINVAL;
> +
> +	trigger = iio_counter_trigger_find_by_id(value, signal_id);
> +	if (!trigger)
> +		return -EINVAL;
> +
> +	mode = counter->ops->trigger_mode_get(counter, value, trigger);
> +
> +	if (mode < 0)
> +		return mode;
> +	else if (mode >= trigger->num_trigger_modes)
> +		return -EINVAL;
> +
> +	trigger->mode = mode;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", trigger->trigger_modes[mode]);
> +}
> +
> +static ssize_t iio_counter_trigger_mode_write(struct iio_dev *indio_dev,
> +	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
> +	size_t len)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_value *value;
> +	ssize_t err;
> +	struct iio_counter_trigger *trigger;
> +	const int signal_id = *(int *)((void *)priv);
> +	unsigned int mode;
> +
> +	if (!counter->ops->trigger_mode_set)
> +		return -EINVAL;
> +
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);
> +	if (!value)
> +		return -EINVAL;
> +
> +	trigger = iio_counter_trigger_find_by_id(value, signal_id);
> +	if (!trigger)
> +		return -EINVAL;
> +
> +	for (mode = 0; mode < trigger->num_trigger_modes; mode++)
> +		if (sysfs_streq(buf, trigger->trigger_modes[mode]))
> +			break;
> +
> +	if (mode >= trigger->num_trigger_modes)
> +		return -EINVAL;
> +
> +	err = counter->ops->trigger_mode_set(counter, value, trigger, mode);
> +	if (err)
> +		return err;
> +
> +	trigger->mode = mode;
> +
> +	return len;
> +}
> +
> +static ssize_t iio_counter_trigger_mode_available_read(
> +	struct iio_dev *indio_dev, uintptr_t priv,
> +	const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_value *value;
> +	ssize_t len = 0;
> +	struct iio_counter_trigger *trigger;
> +	const int signal_id = *(int *)((void *)priv);
> +	unsigned int i;
> +
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);
> +	if (!value)
> +		return -EINVAL;
> +
> +	trigger = iio_counter_trigger_find_by_id(value, signal_id);
> +	if (!trigger)
> +		return -EINVAL;
> +
> +	for (i = 0; i < trigger->num_trigger_modes; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> +			trigger->trigger_modes[i]);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static int iio_counter_value_function_set(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, unsigned int mode)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_value *value;
> +	int err;
> +
> +	if (!counter->ops->value_function_set)
> +		return -EINVAL;
> +
> +	/* Find relevant Value */
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Map IIO core function_set to Generic Counter value_function_set */
> +	err = counter->ops->value_function_set(counter, value, mode);
> +	if (err)
> +		return err;
> +
> +	value->mode = mode;
> +
> +	return 0;
> +}
> +
> +static int iio_counter_value_function_get(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_value *value;
> +	int retval;
> +
> +	if (!counter->ops->value_function_get)
> +		return -EINVAL;
> +
> +	/* Find relevant Value */
> +	value = iio_counter_value_find_by_id(counter, chan->channel2);

Same argument as below - would the driver not be able to do this better?
Often it would know a simple transform to get the right one...


> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Map IIO core function_get to Generic Counter value_function_get */
> +	retval = counter->ops->value_function_get(counter, value);
> +	if (retval < 0)
> +		return retval;
> +	else if (retval >= value->num_function_modes)
> +		return -EINVAL;
> +
> +	value->mode = retval;
> +
> +	return retval;
> +}
> +
> +static int iio_counter_value_ext_info_alloc(struct iio_chan_spec *const chan,
> +	struct iio_counter_value *const value)
> +{
> +	const struct iio_chan_spec_ext_info ext_info_default[] = {
> +		{
> +			.name = "name",
> +			.shared = IIO_SEPARATE,
> +			.read = iio_counter_value_name_read
> +		},
> +		IIO_ENUM("function", IIO_SEPARATE, &value->function_enum),
> +		{
> +			.name = "function_available",
> +			.shared = IIO_SEPARATE,
> +			.read = iio_enum_available_read,
> +			.private = (void *)&value->function_enum
> +		},
> +		{
> +			.name = "triggers",
> +			.shared = IIO_SEPARATE,
> +			.read = iio_counter_value_triggers_read
> +		}
> +	};
> +	const size_t num_default = ARRAY_SIZE(ext_info_default);
> +	const struct iio_chan_spec_ext_info ext_info_trigger[] = {
> +		{
> +			.shared = IIO_SEPARATE,
> +			.read = iio_counter_trigger_mode_read,
> +			.write = iio_counter_trigger_mode_write
> +		},
> +		{
> +			.shared = IIO_SEPARATE,
> +			.read = iio_counter_trigger_mode_available_read
> +		}
> +	};
> +	const size_t num_ext_info_trigger = ARRAY_SIZE(ext_info_trigger);
> +	const size_t num_triggers_ext_info = num_ext_info_trigger *
> +		value->num_triggers;
> +	const size_t num_ext_info = num_default + num_triggers_ext_info + 1;
> +	int err;
> +	struct iio_chan_spec_ext_info *ext_info;
> +	const struct iio_counter_trigger *trigger;
> +	size_t i;
> +	size_t j;
> +
> +	/* Construct function_enum for Value */
> +	value->function_enum.items = value->function_modes;
> +	value->function_enum.num_items = value->num_function_modes;
> +	value->function_enum.set = iio_counter_value_function_set;
> +	value->function_enum.get = iio_counter_value_function_get;
> +
> +	ext_info = kmalloc_array(num_ext_info, sizeof(*ext_info), GFP_KERNEL);
> +	if (!ext_info)
> +		return -ENOMEM;
> +	ext_info[num_ext_info - 1].name = NULL;
> +
> +	/* Add ext_info for the name, function, function_available, and triggers
> +	 * attributes
> +	 */
> +	memcpy(ext_info, ext_info_default, sizeof(ext_info_default));
> +	/* Add ext_info for the trigger_signalX-Z and
> +	 * trigger_signalX-Z_available attributes for each Trigger
> +	 */
> +	for (i = 0; i < num_triggers_ext_info; i += num_ext_info_trigger)
> +		memcpy(ext_info + num_default + i, ext_info_trigger,
> +			sizeof(ext_info_trigger));
> +
> +	/* Set name for each trigger_signalX-Z and trigger_signalX-Z_available
> +	 * attribute; store the respective Signal ID address in each ext_info
> +	 * private member
> +	 */
> +	for (i = num_default, j = 0; j < value->num_triggers; i++, j++) {
> +		trigger = value->triggers + j;
> +
> +		ext_info[i].name = kasprintf(GFP_KERNEL, "trigger_signal%d-%d",
> +			chan->channel, trigger->signal->id);
> +		if (!ext_info[i].name) {
> +			err = -ENOMEM;
> +			goto err_name_alloc;
> +		}
> +		ext_info[i].private = (void *)&trigger->signal->id;
> +		i++;
> +
> +		ext_info[i].name = kasprintf(GFP_KERNEL,
> +			"trigger_signal%d-%d_available",
> +			chan->channel, trigger->signal->id);
> +		if (!ext_info[i].name) {
> +			err = -ENOMEM;
> +			goto err_name_alloc;
> +		}
> +		ext_info[i].private = (void *)&trigger->signal->id;
> +	}
> +
> +	chan->ext_info = ext_info;
> +
> +	return 0;
> +
> +err_name_alloc:
> +	while (i-- > num_default)
> +		kfree(ext_info[i].name);
> +	kfree(ext_info);
> +	return err;
> +}
> +
> +static void iio_counter_value_ext_info_free(
> +	const struct iio_chan_spec *const channel)
> +{
> +	size_t i;
> +	const char *const prefix = "trigger_signal";
> +	const size_t prefix_len = strlen(prefix);
> +
> +	for (i = 0; channel->ext_info[i].name; i++)
> +		if (!strncmp(channel->ext_info[i].name, prefix, prefix_len))
> +			kfree(channel->ext_info[i].name);
> +	kfree(channel->ext_info);
> +}
> +
> +static const struct iio_chan_spec_ext_info iio_counter_signal_ext_info[] = {
> +	{
> +		.name = "name",
> +		.shared = IIO_SEPARATE,
> +		.read = iio_counter_signal_name_read
> +	},
> +	{}
> +};
> +
> +static int iio_counter_channels_alloc(struct iio_counter *const counter)
> +{
> +	const size_t num_channels = counter->num_signals + counter->num_values +
> +		counter->num_channels;
> +	int err;
> +	struct iio_chan_spec *channels;
> +	size_t j;
> +	struct iio_counter_value *value;
> +	size_t i = counter->num_channels;
> +	const struct iio_counter_signal *signal;
> +
> +	channels = kcalloc(num_channels, sizeof(*channels), GFP_KERNEL);

Bring the calculation of num_channels down here - it will make it
more obvious that this allows space for both sources of channel.

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	/* If any channels were supplied on Counter registration,
> +	 * we add them here to the front of the array
> +	 */
> +	memcpy(channels, counter->channels,
> +		counter->num_channels * sizeof(*counter->channels));
> +
> +	/* Add channel for each Value */
> +	for (j = 0; j < counter->num_values; j++) {
> +		value = counter->values + j;
> +
> +		channels[i].type = IIO_COUNT;
> +		channels[i].channel = counter->id;
> +		channels[i].channel2 = value->id;
> +		channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		channels[i].indexed = 1;
> +		channels[i].counter = 1;
> +
> +		/* Add channels for Triggers associated with Value */
Add channels?  'i' would need incrementing.   Also that's not what this function
is doing that I can see...
> +		err = iio_counter_value_ext_info_alloc(channels + i, value);
> +		if (err)
> +			goto err_value_ext_info_alloc;
> +
> +		i++;
> +	}
> +
> +	/* Add channel for each Signal */
> +	for (j = 0; j < counter->num_signals; j++) {
> +		signal = counter->signals + j;
> +
> +		channels[i].type = IIO_SIGNAL;
> +		channels[i].channel = counter->id;
> +		channels[i].channel2 = signal->id;
> +		channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		channels[i].indexed = 1;
> +		channels[i].counter = 1;
> +		channels[i].ext_info = iio_counter_signal_ext_info;
> +
> +		i++;
> +	}
> +
> +	counter->indio_dev->num_channels = num_channels;
> +	counter->indio_dev->channels = channels;
> +
> +	return 0;
> +
> +err_value_ext_info_alloc:
> +	while (i-- > counter->num_channels)
> +		iio_counter_value_ext_info_free(channels + i);
> +	kfree(channels);
> +	return err;
> +}
> +
> +static void iio_counter_channels_free(const struct iio_counter *const counter)
> +{
> +	size_t i = counter->num_channels + counter->indio_dev->num_channels;
> +	const struct iio_chan_spec *const chans = counter->indio_dev->channels;
> +
> +	while (i-- > counter->num_channels)
> +		/* Only IIO_COUNT channels need to be freed here */
> +		if (chans[i].type == IIO_COUNT)
> +			iio_counter_value_ext_info_free(chans + i);
> +
> +	kfree(chans);
> +}
> +
> +static int iio_counter_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_signal *signal;
> +	struct iio_counter_value *value;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	/* Map read_raw to signal_read for Signal */
> +	case IIO_SIGNAL:
> +		if (!counter->ops->signal_read)
> +			return -EINVAL;
> +
> +		signal = iio_counter_signal_find_by_id(counter, chan->channel2);
> +		if (!signal)
> +			return -EINVAL;
> +
> +		return counter->ops->signal_read(counter, signal, val, val2);
> +	/* Map read_raw to value_read for Value */
> +	case IIO_COUNT:
> +		if (!counter->ops->value_read)
> +			return -EINVAL;
> +
> +		value = iio_counter_value_find_by_id(counter, chan->channel2);
> +		if (!value)
> +			return -EINVAL;
> +
> +		return counter->ops->value_read(counter, value, val, val2);
> +	/* Map read_raw to read_raw for non-counter channel */
> +	default:
> +		if (counter->info && counter->info->read_raw)
> +			return counter->info->read_raw(indio_dev, chan, val,
> +				val2, mask);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int iio_counter_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct iio_counter *const counter = iio_priv_get_counter(indio_dev);
> +	struct iio_counter_signal *signal;
> +	struct iio_counter_value *value;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	/* Map write_raw to signal_write for Signal */
> +	case IIO_SIGNAL:
> +		if (!counter->ops->signal_write)
> +			return -EINVAL;
> +
> +		signal = iio_counter_signal_find_by_id(counter, chan->channel2);
> +		if (!signal)
> +			return -EINVAL;

	Hmm. have to search is certainly a little ugly.  Particularly as the driver
	would be able to maintain this as a lookup.  I'd be tempted to pass the
	signal id down into the callback rather than finding the signal in the core.
	Might turn out messier though... :)

> +
> +		return counter->ops->signal_write(counter, signal, val, val2);
> +	/* Map write_raw to value_write for Value */
> +	case IIO_COUNT:
> +		if (!counter->ops->value_write)
> +			return -EINVAL;
> +
> +		value = iio_counter_value_find_by_id(counter, chan->channel2);

Again, this mapping is a simple lookup in the driver I think, perhaps push
it down there?

> +		if (!value)
> +			return -EINVAL;
> +
> +		return counter->ops->value_write(counter, value, val, val2);
> +	/* Map write_raw to write_raw for non-counter channel */
> +	default:
> +		if (counter->info && counter->info->write_raw)
> +			return counter->info->write_raw(indio_dev, chan, val,
> +				val2, mask);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int iio_counter_signals_validate(const struct iio_counter *const counter)
> +{
> +	size_t i;
> +	const struct iio_counter_signal *signal;
> +	size_t j;
> +	int curr_id;
> +
> +	/* At least one Signal must be defined */
> +	if (!counter->num_signals || !counter->signals) {
> +		pr_err("Counter '%d' Signals undefined\n", counter->id);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < counter->num_signals; i++) {
> +		signal = counter->signals + i;
> +		/* No two Signals may share the same ID */
> +		for (j = 0; j < i; j++) {
> +			curr_id = counter->signals[j].id;
> +			if (curr_id == signal->id) {
> +				pr_err("Duplicate Counter '%d' Signal '%d'\n",
> +						counter->id, signal->id);
> +				return -EEXIST;
> +			}
> +		}
> +		for (j = i + 1; j < counter->num_signals; j++) {
> +			curr_id = counter->signals[j].id;
> +			if (curr_id == signal->id) {
> +				pr_err("Duplicate Counter '%d' Signal '%d'\n",
> +						counter->id, signal->id);
> +				return -EEXIST;
> +			}
> +		}

Same as below.

> +	}
> +
> +	return 0;
> +}
> +
> +static int iio_counter_triggers_validate(const int counter_id,
> +	const struct iio_counter_value *const value)
> +{
> +	size_t i;
> +	const struct iio_counter_trigger *trigger;
> +	size_t j;
> +	int curr_id;
> +
> +	/* At least one Trigger must be defined */
> +	if (!value->num_triggers || !value->triggers) {
> +		pr_err("Counter '%d' Value '%d' Triggers undefined\n",
> +			counter_id, value->id);
> +		return -EINVAL;
> +	}
> +
> +	/* Ensure all Triggers have a defined Signal; this prevents a possible
> +	 * NULL pointer dereference when later validating Trigger Signal IDs

Fix comment syntax throughout...

> +	 */
> +	for (i = 0; i < value->num_triggers; i++)
> +		if (!value->triggers[i].signal) {
> +			pr_err("Counter '%d' Trigger '%zu' Signal undefined\n",
> +				counter_id, i);
> +			return -EINVAL;
> +		}
> +
> +	/* Verify validity of each Trigger */
> +	for (i = 0; i < value->num_triggers; i++) {
> +		trigger = value->triggers + i;
> +		/* No two Trigger Signals may share the same ID */
> +		for (j = 0; j < i; j++) {
> +			curr_id = value->triggers[j].signal->id;
> +			if (curr_id == trigger->signal->id) {
> +				pr_err("Signal '%d' is already linked to Counter '%d' Value '%d'\n",
> +					trigger->signal->id, counter_id,
> +					value->id);
> +				return -EEXIST;
> +			}
> +		}
> +		for (j = i + 1; j < value->num_triggers; j++) {
> +			curr_id = value->triggers[j].signal->id;
> +			if (curr_id == trigger->signal->id) {
> +				pr_err("Signal '%d' is already linked to Counter '%d' Value '%d'\n",
> +					trigger->signal->id, counter_id,
> +					value->id);
> +				return -EEXIST;
> +			}
> +		}
Again, one loop with the condition changed so it doesn't fault on the i = j case -- see below and
note I'm reviewing backwards...


> +
> +		/* At least one trigger mode must be defined for each Trigger */
> +		if (!trigger->num_trigger_modes || !trigger->trigger_modes) {
> +			pr_err("Counter '%d' Signal '%d' trigger modes undefined\n",
> +				counter_id, trigger->signal->id);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int iio_counter_values_validate(const struct iio_counter *const counter)
> +{

Hmm. Pretty heavy weight checking.  Ah well, up to you.

> +	size_t i;
> +	const struct iio_counter_value *value;
> +	size_t j;
> +	int curr_id;
> +	int err;
> +
> +	/* At least one Value must be defined */
> +	if (!counter->num_values || !counter->values) {
> +		pr_err("Counter '%d' Values undefined\n", counter->id);
> +		return -EINVAL;
> +	}
> +
> +	/* Verify validity of each Value */
> +	for (i = 0; i < counter->num_values; i++) {
> +		value = counter->values + i;
> +		/* No two Values may share the same ID */
> +		for (j = 0; j < i; j++) {

Single loop with a slightly change to condition
if ((i != j) and (curr_id == value->id))

> +			curr_id = counter->values[j].id;
> +			if (curr_id == value->id) {
> +				pr_err("Duplicate Counter '%d' Value '%d'\n",
> +					counter->id, value->id);
> +				return -EEXIST;
> +			}
> +		}
> +		for (j = i + 1; j < counter->num_values; j++) {
> +			curr_id = counter->values[j].id;
> +			if (curr_id == value->id) {
> +				pr_err("Duplicate Counter '%d' Value '%d'\n",
> +					counter->id, value->id);
> +				return -EEXIST;
> +			}
> +		}
> +
> +		/* At least one function mode must be defined for each Value */
> +		if (!value->num_function_modes || !value->function_modes) {
> +			pr_err("Counter '%d' Value '%d' function modes undefined\n",
> +				counter->id, value->id);
> +			return -EINVAL;
> +		}
> +
> +		/* Verify the Triggers associated with each Value */
> +		err = iio_counter_triggers_validate(counter->id, value);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * iio_counter_register - register Counter to the system
> + * @counter: pointer to IIO Counter to register
> + *
> + * This function piggybacks off of iio_device_register. First, the relevant
> + * Counter members are validated; the signals and values members must be defined
> + * and populated by valid Signal and Value structures respectively. Next, a
> + * struct iio_dev is allocated by a call to iio_device_alloc and initialized for
> + * the Counter, IIO channels are allocated, the Counter address is stored as the
> + * private data, and finally iio_device_register is called.
> + */
> +int iio_counter_register(struct iio_counter *const counter)
> +{
> +	const struct iio_info info_default = {
> +		.read_raw = iio_counter_read_raw,
> +		.write_raw = iio_counter_write_raw
> +	};
> +	int err;
> +	struct iio_info *info;
> +	struct iio_counter **priv;
> +
> +	if (!counter)
> +		return -EINVAL;
> +
> +	/* Verify that Signals are valid and IDs do not conflict */
> +	err = iio_counter_signals_validate(counter);
> +	if (err)
> +		return err;
> +
> +	/* Verify that Values are valid and IDs do not conflict;
Fix multiline comment syntax to standard kernel syntax.
/*
 * Verify
 */
> +	 * Triggers for each Value are also verified for validity
> +	 */
> +	err = iio_counter_values_validate(counter);
> +	if (err)
> +		return err;
> +
> +	counter->indio_dev = iio_device_alloc(sizeof(counter));
> +	if (!counter->indio_dev)
> +		return -ENOMEM;
> +
> +	info = kmalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		err = -ENOMEM;
> +		goto err_info_alloc;
> +	}
> +	/* If an iio_info has been supplied than we use that,
> +	 * otherwise we set all callbacks to NULL; iio_counter_read_raw
> +	 * and iio_counter_write_raw is used for read_raw and write_raw
> +	 * for either case in order to support counter functionality
> +	 * (supplied read_raw/write_raw will be called from within
> +	 * iio_counter_read_raw/iio_counter_write_raw for non-counter
> +	 * channels)
> +	 */

> +	if (counter->info) {
> +		memcpy(info, counter->info, sizeof(*counter->info));
> +		info->read_raw = iio_counter_read_raw;
> +		info->write_raw = iio_counter_write_raw;
> +	} else {
> +		memcpy(info, &info_default, sizeof(info_default));
> +	}
> +
> +	counter->indio_dev->info = info;
> +	counter->indio_dev->modes = INDIO_DIRECT_MODE;
> +	counter->indio_dev->name = counter->name;
> +	counter->indio_dev->dev.parent = counter->dev;
> +
> +	/* IIO channels are allocated and set for Signals, Values, and Triggers;
> +	 * any auxiliary IIO channels provided in iio_counter are also set
> +	 */
> +	err = iio_counter_channels_alloc(counter);
> +	if (err)
> +		goto err_channels_alloc;
> +
> +	/* Pointer to the counter is stored in indio_dev as a way to refer
> +	 * back to the counter from within various IIO callbacks
> +	 */
> +	priv = iio_priv(counter->indio_dev);
> +	memcpy(priv, &counter, sizeof(*priv));
> +
> +	err = iio_device_register(counter->indio_dev);
> +	if (err)
> +		goto err_iio_device_register;
> +
> +	return 0;
> +
> +err_iio_device_register:
> +	iio_counter_channels_free(counter);
> +err_channels_alloc:
> +	kfree(info);
> +err_info_alloc:
> +	iio_device_free(counter->indio_dev);
> +	return err;
> +}
> +EXPORT_SYMBOL(iio_counter_register);
> +
> +/**
> + * iio_counter_unregister - unregister Counter from the system
> + * @counter: pointer to IIO Counter to unregister
> + *
> + * The Counter is unregistered from the system. The indio_dev is unregistered
> + * and all allocated memory is freed.
> + */
> +void iio_counter_unregister(struct iio_counter *const counter)
> +{
> +	const struct iio_info *const info = counter->indio_dev->info;
> +
> +	if (!counter)
> +		return;
> +
> +	iio_device_unregister(counter->indio_dev);
> +
> +	iio_counter_channels_free(counter);
> +
> +	kfree(info);
> +	iio_device_free(counter->indio_dev);
> +}
> +EXPORT_SYMBOL(iio_counter_unregister);
> +
> +static void devm_iio_counter_unreg(struct device *dev, void *res)
> +{
> +	iio_counter_unregister(*(struct iio_counter **)res);
> +}
> +
> +/**
> + * devm_iio_counter_register - Resource-managed iio_counter_register
> + * @dev: Device to allocate iio_counter for
> + * @counter: pointer to IIO Counter to register
> + *
> + * Managed iio_counter_register. The IIO counter registered with this
> + * function is automatically unregistered on driver detach. This function
> + * calls iio_counter_register internally. Refer to that function for more
> + * information.
> + *
> + * If an iio counter registered with this function needs to be unregistered
> + * separately, devm_iio_counter_unregister must be used.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_iio_counter_register(struct device *dev,
> +	struct iio_counter *const counter)
> +{
> +	struct iio_counter **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_iio_counter_unreg, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	*ptr = counter;
> +	ret = iio_counter_register(counter);
> +	if (!ret)
> +		devres_add(dev, ptr);
> +	else
> +		devres_free(ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_iio_counter_register);
> +
> +static int devm_iio_counter_match(struct device *dev, void *res, void *data)
> +{
> +	struct iio_counter **r = res;
> +
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}
> +
> +	return *r == data;
> +}
> +
> +/**
> + * devm_iio_counter_unregister - Resource-managed iio_counter_unregister
> + * @dev: Device this iio_counter belongs to
> + * @counter: the iio counter associated with the device
> + *
> + * Unregister iio counter registered with devm_iio_counter_register.
> + */
> +void devm_iio_counter_unregister(struct device *dev,
> +	struct iio_counter *const counter)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_iio_counter_unreg,
> +		devm_iio_counter_match, counter);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL(devm_iio_counter_unregister);
> diff --git a/include/linux/iio/counter.h b/include/linux/iio/counter.h
> new file mode 100644
> index 000000000000..35645406711a
> --- /dev/null
> +++ b/include/linux/iio/counter.h
> @@ -0,0 +1,166 @@
> +/*
> + * Industrial I/O counter interface
> + * Copyright (C) 2017 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#ifndef _IIO_COUNTER_H_
> +#define _IIO_COUNTER_H_
> +
> +#ifdef CONFIG_IIO_COUNTER
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +
> +/**
> + * struct iio_counter_signal - IIO Counter Signal node
> + * @id:		[DRIVER] unique ID used to identify signal
> + * @name:	[DRIVER] device-specific signal name
> + */
> +struct iio_counter_signal {
> +	int		id;
> +	const char	*name;
> +};
> +
> +/**
> + * struct iio_counter_trigger - IIO Counter Trigger node
> + * @mode:		[DRIVER] current trigger mode state
> + * @trigger_modes:	[DRIVER] available trigger modes
> + * @num_trigger_modes:	[DRIVER] number of modes specified in @trigger_modes
> + * @signal:		[DRIVER] pointer to associated signal
> + */
> +struct iio_counter_trigger {
> +	unsigned int			mode;
> +	const char *const		*trigger_modes;
> +	unsigned int			num_trigger_modes;
> +	struct iio_counter_signal	*signal;

Are signals actually changeable? - Or is that pointer constant?

> +};
> +
> +/**
> + * struct iio_counter_value - IIO Counter Value node
> + * @id:			[DRIVER] unique ID used to identify value
> + * @name:		[DRIVER] device-specific value name
> + * @mode:		[DRIVER] current function mode state
> + * @function_modes:	[DRIVER] available function modes
> + * @num_function_modes:	[DRIVER] number of modes specified in @function_modes
> + * @triggers:		[DRIVER] array of triggers for initialization
> + * @num_triggers:	[DRIVER] number of triggers specified in @triggers
> + * @function_enum:	[INTERN] used internally to generate function attributes
> + */
> +struct iio_counter_value {
> +	int			id;
> +	const char		*name;
> +	unsigned int		mode;
> +	const char *const	*function_modes;
> +	unsigned int		num_function_modes;
> +
> +	struct iio_counter_trigger	*triggers;
> +	size_t				num_triggers;
> +
> +	struct iio_enum		function_enum;
> +};
> +
> +struct iio_counter;
> +
> +/**
> + * struct iio_counter_ops - IIO Counter related callbacks
> + * @signal_read:	function to request a signal value from the device.
> + *			Return value will specify the type of value returned by
> + *			the device. val and val2 will contain the elements
> + *			making up the returned value.

Add some detail on the importance of the return value.

> + * @signal_write:	function to write a signal value to the device.
> + *                      Parameters are interpreted the same as signal_read.

You need a means of establishing the correct format for write (we needed it
in IIO fairly early on too)

> + * @trigger_mode_set:	function to set the trigger mode. mode is the index of
> + *			the requested mode from the value trigger_modes array.
> + * @trigger_mode_get:	function to get the current trigger mode. Return value
> + *			will specify the index of the current mode from the
> + *			value trigger_modes array.
> + * @value_read:		function to request a value value from the device.
> + *			Return value will specify the type of value returned by
> + *			the device. val and val2 will contain the elements
> + *			making up the returned value.
> + * @value_write:	function to write a value value to the device.
> + *                      Parameters are interpreted the same as value_read.
> + * @value_function_set: function to set the value function mode. mode is the
> + *			index of the requested mode from the value
> + *			function_modes array.
> + * @value_function_get: function to get the current value function mode. Return
> + *			value will specify the index of the current mode from
> + *			the value function_modes array.
> + */
> +struct iio_counter_ops {
> +	int (*signal_read)(struct iio_counter *counter,
> +		struct iio_counter_signal *signal, int *val, int *val2);
> +	int (*signal_write)(struct iio_counter *counter,
> +		struct iio_counter_signal *signal, int val, int val2);
> +	int (*trigger_mode_set)(struct iio_counter *counter,
> +		struct iio_counter_value *value,
> +		struct iio_counter_trigger *trigger, unsigned int mode);
> +	int (*trigger_mode_get)(struct iio_counter *counter,
> +		struct iio_counter_value *value,
> +		struct iio_counter_trigger *trigger);
> +	int (*value_read)(struct iio_counter *counter,
> +		struct iio_counter_value *value, int *val, int *val2);
> +	int (*value_write)(struct iio_counter *counter,
> +		struct iio_counter_value *value, int val, int val2);
> +	int (*value_function_set)(struct iio_counter *counter,
> +		struct iio_counter_value *value, unsigned int mode);
> +	int (*value_function_get)(struct iio_counter *counter,
> +		struct iio_counter_value *value);
> +};
> +
> +/**
> + * struct iio_counter - IIO Counter data structure
> + * @id:			[DRIVER] unique ID used to identify counter
> + * @name:		[DRIVER] name of the device
> + * @dev:		[DRIVER] device structure, should be assigned a parent
> + *			and owner
> + * @ops:		[DRIVER] callbacks from driver for counter components
> + * @signals:		[DRIVER] array of signals for initialization
> + * @num_signals:	[DRIVER] number of signals specified in @signals
> + * @values:		[DRIVER] array of values for initialization
> + * @num_values:		[DRIVER] number of values specified in @values
> + * @channels:		[DRIVER] channel specification structure table
> + * @num_channels:	[DRIVER] number of channels specified in @channels
> + * @info:		[DRIVER] callbacks and constant info from driver
> + * @indio_dev:		[INTERN] industrial I/O device structure
> + * @driver_data:	[DRIVER] driver data
> + */
> +struct iio_counter {

Mentioned earlier - I think naming the device counter, is confusing.
The counters should be named counter - call it iio_counter_device
or iio_counter_group or something and keep counter for the things
currently called value.

> +	int				id;
> +	const char			*name;
> +	struct device			*dev;
> +	const struct iio_counter_ops	*ops;
> +
> +	struct iio_counter_signal	*signals;
> +	size_t				num_signals;
> +	struct iio_counter_value	*values;
> +	size_t				num_values;
> +
> +	const struct iio_chan_spec	*channels;
> +	size_t				num_channels;
> +	const struct iio_info		*info;
> +
> +	struct iio_dev	*indio_dev;
> +	void		*driver_data;
> +};
> +
> +int iio_counter_register(struct iio_counter *const counter);
> +void iio_counter_unregister(struct iio_counter *const counter);
> +int devm_iio_counter_register(struct device *dev,
> +	struct iio_counter *const counter);
> +void devm_iio_counter_unregister(struct device *dev,
> +	struct iio_counter *const counter);
> +
> +#endif /* CONFIG_IIO_COUNTER */
> +
> +#endif /* _IIO_COUNTER_H_ */

