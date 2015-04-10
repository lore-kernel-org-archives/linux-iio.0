Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37140 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbbDJLIG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2015 07:08:06 -0400
MIME-Version: 1.0
In-Reply-To: <5526B398.8050806@kernel.org>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com>
	<5526B398.8050806@kernel.org>
Date: Fri, 10 Apr 2015 14:08:05 +0300
Message-ID: <CAEnQRZBUZSRekmcNtJhWfEUzbZiNVQB6Pxn=67TCoJkU_5DySg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 9, 2015 at 8:15 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 06/04/15 15:18, Daniel Baluta wrote:
>> This module is the core of IIO configfs. It creates the "iio" subsystem under
>> configfs mount point root, with one default group for "triggers".
>>
>> It offers basic interface for registering software trigger types. Next patches
>> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
>> create a new kernel module which implements iio_configfs_trigger.h interface.
>>
>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>> support for IIO works.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Looks good and is actually a fair bit simpler than I expected which is nice!
> As an ideal aim, I'd like there to be no need for the core to have any
> idea what triggers exist and can be registered (beyond preventing naming
> clashes etc). Actually, not much would be needed to implement that I think, just
> using a list and looking up in it (we aren't on a particularly fast path so
> don't need anything clever) instead of a simple array.  A touch of locking
> probably to avoid two many simultaneous users of that list...

Good point. Will do.

I will create a list holding the list with the registered trigger types using
the trigger type name as the searching key (e.g. : "hrtimer", "sysfs").

>
> Hmm. having read through the patches, are we fundamentally limited to having to
> specify the entire directory structure before bringing up configfs?

AFAIK, directories can be created in two ways:

*  as default groups registered at iio trigger configfs init time.
*  when userspace applications call mkdir.

So, unless we agree that userspace applications should be aware of IIO
trigger types and manually call mkdir /config/iio/triggers/hrtimer (for example)
we are limited to specifying the entire directory structure in the IIO
configs module.

>
>> ---
>>
>> Changes since v2:
>>       * Fix build errors by compiling industrialio-configfs.ko
>>       as a separate module, as reported by Paul.
>>
>> Changes since v1:
>>       * addressed feedback from v1:
>>               * https://lkml.org/lkml/2015/3/25/647
>>       * create a directory per trigger type
>>       * removed activate and type attributes
>>
>>  drivers/iio/Kconfig                      |   8 ++
>>  drivers/iio/Makefile                     |   1 +
>>  drivers/iio/industrialio-configfs.c      | 127 +++++++++++++++++++++++++++++++
>>  include/linux/iio/iio_configfs_trigger.h |  40 ++++++++++
>>  4 files changed, 176 insertions(+)
>>  create mode 100644 drivers/iio/industrialio-configfs.c
>>  create mode 100644 include/linux/iio/iio_configfs_trigger.h
>>
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index 4011eff..41d5863 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -18,6 +18,14 @@ config IIO_BUFFER
>>         Provide core support for various buffer based data
>>         acquisition methods.
>>
>> +config IIO_CONFIGFS
>> +     tristate "Enable IIO configuration via configfs"
>> +     select CONFIGFS_FS
>> +     help
>> +       This allows configuring various IIO bits through configfs
>> +       (e.g. software triggers). For more info see
>> +       Documentation/iio/iio_configfs.txt.
>> +
>>  if IIO_BUFFER
>>
>>  config IIO_BUFFER_CB
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index 698afc2..72e85c42 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -8,6 +8,7 @@ industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>  industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>>
>> +obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>>  obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>>  obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>>
>> diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
>> new file mode 100644
>> index 0000000..d8ffd76
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-configfs.c
>> @@ -0,0 +1,127 @@
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
>> +#include <linux/init.h>
>> +#include <linux/kmod.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/iio_configfs_trigger.h>
>> +
>> +static struct iio_configfs_trigger_type *trigger_types[IIO_TRIGGER_TYPE_MAX];
>> +static DEFINE_RWLOCK(trigger_types_lock);
>> +
>> +int register_configfs_trigger(struct iio_configfs_trigger_type *t)
>> +{
>> +     int index = t->type;
>> +     int ret = 0;
>> +
>> +     if (index < 0 || index >= IIO_TRIGGER_TYPE_MAX)
>> +             return -EINVAL;
>> +
>> +     write_lock(&trigger_types_lock);
>> +     if (trigger_types[index])
>> +             ret = -EBUSY;
>> +     else
>> +             trigger_types[index] = t;
>> +     write_unlock(&trigger_types_lock);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL(register_configfs_trigger);
>> +
>> +int unregister_configfs_trigger(struct iio_configfs_trigger_type *t)
>> +{
>> +     int index = t->type;
>> +
>> +     if (index < 0 || index >= IIO_TRIGGER_TYPE_MAX)
>> +             return -EINVAL;
>> +
>> +     write_lock(&trigger_types_lock);
>> +     trigger_types[index] = NULL;
>> +     write_unlock(&trigger_types_lock);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL(unregister_configfs_trigger);
>> +
>> +static
>> +struct iio_configfs_trigger_type *iio_get_configfs_trigger_type(int type)
>> +{
>> +     struct iio_configfs_trigger_type *t;
>> +
>> +     if (type < 0 || type >= IIO_TRIGGER_TYPE_MAX)
>> +             return ERR_PTR(-EINVAL);
>> +
>> +     read_lock(&trigger_types_lock);
>> +     t = trigger_types[type];
>> +     if (t && !try_module_get(t->owner))
>> +             t = NULL;
>> +     read_unlock(&trigger_types_lock);
>> +
>> +     return t;
>> +}
>> +
>> +static struct config_group *iio_triggers_default_groups[] = {
>> +     NULL
>> +};
>> +
>> +static struct config_item_type iio_triggers_group_type = {
>> +     .ct_owner       = THIS_MODULE,
>> +};
>> +
>> +static struct config_group iio_triggers_group = {
>> +     .cg_item = {
>> +             .ci_namebuf = "triggers",
>> +             .ci_type = &iio_triggers_group_type,
>> +     },
>> +     .default_groups = iio_triggers_default_groups,
>> +};
>> +
>> +static struct config_group *iio_root_default_groups[] = {
>> +     &iio_triggers_group,
>> +     NULL
>> +};
>> +
>> +static struct config_item_type iio_root_group_type = {
>> +     .ct_owner       = THIS_MODULE,
>> +};
>> +
>> +static struct configfs_subsystem iio_configfs_subsys = {
>> +     .su_group = {
>> +             .cg_item = {
>> +                     .ci_namebuf = "iio",
>> +                     .ci_type = &iio_root_group_type,
>> +             },
>> +             .default_groups = iio_root_default_groups,
>> +     },
>> +     .su_mutex = __MUTEX_INITIALIZER(iio_configfs_subsys.su_mutex),
>> +};
>> +
>> +static int __init iio_configfs_init(void)
>> +{
>> +     config_group_init(&iio_triggers_group);
>> +     config_group_init(&iio_configfs_subsys.su_group);
>> +
>> +     return configfs_register_subsystem(&iio_configfs_subsys);
>> +}
>> +module_init(iio_configfs_init);
>> +
>> +static void __exit iio_configfs_exit(void)
>> +{
>> +     configfs_unregister_subsystem(&iio_configfs_subsys);
>> +}
>> +module_exit(iio_configfs_exit);
>> +
>> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
>> +MODULE_DESCRIPTION("Industrial I/O configfs support");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/iio/iio_configfs_trigger.h b/include/linux/iio/iio_configfs_trigger.h
>> new file mode 100644
>> index 0000000..75e76f2
>> --- /dev/null
>> +++ b/include/linux/iio/iio_configfs_trigger.h
>> @@ -0,0 +1,40 @@
>> +#ifndef __IIO_CONFIGFS_TRIGGER
>> +#define __IIO_CONFIGFS_TRIGGER
>> +
>> +#include <linux/device.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +
>> +#define module_iio_configfs_trigger_driver(__iio_configfs_trigger) \
>> +     module_driver(__iio_configfs_trigger, register_configfs_trigger, \
>> +                   unregister_configfs_trigger)
>> +
>> +enum {
> Is this enum actually needed as such? If we can avoid explicit need
> to list triggers in one place it would be nice.
>
> As I understand it, the point of this is to allow allocating of various
> arrays for easy lookup etc.  How about we switch over to a list and
> lookup based on magic provided by the trigger? (string or address most likely).

Not really needed, I was trying to avoid a list traversal. You have good point
here, I will use a list with the trigger type name (string) as a search key.

>> +     IIO_TRIGGER_TYPE_MAX,
>> +};
>> +
>> +struct iio_configfs_trigger_ops;
>> +
>> +struct iio_configfs_trigger_type {
>> +     int type;
>> +     struct module *owner;
>> +     struct iio_configfs_trigger_ops *trigger_ops;
>> +};
>> +
>> +struct iio_configfs_trigger_info {
>> +     char *name;
>> +     struct iio_trigger *trigger;
>> +     struct iio_configfs_trigger_type *trigger_type;
>> +};
>> +
>> +struct iio_configfs_trigger_ops {
> I wonder if we can make these more flexible from the start because
> avoiding churn in callbacks is always nice as us ensuring we have
> a manageable number in the long run!  Also we might want to play
> the 'fixed point' games we play elsewhere in IIO to allow us to have
> a very wide range of precisions.

Will try, this configfs_trigger_paramtype looks promising.

> enum iio_configfs_trigger_paramtype = {
>      delay,
> };
>
> As a final thought, we have standardised on sampling_frequency elsewhere in
> IIO (largely based on that was what the first few device used) so perhaps
> we can use that here as well instead of delay?

I am not sure I understand what is the "fixed point" game but I tried to
avoid conversions from sampling_frequency integer.fractional part
to timer period by using delay.

As already said sampling frequency comes natural for devices and delay
for timers.

>
> int (*get_parameter)(struct iio_configfs_trigger_info *, enum iio_configfs_triger_paramtype param, unsigned long *);
>
>> +     int (*get_delay)(struct iio_configfs_trigger_info *, unsigned long *);
>> +     int (*set_delay)(struct iio_configfs_trigger_info *, unsigned long);
>> +     int (*probe)(struct iio_configfs_trigger_info *);
>> +     int (*remove)(struct iio_configfs_trigger_info *);
>> +};
>> +
>> +int register_configfs_trigger(struct iio_configfs_trigger_type *);
>> +int unregister_configfs_trigger(struct iio_configfs_trigger_type *);
>> +
>> +#endif /* __IIO_CONFIGFS_TRIGGER */
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
