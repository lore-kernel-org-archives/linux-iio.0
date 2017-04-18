Return-Path: <SRS0=ZM4/=32=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <20170418085156.GA4773@kroah.com>
CC: <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Colin
 Ian King <colin.king@canonical.com>, Paul Gortmaker
	<paul.gortmaker@windriver.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
Date: Tue, 18 Apr 2017 12:59:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170418085156.GA4773@kroah.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2017-04-18 10:51, Greg Kroah-Hartman wrote:
> On Thu, Apr 13, 2017 at 06:43:07PM +0200, Peter Rosin wrote:
>> +config MUX_GPIO
>> +	tristate "GPIO-controlled Multiplexer"
>> +	depends on OF && GPIOLIB
> 
> Why have the gpio and mux core in the same patch?

One is not usable w/o the other. I can split them if you want to?

> And why does this depend on OF?

That's historical, I was originally using of_property_read_u32.
I'll remove the dep...

>> +	help
>> +	  GPIO-controlled Multiplexer controller.
>> +
>> +	  The driver builds a single multiplexer controller using a number
>> +	  of gpio pins. For N pins, there will be 2^N possible multiplexer
>> +	  states. The GPIO pins can be connected (by the hardware) to several
>> +	  multiplexers, which in that case will be operated in parallel.
>> +
>> +	  To compile the driver as a module, choose M here: the module will
>> +	  be called mux-gpio.
>> +
>> +endif
>> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
>> new file mode 100644
>> index 000000000000..bb16953f6290
>> --- /dev/null
>> +++ b/drivers/mux/Makefile
>> @@ -0,0 +1,6 @@
>> +#
>> +# Makefile for multiplexer devices.
>> +#
>> +
>> +obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>> +obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>> diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
>> new file mode 100644
>> index 000000000000..66a8bccfc3d7
>> --- /dev/null
>> +++ b/drivers/mux/mux-core.c
>> @@ -0,0 +1,422 @@
>> +/*
>> + * Multiplexer subsystem
>> + *
>> + * Copyright (C) 2017 Axentia Technologies AB
>> + *
>> + * Author: Peter Rosin <peda@axentia.se>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#define pr_fmt(fmt) "mux-core: " fmt
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/idr.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/mux.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/slab.h>
>> +
>> +/*
>> + * The idle-as-is "state" is not an actual state that may be selected, it
>> + * only implies that the state should not be changed. So, use that state
>> + * as indication that the cached state of the multiplexer is unknown.
>> + */
>> +#define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
>> +
>> +static struct class mux_class = {
>> +	.name = "mux",
>> +	.owner = THIS_MODULE,
>> +};
> 
> No Documentation/ABI/ update for your sysfs files?  Please do so.

Ok I'll look into it. Wasn't even aware that I added any. But there's the
new class of course...

>> +
>> +static int __init mux_init(void)
>> +{
>> +	return class_register(&mux_class);
>> +}
>> +
>> +static DEFINE_IDA(mux_ida);
> 
> When your module is unloaded, you forgot to clean this structure up with
> what was done with it.

I was under the impression that not providing an exit function for modules
made the module infrastructure prevent unloading (by bumping some reference
counter). Maybe that is a misconception?

>> +
>> +static void mux_chip_release(struct device *dev)
>> +{
>> +	struct mux_chip *mux_chip = to_mux_chip(dev);
>> +
>> +	ida_simple_remove(&mux_ida, mux_chip->id);
>> +	kfree(mux_chip);
>> +}
>> +
>> +static struct device_type mux_type = {
>> +	.name = "mux-chip",
>> +	.release = mux_chip_release,
>> +};
>> +
>> +struct mux_chip *mux_chip_alloc(struct device *dev,
>> +				unsigned int controllers, size_t sizeof_priv)
>> +{
>> +	struct mux_chip *mux_chip;
>> +	int i;
>> +
>> +	if (WARN_ON(!dev || !controllers))
>> +		return NULL;
>> +
>> +	mux_chip = kzalloc(sizeof(*mux_chip) +
>> +			   controllers * sizeof(*mux_chip->mux) +
>> +			   sizeof_priv, GFP_KERNEL);
>> +	if (!mux_chip)
>> +		return NULL;
> 
> You don't return PTR_ERR(-ENOMEM)?  Ok, why not?  (I'm not arguing for
> it, just curious...)

