Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35684 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbbDJJCR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2015 05:02:17 -0400
MIME-Version: 1.0
In-Reply-To: <5526B24D.1010701@kernel.org>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-3-git-send-email-daniel.baluta@intel.com>
	<5526B24D.1010701@kernel.org>
Date: Fri, 10 Apr 2015 12:02:15 +0300
Message-ID: <CAEnQRZDQM0UM2f=LcCAMpwZqGgNo8JKLw+CJL9wz2Fq3zx35bQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: trigger: Add support for highres timer
 trigger type
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

On Thu, Apr 9, 2015 at 8:09 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 06/04/15 15:18, Daniel Baluta wrote:
>> This patch adds a new trigger type - the high resoluton timer ("hrtimer")
>> under /config/iio/triggers/ and also creates a module that implements hrtimer
>> trigger type functionality.
>>
>> A new IIO trigger is allocated when a new directory is created under
>> /config/iio/triggers/. The name of the trigger is the same as the dir
>> name. Each trigger will have a "delay" attribute representing the delay
>> between two successive IIO trigger_poll calls.
> Cool ;)
>>
>> Signed-off-by: Marten Svanfeldt <marten@intuitiveaerial.com>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> I'd ideally have liked the break up of the patches to be slightly different.
> There is stuff in here that would have made more sense in the first patch
> as it isn't specific to this particular trigger.

Yes :), this was my first thought too (implemented in v1), but then I wanted
to make a complete example on how to add a new trigger type.

People implementing a new trigger type will find this patch very useful.

Anyhow, I have no objection on this. Can be fixed.
>> ---
>> Changes since v2:
>>       * none
>> Changes since v1:
>>       * replaced sampling_frequency with delay to make the in kernel
>>       processing easier
> Then along comes me an suggests going back again ;)  Make your case...

Initial hrtimer trigger implementation was limited to using integer sampling
frequencies. Adding "rational" frequencies (e.g 12.5 Hz) and converting them
back to hrtimer trigger delay  would add some complex calculation in the kernel
with the possibility of losing precision.

Besides that, for most devices sampling_frequencies (Hz) attribute is natural
because this is what the devices expose in its registers, while the timers
API uses delays (nsec).

Here is how I see the usage of device's sampling_frequency and trigger's
delay (this should be kept in sync)

User application reads device's sampling_frequency and then based on that
it sets trigger's delay to 1/sampling_frequency -- all of that happening in user
space where floating point is easy :).

