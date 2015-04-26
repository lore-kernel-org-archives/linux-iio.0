Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <553D3BE4.8030108@kernel.org>
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>
	<1429538563-23430-3-git-send-email-daniel.baluta@intel.com>
	<553D3BE4.8030108@kernel.org>
Date: Sun, 26 Apr 2015 22:36:11 +0300
Message-ID: <CAEnQRZCa-h9o--2aRXiXHwy9e2xbKENfKk-Xqy9GF5qExud+cg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: core: Introduce IIO configfs support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Paul Bolle <pebolle@tiscali.nl>,
	patrick.porlan@intel.com, adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 26, 2015 at 10:26 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/04/15 15:02, Daniel Baluta wrote:
>> This creates an IIO configfs subystem named "iio", with a default "triggers"
>> group.
>>
>> Triggers group is used for handling software triggers. To create a new software
>> trigger one must create a directory inside the trigger directory.
>>
>> Software trigger name MUST follow the following convention:
>>       * <trigger-type>-<trigger-name>
>> Where:
>>       * <trigger_type>, specifies the interrupt source (e.g: hrtimer)
>>       * <trigger-name>, specifies the IIO device trigger name
>>
>> Failing to follow this convention will result in an directory creation error.
>>
>> E.g, assuming that hrtimer trigger type is registered with IIO software
>> trigger core:
>>
>> $ mkdir /config/iio/triggers/hrtimer-instance1
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Looks good. Couple of little comments inline.
>
> Jonathan
>> ---
>>  drivers/iio/Kconfig                 |   8 +++
>>  drivers/iio/Makefile                |   1 +
>>  drivers/iio/industrialio-configfs.c | 117 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 126 insertions(+)
>>  create mode 100644 drivers/iio/industrialio-configfs.c
>>
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index de7f1d9..c310156 100644
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
>> index df87975..31aead3 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -10,6 +10,7 @@ industrialio-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
>>  industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>>
>>  obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>> +obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>>  obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>>
>>  obj-y += accel/
>> diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
>> new file mode 100644
>> index 0000000..0361434
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-configfs.c
>> @@ -0,0 +1,117 @@
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
>> +#include <linux/iio/sw_trigger.h>
>> +
>> +#define MAX_NAME_LEN 32
> Strikes me as perhaps a little short given we want to allow 'almost' arbitary names for the triggers.

We are anyhow, limited by the configfs name len here.

http://lxr.linux.no/linux+v3.19.1/include/linux/configfs.h#L47


>> +
>> +static struct config_group *trigger_make_group(struct config_group *group,
>> +                                            const char *name)
>> +{
>> +     char *type_name;
>> +     char *trigger_name;
>> +     char buf[MAX_NAME_LEN];
>> +     struct iio_sw_trigger *t;
>> +
>> +     snprintf(buf, MAX_NAME_LEN, "%s", name);
>> +
>> +     /* group name should have the form <trigger-type>-<trigger-name> */
>> +     type_name = buf;
>> +     trigger_name = strchr(buf, '-');
>> +     if (!trigger_name) {
>> +             pr_err("Unable to locate '-' in %s. Use <type>-<name>.\n", buf);
>> +             return ERR_PTR(-EINVAL);
>> +     }
>> +
>> +     /* replace - with \0, this nicely separates the two strings */
>> +     *trigger_name = '\0';
> Dirty trick, but I like it.

Me too, I borrowed it from the usb gadget code. :)

>> +     trigger_name++;
>> +
>> +     t = iio_sw_trigger_create(type_name, trigger_name);
>> +     if (IS_ERR(t))
>> +             return ERR_CAST(t);
>> +
>> +     config_item_set_name(&t->group.cg_item, name);
>> +
>> +     return &t->group;
>> +}
>> +
>> +static void trigger_drop_group(struct config_group *group,
>> +                            struct config_item *item)
>> +{
>> +     struct iio_sw_trigger *t = to_iio_sw_trigger(item);
>> +
>> +     if (t)
>> +             iio_sw_trigger_destroy(t);
>> +     config_item_put(item);
>> +}
>> +
>> +static struct configfs_group_operations triggers_ops = {
>> +     .make_group     = &trigger_make_group,
>> +     .drop_item      = &trigger_drop_group,
>> +};
>> +
>> +static struct config_item_type iio_triggers_group_type = {
>> +     .ct_group_ops = &triggers_ops,
>> +     .ct_owner       = THIS_MODULE,
>> +};
>> +
>> +static struct config_group iio_triggers_group = {
>> +     .cg_item = {
>> +             .ci_namebuf = "triggers",
>> +             .ci_type = &iio_triggers_group_type,
>> +     },
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


thanks,
Daniel.