There's no particular reason. Do you think I should change it?

>> +
>> +	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
>> +	mux_chip->dev.class = &mux_class;
>> +	mux_chip->dev.type = &mux_type;
>> +	mux_chip->dev.parent = dev;
>> +	mux_chip->dev.of_node = dev->of_node;
>> +	dev_set_drvdata(&mux_chip->dev, mux_chip);
>> +
>> +	mux_chip->id = ida_simple_get(&mux_ida, 0, 0, GFP_KERNEL);
>> +	if (mux_chip->id < 0) {
>> +		pr_err("muxchipX failed to get a device id\n");
>> +		kfree(mux_chip);
>> +		return NULL;
>> +	}
>> +	dev_set_name(&mux_chip->dev, "muxchip%d", mux_chip->id);
>> +
>> +	mux_chip->controllers = controllers;
>> +	for (i = 0; i < controllers; ++i) {
>> +		struct mux_control *mux = &mux_chip->mux[i];
>> +
>> +		mux->chip = mux_chip;
>> +		init_rwsem(&mux->lock);
>> +		mux->cached_state = MUX_CACHE_UNKNOWN;
>> +		mux->idle_state = MUX_IDLE_AS_IS;
>> +	}
>> +
>> +	device_initialize(&mux_chip->dev);
> 
> Why are you not registering the device here as well?  Why have this be a
> two step process?

Because of idle state handling. The drivers are expected to fill in
the desired idle state(s) after allocating the mux controller(s).
Then, when registering, the desired idle state is activated (if the
idle state is not idle-as-is, of course) and as a last step the mux
is "advertised".