>>       * implemented hrtimer driver using the new API proposed in patch 1
>>
>>  drivers/iio/industrialio-configfs.c      | 164 +++++++++++++++++++++++++++++++
>>  drivers/iio/trigger/Kconfig              |   9 ++
>>  drivers/iio/trigger/Makefile             |   2 +
>>  drivers/iio/trigger/iio-trig-hrtimer.c   | 154 +++++++++++++++++++++++++++++
>>  include/linux/iio/iio_configfs_trigger.h |   1 +
>>  5 files changed, 330 insertions(+)
>>  create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
>>
>> diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
>> index d8ffd76..a0e5d24 100644
>> --- a/drivers/iio/industrialio-configfs.c
>> +++ b/drivers/iio/industrialio-configfs.c
>> @@ -71,7 +71,170 @@ struct iio_configfs_trigger_type *iio_get_configfs_trigger_type(int type)
>>       return t;
>>  }
>>
>> +struct iio_trigger_item {
>> +     struct config_item item;
>> +     struct iio_configfs_trigger_info *trigger_info;
>> +};
>> +
>> +static
>> +inline struct iio_trigger_item *to_iio_trigger_item(struct config_item *item)
>> +{
>> +     if (!item)
>> +             return NULL;
>> +     return container_of(item, struct iio_trigger_item, item);
>> +}
>> +
>> +CONFIGFS_ATTR_STRUCT(iio_trigger_item);
>> +
>> +#define IIO_TRIGGER_ITEM_ATTR(_name, _mode, _show, _store) \
>> +struct iio_trigger_item_attribute iio_trigger_item_attr_##_name = \
>> +     __CONFIGFS_ATTR(_name, _mode, _show, _store)
>> +
>> +static
>> +ssize_t iio_trigger_item_get_delay(struct iio_trigger_item *item, char *page)
>> +{
>> +     unsigned long delay;
>> +     int ret;
>> +
>> +     struct iio_configfs_trigger_type *t = item->trigger_info->trigger_type;
>> +
>> +     ret = t->trigger_ops->get_delay(item->trigger_info, &delay);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return snprintf(page, PAGE_SIZE, "%lu\n", delay);
>> +}
>> +
>> +static
>> +ssize_t iio_trigger_item_set_delay(struct iio_trigger_item *item,
>> +                                const char *page,
>> +                                size_t count)
>> +{
>> +     int ret;
>> +     unsigned long delay;
>> +     struct iio_configfs_trigger_type *t = item->trigger_info->trigger_type;
>> +
>> +     ret = kstrtoul(page, 10, &delay);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     ret = t->trigger_ops->set_delay(item->trigger_info, delay);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>> +IIO_TRIGGER_ITEM_ATTR(delay, S_IRUGO | S_IWUSR,
>> +                   iio_trigger_item_get_delay,
>> +                   iio_trigger_item_set_delay);
>> +
>> +static struct configfs_attribute *iio_trigger_item_attrs[] = {
>> +     &iio_trigger_item_attr_delay.attr,
>> +     NULL
>> +};
>> +
>> +CONFIGFS_ATTR_OPS(iio_trigger_item);
>> +
>> +static struct configfs_item_operations iio_trigger_item_ops = {
>> +     .show_attribute = iio_trigger_item_attr_show,
>> +     .store_attribute = iio_trigger_item_attr_store,
>> +};
> So everything down to here would have fitted a little better in the previous
> patch to my mind.

ok. As said above, one way of doing this would be to start with
an empty configfs support than build new trigger types on top
of it.

>
>> +
>> +static struct config_item_type iio_trigger_item_type;
>> +
>
> Why is this hrtimer specific?  Only one real place that I can see...
> I think we need to get that element out into the hrtimer module rather than
> here.  A utility function doing most of this makes sense in the core
> but not the hrtimer bit.

ok.

>
>> +static struct config_item *iio_hrtimer_make_item(struct config_group *group,
>> +                                              const char *name)
>> +{
>> +     struct iio_trigger_item *trigger_item;
>> +     struct iio_configfs_trigger_info *trigger_info;
>> +     struct iio_configfs_trigger_type *trigger_type;
>> +     int ret;
>> +
>> +     trigger_item = kzalloc(sizeof(*trigger_item), GFP_KERNEL);
>> +     if (!trigger_item)
>> +             return ERR_PTR(-ENOMEM);
>> +     trigger_info = kzalloc(sizeof(*trigger_info), GFP_KERNEL);
>> +     if (!trigger_info) {
>> +             ret = -ENOMEM;
>> +             goto out_free_trigger_item;
>> +     }
>> +
>> +     trigger_info->name = kstrdup(name, GFP_KERNEL);
>> +     if (!trigger_info->name) {
>> +             ret = -ENOMEM;
>> +             goto out_free_trigger_info;
>> +     }
>> +
>> +     trigger_type = iio_get_configfs_trigger_type(IIO_TRIGGER_TYPE_HRTIMER);
>> +     if (!trigger_type) {
>> +             pr_err("Unable to get hrtimer trigger!\n");
>> +             ret = -ENODEV;
>> +             goto out_free_trigger_name;
>> +     }
>> +     ret = trigger_type->trigger_ops->probe(trigger_info);
>> +     if (ret < 0)
>> +             goto out_error_module_put;
>> +
>> +     trigger_info->trigger_type = trigger_type;
>> +     trigger_item->trigger_info = trigger_info;
>> +
>> +     config_item_init_type_name(&trigger_item->item, name,
>> +                                &iio_trigger_item_type);
>> +
>> +     return &trigger_item->item;
>> +out_error_module_put:
>> +     module_put(trigger_type->owner);
>> +out_free_trigger_name:
>> +     kfree(trigger_info->name);
>> +out_free_trigger_info:
>> +     kfree(trigger_info);
>> +out_free_trigger_item:
>> +     kfree(trigger_item);
>> +     return ERR_PTR(ret);
>> +}
>> +
> This one is no way at all hrtimer specific that I can see!

Well, here we register the iio_trigger_item_type, which has the
"iio_trigger_item_attrs" attributes field.

If a new trigger type has a different set of attributes then
iio_trigger_item_type
would need a different instance.

But I see now how "iio_hrtimer_make_item" needs to be made generic.

>> +static void iio_hrtimer_drop_item(struct config_group *group,
>> +                               struct config_item *item)
>> +{
>> +     struct iio_trigger_item *trigger_item;
>> +     struct iio_configfs_trigger_type *trigger_type;
>> +
>> +     trigger_item = container_of(item, struct iio_trigger_item, item);
>> +     trigger_type = trigger_item->trigger_info->trigger_type;
>> +
>> +     trigger_type->trigger_ops->remove(trigger_item->trigger_info);
>> +     module_put(trigger_type->owner);
>> +     kfree(trigger_item->trigger_info->name);
>> +     kfree(trigger_item->trigger_info);
>> +     kfree(trigger_item);
>> +}
>> +
>> +static struct configfs_group_operations iio_triggers_hrtimer_group_ops = {
> So to make the separation clean we need to create this object dynamically or pass
> it through from the hrtimer trigger module.
>> +     .make_item = iio_hrtimer_make_item,
>> +     .drop_item = iio_hrtimer_drop_item,
>> +};
>> +
>> +static struct config_item_type iio_trigger_item_type = {
>> +     .ct_owner       = THIS_MODULE,
>> +     .ct_item_ops    = &iio_trigger_item_ops,
>> +     .ct_attrs       = iio_trigger_item_attrs,
>> +};
>> +
>> +static struct config_item_type iio_triggers_hrtimer_type = {
>> +     .ct_owner       = THIS_MODULE,
>> +     .ct_group_ops   = &iio_triggers_hrtimer_group_ops,
>> +};
> So this one also needs to come from the hrtimer module.

Hmm. I would also like that hrtimer module to be independent of
configfs stuff. For example, one could use hrtimer trigger from within
the kernel without even the need of iio configfs support to be compiled
in.

I will try to see if this is possible and also address your comment.

>> +
>> +static struct config_group iio_triggers_hrtimer_group = {
>> +     .cg_item = {
>> +             .ci_namebuf = "hrtimer",
>> +             .ci_type = &iio_triggers_hrtimer_type,
>> +     },
>> +};
>> +
>>  static struct config_group *iio_triggers_default_groups[] = {
>> +     &iio_triggers_hrtimer_group,
>>       NULL
>>  };
>>
>> @@ -109,6 +272,7 @@ static struct configfs_subsystem iio_configfs_subsys = {
>>
>>  static int __init iio_configfs_init(void)
>>  {
>> +     config_group_init(&iio_triggers_hrtimer_group);
> ahh... We have to do the init in this order? No dynamic creation later?

This can be done. But I'm not sure we really want this.

Now "hrtimer" is just a default group so that it automagically
appears in /config/iio/triggers/ when the configfs is mounted.

If we want this to be dynamically created later then some userspace
application should be aware of the "hrtimer" trigger type existence
and create the hrtimer directory at some point.

>>       config_group_init(&iio_triggers_group);
>>       config_group_init(&iio_configfs_subsys.su_group);
>>
>> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
>> index 7999612..e21688e 100644
>> --- a/drivers/iio/trigger/Kconfig
>> +++ b/drivers/iio/trigger/Kconfig
>> @@ -5,6 +5,15 @@
>>
>>  menu "Triggers - standalone"
>>
>> +config IIO_HRTIMER_TRIGGER
>> +     tristate "High resolution timer trigger"
>> +     depends on IIO_CONFIGFS
>> +     help
>> +       Provides a frequency based IIO trigger using hrtimers.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called iio-trig-hrtimer.
>> +
>>  config IIO_INTERRUPT_TRIGGER
>>       tristate "Generic interrupt trigger"
>>       help
>> diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
>> index 0694dae..fe06eb5 100644
>> --- a/drivers/iio/trigger/Makefile
>> +++ b/drivers/iio/trigger/Makefile
>> @@ -3,5 +3,7 @@
>>  #
>>
>>  # When adding new entries keep the list in alphabetical order
>> +
>> +obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
>>  obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
>>  obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
>> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
>> new file mode 100644
>> index 0000000..0acde8d
>> --- /dev/null
>> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
>> @@ -0,0 +1,154 @@
>> +/**
>> + * The industrial I/O periodic hrtimer trigger driver
>> + *
>> + * Copyright (C) Intuitive Aerial AB
>> + * Written by Marten Svanfeldt, marten@intuitiveaerial.com
>> + * Copyright (C) 2012, Analog Device Inc.
>> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/hrtimer.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/iio_configfs_trigger.h>
>> +
>> +/* default delay in ns (100Hz) */
>> +#define HRTIMER_TRIGGER_DEFAULT_DELAY 100000000
>> +
>> +struct iio_hrtimer_trig_info {
>> +     struct iio_configfs_trigger_info *trigger_info;
>> +     struct hrtimer timer;
>> +     unsigned long delay;
>> +};
>> +
>> +static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *timer)
>> +{
>> +     struct iio_hrtimer_trig_info *trig_info;
>> +
>> +     trig_info = container_of(timer, struct iio_hrtimer_trig_info, timer);
>> +
>> +     hrtimer_forward_now(timer, ns_to_ktime(trig_info->delay));
>> +     iio_trigger_poll(trig_info->trigger_info->trigger);
>> +
>> +     return HRTIMER_RESTART;
>> +}
>> +
>> +static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
>> +{
>> +     struct iio_hrtimer_trig_info *trig_info;
>> +
>> +     trig_info = iio_trigger_get_drvdata(trig);
>> +
>> +     if (state)
>> +             hrtimer_start(&trig_info->timer, ns_to_ktime(trig_info->delay),
>> +                           HRTIMER_MODE_REL);
>> +     else
>> +             hrtimer_cancel(&trig_info->timer);
>> +
>> +     return 0;
>> +}
>> +
>> +int iio_trig_hrtimer_get_delay(struct iio_configfs_trigger_info *t,
>> +                            unsigned long *delay)
>> +{
>> +     struct iio_hrtimer_trig_info *trig_info;
>> +
>> +     trig_info = iio_trigger_get_drvdata(t->trigger);
>> +     *delay = trig_info->delay;
>> +
>> +     return 0;
>> +}
>> +
>> +int iio_trig_hrtimer_set_delay(struct iio_configfs_trigger_info *t,
>> +                            unsigned long delay)
>> +{
>> +     struct iio_hrtimer_trig_info *trig_info;
>> +
>> +     trig_info = iio_trigger_get_drvdata(t->trigger);
>> +
>> +     if (!delay)
>> +             return -EINVAL;
>> +
>> +     trig_info->delay = delay;
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct iio_trigger_ops iio_hrtimer_trigger_ops = {
>> +     .owner = THIS_MODULE,
>> +     .set_trigger_state = iio_trig_hrtimer_set_state,
>> +};
>> +
>> +static int iio_trig_hrtimer_probe(struct iio_configfs_trigger_info *t)
>> +{
>> +     struct iio_hrtimer_trig_info *trig_info;
>> +     int ret;
>> +
>> +     trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
>> +     if (!trig_info)
>> +             return -ENOMEM;
>> +
>> +     trig_info->trigger_info = t;
>> +
>> +     t->trigger = iio_trigger_alloc("%s", t->name);
>> +     if (!t->trigger)
>> +             return -ENOMEM;
>> +
>> +     iio_trigger_set_drvdata(t->trigger, trig_info);
>> +     t->trigger->ops = &iio_hrtimer_trigger_ops;
>> +
>> +     hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +     trig_info->timer.function = iio_trig_hrtimer_trig;
>> +
>> +     trig_info->delay = HRTIMER_TRIGGER_DEFAULT_DELAY;
>> +
>> +     ret = iio_trigger_register(t->trigger);
>> +     if (ret)
>> +             goto err_free_trigger;
>> +
>> +     return 0;
>> +err_free_trigger:
>> +     iio_trigger_free(t->trigger);
>> +
>> +     return ret;
>> +}
>> +
>> +static int iio_trig_hrtimer_remove(struct iio_configfs_trigger_info *t)
>> +{
>> +     struct iio_hrtimer_trig_info *trig_info;
>> +
>> +     trig_info = iio_trigger_get_drvdata(t->trigger);
>> +
>> +     iio_trigger_unregister(t->trigger);
>> +     hrtimer_cancel(&trig_info->timer);
>> +     iio_trigger_free(t->trigger);
>> +
>> +     return 0;
>> +}
>> +
>> +struct iio_configfs_trigger_ops hrtimer_trigger_ops = {
>> +     .get_delay      = iio_trig_hrtimer_get_delay,
>> +     .set_delay      = iio_trig_hrtimer_set_delay,
>> +     .probe          = iio_trig_hrtimer_probe,
>> +     .remove         = iio_trig_hrtimer_remove,
>> +};
>> +
>> +struct iio_configfs_trigger_type iio_configfs_hrtimer = {
>> +     .type = IIO_TRIGGER_TYPE_HRTIMER,
>> +     .owner = THIS_MODULE,
>> +     .trigger_ops = &hrtimer_trigger_ops,
>> +};
>> +
>> +module_iio_configfs_trigger_driver(iio_configfs_hrtimer);
>> +
>> +MODULE_AUTHOR("Marten Svanfeldt <marten@intuitiveaerial.com>");
>> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
>> +MODULE_DESCRIPTION("Periodic hrtimer trigger for the IIO subsystem");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/iio/iio_configfs_trigger.h b/include/linux/iio/iio_configfs_trigger.h
>> index 75e76f2..6233733 100644
>> --- a/include/linux/iio/iio_configfs_trigger.h
>> +++ b/include/linux/iio/iio_configfs_trigger.h
>> @@ -10,6 +10,7 @@
>>                     unregister_configfs_trigger)
>>
>>  enum {
>> +     IIO_TRIGGER_TYPE_HRTIMER = 0,
>>       IIO_TRIGGER_TYPE_MAX,
>>  };
>>
>>
>

Thanks a lot for your valuable feedback Jonathan :).

Daniel.
