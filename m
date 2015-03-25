Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:47874 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbCYRXE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 25 Mar 2015 13:23:04 -0400
Date: Wed, 25 Mar 2015 18:23:01 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Daniel Baluta <daniel.baluta@intel.com>
cc: jic23@kernel.org, jlbec@evilplan.org, lars@metafoo.de,
	knaack.h@gmx.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, octavian.purdila@intel.com
Subject: Re: [PATCH 1/3] iio: configfs: Add configfs support to IIO
In-Reply-To: <1427302832-9336-2-git-send-email-daniel.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1503251805510.30570@pmeerw.net>
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com> <1427302832-9336-2-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This creates an IIO configfs subsystem named "iio", which has one default
> group named "triggers". This allows us to easily create/destroy software
> triggers. One must create a driver which implements iio_configfs_trigger.h
> interface and then add its trigger type to IIO configfs core.

some minor things noted below... I'm just trying to understand what this 
is about :)
 
> See Documentation/iio/iio_configfs.txt for more details on how configfs
> support for IIO works.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  drivers/iio/Kconfig                      |   8 +
>  drivers/iio/Makefile                     |   1 +
>  drivers/iio/industrialio-configfs.c      | 297 +++++++++++++++++++++++++++++++
>  include/linux/iio/iio_configfs_trigger.h |  48 +++++
>  4 files changed, 354 insertions(+)
>  create mode 100644 drivers/iio/industrialio-configfs.c
>  create mode 100644 include/linux/iio/iio_configfs_trigger.h
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4132935..39f1b69 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -18,6 +18,14 @@ config IIO_BUFFER
>  	  Provide core support for various buffer based data
>  	  acquisition methods.
>  
> +config IIO_CONFIGFS
> +	tristate "Enable IIO configuration via configfs"
> +	select CONFIGFS_FS
> +	help
> +	  This allows configuring various IIO bits through configfs
> +	  (e.g software trigger creation / destruction). For more info
> +	  see Documentation/iio/iio_configfs.txt.
> +
>  if IIO_BUFFER
>  
>  config IIO_BUFFER_CB
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2..90cc407 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_IIO) += industrialio.o
>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
> +industrialio-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>  
> diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
> new file mode 100644
> index 0000000..4d2133a
> --- /dev/null
> +++ b/drivers/iio/industrialio-configfs.c
> @@ -0,0 +1,297 @@
> +/*
> + * Industrial I/O configfs bits
> + *
> + * Copyright (c) 2015 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/configfs.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/iio_configfs_trigger.h>
> +
> +static const char *trigger_types[] =
> +{
> +	"none",
> +};
> +
> +struct iio_configfs_ops iio_none_ops = {
> +	.get_freq	= iio_none_get_freq,
> +	.set_freq	= iio_none_set_freq,
> +	.probe		= iio_none_probe,
> +	.remove		= iio_none_remove,
> +};
> +
> +struct iio_trigger_item {
> +	struct config_item item;
> +	struct iio_configfs_trigger_info *trigger_info;
> +};
> +
> +static
> +inline struct iio_trigger_item *to_iio_trigger_item(struct config_item *item)
> +{
> +	if (!item)
> +		return NULL;
> +	return container_of(item, struct iio_trigger_item, item);
> +}
> +
> +static unsigned int iio_trigger_get_type(const char *type_str)
> +{
> +	int i;

unsigned
the function returns an index, not a type; probably get_type_index()?

> +
> +	for (i = 0; i < ARRAY_SIZE(trigger_types); i++) {
> +		if (!strncmp(trigger_types[i], type_str,
> +			    strlen(trigger_types[i])))
> +			return i;
> +	}
> +	return -EINVAL;
> +}
> +
> +static
> +void iio_trigger_set_configfs_ops(struct iio_configfs_trigger_info *trig_info,
> +				  unsigned int type)
> +{
> +	switch (type) {
> +	case IIO_TRIGGER_TYPE_NONE:
> +		trig_info->configfs_ops = &iio_none_ops;
> +		break;
> +	default:
> +		pr_err("Setting configfs ops failed! Unknown type %d\n", type);

%u

> +		break;
> +	}
> +}
> +
> +CONFIGFS_ATTR_STRUCT(iio_trigger_item);
> +
> +#define IIO_TRIGGER_ITEM_ATTR(_name, _mode, _show, _store) \
> +struct iio_trigger_item_attribute iio_trigger_item_attr_##_name = \
> +	__CONFIGFS_ATTR(_name, _mode, _show, _store)
> +
> +static ssize_t iio_trigger_item_type_read(struct iio_trigger_item *item,
> +					  char *page)
> +{
> +	return sprintf(page, "%s\n", trigger_types[item->trigger_info->type]);
> +}
> +
> +static ssize_t iio_trigger_item_type_write(struct iio_trigger_item *item,
> +					   const char *page, size_t count)
> +{
> +	int type;
> +
> +	if (item->trigger_info->active)
> +		return -EBUSY;
> +
> +	type = iio_trigger_get_type(page);
> +	if (type < 0)
> +		return -EINVAL;
> +
> +	item->trigger_info->type = type;
> +
> +	iio_trigger_set_configfs_ops(item->trigger_info, type);
> +
> +	return count;
> +}
> +
> +static ssize_t iio_trigger_item_activate_read(struct iio_trigger_item *item,
> +					      char *page)
> +{
> +	return sprintf(page, "%d\n", item->trigger_info->active);
> +}
> +
> +static ssize_t iio_trigger_item_activate_write(struct iio_trigger_item *item,
> +					       const char *page, size_t count)
> +{
> +	bool requested_action;
> +	int ret;
> +
> +	ret = strtobool(page, &requested_action);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (requested_action == item->trigger_info->active)
> +		return -EINVAL;
> +
> +	if (requested_action)
> +		item->trigger_info->configfs_ops->probe(item->trigger_info);
> +	else
> +		item->trigger_info->configfs_ops->remove(item->trigger_info);
> +
> +	item->trigger_info->active = requested_action;
> +
> +	return count;
> +}
> +
> +static
> +ssize_t iio_trigger_item_get_sampling_freq(struct iio_trigger_item *item,
> +					   char *page)
> +{
> +	int ret;
> +
> +	if (!item->trigger_info->active)
> +		return -ENODEV;
> +
> +	ret = item->trigger_info->configfs_ops->get_freq(item->trigger_info);
> +	if (ret < 0)
> +		return ret;
> +	return sprintf(page, "%d\n", ret);
> +}
> +
> +static
> +ssize_t iio_trigger_item_set_sampling_freq(struct iio_trigger_item *item,
> +					   const char *page,
> +					   size_t count)

count is size_t, return type is ssize_t

> +{
> +	int ret;
> +	unsigned long freq;
> +
> +	if (!item->trigger_info->active)
> +		return -ENODEV;
> +
> +	ret = kstrtoul(page, 10, &freq);
> +	if (ret < 0)
> +		return 0;
> +
> +	ret = item->trigger_info->configfs_ops->set_freq(item->trigger_info,
> +							 freq);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +IIO_TRIGGER_ITEM_ATTR(type, S_IRUGO | S_IWUSR,
> +		      iio_trigger_item_type_read,
> +		      iio_trigger_item_type_write);
> +
> +IIO_TRIGGER_ITEM_ATTR(activate, S_IRUGO | S_IWUSR,
> +		      iio_trigger_item_activate_read,
> +		      iio_trigger_item_activate_write);
> +
> +IIO_TRIGGER_ITEM_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
> +		      iio_trigger_item_get_sampling_freq,
> +		      iio_trigger_item_set_sampling_freq);
> +
> +static struct configfs_attribute *iio_trigger_item_attrs[] = {
> +	&iio_trigger_item_attr_type.attr,
> +	&iio_trigger_item_attr_sampling_frequency.attr,
> +	&iio_trigger_item_attr_activate.attr,
> +	NULL
> +};
> +
> +CONFIGFS_ATTR_OPS(iio_trigger_item);
> +
> +static struct configfs_item_operations iio_trigger_item_ops = {
> +	.show_attribute = iio_trigger_item_attr_show,
> +	.store_attribute = iio_trigger_item_attr_store,
> +};
> +
> +static struct config_item_type iio_triggers_item_type;
> +
> +static struct config_item *iio_triggers_make_item(struct config_group *group,
> +						  const char *name)
> +{
> +	struct iio_trigger_item *trigger_item;
> +	struct iio_configfs_trigger_info *trigger_info;
> +
> +	trigger_item = kzalloc(sizeof(*trigger_item), GFP_KERNEL);
> +	if (!trigger_item)
> +		return ERR_PTR(-ENOMEM);
> +	trigger_info = kzalloc(sizeof(*trigger_info), GFP_KERNEL);
> +	if (!trigger_info)
> +		goto out_free_trigger_item;
> +
> +	trigger_info->name = kstrdup(name, GFP_KERNEL);
> +	if (!trigger_info->name)
> +		goto out_free_trigger_info;
> +
> +	trigger_info->type = IIO_TRIGGER_TYPE_NONE;
> +	trigger_info->configfs_ops = &iio_none_ops;
> +
> +	trigger_item->trigger_info = trigger_info;
> +	config_item_init_type_name(&trigger_item->item, name,
> +				   &iio_triggers_item_type);
> +
> +	return &trigger_item->item;
> +out_free_trigger_info:
> +	kfree(trigger_info);
> +out_free_trigger_item:
> +	kfree(trigger_item);
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +static void iio_triggers_drop_item(struct config_group *group,
> +				   struct config_item *item)
> +{
> +	struct iio_trigger_item *trigger_item;
> +
> +	trigger_item = container_of(item, struct iio_trigger_item, item);
> +
> +	kfree(trigger_item->trigger_info->name);
> +	kfree(trigger_item->trigger_info);
> +	kfree(trigger_item);
> +}
> +
> +static struct configfs_group_operations iio_triggers_group_ops = {
> +	.make_item = iio_triggers_make_item,
> +	.drop_item = iio_triggers_drop_item,
> +};
> +
> +static struct config_item_type iio_triggers_item_type = {
> +	.ct_owner	= THIS_MODULE,
> +	.ct_item_ops	= &iio_trigger_item_ops,
> +	.ct_attrs	= iio_trigger_item_attrs,
> +};
> +
> +static struct config_item_type iio_triggers_root_type = {
> +	.ct_owner	= THIS_MODULE,
> +	.ct_group_ops	= &iio_triggers_group_ops,
> +};
> +
> +static struct config_group iio_triggers_group = {
> +	.cg_item = {
> +		.ci_namebuf = "triggers",
> +		.ci_type = &iio_triggers_root_type,
> +	},
> +};
> +
> +static struct config_group *iio_default_groups[] = {
> +	&iio_triggers_group,
> +	NULL
> +};
> +
> +static struct config_item_type iio_root_group_type = {
> +	.ct_owner       = THIS_MODULE,
> +};
> +
> +static struct configfs_subsystem iio_configfs_subsys = {
> +	.su_group = {
> +		.cg_item = {
> +			.ci_namebuf = "iio",
> +			.ci_type = &iio_root_group_type,
> +		},
> +		.default_groups = iio_default_groups,
> +	},
> +	.su_mutex = __MUTEX_INITIALIZER(iio_configfs_subsys.su_mutex),
> +};
> +
> +static int __init iio_configfs_init(void)
> +{
> +	config_group_init(&iio_triggers_group);
> +	config_group_init(&iio_configfs_subsys.su_group);
> +
> +	return configfs_register_subsystem(&iio_configfs_subsys);
> +}
> +module_init(iio_configfs_init);
> +
> +static void __exit iio_configfs_exit(void)
> +{
> +	configfs_unregister_subsystem(&iio_configfs_subsys);
> +}
> +module_exit(iio_configfs_exit);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> +MODULE_DESCRIPTION("Industrial I/O configfs support");
> diff --git a/include/linux/iio/iio_configfs_trigger.h b/include/linux/iio/iio_configfs_trigger.h
> new file mode 100644
> index 0000000..e7b5777
> --- /dev/null
> +++ b/include/linux/iio/iio_configfs_trigger.h
> @@ -0,0 +1,48 @@
> +#ifndef __IIO_CONFIGFS_TRIGGER
> +#define __IIO_CONFIGFS_TRIGGER
> +
> +#define IIO_TRIGGER_TYPE_NONE		0
> +
> +struct iio_configfs_trigger_info {
> +	const char *name;
> +	unsigned int type;
> +	unsigned int active;

bool?

> +	struct iio_trigger *trigger;
> +	struct iio_configfs_ops *configfs_ops;
> +};
> +
> +struct iio_configfs_ops {
> +	int (*get_freq)(struct iio_configfs_trigger_info* );

should return unsigned long?
extra space after * and before ) looks weird

> +	int (*set_freq)(struct iio_configfs_trigger_info *, unsigned long);
> +	int (*probe)(struct iio_configfs_trigger_info* );
> +	int (*remove)(struct iio_configfs_trigger_info* );
> +};
> +
> +static 
> +inline int iio_none_get_freq(struct iio_configfs_trigger_info *trigger_info)
> +{ 
> +	return 0; 
> +}
> +
> +static 
> +inline int iio_none_set_freq(struct iio_configfs_trigger_info *trigger_info,
> +			     unsigned long f)
> +{
> +	return 0; 
> +}
> +
> +static
> +inline int iio_none_probe(struct iio_configfs_trigger_info *trigger_info)
> +{
> +	return 0; 
> +}
> +
> +static 
> +inline int iio_none_remove(struct iio_configfs_trigger_info *trigger_info)
> +{
> +	return 0; 
> +}
> +
> +extern struct iio_configfs_ops iio_hrtimer_ops;

shouldn't probably be here yet

> +
> +#endif /* __IIO_CONFIGFS_TRIGGER */
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