>> +
>> +	return mux_chip;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_chip_alloc);
>> +
>> +static int mux_control_set(struct mux_control *mux, int state)
>> +{
>> +	int ret = mux->chip->ops->set(mux, state);
>> +
>> +	mux->cached_state = ret < 0 ? MUX_CACHE_UNKNOWN : state;
>> +
>> +	return ret;
>> +}
>> +
>> +int mux_chip_register(struct mux_chip *mux_chip)
>> +{
>> +	int i;
>> +	int ret;
>> +
>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>> +		struct mux_control *mux = &mux_chip->mux[i];
>> +
>> +		if (mux->idle_state == mux->cached_state)
>> +			continue;
>> +
>> +		ret = mux_control_set(mux, mux->idle_state);
>> +		if (ret < 0) {
>> +			dev_err(&mux_chip->dev, "unable to set idle state\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = device_add(&mux_chip->dev);
>> +	if (ret < 0)
>> +		dev_err(&mux_chip->dev,
>> +			"device_add failed in mux_chip_register: %d\n", ret);
> 
> Did you run checkpatch.pl in strict mode on this new file?  Please do so :)

I did, and did it again just to be sure, and I do not get any complaints.
So, what's wrong?

$ scripts/checkpatch.pl --strict mux-13/0003-mux-minimal-mux-subsystem-and-gpio-based-mux-control.patch
total: 0 errors, 0 warnings, 0 checks, 860 lines checked

mux-13/0003-mux-minimal-mux-subsystem-and-gpio-based-mux-control.patch has no obvious style problems and is ready for submission.

The chackpatch warnings I am aware of are three instances of (for the
'prop', 's' and 'i' arguments):

mux-13/0006-iio-multiplexer-new-iio-category-and-iio-mux-driver.patch
---------------------------------------------------------------------
CHECK: Macro argument reuse 'prop' - possible side-effects?
#433: FILE: drivers/iio/multiplexer/iio-mux.c:326:
+#define of_property_for_each_string_index(np, propname, prop, s, i)    \
+       for (prop = of_find_property(np, propname, NULL),               \
+            s = of_prop_next_string(prop, NULL),                       \
+            i = 0;                                                     \
+            s;                                                         \
+            s = of_prop_next_string(prop, s),                          \
+            i++)

But those kinds of warnings are also present in the code I plagiarized,
so I don't feel too bad...

And then there are a couple of false positives about files added w/o
adding an entry to MAINTAINERS (the files are covers by wildcards).

>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_chip_register);
>> +
>> +void mux_chip_unregister(struct mux_chip *mux_chip)
>> +{
>> +	device_del(&mux_chip->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_chip_unregister);
>> +
>> +void mux_chip_free(struct mux_chip *mux_chip)
>> +{
>> +	if (!mux_chip)
>> +		return;
>> +
>> +	put_device(&mux_chip->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_chip_free);
>> +
>> +static void devm_mux_chip_release(struct device *dev, void *res)
>> +{
>> +	struct mux_chip *mux_chip = *(struct mux_chip **)res;
>> +
>> +	mux_chip_free(mux_chip);
>> +}
>> +
>> +struct mux_chip *devm_mux_chip_alloc(struct device *dev,
>> +				     unsigned int controllers,
>> +				     size_t sizeof_priv)
>> +{
>> +	struct mux_chip **ptr, *mux_chip;
>> +
>> +	ptr = devres_alloc(devm_mux_chip_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return NULL;
>> +
>> +	mux_chip = mux_chip_alloc(dev, controllers, sizeof_priv);
>> +	if (!mux_chip) {
>> +		devres_free(ptr);
>> +		return NULL;
>> +	}
>> +
>> +	*ptr = mux_chip;
>> +	devres_add(dev, ptr);
>> +
>> +	return mux_chip;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_chip_alloc);
> 
> 
> Having devm functions that create/destroy other struct devices worries
> me, do we have other examples of this happening today?  Are you sure you
> got the reference counting all correct?

drivers/iio/industrialio_core.c:devm_iio_device_alloc

Or is the iio case different in some subtle way that I'm missing?

>> +
>> +static int devm_mux_chip_match(struct device *dev, void *res, void *data)
>> +{
>> +	struct mux_chip **r = res;
>> +
>> +	if (WARN_ON(!r || !*r))
> 
> How can this happen?

It shouldn't. I copied the pattern from the iio subsystem.

>> +		return 0;
>> +
>> +	return *r == data;
>> +}
>> +
>> +void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip)
>> +{
>> +	WARN_ON(devres_release(dev, devm_mux_chip_release,
>> +			       devm_mux_chip_match, mux_chip));
> 
> What can someone do with these WARN_ON() splats in the kernel log?

Don't know. Again, I copied the pattern from the iio subsystem.

> 
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_chip_free);
>> +
>> +static void devm_mux_chip_reg_release(struct device *dev, void *res)
>> +{
>> +	struct mux_chip *mux_chip = *(struct mux_chip **)res;
>> +
>> +	mux_chip_unregister(mux_chip);
>> +}
>> +
>> +int devm_mux_chip_register(struct device *dev,
>> +			   struct mux_chip *mux_chip)
>> +{
>> +	struct mux_chip **ptr;
>> +	int res;
>> +
>> +	ptr = devres_alloc(devm_mux_chip_reg_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return -ENOMEM;
>> +
>> +	res = mux_chip_register(mux_chip);
>> +	if (res) {
>> +		devres_free(ptr);
>> +		return res;
>> +	}
>> +
>> +	*ptr = mux_chip;
>> +	devres_add(dev, ptr);
>> +
>> +	return res;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_chip_register);
>> +
>> +void devm_mux_chip_unregister(struct device *dev, struct mux_chip *mux_chip)
>> +{
>> +	WARN_ON(devres_release(dev, devm_mux_chip_reg_release,
>> +			       devm_mux_chip_match, mux_chip));
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_chip_unregister);
>> +
>> +int mux_control_select(struct mux_control *mux, int state)
>> +{
>> +	int ret;
>> +
>> +	if (down_read_trylock(&mux->lock)) {
>> +		if (mux->cached_state == state)
>> +			return 0;
>> +
>> +		/* Sigh, the mux needs updating... */
>> +		up_read(&mux->lock);
>> +	}
>> +
>> +	/* ...or it's just contended. */
>> +	down_write(&mux->lock);
> 
> Why use a read/write lock at all?  Have you tested this to verify it
> really is faster and needed?

For one of the HW configuration that drove the development, the same mux
controller is used to mux both an I2C channel and a couple of ADC lines.

If there is no kind of reader/writer locking going on, there is no way to
do ADC readings concurrently with an I2C transfer even when the consumers
want the mux in the same position. With an ordinary mutex controlling the
mux position, the consumers will unconditionally get serialized, which
seems like a waste to me. Or maybe I'm missing something?

>> +
>> +	if (mux->cached_state == state) {
>> +		/*
>> +		 * Hmmm, someone else changed the mux to my liking.
>> +		 * That makes me wonder how long I waited for nothing?
>> +		 */
>> +		downgrade_write(&mux->lock);
> 
> Oh that always scares me...  Are you _sure_ this is correct?  And
> needed?

It might not be needed, and it would probably work ok to just fall
through and call mux_control_set unconditionally. What is it that
always scares you exactly? Relying on cached state to be correct?
Downgrading writer locks?

>> +		return 0;
>> +	}
>> +
>> +	ret = mux_control_set(mux, state);
>> +	if (ret < 0) {
>> +		if (mux->idle_state != MUX_IDLE_AS_IS)
>> +			mux_control_set(mux, mux->idle_state);
>> +
>> +		up_write(&mux->lock);
>> +		return ret;
>> +	}
>> +
>> +	downgrade_write(&mux->lock);
>> +
>> +	return 1;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_select);
>> +
>> +int mux_control_deselect(struct mux_control *mux)
>> +{
>> +	int ret = 0;
>> +
>> +	if (mux->idle_state != MUX_IDLE_AS_IS &&
>> +	    mux->idle_state != mux->cached_state)
>> +		ret = mux_control_set(mux, mux->idle_state);
>> +
>> +	up_read(&mux->lock);
> 
> You require a lock to be held for a "global" function?  Without
> documentation?  Or even a sparse marking?  That's asking for trouble...

Documentation I can handle, but where should I look to understand how I
should add sparse markings?

The mux needs to be locked somehow. But as I stated in the cover letter
the rwsem isn't a perfect fit.

	I'm using an rwsem to lock a mux, but that isn't really a
	perfect fit. Is there a better locking primitive that I don't
	know about that fits better? I had a mutex at one point, but
	that didn't allow any concurrent accesses at all. At least
	the rwsem allows concurrent access as long as all users
	agree on the mux state, but I suspect that the rwsem will
	degrade to the mutex situation pretty quickly if there is
	any contention.

Also, the lock doesn't add anything if there is only one consumer of
a mux controller. Maybe there should be some mechanism for shortcutting
the locking for the (more common?) single-consumer case?

But again, I need the locking for my multi-consumer use case.

>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_deselect);
>> +
>> +static int of_dev_node_match(struct device *dev, const void *data)
>> +{
>> +	return dev->of_node == data;
>> +}
>> +
>> +static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>> +{
>> +	struct device *dev;
>> +
>> +	dev = class_find_device(&mux_class, NULL, np, of_dev_node_match);
>> +
>> +	return dev ? to_mux_chip(dev) : NULL;
>> +}
>> +
>> +struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct of_phandle_args args;
>> +	struct mux_chip *mux_chip;
>> +	unsigned int controller;
>> +	int index = 0;
>> +	int ret;
>> +
>> +	if (mux_name) {
>> +		index = of_property_match_string(np, "mux-control-names",
>> +						 mux_name);
>> +		if (index < 0) {
>> +			dev_err(dev, "mux controller '%s' not found\n",
>> +				mux_name);
>> +			return ERR_PTR(index);
>> +		}
>> +	}
>> +
>> +	ret = of_parse_phandle_with_args(np,
>> +					 "mux-controls", "#mux-control-cells",
>> +					 index, &args);
>> +	if (ret) {
>> +		dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
>> +			np->full_name, mux_name ?: "", index);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	mux_chip = of_find_mux_chip_by_node(args.np);
>> +	of_node_put(args.np);
>> +	if (!mux_chip)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	if (args.args_count > 1 ||
>> +	    (!args.args_count && (mux_chip->controllers > 1))) {
>> +		dev_err(dev, "%s: wrong #mux-control-cells for %s\n",
>> +			np->full_name, args.np->full_name);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	controller = 0;
>> +	if (args.args_count)
>> +		controller = args.args[0];
>> +
>> +	if (controller >= mux_chip->controllers) {
>> +		dev_err(dev, "%s: bad mux controller %u specified in %s\n",
>> +			np->full_name, controller, args.np->full_name);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	get_device(&mux_chip->dev);
>> +	return &mux_chip->mux[controller];
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_get);
>> +
>> +void mux_control_put(struct mux_control *mux)
>> +{
>> +	put_device(&mux->chip->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_put);
>> +
>> +static void devm_mux_control_release(struct device *dev, void *res)
>> +{
>> +	struct mux_control *mux = *(struct mux_control **)res;
>> +
>> +	mux_control_put(mux);
>> +}
>> +
>> +struct mux_control *devm_mux_control_get(struct device *dev,
>> +					 const char *mux_name)
>> +{
>> +	struct mux_control **ptr, *mux;
>> +
>> +	ptr = devres_alloc(devm_mux_control_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mux = mux_control_get(dev, mux_name);
>> +	if (IS_ERR(mux)) {
>> +		devres_free(ptr);
>> +		return mux;
>> +	}
>> +
>> +	*ptr = mux;
>> +	devres_add(dev, ptr);
>> +
>> +	return mux;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_control_get);
>> +
>> +static int devm_mux_control_match(struct device *dev, void *res, void *data)
>> +{
>> +	struct mux_control **r = res;
>> +
>> +	if (WARN_ON(!r || !*r))
>> +		return 0;
> 
> Same here, how can this happen?

Same response as above.

>> +
>> +	return *r == data;
>> +}
>> +
>> +void devm_mux_control_put(struct device *dev, struct mux_control *mux)
>> +{
>> +	WARN_ON(devres_release(dev, devm_mux_control_release,
>> +			       devm_mux_control_match, mux));
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_control_put);
>> +
>> +/*
>> + * Using subsys_initcall instead of module_init here to ensure - for the
>> + * non-modular case - that the subsystem is initialized when mux consumers
>> + * and mux controllers start to use it /without/ relying on link order.
>> + * For the modular case, the ordering is ensured with module dependencies.
>> + */
>> +subsys_initcall(mux_init);
> 
> Even with subsys_initcall you are relying on link order, you do realize
> that?  What about other subsystems that rely on this?  :)

Yes, that is true, but if others start relying on this, that's their problem,
right? :-)

> 
>> +
>> +MODULE_DESCRIPTION("Multiplexer subsystem");
>> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mux/mux-gpio.c b/drivers/mux/mux-gpio.c
>> new file mode 100644
>> index 000000000000..227d3572e6db
>> --- /dev/null
>> +++ b/drivers/mux/mux-gpio.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * GPIO-controlled multiplexer driver
>> + *
>> + * Copyright (C) 2017 Axentia Technologies AB
>> + *
>> + * Author: Peter Rosin <peda@axentia.se>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/mux.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +
>> +struct mux_gpio {
>> +	struct gpio_descs *gpios;
>> +	int *val;
>> +};
>> +
>> +static int mux_gpio_set(struct mux_control *mux, int state)
>> +{
>> +	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
>> +	int i;
>> +
>> +	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
>> +		mux_gpio->val[i] = (state >> i) & 1;
>> +
>> +	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
>> +				       mux_gpio->gpios->desc,
>> +				       mux_gpio->val);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mux_control_ops mux_gpio_ops = {
>> +	.set = mux_gpio_set,
>> +};
>> +
>> +static const struct of_device_id mux_gpio_dt_ids[] = {
>> +	{ .compatible = "gpio-mux", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mux_gpio_dt_ids);
>> +
>> +static int mux_gpio_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct mux_chip *mux_chip;
>> +	struct mux_gpio *mux_gpio;
>> +	int pins;
>> +	s32 idle_state;
>> +	int ret;
>> +
>> +	pins = gpiod_count(dev, "mux");
>> +	if (pins < 0)
>> +		return pins;
>> +
>> +	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
>> +				       pins * sizeof(*mux_gpio->val));
>> +	if (!mux_chip)
>> +		return -ENOMEM;
>> +
>> +	mux_gpio = mux_chip_priv(mux_chip);
>> +	mux_gpio->val = (int *)(mux_gpio + 1);
>> +	mux_chip->ops = &mux_gpio_ops;
>> +
>> +	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
>> +	if (IS_ERR(mux_gpio->gpios)) {
>> +		ret = PTR_ERR(mux_gpio->gpios);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get gpios\n");
>> +		return ret;
>> +	}
>> +	WARN_ON(pins != mux_gpio->gpios->ndescs);
>> +	mux_chip->mux->states = 1 << pins;
>> +
>> +	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
>> +	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
>> +		if (idle_state < 0 || idle_state >= mux_chip->mux->states) {
>> +			dev_err(dev, "invalid idle-state %u\n", idle_state);
>> +			return -EINVAL;
>> +		}
>> +
>> +		mux_chip->mux->idle_state = idle_state;
>> +	}
>> +
>> +	ret = devm_mux_chip_register(dev, mux_chip);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_info(dev, "%u-way mux-controller registered\n",
>> +		 mux_chip->mux->states);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver mux_gpio_driver = {
>> +	.driver = {
>> +		.name = "gpio-mux",
>> +		.of_match_table	= of_match_ptr(mux_gpio_dt_ids),
>> +	},
>> +	.probe = mux_gpio_probe,
>> +};
>> +module_platform_driver(mux_gpio_driver);
>> +
>> +MODULE_DESCRIPTION("GPIO-controlled multiplexer driver");
>> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mux.h b/include/linux/mux.h
>> new file mode 100644
>> index 000000000000..febdde4246df
>> --- /dev/null
>> +++ b/include/linux/mux.h
>> @@ -0,0 +1,252 @@
>> +/*
>> + * mux.h - definitions for the multiplexer interface
>> + *
>> + * Copyright (C) 2017 Axentia Technologies AB
>> + *
>> + * Author: Peter Rosin <peda@axentia.se>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _LINUX_MUX_H
>> +#define _LINUX_MUX_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/rwsem.h>
>> +
>> +struct mux_chip;
>> +struct mux_control;
>> +struct platform_device;
>> +
>> +/**
>> + * struct mux_control_ops -	Mux controller operations for a mux chip.
>> + * @set:			Set the state of the given mux controller.
>> + */
>> +struct mux_control_ops {
>> +	int (*set)(struct mux_control *mux, int state);
>> +};
>> +
>> +/* These defines match the constants from the dt-bindings. On purpose. */
> 
> Why on purpose?

I sure wasn't an accident? :-)

Want me to remove it?

>> +#define MUX_IDLE_AS_IS      (-1)
>> +#define MUX_IDLE_DISCONNECT (-2)
>> +
>> +/**
>> + * struct mux_control -	Represents a mux controller.
>> + * @lock:		Protects the mux controller state.
>> + * @chip:		The mux chip that is handling this mux controller.
>> + * @states:		The number of mux controller states.
>> + * @cached_state:	The current mux controller state, or -1 if none.
>> + * @idle_state:		The mux controller state to use when inactive, or one
>> + *			of MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT.
>> + */
>> +struct mux_control {
>> +	struct rw_semaphore lock; /* protects the state of the mux */
>> +
>> +	struct mux_chip *chip;
>> +
>> +	unsigned int states;
>> +	int cached_state;
>> +	int idle_state;
>> +};
>> +
>> +/**
>> + * struct mux_chip -	Represents a chip holding mux controllers.
>> + * @controllers:	Number of mux controllers handled by the chip.
>> + * @mux:		Array of mux controllers that are handled.
>> + * @dev:		Device structure.
>> + * @id:			Used to identify the device internally.
>> + * @ops:		Mux controller operations.
>> + */
>> +struct mux_chip {
>> +	unsigned int controllers;
>> +	struct mux_control *mux;
>> +	struct device dev;
>> +	int id;
>> +
>> +	const struct mux_control_ops *ops;
>> +};
>> +
>> +#define to_mux_chip(x) container_of((x), struct mux_chip, dev)
>> +
>> +/**
>> + * mux_chip_priv() - Get the extra memory reserved by mux_chip_alloc().
>> + * @mux_chip: The mux-chip to get the private memory from.
>> + *
>> + * Return: Pointer to the private memory reserved by the allocator.
>> + */
>> +static inline void *mux_chip_priv(struct mux_chip *mux_chip)
>> +{
>> +	return &mux_chip->mux[mux_chip->controllers];
>> +}
>> +
>> +/**
>> + * mux_chip_alloc() - Allocate a mux-chip.
>> + * @dev: The parent device implementing the mux interface.
>> + * @controllers: The number of mux controllers to allocate for this chip.
>> + * @sizeof_priv: Size of extra memory area for private use by the caller.
>> + *
>> + * Return: A pointer to the new mux-chip, NULL on failure.
>> + */
>> +struct mux_chip *mux_chip_alloc(struct device *dev,
>> +				unsigned int controllers, size_t sizeof_priv);
>> +
> 
> Don't put kernel doc comments in a .h file, they normally go into the .c
> file, next to the code itself.  That makes it easier to fix up and
> realise when they need to be changed when the code changes.  The .h file
> rarely changes.

I'll move the lot over.

>> +/**
>> + * mux_chip_register() - Register a mux-chip, thus readying the controllers
>> + *			 for use.
>> + * @mux_chip: The mux-chip to register.
>> + *
>> + * Do not retry registration of the same mux-chip on failure. You should
>> + * instead put it away with mux_chip_free() and allocate a new one, if you
>> + * for some reason would like to retry registration.
>> + *
>> + * Return: Zero on success or a negative errno on error.
>> + */
>> +int mux_chip_register(struct mux_chip *mux_chip);
>> +
>> +/**
>> + * mux_chip_unregister() - Take the mux-chip off-line.
>> + * @mux_chip: The mux-chip to unregister.
>> + *
>> + * mux_chip_unregister() reverses the effects of mux_chip_register().
>> + * But not completely, you should not try to call mux_chip_register()
>> + * on a mux-chip that has been registered before.
>> + */
>> +void mux_chip_unregister(struct mux_chip *mux_chip);
>> +
>> +/**
>> + * mux_chip_free() - Free the mux-chip for good.
>> + * @mux_chip: The mux-chip to free.
>> + *
>> + * mux_chip_free() reverses the effects of mux_chip_alloc().
>> + */
>> +void mux_chip_free(struct mux_chip *mux_chip);
>> +
>> +/**
>> + * devm_mux_chip_alloc() - Resource-managed version of mux_chip_alloc().
>> + * @dev: The parent device implementing the mux interface.
>> + * @controllers: The number of mux controllers to allocate for this chip.
>> + * @sizeof_priv: Size of extra memory area for private use by the caller.
>> + *
>> + * See mux_chip_alloc() for more details.
>> + *
>> + * Return: A pointer to the new mux-chip, NULL on failure.
>> + */
>> +struct mux_chip *devm_mux_chip_alloc(struct device *dev,
>> +				     unsigned int controllers,
>> +				     size_t sizeof_priv);
>> +
>> +/**
>> + * devm_mux_chip_register() - Resource-managed version mux_chip_register().
>> + * @dev: The parent device implementing the mux interface.
>> + * @mux_chip: The mux-chip to register.
>> + *
>> + * See mux_chip_register() for more details.
>> + *
>> + * Return: Zero on success or a negative errno on error.
>> + */
>> +int devm_mux_chip_register(struct device *dev, struct mux_chip *mux_chip);
>> +
>> +/**
>> + * devm_mux_chip_unregister() - Resource-managed version mux_chip_unregister().
>> + * @dev: The device that originally registered the mux-chip.
>> + * @mux_chip: The mux-chip to unregister.
>> + *
>> + * See mux_chip_unregister() for more details.
>> + *
>> + * Note that you do not normally need to call this function.
> 
> Odd, then why is it exported???

You normally don't call the devm_foo_{free,release,unregister,etc} functions.
The intention is of course that the resourse cleans up automatically. But there
are no cases where the manual clean up is not available, at least not that I can
find?

>> + */
>> +void devm_mux_chip_unregister(struct device *dev, struct mux_chip *mux_chip);
>> +
>> +/**
>> + * devm_mux_chip_free() - Resource-managed version mux_chip_free().
>> + * @dev: The device that originally got the mux-chip.
>> + * @mux_chip: The mux-chip to free.
>> + *
>> + * See mux_chip_free() for more details.
>> + *
>> + * Note that you do not normally need to call this function.
>> + */
>> +void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip);
>> +
>> +/**
>> + * mux_control_select() - Select the given multiplexer state.
>> + * @mux: The mux-control to request a change of state from.
>> + * @state: The new requested state.
>> + *
>> + * Make sure to call mux_control_deselect() when the operation is complete and
>> + * the mux-control is free for others to use, but do not call
>> + * mux_control_deselect() if mux_control_select() fails.
>> + *
>> + * Return: 0 if the requested state was already active, or 1 it the
>> + * mux-control state was changed to the requested state. Or a negative
>> + * errno on error.
>> + *
>> + * Note that the difference in return value of zero or one is of
>> + * questionable value; especially if the mux-control has several independent
>> + * consumers, which is something the consumers should perhaps not be making
>> + * assumptions about.
> 
> I don't understand this note, what is a user of this api supposed to do
> differently between 1 and 0?  Why make the difference at all?

If the consumer somehow *knows* that it is the only user of a mux controller,
it can use the return value to shortcut (perhaps costly) actions only needed
when the mux changes. The 1/0 difference was also a "free" extra given the
current implementation of mux_control_select. But it's cheep for the consumer
to keep track of this by itself if it needs it.

It's when there are several (independent) consumers of a mux controller that
the information in the return value is questionable and can't be used to
shortcut actions only needed on mux changes.

Now that you point the finger at it and I have been made to spell out the
problem, I think it's probably wise to remove the distiction so that users
do not start to use the return value when they shouldn't. It's generally
better to keep track of the expected mux state in the consumer and use that
local information to shortcut those (perhaps costly) actions instead.

> And I agree with the comment to split this up into 2 different .h files,
> if possible.

Will split.

> thanks,
> 
> greg k-h
> 

I'll wait for further feedback before posting a v14.

Cheers and thanks,
peda
