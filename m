Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbeAAMJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 07:09:15 -0500
Date: Mon, 1 Jan 2018 12:09:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] iio: Introduce the Generic Counter interface
Message-ID: <20180101120910.25c95579@archlinux>
In-Reply-To: <65ea6a679d10634ef25cc92223cec1089909517c.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
        <65ea6a679d10634ef25cc92223cec1089909517c.1513266127.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Dec 2017 15:50:43 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces the Generic Counter interface for supporting
> counter devices. The Generic Counter interface serves as a catch-all to
> enable rudimentary support for devices that qualify as counters. More
> specific and apt counter interfaces may be developed on top of the
> Generic Counter interface, and those interfaces should be used by
> drivers where possible rather than the Generic Counter interface
> directly.
> 
> In the context of the Generic Counter interface, a counter is defined as
> a device that reports one or more "counter counts" based on the state
> changes of one or more "counter signals" as evaluated by a defined
> "counter function."
> 
> Driver callbacks should be provided to communicate with the device: to
> read and write various Signals and Counts, and to set and get the
> "action mode" and "function mode" for various Synapses and Counts
> respectively.
> 
> To support a counter device, a driver must first allocate the available
> Counter Signals via counter_signal structures. These Signals should
> be stored as an array and set to the signals array member of an
> allocated counter_device structure before the Counter is registered to
> the system.
> 
> Counter Counts may be allocated via counter_count structures, and
> respective Counter Signal associations (Synapses) made via
> counter_synapse structures. Associated counter_synapse structures are
> stored as an array and set to the the synapses array member of the
> respective counter_count structure. These counter_count structures are
> set to the counts array member of an allocated counter_device structure
> before the Counter is registered to the system.
> 
> A counter device is registered to the system by passing the respective
> initialized counter_device structure to the counter_register function;
> similarly, the counter_unregister function unregisters the respective
> Counter. The devm_counter_register and devm_counter_unregister functions
> serve as device memory-managed versions of the counter_register and
> counter_unregister functions respectively.

A few minor comments inline but looks basically sound to me.

