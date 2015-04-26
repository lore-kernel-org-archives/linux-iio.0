Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42968 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbDZTis (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 15:38:48 -0400
Message-ID: <553D3EC4.5080504@kernel.org>
Date: Sun, 26 Apr 2015 20:38:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Subject: Re: [PATCH v4 1/4] iio: core: Introduce IIO software triggers
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>	<1429538563-23430-2-git-send-email-daniel.baluta@intel.com>	<553D3A9F.9030902@kernel.org> <CAEnQRZAQn-6ZVH5T4UuUnTTZfg4CES61NKxgD88bKKOCrc84dg@mail.gmail.com>
In-Reply-To: <CAEnQRZAQn-6ZVH5T4UuUnTTZfg4CES61NKxgD88bKKOCrc84dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/04/15 20:32, Daniel Baluta wrote:
> On Sun, Apr 26, 2015 at 10:21 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 20/04/15 15:02, Daniel Baluta wrote:
>>> A software trigger associates an IIO device trigger with a software
>>> interrupt source (e.g: timer, sysfs). This patch adds the generic
>>> infrastructure for handling software triggers.
>>>
>>> Software interrupts sources are kept in a iio_trigger_types_list and
>>> registered separately when the associated kernel module is loaded.
>>>
>>> Software triggers can be created directly from drivers or from user
>>> space via configfs interface.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> Looks sensible.
>> My only real question is if the rwlock is justified (vs a mutex).
> 
> Hmm, a given iio_trigger_type list element is mostly read. Also, borrowed
> the code from file systems core implementation.
> 
> http://lxr.linux.no/linux+v3.19.1/fs/filesystems.c#L33
> 
> Anyhow, there is no problem to use a mutex.
It it's the standard option for this usecase then I don't really mind.
> 
>>
>>> ---
>>>  drivers/iio/Kconfig                   |   8 +++
>>>  drivers/iio/Makefile                  |   1 +
>>>  drivers/iio/industrialio-sw-trigger.c | 111 ++++++++++++++++++++++++++++++++++
>>>  include/linux/iio/sw_trigger.h        |  50 +++++++++++++++
>>>  4 files changed, 170 insertions(+)
>>>  create mode 100644 drivers/iio/industrialio-sw-trigger.c
>>>  create mode 100644 include/linux/iio/sw_trigger.h
>>>
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>> index 4011eff..de7f1d9 100644
>>> --- a/drivers/iio/Kconfig
>>> +++ b/drivers/iio/Kconfig
>>> @@ -58,6 +58,14 @@ config IIO_CONSUMERS_PER_TRIGGER
>>>       This value controls the maximum number of consumers that a
>>>       given trigger may handle. Default is 2.
>>>
>>> +config IIO_SW_TRIGGER
>>> +     bool "Enable software triggers support"
>>> +     depends on IIO_TRIGGER
>>> +     help
>>> +      Provides IIO core support for software triggers. A software
>>> +      trigger can be created via configfs or directly by a driver
>>> +      using the API provided.
>>> +
>>>  source "drivers/iio/accel/Kconfig"
>>>  source "drivers/iio/adc/Kconfig"
>>>  source "drivers/iio/amplifiers/Kconfig"
>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>> index 698afc2..df87975 100644
>>> --- a/drivers/iio/Makefile
>>> +++ b/drivers/iio/Makefile
>>> @@ -6,6 +6,7 @@ obj-$(CONFIG_IIO) += industrialio.o
>>>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>>>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>> +industrialio-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
>>>  industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>>>
>>>  obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>>> diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
>>> new file mode 100644
>>> index 0000000..567c675
>>> --- /dev/null
>>> +++ b/drivers/iio/industrialio-sw-trigger.c
>>> @@ -0,0 +1,111 @@
>>> +/*
>>> + * The Industrial I/O core, software trigger functions
>>> + *
>>> + * Copyright (c) 2015 Intel Corporation
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License version 2 as published by
>>> + * the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kmod.h>
>>> +#include <linux/list.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <linux/iio/sw_trigger.h>
>>> +
>>> +static LIST_HEAD(iio_trigger_types_list);
>>> +static DEFINE_RWLOCK(iio_trigger_types_lock);
>> Can see the logic, but I'm not totally convinced a rwlock is necessary.
>> We don't actually create new ones terribly often...
> 
> I see your point. Could change the code to use a mutex.
> 
>>> +
>>> +static
>>> +struct iio_sw_trigger_type *iio_find_sw_trigger_type(char *name, unsigned len)
>>> +{
>>> +     struct iio_sw_trigger_type *t = NULL, *iter;
>>> +
>>> +     list_for_each_entry(iter, &iio_trigger_types_list, list)
>>> +             if (!strncmp(iter->name, name, len)) {
>>> +                     t = iter;
>>> +                     break;
>>> +             }
>>> +
>>> +     return t;
>>> +}
>>> +
>>> +int iio_register_sw_trigger_type(struct iio_sw_trigger_type *t)
>>> +{
>>> +     struct iio_sw_trigger_type *iter;
>>> +     int ret = 0;
>>> +
>>> +     write_lock(&iio_trigger_types_lock);
>>> +     iter = iio_find_sw_trigger_type(t->name, strlen(t->name));
>>> +     if (iter)
>>> +             ret = -EBUSY;
>> Rather than EAGAIN?  Could also do the magic attempt to autoload the
>> module that the usb gadget driver does (though add that as a later
>> feature rather than in this first posting I think to keep complexity
>> of patch manageable).
> 
> I see, we can do this later. Anyhow, I'm not convinced that EAGAIN is a good
> value here. We just want to inform the user that the module registering this
> trigger type is already loaded.
> 
> Like here:
> 
> http://lxr.linux.no/linux+v3.19.1/fs/filesystems.c#L78
> 
Gah. I got this backwards.  Ignore me on that one.
> 
>>> +     else
>>> +             list_add_tail(&t->list, &iio_trigger_types_list);
>>> +     write_unlock(&iio_trigger_types_lock);
>> nitpick :) blank line here.
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL(iio_register_sw_trigger_type);
>>> +
>>> +int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *t)
>>> +{
>>> +     struct iio_sw_trigger_type *iter;
>>> +     int ret = 0;
>>> +
>>> +     write_lock(&iio_trigger_types_lock);
>>> +     iter = iio_find_sw_trigger_type(t->name, strlen(t->name));
>>> +     if (!iter)
>>> +             ret = -EINVAL;
>>> +     else
>>> +             list_del(&t->list);
>>> +     write_unlock(&iio_trigger_types_lock);
>>> +
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL(iio_unregister_sw_trigger_type);
>>> +
>>> +static
>>> +struct iio_sw_trigger_type *iio_get_sw_trigger_type(char *name)
>>> +{
>>> +     struct iio_sw_trigger_type *t;
>>> +
>>> +     read_lock(&iio_trigger_types_lock);
>>> +     t = iio_find_sw_trigger_type(name, strlen(name));
>>> +     if (t && !try_module_get(t->owner))
>>> +             t = NULL;
>>> +     read_unlock(&iio_trigger_types_lock);
>>> +
>>> +     return t;
>>> +}
>>> +
>>> +struct iio_sw_trigger *iio_sw_trigger_create(char *type, char *name)
>>> +{
>>> +     struct iio_sw_trigger *t;
>>> +     struct iio_sw_trigger_type *tt;
>> I like the brief variable names (perfectly clear so not actually being
>> sarcastic ;))
>>> +
>>> +     tt = iio_get_sw_trigger_type(type);
>>> +     if (!tt) {
>>> +             pr_err("Invalid trigger type: %s\n", type);
>>> +             return ERR_PTR(-EINVAL);
>>> +     }
>>> +     t = tt->ops->probe(name);
>>> +     if (IS_ERR(t))
>>> +             goto out_module_put;
>>> +
>>> +     return t;
>>> +out_module_put:
>>> +     module_put(tt->owner);
>>> +     return t;
>>> +}
>>> +EXPORT_SYMBOL(iio_sw_trigger_create);
>>> +
>>> +void iio_sw_trigger_destroy(struct iio_sw_trigger *t)
>>> +{
>>> +     struct iio_sw_trigger_type *tt = t->trigger_type;
>>> +
>>> +     tt->ops->remove(t);
>>> +     module_put(tt->owner);
>>> +}
>>> +EXPORT_SYMBOL(iio_sw_trigger_destroy);
>>> diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
>>> new file mode 100644
>>> index 0000000..2e6659b
>>> --- /dev/null
>>> +++ b/include/linux/iio/sw_trigger.h
>>> @@ -0,0 +1,50 @@
>>> +#ifndef __IIO_SW_TRIGGER
>>> +#define __IIO_SW_TRIGGER
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/device.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/configfs.h>
>>> +
>>> +#define module_iio_sw_trigger_driver(__iio_sw_trigger_type) \
>>> +     module_driver(__iio_sw_trigger_type, iio_register_sw_trigger_type, \
>>> +                   iio_unregister_sw_trigger_type)
>>> +
>>> +struct iio_sw_trigger_ops;
>>> +
>>> +struct iio_sw_trigger_type {
>>> +     char *name;
>>> +     struct module *owner;
>>> +     struct iio_sw_trigger_ops *ops;
>>> +     struct list_head list;
>>> +};
>>> +
>>> +struct iio_sw_trigger {
>>> +     struct iio_trigger *trigger;
>>> +     struct iio_sw_trigger_type *trigger_type;
>>> +#ifdef CONFIG_CONFIGFS_FS
>>> +     struct config_group group;
>>> +#endif
>>> +};
>>> +
>>> +struct iio_sw_trigger_ops {
>>> +     struct iio_sw_trigger* (*probe)(const char *);
>>> +     int (*remove)(struct iio_sw_trigger *);
>>> +};
>>> +
>>> +int iio_register_sw_trigger_type(struct iio_sw_trigger_type *);
>>> +int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *);
>>> +
>>> +struct iio_sw_trigger *iio_sw_trigger_create(char *, char *);
>>> +void iio_sw_trigger_destroy(struct iio_sw_trigger *);
>>> +
>>> +#ifdef CONFIG_CONFIGFS_FS
>>> +static inline
>>> +struct iio_sw_trigger *to_iio_sw_trigger(struct config_item *item)
>>> +{
>>> +     return container_of(to_config_group(item), struct iio_sw_trigger,
>>> +                         group);
>>> +}
>>> +#endif
>>> +
>>> +#endif /* __IIO_SW_TRIGGER */
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

