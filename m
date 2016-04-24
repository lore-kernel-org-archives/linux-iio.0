Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35787 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcDXL2x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 07:28:53 -0400
Subject: Re: [RFC PATCH 0/3] Introduce support for creating IIO devices via
 configfs
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a7957593-1a18-39fc-a12f-2e60019f8908@kernel.org>
Date: Sun, 24 Apr 2016 12:28:48 +0100
MIME-Version: 1.0
In-Reply-To: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 16:45, Daniel Baluta wrote:
> For testing purposes is nice to have a quick way of creating IIO devices.
> This patch series introduces support for creating IIO devices via configs
> (patch 1), allowing users to register "device types". For the moment we
> support "dummy" device type (patch 2).
> 
> This is just a RFC in order to see if the interface is acceptable. We also
> need a way to create IIO devices with configurable number of channels.
> 
> Patch 3 introduces configfs entries documentation for easier review.
> 
> Daniel Baluta (3):
>   iio: Add support for creating IIO devices via configfs
>   iio: dummy: Convert IIO dummy to configfs
>   Documentation: iio: Add IIO software devices docs
> 
>  Documentation/ABI/testing/configfs-iio |  13 +++
>  drivers/iio/Kconfig                    |   9 ++
>  drivers/iio/Makefile                   |   1 +
>  drivers/iio/dummy/iio_simple_dummy.c   |  98 ++++++------------
>  drivers/iio/industrialio-sw-device.c   | 181 +++++++++++++++++++++++++++++++++
>  include/linux/iio/sw_device.h          |  70 +++++++++++++
>  6 files changed, 307 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/iio/industrialio-sw-device.c
>  create mode 100644 include/linux/iio/sw_device.h
> 
Sorry, I was a muppet and delete patch one due to a misstap on my phone...
Anyhow, pasting it in here to review...

> This is similar with support for creating triggers via configfs.
> Devices will be hosted under:
> 	* /config/iio/devices
> 
> We allow users to register "device types" under:
> 	* /config/iio/devices/<device_types>/
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
As you observed, there is room in here to share some code with the sw-trigger
support.  Looks like we are going to have an iio-configfs helper library
or perhaps just move them into the industrialio-configfs module...

However, I'm not sure it's actually a good idea.  Seems to me that the amount
of fiddly indirection needed would outway the advantages in reduced code
replication.

Other than a few nitpicks this looks good to me - though that's not surprising
as it's a find and replace job on the trigger version!

