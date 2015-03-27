Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-235.synserver.de ([212.40.185.235]:1046 "EHLO
	smtp-out-235.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbbC0RRW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2015 13:17:22 -0400
Message-ID: <551590A3.1060205@metafoo.de>
Date: Fri, 27 Mar 2015 18:17:23 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: jlbec@evilplan.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com
Subject: Re: [PATCH 1/3] iio: configfs: Add configfs support to IIO
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com> <1427302832-9336-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1427302832-9336-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/25/2015 06:00 PM, Daniel Baluta wrote:
> This creates an IIO configfs subsystem named "iio", which has one default
> group named "triggers". This allows us to easily create/destroy software
> triggers. One must create a driver which implements iio_configfs_trigger.h
> interface and then add its trigger type to IIO configfs core.
>
> See Documentation/iio/iio_configfs.txt for more details on how configfs
> support for IIO works.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

Very good stuff, thanks.

[...]
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

This doesn't necessarily need to be in the initial implementation, but it 
would be good instead of having a global registry inside the core module to 
have a set of functions that allow to register a configfs trigger. These 
functions can be called from the module that implements the trigger in the 
init and exit section. A helper macro similar to module_platform_driver that 
auto-generates those section would be helpful.

Cause right now we do have the dependencies wrong. The core module has a 
symbol dependency on the trigger modules implementing the trigger. That 
means you need to load the trigger module before the core module and also 
means that if at least one trigger is build as a module the core also needs 
to be built as a module.

E.g. lets say there are triggerA, triggerB and triggerC. All build as a 
module. If you want to use any of them you still have to load all of them 
since the core module has a dependency on all of them.

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
> +		break;
> +	}
> +}

I wonder if it is not better to have a sub-directory per trigger type and if 
you create a trigger in the sub-directory it is automatically of that type.

The advantage is that you can have e.g. trigger specific properties.

The downside is that you no longer have a global namespace and there could 
be name collisions by creating triggers with the same name, but with 
different types. This could be solved though by making sure that the 
internal name is pre-fixed by the type. E.g. "hrtimer-foobar" or 
"hrtimer/foobar".

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

Do we need the activate attribute? Shouldn't the trigger be create/destroyed 
if the type field is changed? Or if we have one directory per trigger type 
when the directory for the trigger is created using mkdir? I think that 
would make a nice more natural API.

[...]

