Return-Path: <SRS0=Eec2=33=pengutronix.de=p.zabel@kernel.org>
Message-ID: <1492592817.2970.14.camel@pengutronix.de>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron
 <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan
 Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Colin
 Ian King <colin.king@canonical.com>, Paul Gortmaker
 <paul.gortmaker@windriver.com>, kernel@pengutronix.de
Date: Wed, 19 Apr 2017 11:06:57 +0200
In-Reply-To: <1492101794-13444-4-git-send-email-peda@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
	 <1492101794-13444-4-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
> Add a new minimalistic subsystem that handles multiplexer controllers.
> When multiplexers are used in various places in the kernel, and the
> same multiplexer controller can be used for several independent things,
> there should be one place to implement support for said multiplexer
> controller.
> 
> A single multiplexer controller can also be used to control several
> parallel multiplexers, that are in turn used by different subsystems
> in the kernel, leading to a need to coordinate multiplexer accesses.
> The multiplexer subsystem handles this coordination.
> 
> This new mux controller subsystem initially comes with a single backend
> driver that controls gpio based multiplexers. Even though not needed by
> this initial driver, the mux controller subsystem is prepared to handle
> chips with multiple (independent) mux controllers.
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/driver-model/devres.txt |   8 +
>  MAINTAINERS                           |   2 +
>  drivers/Kconfig                       |   2 +
>  drivers/Makefile                      |   1 +
>  drivers/mux/Kconfig                   |  34 +++
>  drivers/mux/Makefile                  |   6 +
>  drivers/mux/mux-core.c                | 422 ++++++++++++++++++++++++++++++++++
>  drivers/mux/mux-gpio.c                | 114 +++++++++
>  include/linux/mux.h                   | 252 ++++++++++++++++++++
>  9 files changed, 841 insertions(+)
>  create mode 100644 drivers/mux/Kconfig
>  create mode 100644 drivers/mux/Makefile
>  create mode 100644 drivers/mux/mux-core.c
>  create mode 100644 drivers/mux/mux-gpio.c
>  create mode 100644 include/linux/mux.h
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index efb8200819d6..e2343d9cbec7 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -337,6 +337,14 @@ MEM
>  MFD
>    devm_mfd_add_devices()
>  
> +MUX
> +  devm_mux_chip_alloc()
> +  devm_mux_chip_free()
> +  devm_mux_chip_register()
> +  devm_mux_chip_unregister()
> +  devm_mux_control_get()
> +  devm_mux_control_put()
> +
>  PER-CPU MEM
>    devm_alloc_percpu()
>    devm_free_percpu()
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7fc06739c8ad..591eba737678 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8563,6 +8563,8 @@ M:	Peter Rosin <peda@axentia.se>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mux/
>  F:	include/linux/dt-bindings/mux/
> +F:	include/linux/mux.h
> +F:	drivers/mux/
>  
>  MULTISOUND SOUND DRIVER
>  M:	Andrew Veliath <andrewtv@usa.net>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 117ca14ccf85..a7ea13e1b869 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -204,4 +204,6 @@ source "drivers/fpga/Kconfig"
>  
>  source "drivers/fsi/Kconfig"
>  
> +source "drivers/mux/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 2eced9afba53..c0436f6dd5a9 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -177,3 +177,4 @@ obj-$(CONFIG_ANDROID)		+= android/
>  obj-$(CONFIG_NVMEM)		+= nvmem/
>  obj-$(CONFIG_FPGA)		+= fpga/
>  obj-$(CONFIG_FSI)		+= fsi/
> +obj-$(CONFIG_MULTIPLEXER)	+= mux/
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> new file mode 100644
> index 000000000000..41dfe08ead84
> --- /dev/null
> +++ b/drivers/mux/Kconfig
> @@ -0,0 +1,34 @@
> +#
> +# Multiplexer devices
> +#
> +
> +menuconfig MULTIPLEXER
> +	tristate "Multiplexer subsystem"
> +	help
> +	  Multiplexer controller subsystem. Multiplexers are used in a
> +	  variety of settings, and this subsystem abstracts their use
> +	  so that the rest of the kernel sees a common interface. When
> +	  multiple parallel multiplexers are controlled by one single
> +	  multiplexer controller, this subsystem also coordinates the
> +	  multiplexer accesses.
> +
> +	  To compile the subsystem as a module, choose M here: the module will
> +	  be called mux-core.
> +
> +if MULTIPLEXER
> +
> +config MUX_GPIO
> +	tristate "GPIO-controlled Multiplexer"
> +	depends on OF && GPIOLIB
> +	help
> +	  GPIO-controlled Multiplexer controller.
> +
> +	  The driver builds a single multiplexer controller using a number
> +	  of gpio pins. For N pins, there will be 2^N possible multiplexer
> +	  states. The GPIO pins can be connected (by the hardware) to several
> +	  multiplexers, which in that case will be operated in parallel.
> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called mux-gpio.
> +
> +endif
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> new file mode 100644
> index 000000000000..bb16953f6290
> --- /dev/null
> +++ b/drivers/mux/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for multiplexer devices.
> +#
> +
> +obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
> +obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
> diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
> new file mode 100644
> index 000000000000..66a8bccfc3d7
> --- /dev/null
> +++ b/drivers/mux/mux-core.c
> @@ -0,0 +1,422 @@
> +/*
> + * Multiplexer subsystem
> + *
> + * Copyright (C) 2017 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "mux-core: " fmt
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mux.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +/*
> + * The idle-as-is "state" is not an actual state that may be selected, it
> + * only implies that the state should not be changed. So, use that state
> + * as indication that the cached state of the multiplexer is unknown.
> + */
> +#define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
> +
> +static struct class mux_class = {
> +	.name = "mux",
> +	.owner = THIS_MODULE,
> +};
> +
> +static int __init mux_init(void)
> +{
> +	return class_register(&mux_class);
> +}
> +
> +static DEFINE_IDA(mux_ida);
> +
> +static void mux_chip_release(struct device *dev)
> +{
> +	struct mux_chip *mux_chip = to_mux_chip(dev);
> +
> +	ida_simple_remove(&mux_ida, mux_chip->id);
> +	kfree(mux_chip);
> +}
> +
> +static struct device_type mux_type = {
> +	.name = "mux-chip",
> +	.release = mux_chip_release,
> +};
> +
> +struct mux_chip *mux_chip_alloc(struct device *dev,
> +				unsigned int controllers, size_t sizeof_priv)
> +{
> +	struct mux_chip *mux_chip;
> +	int i;
> +
> +	if (WARN_ON(!dev || !controllers))
> +		return NULL;
> +
> +	mux_chip = kzalloc(sizeof(*mux_chip) +
> +			   controllers * sizeof(*mux_chip->mux) +
> +			   sizeof_priv, GFP_KERNEL);
> +	if (!mux_chip)
> +		return NULL;
> +
> +	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
> +	mux_chip->dev.class = &mux_class;
> +	mux_chip->dev.type = &mux_type;
> +	mux_chip->dev.parent = dev;
> +	mux_chip->dev.of_node = dev->of_node;
> +	dev_set_drvdata(&mux_chip->dev, mux_chip);
> +
> +	mux_chip->id = ida_simple_get(&mux_ida, 0, 0, GFP_KERNEL);
> +	if (mux_chip->id < 0) {
> +		pr_err("muxchipX failed to get a device id\n");
> +		kfree(mux_chip);
> +		return NULL;
> +	}
> +	dev_set_name(&mux_chip->dev, "muxchip%d", mux_chip->id);
> +
> +	mux_chip->controllers = controllers;
> +	for (i = 0; i < controllers; ++i) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +
> +		mux->chip = mux_chip;
> +		init_rwsem(&mux->lock);
> +		mux->cached_state = MUX_CACHE_UNKNOWN;
> +		mux->idle_state = MUX_IDLE_AS_IS;
> +	}
> +
> +	device_initialize(&mux_chip->dev);
> +
> +	return mux_chip;
> +}
> +EXPORT_SYMBOL_GPL(mux_chip_alloc);
> +
> +static int mux_control_set(struct mux_control *mux, int state)
> +{
> +	int ret = mux->chip->ops->set(mux, state);
> +
> +	mux->cached_state = ret < 0 ? MUX_CACHE_UNKNOWN : state;
> +
> +	return ret;
> +}
> +
> +int mux_chip_register(struct mux_chip *mux_chip)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < mux_chip->controllers; ++i) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +
> +		if (mux->idle_state == mux->cached_state)
> +			continue;
> +
> +		ret = mux_control_set(mux, mux->idle_state);
> +		if (ret < 0) {
> +			dev_err(&mux_chip->dev, "unable to set idle state\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = device_add(&mux_chip->dev);
> +	if (ret < 0)
> +		dev_err(&mux_chip->dev,
> +			"device_add failed in mux_chip_register: %d\n", ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mux_chip_register);
> +
> +void mux_chip_unregister(struct mux_chip *mux_chip)
> +{
> +	device_del(&mux_chip->dev);
> +}
> +EXPORT_SYMBOL_GPL(mux_chip_unregister);
> +
> +void mux_chip_free(struct mux_chip *mux_chip)
> +{
> +	if (!mux_chip)
> +		return;
> +
> +	put_device(&mux_chip->dev);
> +}
> +EXPORT_SYMBOL_GPL(mux_chip_free);
> +
> +static void devm_mux_chip_release(struct device *dev, void *res)
> +{
> +	struct mux_chip *mux_chip = *(struct mux_chip **)res;
> +
> +	mux_chip_free(mux_chip);
> +}
> +
> +struct mux_chip *devm_mux_chip_alloc(struct device *dev,
> +				     unsigned int controllers,
> +				     size_t sizeof_priv)
> +{
> +	struct mux_chip **ptr, *mux_chip;
> +
> +	ptr = devres_alloc(devm_mux_chip_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	mux_chip = mux_chip_alloc(dev, controllers, sizeof_priv);
> +	if (!mux_chip) {
> +		devres_free(ptr);
> +		return NULL;
> +	}
> +
> +	*ptr = mux_chip;
> +	devres_add(dev, ptr);
> +
> +	return mux_chip;
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_chip_alloc);
> +
> +static int devm_mux_chip_match(struct device *dev, void *res, void *data)
> +{
> +	struct mux_chip **r = res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r == data;
> +}
> +
> +void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip)
> +{
> +	WARN_ON(devres_release(dev, devm_mux_chip_release,
> +			       devm_mux_chip_match, mux_chip));
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_chip_free);
> +
> +static void devm_mux_chip_reg_release(struct device *dev, void *res)
> +{
> +	struct mux_chip *mux_chip = *(struct mux_chip **)res;
> +
> +	mux_chip_unregister(mux_chip);
> +}
> +
> +int devm_mux_chip_register(struct device *dev,
> +			   struct mux_chip *mux_chip)
> +{
> +	struct mux_chip **ptr;
> +	int res;
> +
> +	ptr = devres_alloc(devm_mux_chip_reg_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	res = mux_chip_register(mux_chip);
> +	if (res) {
> +		devres_free(ptr);
> +		return res;
> +	}
> +
> +	*ptr = mux_chip;
> +	devres_add(dev, ptr);
> +
> +	return res;
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_chip_register);
> +
> +void devm_mux_chip_unregister(struct device *dev, struct mux_chip *mux_chip)
> +{
> +	WARN_ON(devres_release(dev, devm_mux_chip_reg_release,
> +			       devm_mux_chip_match, mux_chip));
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_chip_unregister);
> +
> +int mux_control_select(struct mux_control *mux, int state)

If we let two of these race, ...

> +{
> +	int ret;
> +
> +	if (down_read_trylock(&mux->lock)) {
> +		if (mux->cached_state == state)
> +			return 0;
> +		/* Sigh, the mux needs updating... */
> +		up_read(&mux->lock);

... and both decide the mux needs updating ...

> +	}
> +
> +	/* ...or it's just contended. */
> +	down_write(&mux->lock);

... then the last to get to down_write will just wait here forever (or
until the first consumer calls mux_control_deselect, which may never
happen)?

> +
> +	if (mux->cached_state == state) {
> +		/*
> +		 * Hmmm, someone else changed the mux to my liking.
> +		 * That makes me wonder how long I waited for nothing?
> +		 */
> +		downgrade_write(&mux->lock);
> +		return 0;
> +	}
> +
> +	ret = mux_control_set(mux, state);
> +	if (ret < 0) {
> +		if (mux->idle_state != MUX_IDLE_AS_IS)
> +			mux_control_set(mux, mux->idle_state);
> +
> +		up_write(&mux->lock);
> +		return ret;
> +	}
> +
> +	downgrade_write(&mux->lock);
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(mux_control_select);

I wonder if these should be called mux_control_lock/unlock instead,
which would allow for try_lock and lock_timeout variants.

regards
Philipp
