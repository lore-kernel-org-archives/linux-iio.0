Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <5547D266.3040507@metafoo.de>
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com>
	<1430736604-22119-2-git-send-email-daniel.baluta@intel.com>
	<5547D266.3040507@metafoo.de>
Date: Wed, 6 May 2015 12:24:19 +0300
Message-ID: <CAEnQRZCfO6kMj-P9Appi5iTXO_T65LOXBUivH-wU=fWesHsFnQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] iio: core: Introduce IIO software triggers
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Joel Becker <jlbec@evilplan.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Paul Bolle <pebolle@tiscali.nl>,
	patrick.porlan@intel.com, adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 4, 2015 at 11:11 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 05/04/2015 12:50 PM, Daniel Baluta wrote:
>>
>> A software trigger associates an IIO device trigger with a software
>> interrupt source (e.g: timer, sysfs). This patch adds the generic
>> infrastructure for handling software triggers.
>>
>> Software interrupts sources are kept in a iio_trigger_types_list and
>> registered separately when the associated kernel module is loaded.
>>
>> Software triggers can be created directly from drivers or from user
>> space via configfs interface.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>>   drivers/iio/Kconfig                   |   8 +++
>>   drivers/iio/Makefile                  |   1 +
>>   drivers/iio/industrialio-sw-trigger.c | 112
>> ++++++++++++++++++++++++++++++++++
>>   include/linux/iio/sw_trigger.h        |  60 ++++++++++++++++++
>>   4 files changed, 181 insertions(+)
>>   create mode 100644 drivers/iio/industrialio-sw-trigger.c
>>   create mode 100644 include/linux/iio/sw_trigger.h
>>
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index 4011eff..de7f1d9 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -58,6 +58,14 @@ config IIO_CONSUMERS_PER_TRIGGER
>>         This value controls the maximum number of consumers that a
>>         given trigger may handle. Default is 2.
>>
>> +config IIO_SW_TRIGGER
>> +       bool "Enable software triggers support"
>> +       depends on IIO_TRIGGER
>> +       help
>> +        Provides IIO core support for software triggers. A software
>> +        trigger can be created via configfs or directly by a driver
>> +        using the API provided.
>> +
>>   source "drivers/iio/accel/Kconfig"
>>   source "drivers/iio/adc/Kconfig"
>>   source "drivers/iio/amplifiers/Kconfig"
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index 698afc2..df87975 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_IIO) += industrialio.o
>>   industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>>   industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>   industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>> +industrialio-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
>>   industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>>
>>   obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>> diff --git a/drivers/iio/industrialio-sw-trigger.c
>> b/drivers/iio/industrialio-sw-trigger.c
>> new file mode 100644
>> index 0000000..f22aa63
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-sw-trigger.c
>> @@ -0,0 +1,112 @@
>> +/*
>> + * The Industrial I/O core, software trigger functions
>> + *
>> + * Copyright (c) 2015 Intel Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> it
>> + * under the terms of the GNU General Public License version 2 as
>> published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/kmod.h>
>> +#include <linux/list.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/iio/sw_trigger.h>
>> +
>> +static LIST_HEAD(iio_trigger_types_list);
>> +static DEFINE_RWLOCK(iio_trigger_types_lock);
>> +
>> +static
>> +struct iio_sw_trigger_type *iio_find_sw_trigger_type(char *name, unsigned
>> len)
>
>
> const char *name, there are a couple of other places where char * should be
> const char * below as well.

Agree. I will fix this.

>
>> +{
>> +       struct iio_sw_trigger_type *t = NULL, *iter;
>> +
>> +       list_for_each_entry(iter, &iio_trigger_types_list, list)
>> +               if (!strncmp(iter->name, name, len)) {
>> +                       t = iter;
>> +                       break;
>> +               }
>> +
>> +       return t;
>> +}
>> +
>> +int iio_register_sw_trigger_type(struct iio_sw_trigger_type *t)
>
>
> Kernel doc would be nice for the public API

ok.

>
>> +{
>> +       struct iio_sw_trigger_type *iter;
>> +       int ret = 0;
>> +
>> +       write_lock(&iio_trigger_types_lock);
>> +       iter = iio_find_sw_trigger_type(t->name, strlen(t->name));
>> +       if (iter)
>> +               ret = -EBUSY;
>> +       else
>> +               list_add_tail(&t->list, &iio_trigger_types_list);
>> +       write_unlock(&iio_trigger_types_lock);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(iio_register_sw_trigger_type);
>> +
>> +int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *t)
>
>
> I'd make the return type void. Either it is not registered and unregister is
> a noop, or it is registered and it will be successfully unregistered. Either
> way the operation won't fail.

I don't have a strong preference for this. Likely the drivers will not check for
the return code of the function, but would be nice to let them the possibility
to do so.

I'm looking at unregister_filesystem for example:

http://lxr.free-electrons.com/source/fs/filesystems.c#L101

>
>> +{
>> +       struct iio_sw_trigger_type *iter;
>> +       int ret = 0;
>> +
>> +       write_lock(&iio_trigger_types_lock);
>> +       iter = iio_find_sw_trigger_type(t->name, strlen(t->name));
>
>
> Not sure if we need this. unregister should never be called without register
> succeeding before.
>

Famous last words :). I can change it if you really have a preference for this.
I don't see any drawbacks as it is now. Also the Linux kernel code seems to
use both patterns.

>
>> +       if (!iter)
>> +               ret = -EINVAL;
>> +       else
>> +               list_del(&t->list);
>> +       write_unlock(&iio_trigger_types_lock);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(iio_unregister_sw_trigger_type);
>> +
>> +static
>> +struct iio_sw_trigger_type *iio_get_sw_trigger_type(char *name)
>> +{
>> +       struct iio_sw_trigger_type *t;
>> +
>> +       read_lock(&iio_trigger_types_lock);
>> +       t = iio_find_sw_trigger_type(name, strlen(name));
>> +       if (t && !try_module_get(t->owner))
>> +               t = NULL;
>> +       read_unlock(&iio_trigger_types_lock);
>> +
>> +       return t;
>> +}
>> +
>> +struct iio_sw_trigger *iio_sw_trigger_create(char *type, char *name)
>> +{
>> +       struct iio_sw_trigger *t;
>> +       struct iio_sw_trigger_type *tt;
>> +
>> +       tt = iio_get_sw_trigger_type(type);
>> +       if (!tt) {
>> +               pr_err("Invalid trigger type: %s\n", type);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +       t = tt->ops->probe(name);
>> +       if (IS_ERR(t))
>> +               goto out_module_put;
>> +
>> +       return t;
>> +out_module_put:
>> +       module_put(tt->owner);
>> +       return t;
>> +}
>> +EXPORT_SYMBOL(iio_sw_trigger_create);
>
> [...]
>>
>> +struct iio_sw_trigger_type {
>> +       char *name;
>
>
> const
>
>> +       struct module *owner;
>> +       struct iio_sw_trigger_ops *ops;
>
>
> const
>
>> +       struct list_head list;
>> +};
>> +
>> +struct iio_sw_trigger {
>> +       struct iio_trigger *trigger;
>> +       struct iio_sw_trigger_type *trigger_type;
>> +#ifdef CONFIG_CONFIGFS_FS
>> +       struct config_group group;
>> +#endif
>
>
> The configfs specific bits should go into patch 2.

Agree.

>
>> +};
>> +
>> +struct iio_sw_trigger_ops {
>> +       struct iio_sw_trigger* (*probe)(const char *);
>> +       int (*remove)(struct iio_sw_trigger *);
>> +};
>> +
>> +int iio_register_sw_trigger_type(struct iio_sw_trigger_type *);
>> +int iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *);
>> +
>> +struct iio_sw_trigger *iio_sw_trigger_create(char *, char *);
>> +void iio_sw_trigger_destroy(struct iio_sw_trigger *);
>> +
>> +#ifdef CONFIG_CONFIGFS_FS
>> +static inline
>> +struct iio_sw_trigger *to_iio_sw_trigger(struct config_item *item)
>> +{
>> +       return container_of(to_config_group(item), struct iio_sw_trigger,
>> +                           group);
>> +}
>> +#endif
>> +
>> +#endif /* __IIO_SW_TRIGGER */
>>
>
> --

Thanks a lot Lars!

Daniel.
