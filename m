Return-Path: <SRS0=tGTo=BC=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170929200107.GA6418@sophia>
References: <cover.1506353914.git.vilhelm.gray@gmail.com> <842fc24036d62f4d60efb07aa87a9539b3016da2.1506353914.git.vilhelm.gray@gmail.com>
 <CA+M3ks4i1yPHmqonfKOVRy7D9HHLvxkcGSoE0gBMdYVc8jHRFg@mail.gmail.com> <20170929200107.GA6418@sophia>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 3 Oct 2017 16:01:17 +0200
Message-ID: <CA+M3ks5XqQWc5bPdjYAeajrBG4VX5rpbf0U0Y7EF4UfH3s+ZNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: Introduce the generic counter interface
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-09-29 22:01 GMT+02:00 William Breathitt Gray <vilhelm.gray@gmail.com>:
> On Fri, Sep 29, 2017 at 03:42:02PM +0200, Benjamin Gaignard wrote:
>>2017-09-25 20:08 GMT+02:00 William Breathitt Gray <vilhelm.gray@gmail.com>:
>>> This patch introduces the IIO generic counter interface for supporting
>>> counter devices. The generic counter interface serves as a catch-all to
>>> enable rudimentary support for devices that qualify as counters. More
>>> specific and apt counter interfaces may be developed on top of the
>>> generic counter interface, and those interfaces should be used by
>>> drivers when possible rather than the generic counter interface.
>>>
>>> In the context of the IIO generic counter interface, a counter is
>>> defined as a device that reports one or more "counter values" based on
>>> the state changes of one or more "counter signals" as evaluated by a
>>> defined "counter function."
>>>
>>> The IIO generic counter interface piggybacks off of the IIO core. This
>>> is primarily used to leverage the existing sysfs setup: the IIO_COUNT
>>> channel attributes represent the "counter value," while the IIO_SIGNAL
>>> channel attributes represent the "counter signal;" auxilary IIO_COUNT
>>> attributes represent the "counter signal" connections and their
>>> respective state change configurations which trigger an associated
>>> "counter function" evaluation.
>>>
>>> The iio_counter_ops structure serves as a container for driver callbacks
>>> to communicate with the device; function callbacks are provided to read
>>> and write various "counter signals" and "counter values," and set and
>>> get the "trigger mode" and "function mode" for various "counter signals"
>>> and "counter values" respectively.
>>>
>>> To support a counter device, a driver must first allocate the available
>>> "counter signals" via iio_counter_signal structures. These "counter
>>> signals" should be stored as an array and set to the init_signals member
>>> of an allocated iio_counter structure before the counter is registered.
>>>
>>> "Counter values" may be allocated via iio_counter_value structures, and
>>> respective "counter signal" associations made via iio_counter_trigger
>>> structures. Initial associated iio_counter_trigger structures may be
>>> stored as an array and set to the the init_triggers member of the
>>> respective iio_counter_value structure. These iio_counter_value
>>> structures may be set to the init_values member of an allocated
>>> iio_counter structure before the counter is registered if so desired.
>>>
>>> A counter device is registered to the system by passing the respective
>>> initialized iio_counter structure to the iio_counter_register function;
>>> similarly, the iio_counter_unregister function unregisters the
>>> respective counter.
>>>
>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>
>>Hi William,
>>
>>Thanks for your patches, I start try to implement them in stm32-timer driver
>>but I think it will take me some time before understand all your code.
>>
>>I have some warning when compiling the code (see below).
>
> Hi Benjamin,
>
> Thank you for trying out the patches. I've been focusing on the main API
> documentation thus far, so unfortunately the current code is still a bit
> hard to follow -- hopefully I can clean it up some soon. Regardless,
> I'll be happy to answer any questions you may encounter while reviewing
> the patches.
>
> Regarding the compilation warnings: see my response inline below.
>
>>
>>About wording, I think that using "trigger" to describe signal active
>>states/edges
>>could be confusing in IIO context but I haven't found yet a better name.
>
> I agree very much with this. "Trigger" was a bad name choice when I
> developed the Generic Counter paradigm. I would like to come up with a
> better name for this component before this patchset is merged.
>
> The "Trigger" component essentially describes an association between a
> Signal and Value. The association typically has a defined Signal data
> condition which triggers the respective Value function operation (or
> occasionally the trigger condition is just left as "None"), but
> ultimately it's the association itself that is the key aspect this
> component.
>
> I have considered changing it to "Association" or "Connection" as the
> name, but both of these seem to sound too vague of terms. I shall keep
> thinking of various alternative names for this component and change the
> documentation in a subsequent patchset version once we have a more
> fitting name.

Yes it isn't easy to find the good name for that, maybe signal capabilities or
signal behavoir could also be considere.

>
>>
>>I also not very sure about what you expect from iio_counter_ops signal_read and
>>signal_write functions, do you think get/set the value of the signal ?
>>(i.e read gpio level ?)
>
> Yes, for an ordinary simple counter, signal_read and signal_write would
> typically expose control of the respective hardware input line level.
>
> However, it is important to remember that within the context of the
> Generic Counter paradigm, Signals are abstract components: a single
> Signal may not directly correlate to a single hardware input line; this
> is the primary reason for providing the signal_read/signal_write
> functions.
>
> For example, suppose we have a counter with a single Value associated to
> a single Signal. The Signal data is a 3-bit decimal value, and the Value
> is an ongoing count of the number of times the Signal data decimal value
> has had a value greater than "5."
>
> The hardware itself could consist of three individual input lines
> (one for each bit), but there is ultimately only one Signal. In this
> scenario, I would expect signal_read to simply return the 3-bit decimal
> value -- not the three physical hardware input line level. Notice the
> abstraction which has occurred: the Signal is the data represented by
> the hardware input, but not the raw hardware input itself.

I do not have access to the hardware input value anyway so I will just
keep those functions empty.

I have done some progress in driver implementation but I have questions
and suggestion, see below.

Benjamin