Jonathan
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                           |   7 +
>  drivers/iio/Kconfig                   |   3 +-
>  drivers/iio/counter/Kconfig           |  16 +-
>  drivers/iio/counter/Makefile          |   3 +
>  drivers/iio/counter/generic-counter.c | 992 ++++++++++++++++++++++++++++++++++
>  include/linux/iio/counter.h           | 239 ++++++++
>  6 files changed, 1255 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/iio/counter/generic-counter.c
>  create mode 100644 include/linux/iio/counter.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36f76be322a3..07dd7b933bfa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3661,6 +3661,13 @@ W:	http://www.fi.muni.cz/~kas/cosa/
>  S:	Maintained
>  F:	drivers/net/wan/cosa*
>  
> +COUNTER INTERFACE
> +M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/counter/
> +F:	include/linux/iio/counter.h
> +
>  CPMAC ETHERNET DRIVER
>  M:	Florian Fainelli <f.fainelli@gmail.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b3c8c6ef0dff..62a923aeb462 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -73,7 +73,6 @@ source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
>  source "drivers/iio/chemical/Kconfig"
>  source "drivers/iio/common/Kconfig"
> -source "drivers/iio/counter/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/dummy/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
> @@ -95,3 +94,5 @@ source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
>  
>  endif # IIO
> +
> +source "drivers/iio/counter/Kconfig"
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index 474e1ac4e7c0..4eaf4e53c5aa 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -3,11 +3,18 @@
>  #
>  # When adding new entries keep the list in alphabetical order
>  
> -menu "Counters"
> +menuconfig COUNTER
> +	tristate "Counter support"
> +	help
> +	  Provides support for Counter devices. The Generic Counter API provides
> +	  rudimentary support for counters and serves as building blocks to
> +	  create more complex counter interfaces.
> +
> +if COUNTER
>  
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
> -	depends on PC104 && X86 && ISA_BUS_API
> +	depends on PC104 && X86 && ISA_BUS_API && IIO
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
>  	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
> @@ -23,11 +30,12 @@ config 104_QUAD_8
>  
>  config STM32_LPTIMER_CNT
>  	tristate "STM32 LP Timer encoder counter driver"
> -	depends on MFD_STM32_LPTIMER || COMPILE_TEST
> +	depends on (MFD_STM32_LPTIMER || COMPILE_TEST) && IIO
>  	help
>  	  Select this option to enable STM32 Low-Power Timer quadrature encoder
>  	  and counter driver.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer-cnt.
> -endmenu
> +
> +endif # COUNTER
> diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
> index 1b9a896eb488..513c49d832d4 100644
> --- a/drivers/iio/counter/Makefile
> +++ b/drivers/iio/counter/Makefile
> @@ -4,5 +4,8 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  
> +obj-$(CONFIG_COUNTER) += counter.o
> +counter-$(CONFIG_COUNTER) += generic-counter.o
> +
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> diff --git a/drivers/iio/counter/generic-counter.c b/drivers/iio/counter/generic-counter.c
> new file mode 100644
> index 000000000000..0efd36ee2118
> --- /dev/null
> +++ b/drivers/iio/counter/generic-counter.c
> @@ -0,0 +1,992 @@
> +/*
> + * Generic Counter interface
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
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/gfp.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/kdev_t.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/counter.h>
> +
> +struct counter_device_attr {
> +	struct device_attribute		dev_attr;
> +	struct list_head		l;
> +	void				*component;
> +	void				*component_data;
> +};
> +
> +static int counter_attribute_create(const char *const prefix,
> +	const char *const name,
> +	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
> +		char *buf),
> +	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t len),
> +	void *const component, void *const component_data,
> +	struct counter_device_state *const device_state)
> +{
> +	struct counter_device_attr *counter_attr;
> +	struct device_attribute *dev_attr;
> +	struct counter_device_attr *t;
> +	int err;
> +	struct list_head *const attr_list = &device_state->attr_list;
> +
> +	/* Allocate a Counter device attribute */
> +	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> +	if (!counter_attr)
> +		return -ENOMEM;
> +	dev_attr = &counter_attr->dev_attr;
> +
> +	sysfs_attr_init(&dev_attr->attr);
> +
> +	/* Configure device attribute */
> +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, name);
> +	if (!dev_attr->attr.name) {
> +		err = -ENOMEM;
> +		goto err_free_counter_attr;
> +	}
> +	if (show) {
> +		dev_attr->attr.mode |= 0444;
> +		dev_attr->show = show;
> +	}
> +	if (store) {
> +		dev_attr->attr.mode |= 0200;
> +		dev_attr->store = store;
> +	}
> +
> +	/* Check for duplicate name */
> +	list_for_each_entry(t, attr_list, l)
> +		if (!strcmp(t->dev_attr.attr.name, dev_attr->attr.name)) {
> +			dev_err(&device_state->dev,
> +				"tried to double register : %s\n",
> +				t->dev_attr.attr.name);
> +			err = -EBUSY;
> +			goto err_free_attr_name;
> +		}
I think there is no actual need to deal with the duplicate
here. It will cause an error when the sysfs attributes are actually
created.  I'd leave it until there to run this sanity check as this
represents a bug anyway so no real need to check for it early.
> +
> +	/* Store associated Counter component with attribute */
> +	counter_attr->component = component;
> +	counter_attr->component_data = component_data;
> +
> +	/* Keep track of the attribute for later cleanup */
> +	list_add(&counter_attr->l, attr_list);
> +	device_state->num_attr++;
> +
> +	return 0;
> +
> +err_free_attr_name:
> +	kfree(dev_attr->attr.name);
> +err_free_counter_attr:
> +	kfree(counter_attr);
> +	return err;
> +}
> +
> +#define to_counter_attr(_dev_attr) \
> +	container_of(_dev_attr, struct counter_device_attr, dev_attr)
> +
> +static ssize_t counter_signal_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_signal *const signal = to_counter_attr(attr)->component;
> +
> +	return counter->signal_read(counter, signal, buf);
> +}
> +
> +static ssize_t counter_signal_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_signal *const signal = to_counter_attr(attr)->component;
> +
> +	return counter->signal_write(counter, signal, buf, len);
> +}
> +
> +static ssize_t counter_device_attr_name_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const char *const name = to_counter_attr(attr)->component;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", name);
> +}
> +
> +static ssize_t counter_signal_ext_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct counter_signal_ext *const ext = devattr->component_data;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_signal *const signal = devattr->component;
> +
> +	return ext->read(counter, signal, ext->priv, buf);
> +}
> +
> +static ssize_t counter_signal_ext_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct counter_signal_ext *const ext = devattr->component_data;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_signal *const signal = devattr->component;
> +
> +	return ext->write(counter, signal, ext->priv, buf, len);
> +}
> +
> +static int counter_signal_ext_register(const char *const prefix,
> +	struct counter_signal *const signal,
> +	struct counter_device_state *const device_state)
> +{
> +	const size_t num_ext = signal->num_ext;
> +	size_t i;
> +	const struct counter_signal_ext *ext;
> +	int err;
> +
> +	/* Return early if no extensions */
> +	if (!signal->ext || !num_ext)
> +		return 0;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = signal->ext + i;
> +		err = counter_attribute_create(prefix, ext->name,
> +			(ext->read) ? counter_signal_ext_show : NULL,
> +			(ext->write) ? counter_signal_ext_store : NULL,
> +			signal, ext, device_state);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_signal_attributes_create(const char *const signal_attr_name,
> +	const struct counter_device *const counter,
> +	struct counter_signal *const signal)
> +{
> +	struct counter_device_state *const device_state = counter->device_state;
> +	int err;
> +	const char *prefix;
> +
> +	/* Create main Signal attribute */
> +	err = counter_attribute_create("", signal_attr_name,
> +		(counter->signal_read) ? counter_signal_show : NULL,
> +		(counter->signal_write) ? counter_signal_store : NULL,
> +		signal, NULL, device_state);
> +	if (err)
> +		return err;
> +
> +	prefix = kasprintf(GFP_KERNEL, "%s_", signal_attr_name);
> +	if (!prefix)
> +		return -ENOMEM;
> +
> +	/* Create Signal name attribute */
> +	if (signal->name) {
> +		err = counter_attribute_create(prefix, "name",
> +			counter_device_attr_name_show, NULL, signal->name, NULL,
> +			device_state);
> +		if (err)
> +			goto err_free_prefix;
> +	}
> +
> +	/* Register Signal extension attributes */
> +	err = counter_signal_ext_register(prefix, signal, device_state);
> +	if (err)
> +		goto err_free_prefix;
> +
> +	kfree(prefix);
> +
> +	return 0;
> +
> +err_free_prefix:
> +	kfree(prefix);
> +	return err;
> +}
> +
> +static int counter_signals_register(const struct counter_device *const counter)
> +{
> +	const size_t num_signals = counter->num_signals;
> +	struct counter_device_state *const device_state = counter->device_state;
> +	struct device *const dev = &device_state->dev;
> +	size_t i;
> +	struct counter_signal *signal;
> +	const char *name;
> +	int err;
> +
> +	/* At least one Signal must be defined */
> +	if (!counter->signals || !num_signals) {
> +		dev_err(dev, "Signals undefined\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register each Signal */
> +	for (i = 0; i < num_signals; i++) {
> +		signal = counter->signals + i;
> +
> +		/* Generate Signal attribute name */
> +		name = kasprintf(GFP_KERNEL, "signal%d", signal->id);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		/* Create all attributes associated with Signal */
> +		err = counter_signal_attributes_create(name, counter, signal);
> +		if (err)
> +			goto err_free_name;
> +
> +		kfree(name);
> +	}
> +
> +	return 0;
> +
> +err_free_name:
> +	kfree(name);
> +	return err;
> +}
> +
> +static ssize_t counter_action_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = devattr->component_data;
> +	struct counter_synapse *const synapse = devattr->component;
> +	size_t action;
> +
> +	err = counter->action_get(counter, count, synapse, &action);
> +	if (err)
> +		return err;
> +
> +	synapse->action = action;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", synapse->actions[action]);
> +}
> +
> +static ssize_t counter_action_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	struct counter_synapse *const synapse = devattr->component;
> +	size_t action;
> +	const size_t num_actions = synapse->num_actions;
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = devattr->component_data;
> +
> +	/* Find requested action mode */
> +	for (action = 0; action < num_actions; action++)
> +		if (sysfs_streq(buf, synapse->actions[action]))
> +			break;
> +	/* If requested action mode not found */
> +	if (action >= num_actions)
> +		return -EINVAL;
> +
> +	err = counter->action_set(counter, count, synapse, action);
> +	if (err)
> +		return err;
> +
> +	synapse->action = action;
> +
> +	return len;
> +}
> +
> +static ssize_t counter_device_attr_available_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const char *const *const modes = devattr->component;
> +	const size_t num_modes = *(size_t *)devattr->component_data;
> +	ssize_t len = 0;
> +	size_t i;
> +
> +	for (i = 0; i < num_modes; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n", modes[i]);
> +
> +	return len;
> +}
> +
> +static int counter_synapses_register(const struct counter_device *const counter,
> +	struct counter_count *const count, const char *const count_attr_name)
> +{
> +	struct counter_device_state *const device_state = counter->device_state;
> +	const size_t num_synapses = count->num_synapses;
> +	struct device *const dev = &device_state->dev;
> +	size_t i;
> +	struct counter_synapse *synapse;
> +	const char *prefix;
> +	int err;
> +
> +	/* At least one Synapse must be defined */
> +	if (!count->synapses || !num_synapses) {
> +		dev_err(dev, "Count '%d' Synapses undefined\n",	count->id);
> +		return -EINVAL;
> +	}
> +
> +	/* Register each Synapse */
> +	for (i = 0; i < num_synapses; i++) {
> +		synapse = count->synapses + i;
> +
> +		/* Ensure all Synapses have a defined Signal */
> +		if (!synapse->signal) {
> +			dev_err(dev,
> +				"Count '%d' Synapse '%zu' Signal undefined\n",
> +				count->id, i);
> +			return -EINVAL;
> +		}
> +
> +		/* At least one action mode must be defined for each Synapse */
> +		if (!synapse->actions || !synapse->num_actions) {
> +			dev_err(dev,
> +				"Count '%d' Signal '%d' action modes undefined\n",
> +				count->id, synapse->signal->id);
> +			return -EINVAL;
> +		}
> +
> +		/* Generate attribute prefix */
> +		prefix = kasprintf(GFP_KERNEL, "%s_signal%d_", count_attr_name,
> +			synapse->signal->id);
> +		if (!prefix)
> +			return -ENOMEM;
> +
> +		/* Create action attribute */
> +		err = counter_attribute_create(prefix, "action",
> +			(counter->action_get) ? counter_action_show : NULL,
> +			(counter->action_set) ? counter_action_store : NULL,
> +			synapse, count, device_state);
> +		if (err)
> +			goto err_free_prefix;
> +
> +		/* Create action_available attribute */
> +		err = counter_attribute_create(prefix, "action_available",
> +			counter_device_attr_available_show, NULL,
> +			synapse->actions, &synapse->num_actions, device_state);
> +		if (err)
> +			goto err_free_prefix;
> +
> +		kfree(prefix);
> +	}
> +
> +	return 0;
> +
> +err_free_prefix:
> +	kfree(prefix);
> +	return err;
> +}
> +
> +static ssize_t counter_count_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = to_counter_attr(attr)->component;
> +
> +	return counter->count_read(counter, count, buf);
> +}
> +
> +static ssize_t counter_count_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = to_counter_attr(attr)->component;
> +
> +	return counter->count_write(counter, count, buf, len);
> +}
> +
> +static ssize_t counter_function_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = to_counter_attr(attr)->component;
> +	size_t function;
> +
> +	err = counter->function_get(counter, count, &function);
> +	if (err)
> +		return err;
> +
> +	count->function = function;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", count->functions[function]);
> +}
> +
> +static ssize_t counter_function_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct counter_count *const count = to_counter_attr(attr)->component;
> +	const size_t num_functions = count->num_functions;
> +	size_t function;
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	/* Find requested Count function mode */
> +	for (function = 0; function < num_functions; function++)
> +		if (sysfs_streq(buf, count->functions[function]))
> +			break;
> +	/* Return error if requested Count function mode not found */
> +	if (function >= num_functions)
> +		return -EINVAL;
> +
> +	err = counter->function_set(counter, count, function);
> +	if (err)
> +		return err;
> +
> +	count->function = function;
> +
> +	return len;
> +}
> +
> +static ssize_t counter_count_synapses_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	size_t i;
> +	struct counter_count *const count = to_counter_attr(attr)->component;
> +	const struct counter_synapse *synapse;
> +	ssize_t len = 0;
> +
> +	/* Print out a list of every Signal association to Count */
> +	for (i = 0; i < count->num_synapses; i++) {
> +		synapse = count->synapses + i;
> +		len += snprintf(buf + len, PAGE_SIZE - len, "%d\t%s\t%s\n",
> +			synapse->signal->id, synapse->signal->name,
> +			synapse->actions[synapse->action]);
> +		if (len >= PAGE_SIZE)
> +			return -ENOMEM;
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t counter_count_ext_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct counter_count_ext *const ext = devattr->component_data;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = devattr->component;
> +
> +	return ext->read(counter, count, ext->priv, buf);
> +}
> +
> +static ssize_t counter_count_ext_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct counter_count_ext *const ext = devattr->component_data;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = devattr->component;
> +
> +	return ext->write(counter, count, ext->priv, buf, len);
> +}
> +
> +static int counter_count_ext_register(const char *const prefix,
> +	struct counter_count *const count,
> +	struct counter_device_state *const device_state)
> +{
> +	const size_t num_ext = count->num_ext;
> +	size_t i;
> +	const struct counter_count_ext *ext;
> +	int err;
> +
> +	/* Return early if no extensions */
> +	if (!count->ext || !num_ext)
> +		return 0;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = count->ext + i;
> +		err = counter_attribute_create(prefix, ext->name,
> +			(ext->read) ? counter_count_ext_show : NULL,
> +			(ext->write) ? counter_count_ext_store : NULL,
> +			count, ext, device_state);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_count_attributes_create(const char *const count_attr_name,
> +	const struct counter_device *const counter,
> +	struct counter_count *const count)
> +{
> +	struct counter_device_state *const device_state = counter->device_state;
> +	int err;
> +	const char *prefix;
> +
> +	/* Create main Count attribute */
> +	err = counter_attribute_create("", count_attr_name,
> +		(counter->count_read) ? counter_count_show : NULL,
> +		(counter->count_write) ? counter_count_store : NULL,
> +		count, NULL, device_state);
> +	if (err)
> +		return err;
> +
> +	prefix = kasprintf(GFP_KERNEL, "%s_", count_attr_name);
> +	if (!prefix)
> +		return -ENOMEM;
> +
> +	/* Create Count function attribute */
> +	err = counter_attribute_create(prefix, "function",
> +		(counter->function_get) ? counter_function_show : NULL,
> +		(counter->function_set) ? counter_function_store : NULL,
> +		count, NULL, device_state);
> +	if (err)
> +		goto err_free_prefix;
> +
> +	/* Create Count function_available attribute */
> +	err = counter_attribute_create(prefix, "function_available",
> +		counter_device_attr_available_show, NULL, count->functions,
> +		&count->num_functions, device_state);
> +	if (err)
> +		goto err_free_prefix;
> +
> +	/* Create Count synapses attribute */
> +	err = counter_attribute_create(prefix, "synapses",
> +		counter_count_synapses_show, NULL, count, NULL, device_state);
> +	if (err)
> +		goto err_free_prefix;
> +
> +	/* Create Count name attribute */
> +	if (count->name) {
> +		err = counter_attribute_create(prefix, "name",
> +			counter_device_attr_name_show,	NULL, count->name, NULL,
> +			device_state);
> +		if (err)
> +			goto err_free_prefix;
> +	}
> +
> +	/* Register Count extension attributes */
> +	err = counter_count_ext_register(prefix, count, device_state);
> +	if (err)
> +		goto err_free_prefix;
> +
> +	kfree(prefix);
> +
> +	return 0;
> +
> +err_free_prefix:
> +	kfree(prefix);
> +	return err;
> +}
> +
> +static int counter_counts_register(const struct counter_device *const counter)
> +{
> +	const size_t num_counts = counter->num_counts;
> +	struct device *const dev = &counter->device_state->dev;
> +	size_t i;
> +	struct counter_count *count;
> +	const char *name;
> +	int err;
> +
> +	/* At least one Count must be defined */
> +	if (!counter->counts || !num_counts) {
> +		dev_err(dev, "Counts undefined\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register each Count */
> +	for (i = 0; i < num_counts; i++) {
> +		count = counter->counts + i;
> +
> +		/* At least one function mode must be defined for each Count */
> +		if (!count->functions || !count->num_functions) {
> +			dev_err(dev, "Count '%d' function modes undefined\n",
> +				count->id);
> +			return -EINVAL;
> +		}
> +
> +		/* Generate attribute name */
> +		name = kasprintf(GFP_KERNEL, "count%d", count->id);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		/* Register the Synapses associated with each Count */
> +		err = counter_synapses_register(counter, count, name);
> +		if (err)
> +			goto err_free_name;
> +
> +		/* Create all attributes associated with Count */
> +		err = counter_count_attributes_create(name, counter, count);
> +		if (err)
> +			goto err_free_name;
> +
> +		kfree(name);
> +	}
> +
> +	return 0;
> +
> +err_free_name:
> +	kfree(name);
> +	return err;
> +}
> +
> +static struct bus_type counter_bus_type = {
> +	.name = "counter"
> +};
> +
> +static dev_t counter_devt;
> +
> +#define COUNTER_DEV_MAX 256
> +
> +static int __init counter_init(void)
> +{
> +	int err;
> +
> +	err = bus_register(&counter_bus_type);
> +	if (err) {
> +		pr_err("counter: could not register Counter bus type\n");
> +		return err;
> +	}
> +
> +	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "counter");
> +	if (err) {
> +		pr_err("counter: failed to allocate char dev region\n");
> +		bus_unregister(&counter_bus_type);
> +		return err;

Drop this and return err below

> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit counter_exit(void)
> +{
> +	if (counter_devt)
> +		unregister_chrdev_region(counter_devt, COUNTER_DEV_MAX);
> +	bus_unregister(&counter_bus_type);
> +}
> +
> +static void free_counter_device_state_attr_list(struct list_head *attr_list)
> +{
> +	struct counter_device_attr *p, *n;
> +
> +	list_for_each_entry_safe(p, n, attr_list, l) {
> +		kfree(p->dev_attr.attr.name);
> +		list_del(&p->l);
> +		kfree(p);
> +	}
> +}
> +
> +/* Provides a unique ID for each counter device */
> +static DEFINE_IDA(counter_ida);
> +
> +static void counter_device_release(struct device *dev)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_device_state *const device_state = counter->device_state;
> +
> +	kfree(device_state->attr_group.attrs);
> +	free_counter_device_state_attr_list(&device_state->attr_list);
> +	ida_simple_remove(&counter_ida, device_state->id);
> +	kfree(device_state);
> +}
> +
> +static struct device_type counter_device_type = {
> +	.name = "counter_device",
> +	.release = counter_device_release
> +};
> +
> +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct counter_device_state *const device_state = container_of(
> +		inode->i_cdev, struct counter_device_state, chrdev);
> +	struct device *const dev = &device_state->dev;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	get_device(dev);
> +	filp->private_data = counter;
> +
> +	return 0;
> +}
> +
> +static int counter_chrdev_release(struct inode *inode, struct file *filp)
> +{
> +	struct counter_device_state *const device_state = container_of(
> +		inode->i_cdev, struct counter_device_state, chrdev);
> +
> +	put_device(&device_state->dev);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations counter_fileops = {
> +	.owner = THIS_MODULE,
> +	.open = counter_chrdev_open,
> +	.release = counter_chrdev_release
> +};
> +
> +static ssize_t counter_device_ext_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct counter_device_ext *const ext = devattr->component_data;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	return ext->read(counter, ext->priv, buf);
> +}
> +
> +static ssize_t counter_device_ext_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct counter_device_ext *const ext = devattr->component_data;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	return ext->write(counter, ext->priv, buf, len);
> +}
> +
> +static int counter_device_ext_register(struct counter_device *const counter)
> +{
> +	const size_t num_ext = counter->num_ext;
> +	size_t i;
> +	const struct counter_device_ext *ext;
> +	int err;
> +
> +	/* Return early if no extensions */
> +	if (!counter->ext || !num_ext)
> +		return 0;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = counter->ext + i;
> +		err = counter_attribute_create("", ext->name,
> +			(ext->read) ? counter_device_ext_show : NULL,
> +			(ext->write) ? counter_device_ext_store : NULL,
> +			NULL, ext, counter->device_state);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t counter_name_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", counter->name);
> +}
> +
> +static DEVICE_ATTR_RO(counter_name);
> +
> +/**
> + * counter_register - register Counter to the system
> + * @counter: pointer to Counter to register
> + *
> + * This function registers a Counter to the system. A sysfs "counter" directory
> + * will be created and populated with sysfs attributes correlating with the
> + * Counter Signals, Synapses, and Counts respectively.
> + */
> +int counter_register(struct counter_device *const counter)
> +{
> +	int err;
> +	struct counter_device_state *device_state;
> +	struct counter_device_attr *p;
> +	size_t i = 0;
> +
> +	if (!counter)
> +		return -EINVAL;
> +
> +	/* Allocate internal state container for Counter device */
> +	device_state = kzalloc(sizeof(*device_state), GFP_KERNEL);
> +	if (!device_state)
> +		return -ENOMEM;
> +	counter->device_state = device_state;
> +
> +	/* Acquire unique ID */
> +	device_state->id = ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> +	if (device_state->id < 0) {
> +		err = device_state->id;
> +		goto err_free_device_state;
> +	}
> +
> +	/* Configure device structure for Counter */
> +	device_state->dev.type = &counter_device_type;
> +	device_state->dev.bus = &counter_bus_type;
> +	if (counter->parent) {
> +		device_state->dev.parent = counter->parent;
> +		device_state->dev.of_node = counter->parent->of_node;
> +	}
> +	dev_set_name(&device_state->dev, "counter%d", device_state->id);
> +	device_initialize(&device_state->dev);
> +	dev_set_drvdata(&device_state->dev, counter);
> +	device_state->dev.devt = MKDEV(MAJOR(counter_devt), device_state->id);
> +
> +	/* Initialize attribute list */
> +	INIT_LIST_HEAD(&device_state->attr_list);
> +
> +	/* Verify Signals are valid and register */
> +	err = counter_signals_register(counter);
> +	if (err)
> +		goto err_free_attributes;
> +
> +	/* Verify Counts and respective Synapses are valid and register */
> +	err = counter_counts_register(counter);
> +	if (err)
> +		goto err_free_attributes;
> +
> +	/* Register Counter device extension attributes */
> +	err = counter_device_ext_register(counter);
> +	if (err)
> +		goto err_free_attributes;
> +
> +	/* Account for name attribute */
> +	if (counter->name)
> +		device_state->num_attr++;
> +
> +	/* Allocate space for attribute pointers in attribute group */
> +	device_state->attr_group.attrs = kcalloc(device_state->num_attr + 1,
> +		sizeof(*device_state->attr_group.attrs), GFP_KERNEL);
> +	if (!device_state->attr_group.attrs) {
> +		err = -ENOMEM;
> +		goto err_free_attributes;
> +	}
> +
> +	/* Add attribute pointers to attribute group */
> +	list_for_each_entry(p, &device_state->attr_list, l)
> +		device_state->attr_group.attrs[i++] = &p->dev_attr.attr;
> +	if (counter->name)
> +		device_state->attr_group.attrs[i] = &dev_attr_counter_name.attr;
> +
> +	/* Associate attributes with device */
> +	device_state->groups[0] = &device_state->attr_group;
> +	device_state->dev.groups = device_state->groups;
> +
> +	/* Initialize associated character device */
> +	cdev_init(&device_state->chrdev, &counter_fileops);

Right now you can open and close it but nothing else.  I'd get rid of the
cdev entirely unless I'm missing a later use.
> +	device_state->chrdev.owner = THIS_MODULE;
> +	err = cdev_device_add(&device_state->chrdev, &device_state->dev);
> +	if (err)
> +		goto err_free_attr_group_attrs;
> +
> +	return 0;
> +
> +err_free_attr_group_attrs:
> +	kfree(counter->device_state->attr_group.attrs);
> +err_free_attributes:
> +	free_counter_device_state_attr_list(&counter->device_state->attr_list);
> +	ida_simple_remove(&counter_ida, counter->device_state->id);
> +err_free_device_state:
> +	kfree(counter->device_state);
> +	return err;
> +}
> +EXPORT_SYMBOL(counter_register);
> +
> +/**
> + * counter_unregister - unregister Counter from the system
> + * @counter: pointer to Counter to unregister
> + *
> + * The Counter is unregistered from the system; all allocated memory is freed.
> + */
> +void counter_unregister(struct counter_device *const counter)
> +{
> +	struct cdev *cdev;
> +	struct device *dev;
> +
> +	if (counter) {
> +		cdev = &counter->device_state->chrdev;
> +		dev = &counter->device_state->dev;
> +
> +		cdev_device_del(cdev, dev);
> +		put_device(dev);
> +	}
> +}
> +EXPORT_SYMBOL(counter_unregister);
> +
> +static void devm_counter_unreg(struct device *dev, void *res)
> +{
> +	counter_unregister(*(struct counter_device **)res);
> +}
> +
> +/**
> + * devm_counter_register - Resource-managed counter_register
> + * @dev: device to allocate counter_device for
> + * @counter: pointer to Counter to register
> + *
> + * Managed counter_register. The Counter registered with this function is
> + * automatically unregistered on driver detach. This function calls
> + * counter_register internally. Refer to that function for more information.
> + *
> + * If an Counter registered with this function needs to be unregistered
> + * separately, devm_counter_unregister must be used.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_counter_register(struct device *dev,
> +	struct counter_device *const counter)
> +{
> +	struct counter_device **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = counter_register(counter);
> +	if (!ret) {
> +		*ptr = counter;
> +		devres_add(dev, ptr);
> +	} else
> +		devres_free(ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_counter_register);
> +
> +static int devm_counter_match(struct device *dev, void *res, void *data)
> +{
> +	struct counter_device **r = res;
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
> + * devm_counter_unregister - Resource-managed counter_unregister
> + * @dev: device this counter_device belongs to
> + * @counter: the Counter associated with the device
> + *
> + * Unregister Counter registered with devm_counter_register.
> + */
> +void devm_counter_unregister(struct device *dev,
> +	struct counter_device *const counter)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_counter_unreg,
> +		devm_counter_match, counter);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL(devm_counter_unregister);
> +
> +subsys_initcall(counter_init);
> +module_exit(counter_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Generic Counter interface");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/counter.h b/include/linux/iio/counter.h
> new file mode 100644
> index 000000000000..070ed8fd53fb
> --- /dev/null
> +++ b/include/linux/iio/counter.h
> @@ -0,0 +1,239 @@
> +/*
> + * Counter interface
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
> +#ifndef _COUNTER_H_
> +#define _COUNTER_H_
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +struct counter_device;
> +struct counter_signal;
> +
> +/**
> + * struct counter_signal_ext - Counter Signal extensions
> + * @name:	[DRIVER] attribute name
> + * @read:	[DRIVER] read callback for this attribute; may be NULL
> + * @write:	[DRIVER] write callback for this attribute; may be NULL
> + * @priv:	[DRIVER] data private to the driver
> + */
> +struct counter_signal_ext {
> +	const char	*name;
> +	ssize_t		(*read)(struct counter_device *counter,
> +				struct counter_signal *signal, void *priv,
> +				char *buf);
> +	ssize_t		(*write)(struct counter_device *counter,
> +				struct counter_signal *signal, void *priv,
> +				const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +/**
> + * struct counter_signal - Counter Signal node
> + * @id:		[DRIVER] unique ID used to identify signal
> + * @name:	[DRIVER] device-specific signal name
> + * @ext:	[DRIVER] optional array of Counter Signal extensions
> + * @num_ext:	[DRIVER] number of Counter Signal extensions specified in @ext
> + * @priv:	[DRIVER] optional private data supplied by driver
> + */
> +struct counter_signal {
> +	int		id;
> +	const char	*name;
> +
> +	const struct counter_signal_ext	*ext;
> +	size_t				num_ext;
> +
> +	void	*priv;
> +};
> +
> +/**
> + * struct counter_synapse - Counter Synapse node
> + * @action:		[DRIVER] current action mode
> + * @actions:		[DRIVER] available action modes
> + * @num_actions:	[DRIVER] number of action modes specified in @actions
> + * @signal:		[DRIVER] pointer to associated signal
> + */
> +struct counter_synapse {
> +	size_t			action;
> +	const char *const	*actions;
> +	size_t			num_actions;
> +	struct counter_signal	*signal;
> +};
> +
> +struct counter_count;
> +
> +/**
> + * struct counter_count_ext - Counter Count extension
> + * @name:	[DRIVER] attribute name
> + * @read:	[DRIVER] read callback for this attribute; may be NULL
> + * @write:	[DRIVER] write callback for this attribute; may be NULL
> + * @priv:	[DRIVER] data private to the driver
> + */
> +struct counter_count_ext {
> +	const char	*name;
> +	ssize_t		(*read)(struct counter_device *counter,
> +				struct counter_count *count, void *priv,
> +				char *buf);
> +	ssize_t		(*write)(struct counter_device *counter,
> +				struct counter_count *count, void *priv,
> +				const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +/**
> + * struct counter_count - Counter Count node
> + * @id:			[DRIVER] unique ID used to identify Count
Again, drop [DRIVER]
> + * @name:		[DRIVER] device-specific Count name
> + * @function:		[DRIVER] current function mode
> + * @functions:		[DRIVER] available function modes
> + * @num_functions:	[DRIVER] number of functions specified in @functions
> + * @synapses:		[DRIVER] array of synapses for initialization
> + * @num_synapses:	[DRIVER] number of synapses specified in @synapses
> + * @ext:		[DRIVER] optional array of Counter Count extensions
> + * @num_ext:		[DRIVER] number of Counter Count extensions specified in
> + *			@ext
> + * @priv:		[DRIVER] optional private data supplied by driver
> + */
> +struct counter_count {
> +	int			id;

My personal view is that trying to align these always just leads to
it going wrong.  I'd not do it, but it is personal taste so up to you!

> +	const char		*name;
> +	size_t			function;
> +	const char *const	*functions;
> +	size_t			num_functions;
> +
> +	struct counter_synapse	*synapses;
> +	size_t			num_synapses;
> +
> +	const struct counter_count_ext	*ext;
> +	size_t				num_ext;
> +
> +	void	*priv;
> +};
> +
> +/**
> + * struct counter_device_state - internal state container for a Counter device
> + * @id:		unique ID used to identify the Counter
> + * @dev:	internal device structure
> + * @chrdev:	associated character device
> + * @attr_list:	list to keep track of created Counter sysfs attributes
> + * @attr_group:	Counter sysfs attributes group
> + * @groups:	attribute groups
> + * @num_attr:	number of Counter sysfs attributes
> + */
> +struct counter_device_state {
> +	int				id;
> +	struct device			dev;
> +	struct cdev			chrdev;

So far in the description I haven't seen any use of a chrdev.
Perhaps it will become clear later!

> +	struct list_head		attr_list;
> +	struct attribute_group		attr_group;
> +	const struct attribute_group	*groups[2];

Why 2?  Docs should say at least.

> +	size_t				num_attr;
> +};
> +
> +/**
> + * struct counter_device_ext - Counter device extension
> + * @name:	[DRIVER] attribute name

Drop the [DRIVER] tag - it's not standard and doesn't add anything here!

> + * @read:	[DRIVER] read callback for this attribute; may be NULL
> + * @write:	[DRIVER] write callback for this attribute; may be NULL
> + * @priv:	[DRIVER] data private to the driver
> + */
> +struct counter_device_ext {
> +	const char	*name;
> +	ssize_t		(*read)(struct counter_device *counter, void *priv,
> +				char *buf);
> +	ssize_t		(*write)(struct counter_device *counter, void *priv,
> +				const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +/**
> + * struct counter_device - Counter data structure
> + * @name:		[DRIVER] name of the device
> + * @parent:		[DRIVER] optional parent device providing the counters
> + * @device_state:	[INTERN] internal device state container

Given I made up this convention (or stole it from somewhere) I feel justified
in saying, don't use it here.  Just mark the one item that is for
internal use only.

> + * @signal_read:	[DRIVER] read callback for Signal attribute; may be NULL
> + * @signal_write:	[DRIVER] write callback for Signal attribute; may be
> + *			NULL
> + * @count_read:		[DRIVER] read callback for Count attribute; may be NULL
> + * @count_write:	[DRIVER] write callback for Count attribute; may be NULL
> + * @function_get:	[DRIVER] function to get the current count function
> + *			mode. Returns 0 on success and negative error code on
> + *			error. The index of the respective Count's returned
> + *			function mode should be passed back via the function
> + *			parameter.
> + * @function_set:	[DRIVER] function to set the count function mode.
> + *			function is the index of the requested function mode
> + *			from the respective Count's functions array.
> + * @action_get:		[DRIVER] function to get the current action mode.
> + *			Returns 0 on success and negative error code on error.
> + *			The index of the respective Signal's returned action
> + *			mode should be passed back via the action parameter.
> + * @action_set:		[DRIVER] function to set the action mode. action is the
> + *			index of the requested action mode from the respective
> + *			Synapse's actions array.
> + * @signals:		[DRIVER] array of Signals
> + * @num_signals:	[DRIVER] number of Signals specified in @signals
> + * @counts:		[DRIVER] array of Counts
> + * @num_counts:		[DRIVER] number of Counts specified in @counts
> + * @ext:		[DRIVER] optional array of Counter device extensions
> + * @num_ext:		[DRIVER] number of Counter device extensions specified
> + *			in @ext
> + * @priv:		[DRIVER] optional private data supplied by driver
> + */
> +struct counter_device {
> +	const char			*name;
> +	struct device			*parent;
> +	struct counter_device_state	*device_state;
> +
> +	ssize_t	(*signal_read)(struct counter_device *counter,
> +			struct counter_signal *signal, char *buf);
> +	ssize_t	(*signal_write)(struct counter_device *counter,
> +			struct counter_signal *signal, const char *buf,
> +			size_t len);
> +	ssize_t	(*count_read)(struct counter_device *counter,
> +			struct counter_count *count, char *buf);
> +	ssize_t (*count_write)(struct counter_device *counter,
> +			struct counter_count *count, const char *buf,
> +			size_t len);
> +	int	(*function_get)(struct counter_device *counter,
> +			struct counter_count *count, size_t *function);
> +	int	(*function_set)(struct counter_device *counter,
> +			struct counter_count *count, size_t function);
> +	int	(*action_get)(struct counter_device *counter,
> +			struct counter_count *count,
> +			struct counter_synapse *synapse, size_t *action);
> +	int	(*action_set)(struct counter_device *counter,
> +			struct counter_count *count,
> +			struct counter_synapse *synapse, size_t action);
> +
> +	struct counter_signal	*signals;
> +	size_t			num_signals;
> +	struct counter_count	*counts;
> +	size_t			num_counts;
> +
> +	const struct counter_device_ext	*ext;
> +	size_t				num_ext;
> +
> +	void	*priv;
> +};
> +
> +extern int counter_register(struct counter_device *const counter);
> +extern void counter_unregister(struct counter_device *const counter);
> +extern int devm_counter_register(struct device *dev,
> +	struct counter_device *const counter);
> +extern void devm_counter_unregister(struct device *dev,
> +	struct counter_device *const counter);
> +
> +#endif /* _COUNTER_H_ */

