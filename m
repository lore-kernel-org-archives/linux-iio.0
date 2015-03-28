Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59692 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbbC1LvD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:51:03 -0400
Message-ID: <551695A0.50807@kernel.org>
Date: Sat, 28 Mar 2015 11:50:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: jlbec@evilplan.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com
Subject: Re: [PATCH 1/3] iio: configfs: Add configfs support to IIO
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com> <1427302832-9336-2-git-send-email-daniel.baluta@intel.com> <551590A3.1060205@metafoo.de>
In-Reply-To: <551590A3.1060205@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/15 17:17, Lars-Peter Clausen wrote:
> On 03/25/2015 06:00 PM, Daniel Baluta wrote:
>> This creates an IIO configfs subsystem named "iio", which has one default
>> group named "triggers". This allows us to easily create/destroy software
>> triggers. One must create a driver which implements iio_configfs_trigger.h
>> interface and then add its trigger type to IIO configfs core.
>>
>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>> support for IIO works.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> Very good stuff, thanks.
> 
> [...]
>> diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
>> new file mode 100644
>> index 0000000..4d2133a
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-configfs.c
>> @@ -0,0 +1,297 @@
>> +/*
>> + * Industrial I/O configfs bits
>> + *
>> + * Copyright (c) 2015 Intel Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/configfs.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/iio/iio_configfs_trigger.h>
>> +
>> +static const char *trigger_types[] =
>> +{
>> +    "none",
>> +};
> 
> This doesn't necessarily need to be in the initial implementation, but it would be good instead of having a global registry inside the core module to have a set of functions that allow to register a configfs trigger. These functions can be called from the module that implements the trigger in the init and exit section. A helper macro similar to module_platform_driver that auto-generates those section would be helpful.
> 
> Cause right now we do have the dependencies wrong. The core module has a symbol dependency on the trigger modules implementing the trigger. That means you need to load the trigger module before the core module and also means that if at least one trigger is build as a module the core also needs to be built as a module.
> 
> E.g. lets say there are triggerA, triggerB and triggerC. All build as a module. If you want to use any of them you still have to load all of them since the core module has a dependency on all of them.
> 
>> +
>> +struct iio_configfs_ops iio_none_ops = {
>> +    .get_freq    = iio_none_get_freq,
>> +    .set_freq    = iio_none_set_freq,
>> +    .probe        = iio_none_probe,
>> +    .remove        = iio_none_remove,
>> +};
>> +
>> +struct iio_trigger_item {
>> +    struct config_item item;
>> +    struct iio_configfs_trigger_info *trigger_info;
>> +};
>> +
>> +static
>> +inline struct iio_trigger_item *to_iio_trigger_item(struct config_item *item)
>> +{
>> +    if (!item)
>> +        return NULL;
>> +    return container_of(item, struct iio_trigger_item, item);
>> +}
>> +
>> +static unsigned int iio_trigger_get_type(const char *type_str)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(trigger_types); i++) {
>> +        if (!strncmp(trigger_types[i], type_str,
>> +                strlen(trigger_types[i])))
>> +            return i;
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>> +static
>> +void iio_trigger_set_configfs_ops(struct iio_configfs_trigger_info *trig_info,
>> +                  unsigned int type)
>> +{
>> +    switch (type) {
>> +    case IIO_TRIGGER_TYPE_NONE:
>> +        trig_info->configfs_ops = &iio_none_ops;
>> +        break;
>> +    default:
>> +        pr_err("Setting configfs ops failed! Unknown type %d\n", type);
>> +        break;
>> +    }
>> +}
> 

> I wonder if it is not better to have a sub-directory per trigger type
> and if you create a trigger in the sub-directory it is automatically
> of that type.
I agree, this would perhaps be more flexible / intuitive.
> 
> The advantage is that you can have e.g. trigger specific properties.
The initial set of triggers will be (I guess!)

* high resolution timer
* sysfs (userspace trigger) - in parallel with it's existing sysfs interface
  which unfortunately we'll have to keep for at least a few years.
Later on, once we have in kernel interfaces for events I'd expect we'll
want event fired triggers (grab data based on an event from the same device
or a different one for that matter)...

Anyhow, definitely going to want different properties for these!

> 
> The downside is that you no longer have a global namespace and there
> could be name collisions by creating triggers with the same name, but
> with different types. This could be solved though by making sure that
> the internal name is pre-fixed by the type. E.g. "hrtimer-foobar" or
> "hrtimer/foobar".
Yes, the prefix would be sensible. 

>> +
>> +CONFIGFS_ATTR_STRUCT(iio_trigger_item);
>> +
>> +#define IIO_TRIGGER_ITEM_ATTR(_name, _mode, _show, _store) \
>> +struct iio_trigger_item_attribute iio_trigger_item_attr_##_name = \
>> +    __CONFIGFS_ATTR(_name, _mode, _show, _store)
>> +
>> +static ssize_t iio_trigger_item_type_read(struct iio_trigger_item *item,
>> +                      char *page)
>> +{
>> +    return sprintf(page, "%s\n", trigger_types[item->trigger_info->type]);
>> +}
>> +
>> +static ssize_t iio_trigger_item_type_write(struct iio_trigger_item *item,
>> +                       const char *page, size_t count)
>> +{
>> +    int type;
>> +
>> +    if (item->trigger_info->active)
>> +        return -EBUSY;
>> +
>> +    type = iio_trigger_get_type(page);
>> +    if (type < 0)
>> +        return -EINVAL;
>> +
>> +    item->trigger_info->type = type;
>> +
>> +    iio_trigger_set_configfs_ops(item->trigger_info, type);
>> +
>> +    return count;
>> +}
>> +
>> +static ssize_t iio_trigger_item_activate_read(struct iio_trigger_item *item,
>> +                          char *page)
>> +{
>> +    return sprintf(page, "%d\n", item->trigger_info->active);
>> +}
>> +
>> +static ssize_t iio_trigger_item_activate_write(struct iio_trigger_item *item,
>> +                           const char *page, size_t count)
>> +{
>> +    bool requested_action;
>> +    int ret;
>> +
>> +    ret = strtobool(page, &requested_action);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    if (requested_action == item->trigger_info->active)
>> +        return -EINVAL;
>> +
>> +    if (requested_action)
>> +        item->trigger_info->configfs_ops->probe(item->trigger_info);
>> +    else
>> +        item->trigger_info->configfs_ops->remove(item->trigger_info);
>> +
>> +    item->trigger_info->active = requested_action;
>> +
>> +    return count;
>> +}
> 
> Do we need the activate attribute? Shouldn't the trigger be
> create/destroyed if the type field is changed? Or if we have one
> directory per trigger type when the directory for the trigger is
> created using mkdir? I think that would make a nice more natural
> API.> 
> [...]
Only exception would be a trigger that has no meaning until we have
configured it - e.g. the event triggers mentioned above.  That would
need an explicit activate.  Question is whether we want to start
out with that interface for all triggers on the basis it will be
needed later?

Actually come to think of it, there is no problem with registering
an unconfigured trigger - just with using it.  Hence we could do
so and only fault out when a buffer using the trigger is started.
That works for the complex usecase (as long as we spit out appropriate
log messages / error codes).

Hence if we can get away with doing everything on the mkdir that
would be great.
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