>
> Sincerely,
>
> William Breathitt Gray
>
>>
>>I will continue to review and implement your patches, I hope that end
>>of next week
>>have something functionnal to share with you.
>>
>>Thansk to have propose this, I do believe it will be helpful
>>
>>Benjamin
>>> ---
>>>  MAINTAINERS                        |    7 +
>>>  drivers/iio/Kconfig                |    8 +
>>>  drivers/iio/Makefile               |    1 +
>>>  drivers/iio/counter/Kconfig        |    1 +
>>>  drivers/iio/industrialio-counter.c | 1151 ++++++++++++++++++++++++++++++++++++
>>>  include/linux/iio/counter.h        |  221 +++++++
>>>  6 files changed, 1389 insertions(+)
>>>  create mode 100644 drivers/iio/industrialio-counter.c
>>>  create mode 100644 include/linux/iio/counter.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6f7721d1634c..24fc2dcf1995 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -6577,6 +6577,13 @@ F:       Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
>>>  F:     Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
>>>  F:     drivers/iio/adc/envelope-detector.c
>>>
>>> +IIO GENERIC COUNTER INTERFACE
>>> +M:     William Breathitt Gray <vilhelm.gray@gmail.com>
>>> +L:     linux-iio@vger.kernel.org
>>> +S:     Maintained
>>> +F:     drivers/iio/industrialio-counter.c
>>> +F:     include/linux/iio/counter.h
>>> +
>>>  IIO MULTIPLEXER
>>>  M:     Peter Rosin <peda@axentia.se>
>>>  L:     linux-iio@vger.kernel.org
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>> index b3c8c6ef0dff..78e01f4f5937 100644
>>> --- a/drivers/iio/Kconfig
>>> +++ b/drivers/iio/Kconfig
>>> @@ -30,6 +30,14 @@ config IIO_CONFIGFS
>>>           (e.g. software triggers). For more info see
>>>           Documentation/iio/iio_configfs.txt.
>>>
>>> +config IIO_COUNTER
>>> +       bool "Enable IIO counter support"
>>> +       help
>>> +         Provides IIO core support for counters. This API provides
>>> +         a generic interface that serves as the building blocks to
>>> +         create more complex counter interfaces. Rudimentary support
>>> +         for counters is enabled.
>>> +
>>>  config IIO_TRIGGER
>>>         bool "Enable triggered sampling support"
>>>         help
>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>> index 93c769cd99bf..6427ff38f964 100644
>>> --- a/drivers/iio/Makefile
>>> +++ b/drivers/iio/Makefile
>>> @@ -5,6 +5,7 @@
>>>  obj-$(CONFIG_IIO) += industrialio.o
>>>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>>>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>> +industrialio-$(CONFIG_IIO_COUNTER) += industrialio-counter.o
>>>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>>
>>>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>>> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
>>> index b37e5fc03149..3d46a790d8db 100644
>>> --- a/drivers/iio/counter/Kconfig
>>> +++ b/drivers/iio/counter/Kconfig
>>> @@ -4,6 +4,7 @@
>>>  # When adding new entries keep the list in alphabetical order
>>>
>>>  menu "Counters"
>>> +       depends on IIO_COUNTER
>>>
>>>  config 104_QUAD_8
>>>         tristate "ACCES 104-QUAD-8 driver"
>>> diff --git a/drivers/iio/industrialio-counter.c b/drivers/iio/industrialio-counter.c
>>> new file mode 100644
>>> index 000000000000..bdf190d010e4
>>> --- /dev/null
>>> +++ b/drivers/iio/industrialio-counter.c
>>> @@ -0,0 +1,1151 @@
>>> +/*
>>> + * Industrial I/O counter interface functions
>>> + * Copyright (C) 2017 William Breathitt Gray
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License, version 2, as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + */
>>> +#include <linux/err.h>
>>> +#include <linux/export.h>
>>> +#include <linux/gfp.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/list.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/printk.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/string.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/types.h>
>>> +
>>> +#include <linux/iio/counter.h>
>>> +
>>> +static struct iio_counter_signal *iio_counter_signal_find_by_id(
>>> +       const struct iio_counter *const counter, const int id)
>>> +{
>>> +       struct iio_counter_signal *iter;
>>> +
>>> +       list_for_each_entry(iter, &counter->signal_list, list)
>>> +               if (iter->id == id)
>>> +                       return iter;
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>> +static struct iio_counter_trigger *iio_counter_trigger_find_by_id(
>>> +       const struct iio_counter_value *const value, const int id)
>>> +{
>>> +       struct iio_counter_trigger *iter;
>>> +
>>> +       list_for_each_entry(iter, &value->trigger_list, list)
>>> +               if (iter->signal->id == id)
>>> +                       return iter;
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>> +static struct iio_counter_value *iio_counter_value_find_by_id(
>>> +       const struct iio_counter *const counter, const int id)
>>> +{
>>> +       struct iio_counter_value *iter;
>>> +
>>> +       list_for_each_entry(iter, &counter->value_list, list)
>>> +               if (iter->id == id)
>>> +                       return iter;
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>> +static void iio_counter_trigger_unregister_all(
>>> +       struct iio_counter_value *const value)
>>> +{
>>> +       struct iio_counter_trigger *iter, *tmp_iter;
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +       list_for_each_entry_safe(iter, tmp_iter, &value->trigger_list, list)
>>> +               list_del(&iter->list);
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +}
>>> +
>>> +static void iio_counter_signal_unregister_all(struct iio_counter *const counter)
>>> +{
>>> +       struct iio_counter_signal *iter, *tmp_iter;
>>> +
>>> +       mutex_lock(&counter->signal_list_lock);
>>> +       list_for_each_entry_safe(iter, tmp_iter, &counter->signal_list, list)
>>> +               list_del(&iter->list);
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +}
>>> +
>>> +static void iio_counter_value_unregister_all(struct iio_counter *const counter)
>>> +{
>>> +       struct iio_counter_value *iter, *tmp_iter;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +       list_for_each_entry_safe(iter, tmp_iter, &counter->value_list, list) {
>>> +               iio_counter_trigger_unregister_all(iter);
>>> +
>>> +               list_del(&iter->list);
>>> +       }
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +}
>>> +
>>> +static ssize_t iio_counter_signal_name_read(struct iio_dev *indio_dev,
>>> +       uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       const struct iio_counter_signal *signal;
>>> +
>>> +       mutex_lock(&counter->signal_list_lock);
>>> +       signal = iio_counter_signal_find_by_id(counter, chan->channel2);
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +       if (!signal)
>>> +               return -EINVAL;
>>> +
>>> +       return scnprintf(buf, PAGE_SIZE, "%s\n", signal->name);
>>> +}
>>> +
>>> +static ssize_t iio_counter_value_name_read(struct iio_dev *indio_dev,
>>> +       uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       const struct iio_counter_value *value;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +       if (!value)
>>> +               return -EINVAL;
>>> +
>>> +       return scnprintf(buf, PAGE_SIZE, "%s\n", value->name);
>>> +}
>>> +
>>> +static ssize_t iio_counter_value_triggers_read(struct iio_dev *indio_dev,
>>> +       uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_value *value;
>>> +       const struct iio_counter_trigger *trigger;
>>> +       ssize_t len = 0;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       if (!value) {
>>> +               len = -EINVAL;
>>> +               goto err_find_value;
>>> +       }
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +       list_for_each_entry(trigger, &value->trigger_list, list) {
>>> +               len += snprintf(buf + len, PAGE_SIZE - len, "%d\t%s\t%s\n",
>>> +                       trigger->signal->id, trigger->signal->name,
>>> +                       trigger->trigger_modes[trigger->mode]);
>>> +               if (len >= PAGE_SIZE) {
>>> +                       len = -ENOMEM;
>>> +                       goto err_no_buffer_space;
>>> +               }
>>> +       }
>>> +err_no_buffer_space:
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +
>>> +err_find_value:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       return len;
>>> +}
>>> +
>>> +static ssize_t iio_counter_trigger_mode_read(struct iio_dev *indio_dev,
>>> +       uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_value *value;
>>> +       ssize_t ret;
>>> +       struct iio_counter_trigger *trigger;
>>> +       const int signal_id = *(int *)((void *)priv);
>>> +       int mode;
>>> +
>>> +       if (!counter->ops->trigger_mode_get)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       if (!value) {
>>> +               ret = -EINVAL;
>>> +               goto err_value;
>>> +       }
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +
>>> +       trigger = iio_counter_trigger_find_by_id(value, signal_id);
>>> +       if (!trigger) {
>>> +               ret = -EINVAL;
>>> +               goto err_trigger;
>>> +       }
>>> +
>>> +       mode = counter->ops->trigger_mode_get(counter, value, trigger);
>>> +
>>> +       if (mode < 0) {
>>> +               ret = mode;
>>> +               goto err_trigger;
>>> +       } else if (mode >= trigger->num_trigger_modes) {
>>> +               ret = -EINVAL;
>>> +               goto err_trigger;
>>> +       }
>>> +
>>> +       trigger->mode = mode;
>>> +
>>> +       ret = scnprintf(buf, PAGE_SIZE, "%s\n", trigger->trigger_modes[mode]);
>>> +
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       return ret;
>>> +
>>> +err_trigger:
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +err_value:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +       return ret;
>>> +}
>>> +
>>> +static ssize_t iio_counter_trigger_mode_write(struct iio_dev *indio_dev,
>>> +       uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
>>> +       size_t len)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_value *value;
>>> +       ssize_t err;
>>> +       struct iio_counter_trigger *trigger;
>>> +       const int signal_id = *(int *)((void *)priv);
>>> +       unsigned int mode;
>>> +
>>> +       if (!counter->ops->trigger_mode_set)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       if (!value) {
>>> +               err = -EINVAL;
>>> +               goto err_value;
>>> +       }
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +
>>> +       trigger = iio_counter_trigger_find_by_id(value, signal_id);
>>> +       if (!trigger) {
>>> +               err = -EINVAL;
>>> +               goto err_trigger;
>>> +       }
>>> +
>>> +       for (mode = 0; mode < trigger->num_trigger_modes; mode++)
>>> +               if (sysfs_streq(buf, trigger->trigger_modes[mode]))
>>> +                       break;
>>> +
>>> +       if (mode >= trigger->num_trigger_modes) {
>>> +               err = -EINVAL;
>>> +               goto err_trigger;
>>> +       }
>>> +
>>> +       err = counter->ops->trigger_mode_set(counter, value, trigger, mode);
>>> +       if (err)
>>> +               goto err_trigger;
>>> +
>>> +       trigger->mode = mode;
>>> +
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       return len;
>>> +
>>> +err_trigger:
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +err_value:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +       return err;
>>> +}
>>> +
>>> +static ssize_t iio_counter_trigger_mode_available_read(
>>> +       struct iio_dev *indio_dev, uintptr_t priv,
>>> +       const struct iio_chan_spec *chan, char *buf)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_value *value;
>>> +       ssize_t len = 0;
>>> +       struct iio_counter_trigger *trigger;
>>> +       const int signal_id = *(int *)((void *)priv);
>>> +       unsigned int i;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       if (!value) {
>>> +               len = -EINVAL;
>>> +               goto err_no_value;
>>> +       }
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +
>>> +       trigger = iio_counter_trigger_find_by_id(value, signal_id);
>>> +       if (!trigger) {
>>> +               len = -EINVAL;
>>> +               goto err_no_trigger;
>>> +       }
>>> +
>>> +       for (i = 0; i < trigger->num_trigger_modes; i++)
>>> +               len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
>>> +                       trigger->trigger_modes[i]);
>>> +
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       buf[len - 1] = '\n';
>>> +
>>> +       return len;
>>> +
>>> +err_no_trigger:
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +err_no_value:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +       return len;
>>> +}
>>> +
>>> +static int iio_counter_value_function_set(struct iio_dev *indio_dev,
>>> +       const struct iio_chan_spec *chan, unsigned int mode)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_value *value;
>>> +       int err;
>>> +
>>> +       if (!counter->ops->value_function_set)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       if (!value) {
>>> +               err = -EINVAL;
>>> +               goto err_value;
>>> +       }
>>> +
>>> +       err = counter->ops->value_function_set(counter, value, mode);
>>> +       if (err)
>>> +               goto err_value;
>>> +
>>> +       value->mode = mode;
>>> +
>>> +err_value:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       return err;
>>> +}
>>> +
>>> +static int iio_counter_value_function_get(struct iio_dev *indio_dev,
>>> +       const struct iio_chan_spec *chan)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_value *value;
>>> +       int retval;
>>> +
>>> +       if (!counter->ops->value_function_get)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +
>>> +       value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +       if (!value) {
>>> +               retval = -EINVAL;
>>> +               goto err_value;
>>> +       }
>>> +
>>> +       retval = counter->ops->value_function_get(counter, value);
>>> +       if (retval < 0)
>>> +               goto err_value;
>>> +       else if (retval >= value->num_function_modes) {
>>> +               retval = -EINVAL;
>>> +               goto err_value;
>>> +       }
>>> +
>>> +       value->mode = retval;
>>> +
>>> +err_value:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       return retval;
>>> +}
>>> +
>>> +static int iio_counter_value_ext_info_alloc(struct iio_chan_spec *const chan,
>>> +       struct iio_counter_value *const value)
>>> +{
>>> +       const struct iio_chan_spec_ext_info ext_info_default[] = {
>>> +               {
>>> +                       .name = "name",
>>> +                       .shared = IIO_SEPARATE,
>>> +                       .read = iio_counter_value_name_read
>>> +               },
>>> +               IIO_ENUM("function", IIO_SEPARATE, &value->function_enum),
>>> +               {
>>> +                       .name = "function_available",
>>> +                       .shared = IIO_SEPARATE,
>>> +                       .read = iio_enum_available_read,
>>> +                       .private = (void *)&value->function_enum
>>I have this warning the 3 times that  private field is set
>>drivers/iio/industrialio-counter.c:401:15: warning: initialization
>>makes integer from pointer without a cast [-Wint-conversion]
>>    .private = (void *)&value->function_enum
>>
>>I think you can change it to "void *" instead of a uintptr_t
>
> These are pretty benign warnings which you may ignore: I'm doing an
> implicit conversion to uintptr_t which is ultimately an integer type; in
> general, pointer to integer conversations are unsafe, but there is a
> special exception in the C language for the uintptr_t data type. I could
> have used an explicit cast to avoid the warning but opted to leave it
> implicit to keep the code easier to read.
>
> However, it would be nice if the private member was void *, since the
> intent of my code would be clearer in that case (passing a pointer for
> later dereference). Unfortunately, I'm hesitant to submit a patch to
> change the "private" member data type to void * since other drivers may
> require the uintptr_t data type -- my suspicion is that there are some
> drivers out there which do since the choice to introduce the "private"
> member as a uintptr_t appears deliberate.
>
>>> +               },
>>> +               {
>>> +                       .name = "triggers",
>>> +                       .shared = IIO_SEPARATE,
>>> +                       .read = iio_counter_value_triggers_read
>>> +               }
>>> +       };
>>> +       const size_t num_default = ARRAY_SIZE(ext_info_default);
>>> +       const struct iio_chan_spec_ext_info ext_info_trigger[] = {
>>> +               {
>>> +                       .shared = IIO_SEPARATE,
>>> +                       .read = iio_counter_trigger_mode_read,
>>> +                       .write = iio_counter_trigger_mode_write
>>> +               },
>>> +               {
>>> +                       .shared = IIO_SEPARATE,
>>> +                       .read = iio_counter_trigger_mode_available_read
>>> +               }
>>> +       };
>>> +       const size_t num_ext_info_trigger = ARRAY_SIZE(ext_info_trigger);
>>> +       const struct list_head *pos;
>>> +       size_t num_triggers = 0;
>>> +       size_t num_triggers_ext_info;
>>> +       size_t num_ext_info;
>>> +       int err;
>>> +       struct iio_chan_spec_ext_info *ext_info;
>>> +       const struct iio_counter_trigger *trigger_pos;
>>> +       size_t i;
>>> +
>>> +       value->function_enum.items = value->function_modes;
>>> +       value->function_enum.num_items = value->num_function_modes;
>>> +       value->function_enum.set = iio_counter_value_function_set;
>>> +       value->function_enum.get = iio_counter_value_function_get;
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +
>>> +       list_for_each(pos, &value->trigger_list)
>>> +               num_triggers++;
>>> +
>>> +       num_triggers_ext_info = num_ext_info_trigger * num_triggers;
>>> +       num_ext_info = num_default + num_triggers_ext_info + 1;
>>> +
>>> +       ext_info = kmalloc_array(num_ext_info, sizeof(*ext_info), GFP_KERNEL);
>>> +       if (!ext_info) {
>>> +               err = -ENOMEM;
>>> +               goto err_ext_info_alloc;
>>> +       }
>>> +       ext_info[num_ext_info - 1].name = NULL;
>>> +
>>> +       memcpy(ext_info, ext_info_default, sizeof(ext_info_default));
>>> +       for (i = 0; i < num_triggers_ext_info; i += num_ext_info_trigger)
>>> +               memcpy(ext_info + num_default + i, ext_info_trigger,
>>> +                       sizeof(ext_info_trigger));
>>> +
>>> +       i = num_default;
>>> +       list_for_each_entry(trigger_pos, &value->trigger_list, list) {
>>> +               ext_info[i].name = kasprintf(GFP_KERNEL, "trigger_signal%d-%d",
>>> +                       chan->channel, trigger_pos->signal->id);
>>> +               if (!ext_info[i].name) {
>>> +                       err = -ENOMEM;
>>> +                       goto err_name_alloc;
>>> +               }
>>> +               ext_info[i].private = (void *)&trigger_pos->signal->id;
>>> +               i++;
>>> +
>>> +               ext_info[i].name = kasprintf(GFP_KERNEL,
>>> +                       "trigger_signal%d-%d_available",
>>> +                       chan->channel, trigger_pos->signal->id);
>>> +               if (!ext_info[i].name) {
>>> +                       err = -ENOMEM;
>>> +                       goto err_name_alloc;
>>> +               }
>>> +               ext_info[i].private = (void *)&trigger_pos->signal->id;
>>> +               i++;
>>> +       }
>>> +
>>> +       chan->ext_info = ext_info;
>>> +
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +
>>> +       return 0;
>>> +
>>> +err_name_alloc:
>>> +       while (i-- > num_default)
>>> +               kfree(ext_info[i].name);
>>> +       kfree(ext_info);
>>> +err_ext_info_alloc:
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +       return err;
>>> +}
>>> +
>>> +static void iio_counter_value_ext_info_free(
>>> +       const struct iio_chan_spec *const channel)
>>> +{
>>> +       size_t i;
>>> +       const char *const prefix = "trigger_signal";
>>> +       const size_t prefix_len = strlen(prefix);
>>> +
>>> +       for (i = 0; channel->ext_info[i].name; i++)
>>> +               if (!strncmp(channel->ext_info[i].name, prefix, prefix_len))
>>> +                       kfree(channel->ext_info[i].name);
>>> +       kfree(channel->ext_info);
>>> +}
>>> +
>>> +static const struct iio_chan_spec_ext_info iio_counter_signal_ext_info[] = {
>>> +       {
>>> +               .name = "name",
>>> +               .shared = IIO_SEPARATE,
>>> +               .read = iio_counter_signal_name_read
>>> +       },
>>> +       {}
>>> +};
>>> +
>>> +static int iio_counter_channels_alloc(struct iio_counter *const counter)
>>> +{
>>> +       const struct list_head *pos;
>>> +       size_t num_channels = 0;
>>> +       int err;
>>> +       struct iio_chan_spec *channels;
>>> +       struct iio_counter_value *value_pos;
>>> +       size_t i = counter->num_channels;
>>> +       const struct iio_counter_signal *signal_pos;
>>> +
>>> +       mutex_lock(&counter->signal_list_lock);
>>> +
>>> +       list_for_each(pos, &counter->signal_list)
>>> +               num_channels++;
>>> +
>>> +       if (!num_channels) {
>>> +               err = -EINVAL;
>>> +               goto err_no_signals;
>>> +       }
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +
>>> +       list_for_each(pos, &counter->value_list)
>>> +               num_channels++;
>>> +
>>> +       num_channels += counter->num_channels;
>>> +
>>> +       channels = kcalloc(num_channels, sizeof(*channels), GFP_KERNEL);
>>> +       if (!channels) {
>>> +               err = -ENOMEM;
>>> +               goto err_channels_alloc;
>>> +       }
>>> +
>>> +       memcpy(channels, counter->channels,
>>> +               counter->num_channels * sizeof(*counter->channels));
>>> +
>>> +       list_for_each_entry(value_pos, &counter->value_list, list) {
>>> +               channels[i].type = IIO_COUNT;
>>> +               channels[i].channel = counter->id;
>>> +               channels[i].channel2 = value_pos->id;
>>> +               channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>>> +               channels[i].indexed = 1;
>>> +               channels[i].counter = 1;
>>> +
>>> +               err = iio_counter_value_ext_info_alloc(channels + i, value_pos);
>>> +               if (err)
>>> +                       goto err_value_ext_info_alloc;
>>> +
>>> +               i++;
>>> +       }
>>> +
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       list_for_each_entry(signal_pos, &counter->signal_list, list) {
>>> +               channels[i].type = IIO_SIGNAL;
>>> +               channels[i].channel = counter->id;
>>> +               channels[i].channel2 = signal_pos->id;
>>> +               channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>>> +               channels[i].indexed = 1;
>>> +               channels[i].counter = 1;
>>> +               channels[i].ext_info = iio_counter_signal_ext_info;
>>> +
>>> +               i++;
>>> +       }
>>> +
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +
>>> +       counter->indio_dev->num_channels = num_channels;
>>> +       counter->indio_dev->channels = channels;
>>> +
>>> +       return 0;
>>> +
>>> +err_value_ext_info_alloc:
>>> +       while (i-- > counter->num_channels)
>>> +               iio_counter_value_ext_info_free(channels + i);
>>> +       kfree(channels);
>>> +err_channels_alloc:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +err_no_signals:
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +       return err;
>>> +}
>>> +
>>> +static void iio_counter_channels_free(const struct iio_counter *const counter)
>>> +{
>>> +       size_t i = counter->num_channels + counter->indio_dev->num_channels;
>>> +       const struct iio_chan_spec *const chans = counter->indio_dev->channels;
>>> +
>>> +       while (i-- > counter->num_channels)
>>> +               if (chans[i].type == IIO_COUNT)
>>> +                       iio_counter_value_ext_info_free(chans + i);
>>> +
>>> +       kfree(chans);
>>> +}
>>> +
>>> +static int iio_counter_read_raw(struct iio_dev *indio_dev,
>>> +       struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_signal *signal;
>>> +       int retval;
>>> +       struct iio_counter_value *value;
>>> +
>>> +       if (mask != IIO_CHAN_INFO_RAW)
>>> +               return -EINVAL;
>>> +
>>> +       switch (chan->type) {
>>> +       case IIO_SIGNAL:
>>> +               if (!counter->ops->signal_read)
>>> +                       return -EINVAL;
>>> +
>>> +               mutex_lock(&counter->signal_list_lock);
>>> +               signal = iio_counter_signal_find_by_id(counter, chan->channel2);
>>> +               if (!signal) {
>>> +                       mutex_unlock(&counter->signal_list_lock);
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               retval = counter->ops->signal_read(counter, signal, val, val2);
>>> +               mutex_unlock(&counter->signal_list_lock);
>>> +
>>> +               return retval;
>>> +       case IIO_COUNT:
>>> +               if (!counter->ops->value_read)
>>> +                       return -EINVAL;
>>> +
>>> +               mutex_lock(&counter->value_list_lock);
>>> +               value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +               if (!value) {
>>> +                       mutex_unlock(&counter->value_list_lock);
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               retval = counter->ops->value_read(counter, value, val, val2);
>>> +               mutex_unlock(&counter->value_list_lock);
>>> +
>>> +               return retval;
>>> +       default:
>>> +               if (counter->info && counter->info->read_raw)
>>> +                       return counter->info->read_raw(indio_dev, chan, val,
>>> +                               val2, mask);
>>> +       }
>>> +
>>> +       return -EINVAL;
>>> +}
>>> +
>>> +static int iio_counter_write_raw(struct iio_dev *indio_dev,
>>> +       struct iio_chan_spec const *chan, int val, int val2, long mask)
>>> +{
>>> +       struct iio_counter *const counter = iio_priv(indio_dev);
>>> +       struct iio_counter_signal *signal;
>>> +       int retval;
>>> +       struct iio_counter_value *value;
>>> +
>>> +       if (mask != IIO_CHAN_INFO_RAW)
>>> +               return -EINVAL;

I have an issue with this check because I believe it make impossible to call
the callback registered in iio_info since the channel isn't always
IIO_CHAN_INFO_RAW
but could be  IIO_CHAN_INFO_ENABLE or IIO_CHAN_INFO_SCALE in my driver.
Maybe it is comming from my code be I don't understand how it could
works in 104-quad-8 either

>>> +
>>> +       switch (chan->type) {
>>> +       case IIO_SIGNAL:
>>> +               if (!counter->ops->signal_write)
>>> +                       return -EINVAL;
>>> +
>>> +               mutex_lock(&counter->signal_list_lock);
>>> +               signal = iio_counter_signal_find_by_id(counter, chan->channel2);
>>> +               if (!signal) {
>>> +                       mutex_unlock(&counter->signal_list_lock);
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               retval = counter->ops->signal_write(counter, signal, val, val2);
>>> +               mutex_unlock(&counter->signal_list_lock);
>>> +
>>> +               return retval;
>>> +       case IIO_COUNT:
>>> +               if (!counter->ops->value_write)
>>> +                       return -EINVAL;
>>> +
>>> +               mutex_lock(&counter->value_list_lock);
>>> +               value = iio_counter_value_find_by_id(counter, chan->channel2);
>>> +               if (!value) {
>>> +                       mutex_unlock(&counter->value_list_lock);
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               retval = counter->ops->value_write(counter, value, val, val2);
>>> +               mutex_unlock(&counter->value_list_lock);
>>> +
>>> +               return retval;
>>> +       default:
>>> +               if (counter->info && counter->info->write_raw)
>>> +                       return counter->info->write_raw(indio_dev, chan, val,
>>> +                               val2, mask);
>>> +       }
>>> +
>>> +       return -EINVAL;
>>> +}
>>> +
>>> +static int iio_counter_signal_register(struct iio_counter *const counter,
>>> +       struct iio_counter_signal *const signal)
>>> +{
>>> +       int err;
>>> +
>>> +       if (!counter || !signal)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&counter->signal_list_lock);
>>> +       if (iio_counter_signal_find_by_id(counter, signal->id)) {
>>> +               pr_err("Duplicate counter signal ID '%d'\n", signal->id);
>>> +               err = -EEXIST;
>>> +               goto err_duplicate_id;
>>> +       }
>>> +       list_add_tail(&signal->list, &counter->signal_list);
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +
>>> +       return 0;
>>> +
>>> +err_duplicate_id:
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +       return err;
>>> +}
>>> +
>>> +static void iio_counter_signal_unregister(struct iio_counter *const counter,
>>> +       struct iio_counter_signal *const signal)
>>> +{
>>> +       if (!counter || !signal)
>>> +               return;
>>> +
>>> +       mutex_lock(&counter->signal_list_lock);
>>> +       list_del(&signal->list);
>>> +       mutex_unlock(&counter->signal_list_lock);
>>> +}
>>> +
>>> +static int iio_counter_signals_register(struct iio_counter *const counter,
>>> +       struct iio_counter_signal *const signals, const size_t num_signals)
>>> +{
>>> +       size_t i;
>>> +       int err;
>>> +
>>> +       if (!counter || !signals)
>>> +               return -EINVAL;
>>> +
>>> +       for (i = 0; i < num_signals; i++) {
>>> +               err = iio_counter_signal_register(counter, signals + i);
>>> +               if (err)
>>> +                       goto err_signal_register;
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +err_signal_register:
>>> +       while (i--)
>>> +               iio_counter_signal_unregister(counter, signals + i);
>>> +       return err;
>>> +}
>>> +
>>> +static void iio_counter_signals_unregister(struct iio_counter *const counter,
>>> +       struct iio_counter_signal *signals, size_t num_signals)
>>> +{
>>> +       if (!counter || !signals)
>>> +               return;
>>> +
>>> +       while (num_signals--) {
>>> +               iio_counter_signal_unregister(counter, signals);
>>> +               signals++;
>>> +       }
>>> +}
>>> +
>>> +/**
>>> + * iio_counter_trigger_register - register Trigger to Value
>>> + * @value: pointer to IIO Counter Value for association
>>> + * @trigger: pointer to IIO Counter Trigger to register
>>> + *
>>> + * The Trigger is added to the Value's trigger_list. A check is first performed
>>> + * to verify that the respective Signal is not already linked to the Value; if
>>> + * the respective Signal is already linked to the Value, the Trigger is not
>>> + * added to the Value's trigger_list.
>>> + *
>>> + * NOTE: This function will acquire and release the Value's trigger_list_lock
>>> + * during execution.
>>> + */
>>> +int iio_counter_trigger_register(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *const trigger)
>>> +{
>>> +       if (!value || !trigger || !trigger->signal)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +       if (iio_counter_trigger_find_by_id(value, trigger->signal->id)) {
>>> +               pr_err("Signal%d is already linked to counter value%d\n",
>>> +                       trigger->signal->id, value->id);
>>> +               return -EEXIST;
>>> +       }
>>> +       list_add_tail(&trigger->list, &value->trigger_list);
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +
>>> +       return 0;
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_trigger_register);
>>> +
>>> +/**
>>> + * iio_counter_trigger_unregister - unregister Trigger from Value
>>> + * @value: pointer to IIO Counter Value of association
>>> + * @trigger: pointer to IIO Counter Trigger to unregister
>>> + *
>>> + * The Trigger is removed from the Value's trigger_list.
>>> + *
>>> + * NOTE: This function will acquire and release the Value's trigger_list_lock
>>> + * during execution.
>>> + */
>>> +void iio_counter_trigger_unregister(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *const trigger)
>>> +{
>>> +       if (!value || !trigger || !trigger->signal)
>>> +               return;
>>> +
>>> +       mutex_lock(&value->trigger_list_lock);
>>> +       list_del(&trigger->list);
>>> +       mutex_unlock(&value->trigger_list_lock);
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_trigger_unregister);
>>> +
>>> +/**
>>> + * iio_counter_triggers_register - register an array of Triggers to Value
>>> + * @value: pointer to IIO Counter Value for association
>>> + * @triggers: array of pointers to IIO Counter Triggers to register
>>> + *
>>> + * The iio_counter_trigger_register function is called for each Trigger in the
>>> + * array. The @triggers array is traversed for the first @num_triggers Triggers.
>>> + *
>>> + * NOTE: @num_triggers must not be greater than the size of the @triggers array.
>>> + */
>>> +int iio_counter_triggers_register(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *const triggers, const size_t num_triggers)
>>> +{
>>> +       size_t i;
>>> +       int err;
>>> +
>>> +       if (!value || !triggers)
>>> +               return -EINVAL;
>>> +
>>> +       for (i = 0; i < num_triggers; i++) {
>>> +               err = iio_counter_trigger_register(value, triggers + i);
>>> +               if (err)
>>> +                       goto err_trigger_register;
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +err_trigger_register:
>>> +       while (i--)
>>> +               iio_counter_trigger_unregister(value, triggers + i);
>>> +       return err;
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_triggers_register);
>>> +
>>> +/**
>>> + * iio_counter_triggers_unregister - unregister Triggers from Value
>>> + * @value: pointer to IIO Counter Value of association
>>> + * @triggers: array of pointers to IIO Counter Triggers to unregister
>>> + *
>>> + * The iio_counter_trigger_unregister function is called for each Trigger in the
>>> + * array. The @triggers array is traversed for the first @num_triggers Triggers.
>>> + *
>>> + * NOTE: @num_triggers must not be greater than the size of the @triggers array.
>>> + */
>>> +void iio_counter_triggers_unregister(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *triggers, size_t num_triggers)
>>> +{
>>> +       if (!value || !triggers)
>>> +               return;
>>> +
>>> +       while (num_triggers--) {
>>> +               iio_counter_trigger_unregister(value, triggers);
>>> +               triggers++;
>>> +       }
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_triggers_unregister);
>>> +
>>> +/**
>>> + * iio_counter_value_register - register Value to Counter
>>> + * @counter: pointer to IIO Counter for association
>>> + * @value: pointer to IIO Counter Value to register
>>> + *
>>> + * The registration process occurs in two major steps. First, the Value is
>>> + * initialized: trigger_list_lock is initialized, trigger_list is initialized,
>>> + * and init_triggers if not NULL is passed to iio_counter_triggers_register.
>>> + * Second, the Value is added to the Counter's value_list. A check is first
>>> + * performed to verify that the Value is not already associated to the Counter
>>> + * (via the Value's unique ID); if the Value is already associated to the
>>> + * Counter, the Value is not added to the Counter's value_list and all of the
>>> + * Value's Triggers are unregistered.
>>> + *
>>> + * NOTE: This function will acquire and release the Counter's value_list_lock
>>> + * during execution.
>>> + */
>>> +int iio_counter_value_register(struct iio_counter *const counter,
>>> +       struct iio_counter_value *const value)
>>> +{
>>> +       int err;
>>> +
>>> +       if (!counter || !value)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_init(&value->trigger_list_lock);
>>> +       INIT_LIST_HEAD(&value->trigger_list);
>>> +
>>> +       if (value->init_triggers) {
>>> +               err = iio_counter_triggers_register(value,
>>> +                       value->init_triggers, value->num_init_triggers);
>>> +               if (err)
>>> +                       return err;
>>> +       }
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +       if (iio_counter_value_find_by_id(counter, value->id)) {
>>> +               pr_err("Duplicate counter value ID '%d'\n", value->id);
>>> +               err = -EEXIST;
>>> +               goto err_duplicate_id;
>>> +       }
>>> +       list_add_tail(&value->list, &counter->value_list);
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       return 0;
>>> +
>>> +err_duplicate_id:
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +       iio_counter_trigger_unregister_all(value);
>>> +       return err;
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_value_register);
>>> +
>>> +/**
>>> + * iio_counter_value_unregister - unregister Value from Counter
>>> + * @counter: pointer to IIO Counter of association
>>> + * @value: pointer to IIO Counter Value to unregister
>>> + *
>>> + * The Value is removed from the Counter's value_list and all of the Value's
>>> + * Triggers are unregistered.
>>> + *
>>> + * NOTE: This function will acquire and release the Counter's value_list_lock
>>> + * during execution.
>>> + */
>>> +void iio_counter_value_unregister(struct iio_counter *const counter,
>>> +       struct iio_counter_value *const value)
>>> +{
>>> +       if (!counter || !value)
>>> +               return;
>>> +
>>> +       mutex_lock(&counter->value_list_lock);
>>> +       list_del(&value->list);
>>> +       mutex_unlock(&counter->value_list_lock);
>>> +
>>> +       iio_counter_trigger_unregister_all(value);
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_value_unregister);
>>> +
>>> +/**
>>> + * iio_counter_values_register - register an array of Values to Counter
>>> + * @counter: pointer to IIO Counter for association
>>> + * @values: array of pointers to IIO Counter Values to register
>>> + *
>>> + * The iio_counter_value_register function is called for each Value in the
>>> + * array. The @values array is traversed for the first @num_values Values.
>>> + *
>>> + * NOTE: @num_values must not be greater than the size of the @values array.
>>> + */
>>> +int iio_counter_values_register(struct iio_counter *const counter,
>>> +       struct iio_counter_value *const values, const size_t num_values)
>>> +{
>>> +       size_t i;
>>> +       int err;
>>> +
>>> +       if (!counter || !values)
>>> +               return -EINVAL;
>>> +
>>> +       for (i = 0; i < num_values; i++) {
>>> +               err = iio_counter_value_register(counter, values + i);
>>> +               if (err)
>>> +                       goto err_values_register;
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +err_values_register:
>>> +       while (i--)
>>> +               iio_counter_value_unregister(counter, values + i);
>>> +       return err;
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_values_register);
>>> +
>>> +/**
>>> + * iio_counter_values_unregister - unregister Values from Counter
>>> + * @counter: pointer to IIO Counter of association
>>> + * @values: array of pointers to IIO Counter Values to unregister
>>> + *
>>> + * The iio_counter_value_unregister function is called for each Value in the
>>> + * array. The @values array is traversed for the first @num_values Values.
>>> + *
>>> + * NOTE: @num_values must not be greater than the size of the @values array.
>>> + */
>>> +void iio_counter_values_unregister(struct iio_counter *const counter,
>>> +       struct iio_counter_value *values, size_t num_values)
>>> +{
>>> +       if (!counter || !values)
>>> +               return;
>>> +
>>> +       while (num_values--) {
>>> +               iio_counter_value_unregister(counter, values);
>>> +               values++;
>>> +       }
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_values_unregister);
>>> +
>>> +/**
>>> + * iio_counter_register - register Counter to the system
>>> + * @counter: pointer to IIO Counter to register
>>> + *
>>> + * This function piggybacks off of iio_device_register. First, the relevant
>>> + * Counter members are initialized; if init_signals is not NULL it is passed to
>>> + * iio_counter_signals_register, and similarly if init_values is not NULL it is
>>> + * passed to iio_counter_values_register. Next, a struct iio_dev is allocated by
>>> + * a call to iio_device_alloc and initialized for the Counter, IIO channels are
>>> + * allocated, the Counter is copied as the private data, and finally
>>> + * iio_device_register is called.
>>> + */
>>> +int iio_counter_register(struct iio_counter *const counter)
>>> +{
>>> +       const struct iio_info info_default = {
>>> +               .read_raw = iio_counter_read_raw,
>>> +               .write_raw = iio_counter_write_raw
>>> +       };
>>> +       int err;
>>> +       struct iio_info *info;
>>> +       struct iio_counter *priv;
>>> +
>>> +       if (!counter)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_init(&counter->signal_list_lock);
>>> +       INIT_LIST_HEAD(&counter->signal_list);
>>> +
>>> +       if (counter->init_signals) {
>>> +               err = iio_counter_signals_register(counter,
>>> +                       counter->init_signals, counter->num_init_signals);
>>> +               if (err)
>>> +                       return err;
>>> +       }
>>> +
>>> +       mutex_init(&counter->value_list_lock);
>>> +       INIT_LIST_HEAD(&counter->value_list);
>>> +
>>> +       if (counter->init_values) {
>>> +               err = iio_counter_values_register(counter,
>>> +                       counter->init_values, counter->num_init_values);
>>> +               if (err)
>>> +                       goto err_values_register;
>>> +       }
>>> +
>>> +       counter->indio_dev = iio_device_alloc(sizeof(*counter));
>>> +       if (!counter->indio_dev) {
>>> +               err = -ENOMEM;
>>> +               goto err_iio_device_alloc;
>>> +       }
>>> +
>>> +       info = kmalloc(sizeof(*info), GFP_KERNEL);
>>> +       if (!info) {
>>> +               err = -ENOMEM;
>>> +               goto err_info_alloc;
>>> +       }
>>> +       if (counter->info) {
>>> +               memcpy(info, counter->info, sizeof(*counter->info));
>>> +               info->read_raw = iio_counter_read_raw;
>>> +               info->write_raw = iio_counter_write_raw;
>>> +       } else {
>>> +               memcpy(info, &info_default, sizeof(info_default));
>>> +       }
>>> +
>>> +       counter->indio_dev->info = info;
>>> +       counter->indio_dev->modes = INDIO_DIRECT_MODE;

For stm32 triggerd river I need to be able to change indio_dev->modes
to INDIO_HARDWARE_TRIGGERED
Could you add a parameter to be able to configure teh modes ?

>>> +       counter->indio_dev->name = counter->name;
>>> +       counter->indio_dev->dev.parent = counter->dev;
>>> +
>>> +       err = iio_counter_channels_alloc(counter);
>>> +       if (err)
>>> +               goto err_channels_alloc;
>>> +
>>> +       priv = iio_priv(counter->indio_dev);
>>> +       memcpy(priv, counter, sizeof(*priv));
>>> +
>>> +       err = iio_device_register(priv->indio_dev);
>>> +       if (err)
>>> +               goto err_iio_device_register;
>>> +
>>> +       return 0;
>>> +
>>> +err_iio_device_register:
>>> +       iio_counter_channels_free(counter);
>>> +err_channels_alloc:
>>> +       kfree(info);
>>> +err_info_alloc:
>>> +       iio_device_free(counter->indio_dev);
>>> +err_iio_device_alloc:
>>> +       iio_counter_values_unregister(counter, counter->init_values,
>>> +               counter->num_init_values);
>>> +err_values_register:
>>> +       iio_counter_signals_unregister(counter, counter->init_signals,
>>> +               counter->num_init_signals);
>>> +       return err;
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_register);
>>> +
>>> +/**
>>> + * iio_counter_unregister - unregister Counter from the system
>>> + * @counter: pointer to IIO Counter to unregister
>>> + *
>>> + * The Counter is unregistered from the system. The indio_dev is unregistered,
>>> + * allocated memory is freed, and all associated Values and Signals are
>>> + * unregistered.
>>> + */
>>> +void iio_counter_unregister(struct iio_counter *const counter)
>>> +{
>>> +       const struct iio_info *const info = counter->indio_dev->info;
>>> +
>>> +       if (!counter)
>>> +               return;
>>> +
>>> +       iio_device_unregister(counter->indio_dev);
>>> +
>>> +       iio_counter_channels_free(counter);
>>> +
>>> +       kfree(info);
>>> +       iio_device_free(counter->indio_dev);
>>> +
>>> +       iio_counter_value_unregister_all(counter);
>>> +       iio_counter_signal_unregister_all(counter);
>>> +}
>>> +EXPORT_SYMBOL(iio_counter_unregister);

I have added devm_iio_counter_register and devm_iio_counter_unregister to avoid
add remove in driver code. If that make sense for you can add tehm in your code
/**
 * devm_iio_counter_register - Resource-managed iio_counter_register()
 * @dev: Device to allocate iio_dev for
 * @counter: pointer to IIO Counter to register
 *
 * Managed iio_counter_register.  The IIO counter registered with this
 * function is automatically unregistered on driver detach. This function
 * calls iio_counter_register() internally. Refer to that function for more
 * information.
 *
 * If an iio counter registered with this function needs to be unregistered
 * separately, devm_iio_counter_unregister() must be used.
 *
 * RETURNS:
 * 0 on success, negative error number on failure.
 */
int devm_iio_counter_register(struct device *dev,
      struct iio_counter *const counter)
{
struct iio_counter **ptr;
int ret;

ptr = devres_alloc(devm_iio_counter_unreg, sizeof(*ptr), GFP_KERNEL);
if (!ptr)
return -ENOMEM;

*ptr = counter;
ret = iio_counter_register(counter);
if (!ret)
devres_add(dev, ptr);
else
devres_free(ptr);

return ret;

}
EXPORT_SYMBOL(devm_iio_counter_register);

static int devm_iio_counter_match(struct device *dev, void *res, void *data)
{
struct iio_counter **r = res;
if (!r || !*r) {
WARN_ON(!r || !*r);
return 0;
}
return *r == data;
}

/**
 * devm_iio_counter_unregister - Resource-managed iio_counter_unregister()
 * @dev: Device this iio_dev belongs to
 * @counter: the iio counter associated with the device
 *
 * Unregister iio counter registered with devm_iio_counter_register().
 */
void devm_iio_counter_unregister(struct device *dev,
struct iio_counter *const counter)
{
int rc;

rc = devres_release(dev, devm_iio_counter_unreg,
    devm_iio_counter_match, counter);
WARN_ON(rc);
}
EXPORT_SYMBOL(devm_iio_counter_unregister);

>>> diff --git a/include/linux/iio/counter.h b/include/linux/iio/counter.h
>>> new file mode 100644
>>> index 000000000000..1c1ca13a6053
>>> --- /dev/null
>>> +++ b/include/linux/iio/counter.h
>>> @@ -0,0 +1,221 @@
>>> +/*
>>> + * Industrial I/O counter interface
>>> + * Copyright (C) 2017 William Breathitt Gray
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License, version 2, as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + */
>>> +#ifndef _IIO_COUNTER_H_
>>> +#define _IIO_COUNTER_H_
>>> +
>>> +#ifdef CONFIG_IIO_COUNTER
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/types.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +
>>> +/**
>>> + * struct iio_counter_signal - IIO Counter Signal node
>>> + * @id:                [DRIVER] unique ID used to identify signal
>>> + * @name:      [DRIVER] device-specific signal name
>>> + * @list:      [INTERN] list of all signals currently registered to counter
>>> + */
>>> +struct iio_counter_signal {
>>> +       int             id;
>>> +       const char      *name;
>>> +
>>> +       struct list_head        list;
>>> +};
>>> +
>>> +/**
>>> + * struct iio_counter_trigger - IIO Counter Trigger node
>>> + * @mode:              [DRIVER] current trigger mode state
>>> + * @trigger_modes:     [DRIVER] available trigger modes
>>> + * @num_trigger_modes: [DRIVER] number of modes specified in @trigger_modes
>>> + * @signal:            [DRIVER] pointer to associated signal
>>> + * @list:              [INTERN] list of all triggers currently registered to
>>> + *                     value
>>> + */
>>> +struct iio_counter_trigger {
>>> +       unsigned int                    mode;
>>> +       const char *const               *trigger_modes;
>>> +       unsigned int                    num_trigger_modes;
>>> +       struct iio_counter_signal       *signal;
>>> +
>>> +       struct list_head                list;
>>> +};
>>> +
>>> +/**
>>> + * struct iio_counter_value - IIO Counter Value node
>>> + * @id:                        [DRIVER] unique ID used to identify value
>>> + * @name:              [DRIVER] device-specific value name
>>> + * @mode:              [DRIVER] current function mode state
>>> + * @function_modes:    [DRIVER] available function modes
>>> + * @num_function_modes:        [DRIVER] number of modes specified in @function_modes
>>> + * @init_triggers:     [DRIVER] array of triggers for initialization
>>> + * @num_init_triggers: [DRIVER] number of triggers specified in @init_triggers
>>> + * @function_enum:     [INTERN] used internally to generate function attributes
>>> + * @trigger_list_lock: [INTERN] lock for accessing @trigger_list
>>> + * @trigger_list:      [INTERN] list of all triggers currently registered to
>>> + *                     value
>>> + * @list:              [INTERN] list of all values currently registered to
>>> + *                     counter
>>> + */
>>> +struct iio_counter_value {
>>> +       int                     id;
>>> +       const char              *name;
>>> +       unsigned int            mode;
>>> +       const char *const       *function_modes;
>>> +       unsigned int            num_function_modes;
>>> +
>>> +       struct iio_counter_trigger      *init_triggers;
>>> +       size_t                          num_init_triggers;
>>> +
>>> +       struct iio_enum         function_enum;
>>> +       struct mutex            trigger_list_lock;
>>> +       struct list_head        trigger_list;
>>> +
>>> +       struct list_head        list;
>>> +};
>>> +
>>> +struct iio_counter;
>>> +
>>> +/**
>>> + * struct iio_counter_ops - IIO Counter related callbacks
>>> + * @signal_read:       function to request a signal value from the device.
>>> + *                     Return value will specify the type of value returned by
>>> + *                     the device. val and val2 will contain the elements
>>> + *                     making up the returned value. Note that the counter
>>> + *                     signal_list_lock is acquired before this function is
>>> + *                     called, and released after this function returns.
>>> + * @signal_write:      function to write a signal value to the device.
>>> + *                     Parameters and locking behavior are the same as
>>> + *                     signal_read.
>>> + * @trigger_mode_set:  function to set the trigger mode. mode is the index of
>>> + *                     the requested mode from the value trigger_modes array.
>>> + *                     Note that the counter value_list_lock and value
>>> + *                     trigger_list_lock are acquired before this function is
>>> + *                     called, and released after this function returns.
>>> + * @trigger_mode_get:  function to get the current trigger mode. Return value
>>> + *                     will specify the index of the current mode from the
>>> + *                     value trigger_modes array. Locking behavior is the same
>>> + *                     as trigger_mode_set.
>>> + * @value_read:                function to request a value value from the device.
>>> + *                     Return value will specify the type of value returned by
>>> + *                     the device. val and val2 will contain the elements
>>> + *                     making up the returned value. Note that the counter
>>> + *                     value_list_lock is acquired before this function is
>>> + *                     called, and released after this function returns.
>>> + * @value_write:       function to write a value value to the device.
>>> + *                     Parameters and locking behavior are the same as
>>> + *                     value_read.
>>> + * @value_function_set: function to set the value function mode. mode is the
>>> + *                     index of the requested mode from the value
>>> + *                     function_modes array. Note that the counter
>>> + *                     value_list_lock is acquired before this function is
>>> + *                     called, and released after this function returns.
>>> + * @value_function_get: function to get the current value function mode. Return
>>> + *                     value will specify the index of the current mode from
>>> + *                     the value function_modes array. Locking behavior is the
>>> + *                     same as value_function_get.
>>> + */
>>> +struct iio_counter_ops {
>>> +       int (*signal_read)(struct iio_counter *counter,
>>> +               struct iio_counter_signal *signal, int *val, int *val2);
>>> +       int (*signal_write)(struct iio_counter *counter,
>>> +               struct iio_counter_signal *signal, int val, int val2);
>>> +       int (*trigger_mode_set)(struct iio_counter *counter,
>>> +               struct iio_counter_value *value,
>>> +               struct iio_counter_trigger *trigger, unsigned int mode);
>>> +       int (*trigger_mode_get)(struct iio_counter *counter,
>>> +               struct iio_counter_value *value,
>>> +               struct iio_counter_trigger *trigger);
>>> +       int (*value_read)(struct iio_counter *counter,
>>> +               struct iio_counter_value *value, int *val, int *val2);
>>> +       int (*value_write)(struct iio_counter *counter,
>>> +               struct iio_counter_value *value, int val, int val2);
>>> +       int (*value_function_set)(struct iio_counter *counter,
>>> +               struct iio_counter_value *value, unsigned int mode);
>>> +       int (*value_function_get)(struct iio_counter *counter,
>>> +               struct iio_counter_value *value);
>>> +};

I think it would be more clear if structures iio_counter_signal,
iio_counter_trigger
and iio_counter_value embedded the functions related to their use.
For example struct iio_counter_trigger could have trigger_mode_set and
trigger_mode_get
functions. If you do like that you can remove iio_counter_ops.

Do you think that some functions like get/set counter value, direction
and counter
range (min, max) are generic enough to be included in
iio_counter_value structure ?

>>> +
>>> +/**
>>> + * struct iio_counter - IIO Counter data structure
>>> + * @id:                        [DRIVER] unique ID used to identify counter
>>> + * @name:              [DRIVER] name of the device
>>> + * @dev:               [DRIVER] device structure, should be assigned a parent
>>> + *                     and owner
>>> + * @ops:               [DRIVER] callbacks from driver for counter components
>>> + * @init_signals:      [DRIVER] array of signals for initialization
>>> + * @num_init_signals:  [DRIVER] number of signals specified in @init_signals
>>> + * @init_values:       [DRIVER] array of values for initialization
>>> + * @num_init_values:   [DRIVER] number of values specified in @init_values
>>> + * @signal_list_lock:  [INTERN] lock for accessing @signal_list
>>> + * @signal_list:       [INTERN] list of all signals currently registered to
>>> + *                     counter
>>> + * @value_list_lock:   [INTERN] lock for accessing @value_list
>>> + * @value_list:                [INTERN] list of all values currently registered to
>>> + *                     counter
>>> + * @channels:          [DRIVER] channel specification structure table
>>> + * @num_channels:      [DRIVER] number of channels specified in @channels
>>> + * @info:              [DRIVER] callbacks and constant info from driver
>>> + * @indio_dev:         [INTERN] industrial I/O device structure
>>> + * @driver_data:       [DRIVER] driver data
>>> + */
>>> +struct iio_counter {
>>> +       int                             id;
>>> +       const char                      *name;
>>> +       struct device                   *dev;

id, name and dev are already in struct iio_dev, maybe we can remove them ?

>>> +       const struct iio_counter_ops    *ops;
>>> +
>>> +       struct iio_counter_signal       *init_signals;
>>> +       size_t                          num_init_signals;

I think we can remove init_signals and num_init_signals from this structure
because they are already linked with the values through trigger structure.

>>> +       struct iio_counter_value        *init_values;
>>> +       size_t                          num_init_values;
>>> +
>>> +       struct mutex            signal_list_lock;
>>> +       struct list_head        signal_list;
>>> +       struct mutex            value_list_lock;
>>> +       struct list_head        value_list;
>>> +
>>> +       const struct iio_chan_spec      *channels;
>>> +       size_t                          num_channels;
>>> +       const struct iio_info           *info;
>>> +
>>> +       struct iio_dev  *indio_dev;
>>> +       void            *driver_data;

"driver_data" => "priv" to do like iio_dev

>>> +};
>>> +
>>> +int iio_counter_trigger_register(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *const trigger);
>>> +void iio_counter_trigger_unregister(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *const trigger);
>>> +int iio_counter_triggers_register(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *const triggers, const size_t num_triggers);
>>> +void iio_counter_triggers_unregister(struct iio_counter_value *const value,
>>> +       struct iio_counter_trigger *triggers, size_t num_triggers);
>>> +
>>> +int iio_counter_value_register(struct iio_counter *const counter,
>>> +       struct iio_counter_value *const value);
>>> +void iio_counter_value_unregister(struct iio_counter *const counter,
>>> +       struct iio_counter_value *const value);
>>> +int iio_counter_values_register(struct iio_counter *const counter,
>>> +       struct iio_counter_value *const values, const size_t num_values);
>>> +void iio_counter_values_unregister(struct iio_counter *const counter,
>>> +       struct iio_counter_value *values, size_t num_values);
>>> +
>>> +int iio_counter_register(struct iio_counter *const counter);
>>> +void iio_counter_unregister(struct iio_counter *const counter);
>>> +
>>> +#endif /* CONFIG_IIO_COUNTER */
>>> +
>>> +#endif /* _IIO_COUNTER_H_ */
>>> --
>>> 2.14.1
>>>