Jonathan
> ---
>  drivers/iio/Kconfig                  |   9 ++
>  drivers/iio/Makefile                 |   1 +
>  drivers/iio/industrialio-sw-device.c | 181 +++++++++++++++++++++++++++++++++++
>  include/linux/iio/sw_device.h        |  70 ++++++++++++++
>  4 files changed, 261 insertions(+)
>  create mode 100644 drivers/iio/industrialio-sw-device.c
>  create mode 100644 include/linux/iio/sw_device.h
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 505e921..77711a3 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -46,6 +46,15 @@ config IIO_CONSUMERS_PER_TRIGGER
>  	This value controls the maximum number of consumers that a
>  	given trigger may handle. Default is 2.
>  
> +config IIO_SW_DEVICE
> +	tristate "Enable software IIO device support"
> +	select IIO_CONFIGFS
> +	help
> +	 Provides IIO core support for software device. A software
> +	 device can be created via configfs or directly by a driver
> +	 using the API provided.
> +
One blank line too many here...
> +
>  config IIO_SW_TRIGGER
>  	tristate "Enable software triggers support"
>  	select IIO_CONFIGFS
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 20f6490..87e4c43 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -8,6 +8,7 @@ industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  
>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
> +obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
>  obj-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
>  obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
>  
> diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
> new file mode 100644
> index 0000000..243aaf4
> --- /dev/null
> +++ b/drivers/iio/industrialio-sw-device.c
> @@ -0,0 +1,181 @@
> +/*
> + * The Industrial I/O core, software IIO devices functions
> + *
> + * Copyright (c) 2015 Intel Corporation
I think you can reasonably claim 2016 - but up to you.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kmod.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/sw_device.h>
> +#include <linux/iio/configfs.h>
> +#include <linux/configfs.h>
> +
> +static struct config_group *iio_devices_group;
> +static struct config_item_type iio_device_type_group_type;
> +
> +static struct config_item_type iio_devices_group_type = {
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static LIST_HEAD(iio_device_types_list);
> +static DEFINE_MUTEX(iio_device_types_lock);
> +
> +static
> +struct iio_sw_device_type *__iio_find_sw_device_type(const char *name,
> +						     unsigned len)
> +{
> +	struct iio_sw_device_type *d = NULL, *iter;
> +
> +	list_for_each_entry(iter, &iio_device_types_list, list)
> +		if (!strcmp(iter->name, name)) {
> +			d = iter;
> +			break;
> +		}
> +
> +	return d;
> +}
> +
> +int iio_register_sw_device_type(struct iio_sw_device_type *d)
> +{
> +	struct iio_sw_device_type *iter;
> +	int ret = 0;
> +
> +	mutex_lock(&iio_device_types_lock);
> +	iter = __iio_find_sw_device_type(d->name, strlen(d->name));
> +	if (iter)
> +		ret = -EBUSY;
> +	else
> +		list_add_tail(&d->list, &iio_device_types_list);
> +	mutex_unlock(&iio_device_types_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	d->group = configfs_register_default_group(iio_devices_group, d->name,
> +						&iio_device_type_group_type);
> +	if (IS_ERR(d->group))
> +		ret = PTR_ERR(d->group);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(iio_register_sw_device_type);
> +
> +void iio_unregister_sw_device_type(struct iio_sw_device_type *dt)
> +{
> +	struct iio_sw_device_type *iter;
> +
> +	mutex_lock(&iio_device_types_lock);
> +	iter = __iio_find_sw_device_type(dt->name, strlen(dt->name));
> +	if (iter)
> +		list_del(&dt->list);
> +	mutex_unlock(&iio_device_types_lock);
> +
> +	configfs_unregister_default_group(dt->group);
> +}
> +EXPORT_SYMBOL(iio_unregister_sw_device_type);
> +
> +static
> +struct iio_sw_device_type *iio_get_sw_device_type(const char *name)
> +{
> +	struct iio_sw_device_type *dt;
> +
> +	mutex_lock(&iio_device_types_lock);
> +	dt = __iio_find_sw_device_type(name, strlen(name));
> +	if (dt && !try_module_get(dt->owner))
> +		dt = NULL;
> +	mutex_unlock(&iio_device_types_lock);
> +
> +	return dt;
> +}
> +
> +struct iio_sw_device *iio_sw_device_create(const char *type, const char *name)
> +{
> +	struct iio_sw_device *d;
> +	struct iio_sw_device_type *dt;
> +
> +	dt = iio_get_sw_device_type(type);
> +	if (!dt) {
> +		pr_err("Invalid device type: %s\n", type);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	d = dt->ops->probe(name);
> +	if (IS_ERR(d))
> +		goto out_module_put;
> +
> +	d->device_type = dt;
> +
> +	return d;
> +out_module_put:
> +	module_put(dt->owner);
> +	return d;
> +}
> +EXPORT_SYMBOL(iio_sw_device_create);
> +
> +void iio_sw_device_destroy(struct iio_sw_device *d)
> +{
> +	struct iio_sw_device_type *dt = d->device_type;
> +
> +	dt->ops->remove(d);
> +	module_put(dt->owner);
> +}
> +EXPORT_SYMBOL(iio_sw_device_destroy);
> +
> +static struct config_group *device_make_group(struct config_group *group,
> +					      const char *name)
> +{
> +	struct iio_sw_device *d;
> +
> +	d = iio_sw_device_create(group->cg_item.ci_name, name);
> +	if (IS_ERR(d))
> +		return ERR_CAST(d);
> +
> +	config_item_set_name(&d->group.cg_item, "%s", name);
blank line here (funilly enough yuo have one in the trigger version)
> +	return &d->group;
> +}
> +
> +static void device_drop_group(struct config_group *group,
> +			      struct config_item *item)
> +{
> +	struct iio_sw_device *d = to_iio_sw_device(item);
> +
> +	iio_sw_device_destroy(d);
> +	config_item_put(item);
> +}
> +
> +static struct configfs_group_operations device_ops = {
> +	.make_group	= &device_make_group,
> +	.drop_item	= &device_drop_group,
> +};
> +
> +static struct config_item_type iio_device_type_group_type = {
> +	.ct_group_ops = &device_ops,
> +	.ct_owner       = THIS_MODULE,
> +};
> +
> +static int __init iio_sw_device_init(void)
> +{
> +	iio_devices_group =
> +		configfs_register_default_group(&iio_configfs_subsys.su_group,
> +						"devices",
> +						&iio_devices_group_type);
> +	return PTR_ERR_OR_ZERO(iio_devices_group);
> +}
> +module_init(iio_sw_device_init);
> +
> +static void __exit iio_sw_device_exit(void)
> +{
> +	configfs_unregister_default_group(iio_devices_group);
> +}
> +module_exit(iio_sw_device_exit);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> +MODULE_DESCRIPTION("Industrial I/O software devices support");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
> new file mode 100644
> index 0000000..672a9ad
> --- /dev/null
> +++ b/include/linux/iio/sw_device.h
> @@ -0,0 +1,70 @@
> +/*
> + * Industrial I/O software device interface
> + *
> + * Copyright (c) 2015 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef __IIO_SW_DEVICE
> +#define __IIO_SW_DEVICE
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/configfs.h>
> +
> +#define module_iio_sw_device_driver(__iio_sw_device_type) \
> +	module_driver(__iio_sw_device_type, iio_register_sw_device_type, \
> +		      iio_unregister_sw_device_type)
> +
> +struct iio_sw_device_ops;
> +
> +struct iio_sw_device_type {
> +	const char *name;
> +	struct module *owner;
> +	const struct iio_sw_device_ops *ops;
> +	struct list_head list;
> +	struct config_group *group;
> +};
> +
> +struct iio_sw_device {
> +	struct iio_dev *device;
> +	struct iio_sw_device_type *device_type;
> +	struct config_group group;
> +};
> +
> +struct iio_sw_device_ops {
> +	struct iio_sw_device* (*probe)(const char *);
> +	int (*remove)(struct iio_sw_device *);
> +};
> +
> +static inline
> +struct iio_sw_device *to_iio_sw_device(struct config_item *item)
> +{
> +	return container_of(to_config_group(item), struct iio_sw_device,
> +			    group);
> +}
> +
> +int iio_register_sw_device_type(struct iio_sw_device_type *dt);
> +void iio_unregister_sw_device_type(struct iio_sw_device_type *dt);
> +
> +struct iio_sw_device *iio_sw_device_create(const char *, const char *);
> +void iio_sw_device_destroy(struct iio_sw_device *);
> +
> +int iio_sw_device_type_configfs_register(struct iio_sw_device_type *dt);
> +void iio_sw_device_type_configfs_unregister(struct iio_sw_device_type *dt);
> +
> +static inline
> +void iio_swd_group_init_type_name(struct iio_sw_device *d,
> +				  const char *name,
> +				  struct config_item_type *type)
> +{
> +#ifdef CONFIG_CONFIGFS_FS
> +	config_group_init_type_name(&d->group, name, type);
> +#endif
> +}
> +
> +#endif /* __IIO_SW_DEVICE */
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


