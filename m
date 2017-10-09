Return-Path: <SRS0=pXDu=BI=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171008153050.71df3fdf@archlinux>
References: <cover.1507220144.git.vilhelm.gray@gmail.com> <ae131029e31c4ad54092dd247e411dd3929b0e2d.1507220144.git.vilhelm.gray@gmail.com>
 <20171008153050.71df3fdf@archlinux>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 9 Oct 2017 14:56:03 +0200
Message-ID: <CA+M3ks593u55YHVNfg3nxkqVDy+YtuED3XTr+M0AoU2q8F7zHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: Introduce the generic counter interface
To: Jonathan Cameron <jic23@kernel.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-10-08 16:30 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
> On Thu,  5 Oct 2017 14:13:44 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch introduces the IIO generic counter interface for supporting
>> counter devices. The generic counter interface serves as a catch-all to
>> enable rudimentary support for devices that qualify as counters. More
>> specific and apt counter interfaces may be developed on top of the
>> generic counter interface, and those interfaces should be used by
>> drivers when possible rather than the generic counter interface.
>
> I think you probably want to avoid any additional layering and try to
> push things down here (maybe with a few utility functions to simplify
> common cases), but that's a question for another day!
>>
>> In the context of the IIO generic counter interface, a counter is
>> defined as a device that reports one or more "counter values" based on
>> the state changes of one or more "counter signals" as evaluated by a
>> defined "counter function."
>>
>> The IIO generic counter interface piggybacks off of the IIO core. This
>> is primarily used to leverage the existing sysfs setup: the IIO_COUNT
>> channel attributes represent the Counter Value, while the IIO_SIGNAL
>> channel attributes represent the Counter Signal; auxilary IIO_COUNT
>> attributes represent the Counter Signal connections (Triggers) and their
>> respective state change configurations which trigger an associated
>> "counter function" evaluation.
>>
>> The iio_counter_ops structure serves as a container for driver callbacks
>> to communicate with the device; function callbacks are provided to read
>> and write various Signals and Values, and set and get the "trigger mode"
>> and "function mode" for various Triggers and Values respectively.
>>
>> To support a counter device, a driver must first allocate the available
>> Counter Signals via iio_counter_signal structures. These Signals should
>> be stored as an array and set to the signals array member of an
>> allocated iio_counter structure before the Counter is registered to the
>> system.
>>
>> Counter Values may be allocated via iio_counter_value structures, and
>> respective Counter Signal associations (Triggers) made via
>> iio_counter_trigger structures. Associated iio_counter_trigger
>> structures are stored as an array and set to the the triggers array
>> member of the respective iio_counter_value structure. These
>> iio_counter_value structures are set to the values array member of an
>> allocated iio_counter structure before the Counter is registered to the
>> system.
>>
>> A counter device is registered to the system by passing the respective
>> initialized iio_counter structure to the iio_counter_register function;
>> similarly, the iio_counter_unregister function unregisters the
>> respective counter. The devm_iio_counter_register and
>> iio_devm_iio_counter_unregister functions serve as device memory-managed
>> versions of the iio_counter_register and iio_counter unregister
>> functions respectively.
>
> All the find by ids are the main complexity introduced by layering this
> on IIO that you probably wouldn't have if it wasn't so layered.  Hmm.
> I suggest inline that you could allow drivers to provide fast
> versions of that search given they can probably infer it directly from
> the index.  Might be something to ignore for now though in the interests
> of initial simplicity.
>
> Otherwise a few comments inline, but mostly this is coming together
> pretty well.  I'm actually surprised the layering on top of IIO didn't
> end up more painful than it did. It's not horrendous - which is not
> to say you wouldn't be better breaking free of that entirely...
> (I'm not sure either way).
>
> I think the big remaining questions are around naming more than anything
> else.  I don't like the name value when a user will think they are lookin=
g
> for a counter.  If you use counter though the current use of counter need=
s
> to change.
>
> Trigger is also, as has been raised, a rather overloaded term. Not totall=
y
> obvious what a better term is but we shouldn't reuse that one...
>
> I'll try and think of something if you have no luck!
>
> Jonathan
>>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> ---
>>  MAINTAINERS                        |   7 +
>>  drivers/iio/Kconfig                |   8 +
>>  drivers/iio/Makefile               |   1 +
>>  drivers/iio/counter/Kconfig        |   1 +
>>  drivers/iio/industrialio-counter.c | 900 ++++++++++++++++++++++++++++++=
+++++++
>>  include/linux/iio/counter.h        | 166 +++++++
>>  6 files changed, 1083 insertions(+)
>>  create mode 100644 drivers/iio/industrialio-counter.c
>>  create mode 100644 include/linux/iio/counter.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2281af4b41b6..8b7c37bed252 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6693,6 +6693,13 @@ F:     Documentation/ABI/testing/sysfs-bus-iio-ad=
c-envelope-detector
>>  F:   Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
>>  F:   drivers/iio/adc/envelope-detector.c
>>
>> +IIO GENERIC COUNTER INTERFACE
>> +M:   William Breathitt Gray <vilhelm.gray@gmail.com>
>> +L:   linux-iio@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/iio/industrialio-counter.c
>> +F:   include/linux/iio/counter.h
>
> Don't forget the directory the drivers are going in ;)
> *laughs manically*
>> +
>>  IIO MULTIPLEXER
>>  M:   Peter Rosin <peda@axentia.se>
>>  L:   linux-iio@vger.kernel.org
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index b3c8c6ef0dff..78e01f4f5937 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -30,6 +30,14 @@ config IIO_CONFIGFS
>>         (e.g. software triggers). For more info see
>>         Documentation/iio/iio_configfs.txt.
>>
>> +config IIO_COUNTER
>> +     bool "Enable IIO counter support"
>> +     help
>> +       Provides IIO core support for counters. This API provides
>> +       a generic interface that serves as the building blocks to
>> +       create more complex counter interfaces. Rudimentary support
>> +       for counters is enabled.
>> +
>>  config IIO_TRIGGER
>>       bool "Enable triggered sampling support"
>>       help
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index 93c769cd99bf..6427ff38f964 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -5,6 +5,7 @@
>>  obj-$(CONFIG_IIO) +=3D industrialio.o
>>  industrialio-y :=3D industrialio-core.o industrialio-event.o inkern.o
>>  industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
>> +industrialio-$(CONFIG_IIO_COUNTER) +=3D industrialio-counter.o
>>  industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
>>
>>  obj-$(CONFIG_IIO_CONFIGFS) +=3D industrialio-configfs.o
>> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
>> index 474e1ac4e7c0..c8becfe78e28 100644
>> --- a/drivers/iio/counter/Kconfig
>> +++ b/drivers/iio/counter/Kconfig
>> @@ -4,6 +4,7 @@
>>  # When adding new entries keep the list in alphabetical order
>>
>>  menu "Counters"
>> +     depends on IIO_COUNTER
>>
>>  config 104_QUAD_8
>>       tristate "ACCES 104-QUAD-8 driver"
>> diff --git a/drivers/iio/industrialio-counter.c b/drivers/iio/industrial=
io-counter.c
>> new file mode 100644
>> index 000000000000..dfb982dae3a8
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-counter.c
>> @@ -0,0 +1,900 @@
>> +/*
>> + * Industrial I/O counter interface functions
>> + * Copyright (C) 2017 William Breathitt Gray
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/gfp.h>
>> +#include <linux/kernel.h>
>> +#include <linux/printk.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/types.h>
>> +
>> +#include <linux/iio/counter.h>
>> +
>> +#define iio_priv_get_counter(_indio_dev) \
>> +     (*(struct iio_counter **)iio_priv(_indio_dev))
>> +
>> +static struct iio_counter_signal *iio_counter_signal_find_by_id(
>> +     const struct iio_counter *const counter, const int id)
>> +{
>> +     size_t i;
>> +     struct iio_counter_signal *signal;
>> +
>> +     for (i =3D 0; i < counter->num_signals; i++) {
>> +             signal =3D counter->signals + i;
>> +             if (signal->id =3D=3D id)
>> +                     return signal;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static struct iio_counter_trigger *iio_counter_trigger_find_by_id(
>> +     const struct iio_counter_value *const value, const int id)
>> +{
>> +     size_t i;
>> +     struct iio_counter_trigger *trigger;
>> +
>> +     for (i =3D 0; i < value->num_triggers; i++) {
>> +             trigger =3D value->triggers + i;
>> +             if (trigger->signal->id =3D=3D id)
>> +                     return trigger;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static struct iio_counter_value *iio_counter_value_find_by_id(
>> +     const struct iio_counter *const counter, const int id)
>> +{
>> +     size_t i;
>> +     struct iio_counter_value *value;
>
> In most cases this mapping will be entirely obvious to the
> driver - perhaps provide an optional callback to let it
> provide it directly without any searching?
>
> We could always add this later though if we start getting
> drivers with lots of instances of the various parts...
>
>> +
>> +     for (i =3D 0; i < counter->num_values; i++) {
>> +             value =3D counter->values + i;
>> +             if (value->id =3D=3D id)
>> +                     return value;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static ssize_t iio_counter_signal_name_read(struct iio_dev *indio_dev,
>> +     uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     const struct iio_counter_signal *signal;
>> +
>> +     signal =3D iio_counter_signal_find_by_id(counter, chan->channel2);
>> +     if (!signal)
>> +             return -EINVAL;
>> +
>> +     return scnprintf(buf, PAGE_SIZE, "%s\n", signal->name);
>> +}
>> +
>> +static ssize_t iio_counter_value_name_read(struct iio_dev *indio_dev,
>> +     uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     const struct iio_counter_value *value;
>> +
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     return scnprintf(buf, PAGE_SIZE, "%s\n", value->name);
>
> I mentioned before but I wonder if we can just push name down into
> the chan spec itself in some fashion.  Whether to associate it with
> existing datasheet_name or not is an open question however.
>
>> +}
>> +
>> +static ssize_t iio_counter_value_triggers_read(struct iio_dev *indio_de=
v,
>> +     uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_value *value;
>> +     size_t i;
>> +     const struct iio_counter_trigger *trigger;
>> +     ssize_t len =3D 0;
>> +
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     /* Print out a list of every Signal association to Value */
>> +     for (i =3D 0; i < value->num_triggers; i++) {
>> +             trigger =3D value->triggers + i;
>> +             len +=3D snprintf(buf + len, PAGE_SIZE - len, "%d\t%s\t%s\=
n",
>> +                     trigger->signal->id, trigger->signal->name,
>> +                     trigger->trigger_modes[trigger->mode]);
>> +             if (len >=3D PAGE_SIZE)
>> +                     return -ENOMEM;
>> +     }
>> +
>> +     return len;
>> +}
>> +
>> +static ssize_t iio_counter_trigger_mode_read(struct iio_dev *indio_dev,
>> +     uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_value *value;
>> +     struct iio_counter_trigger *trigger;
>> +     const int signal_id =3D *(int *)((void *)priv);
>> +     int mode;
>> +
>> +     if (!counter->ops->trigger_mode_get)
>> +             return -EINVAL;
>> +
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     trigger =3D iio_counter_trigger_find_by_id(value, signal_id);
>> +     if (!trigger)
>> +             return -EINVAL;
>> +
>> +     mode =3D counter->ops->trigger_mode_get(counter, value, trigger);
>> +
>> +     if (mode < 0)
>> +             return mode;
>> +     else if (mode >=3D trigger->num_trigger_modes)
>> +             return -EINVAL;
>> +
>> +     trigger->mode =3D mode;
>> +
>> +     return scnprintf(buf, PAGE_SIZE, "%s\n", trigger->trigger_modes[mo=
de]);
>> +}
>> +
>> +static ssize_t iio_counter_trigger_mode_write(struct iio_dev *indio_dev=
,
>> +     uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
>> +     size_t len)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_value *value;
>> +     ssize_t err;
>> +     struct iio_counter_trigger *trigger;
>> +     const int signal_id =3D *(int *)((void *)priv);
>> +     unsigned int mode;
>> +
>> +     if (!counter->ops->trigger_mode_set)
>> +             return -EINVAL;
>> +
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     trigger =3D iio_counter_trigger_find_by_id(value, signal_id);
>> +     if (!trigger)
>> +             return -EINVAL;
>> +
>> +     for (mode =3D 0; mode < trigger->num_trigger_modes; mode++)
>> +             if (sysfs_streq(buf, trigger->trigger_modes[mode]))
>> +                     break;
>> +
>> +     if (mode >=3D trigger->num_trigger_modes)
>> +             return -EINVAL;
>> +
>> +     err =3D counter->ops->trigger_mode_set(counter, value, trigger, mo=
de);
>> +     if (err)
>> +             return err;
>> +
>> +     trigger->mode =3D mode;
>> +
>> +     return len;
>> +}
>> +
>> +static ssize_t iio_counter_trigger_mode_available_read(
>> +     struct iio_dev *indio_dev, uintptr_t priv,
>> +     const struct iio_chan_spec *chan, char *buf)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_value *value;
>> +     ssize_t len =3D 0;
>> +     struct iio_counter_trigger *trigger;
>> +     const int signal_id =3D *(int *)((void *)priv);
>> +     unsigned int i;
>> +
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     trigger =3D iio_counter_trigger_find_by_id(value, signal_id);
>> +     if (!trigger)
>> +             return -EINVAL;
>> +
>> +     for (i =3D 0; i < trigger->num_trigger_modes; i++)
>> +             len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%s ",
>> +                     trigger->trigger_modes[i]);
>> +
>> +     buf[len - 1] =3D '\n';
>> +
>> +     return len;
>> +}
>> +
>> +static int iio_counter_value_function_set(struct iio_dev *indio_dev,
>> +     const struct iio_chan_spec *chan, unsigned int mode)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_value *value;
>> +     int err;
>> +
>> +     if (!counter->ops->value_function_set)
>> +             return -EINVAL;
>> +
>> +     /* Find relevant Value */
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     /* Map IIO core function_set to Generic Counter value_function_set=
 */
>> +     err =3D counter->ops->value_function_set(counter, value, mode);
>> +     if (err)
>> +             return err;
>> +
>> +     value->mode =3D mode;
>> +
>> +     return 0;
>> +}
>> +
>> +static int iio_counter_value_function_get(struct iio_dev *indio_dev,
>> +     const struct iio_chan_spec *chan)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_value *value;
>> +     int retval;
>> +
>> +     if (!counter->ops->value_function_get)
>> +             return -EINVAL;
>> +
>> +     /* Find relevant Value */
>> +     value =3D iio_counter_value_find_by_id(counter, chan->channel2);
>
> Same argument as below - would the driver not be able to do this better?
> Often it would know a simple transform to get the right one...
>
>
>> +     if (!value)
>> +             return -EINVAL;
>> +
>> +     /* Map IIO core function_get to Generic Counter value_function_get=
 */
>> +     retval =3D counter->ops->value_function_get(counter, value);
>> +     if (retval < 0)
>> +             return retval;
>> +     else if (retval >=3D value->num_function_modes)
>> +             return -EINVAL;
>> +
>> +     value->mode =3D retval;
>> +
>> +     return retval;
>> +}
>> +
>> +static int iio_counter_value_ext_info_alloc(struct iio_chan_spec *const=
 chan,
>> +     struct iio_counter_value *const value)
>> +{
>> +     const struct iio_chan_spec_ext_info ext_info_default[] =3D {
>> +             {
>> +                     .name =3D "name",
>> +                     .shared =3D IIO_SEPARATE,
>> +                     .read =3D iio_counter_value_name_read
>> +             },
>> +             IIO_ENUM("function", IIO_SEPARATE, &value->function_enum),
>> +             {
>> +                     .name =3D "function_available",
>> +                     .shared =3D IIO_SEPARATE,
>> +                     .read =3D iio_enum_available_read,
>> +                     .private =3D (void *)&value->function_enum
>> +             },
>> +             {
>> +                     .name =3D "triggers",
>> +                     .shared =3D IIO_SEPARATE,
>> +                     .read =3D iio_counter_value_triggers_read
>> +             }
>> +     };
>> +     const size_t num_default =3D ARRAY_SIZE(ext_info_default);
>> +     const struct iio_chan_spec_ext_info ext_info_trigger[] =3D {
>> +             {
>> +                     .shared =3D IIO_SEPARATE,
>> +                     .read =3D iio_counter_trigger_mode_read,
>> +                     .write =3D iio_counter_trigger_mode_write
>> +             },
>> +             {
>> +                     .shared =3D IIO_SEPARATE,
>> +                     .read =3D iio_counter_trigger_mode_available_read
>> +             }
>> +     };
>> +     const size_t num_ext_info_trigger =3D ARRAY_SIZE(ext_info_trigger)=
;
>> +     const size_t num_triggers_ext_info =3D num_ext_info_trigger *
>> +             value->num_triggers;
>> +     const size_t num_ext_info =3D num_default + num_triggers_ext_info =
+ 1;
>> +     int err;
>> +     struct iio_chan_spec_ext_info *ext_info;
>> +     const struct iio_counter_trigger *trigger;
>> +     size_t i;
>> +     size_t j;
>> +
>> +     /* Construct function_enum for Value */
>> +     value->function_enum.items =3D value->function_modes;
>> +     value->function_enum.num_items =3D value->num_function_modes;
>> +     value->function_enum.set =3D iio_counter_value_function_set;
>> +     value->function_enum.get =3D iio_counter_value_function_get;
>> +
>> +     ext_info =3D kmalloc_array(num_ext_info, sizeof(*ext_info), GFP_KE=
RNEL);
>> +     if (!ext_info)
>> +             return -ENOMEM;
>> +     ext_info[num_ext_info - 1].name =3D NULL;
>> +
>> +     /* Add ext_info for the name, function, function_available, and tr=
iggers
>> +      * attributes
>> +      */
>> +     memcpy(ext_info, ext_info_default, sizeof(ext_info_default));
>> +     /* Add ext_info for the trigger_signalX-Z and
>> +      * trigger_signalX-Z_available attributes for each Trigger
>> +      */
>> +     for (i =3D 0; i < num_triggers_ext_info; i +=3D num_ext_info_trigg=
er)
>> +             memcpy(ext_info + num_default + i, ext_info_trigger,
>> +                     sizeof(ext_info_trigger));
>> +
>> +     /* Set name for each trigger_signalX-Z and trigger_signalX-Z_avail=
able
>> +      * attribute; store the respective Signal ID address in each ext_i=
nfo
>> +      * private member
>> +      */
>> +     for (i =3D num_default, j =3D 0; j < value->num_triggers; i++, j++=
) {
>> +             trigger =3D value->triggers + j;
>> +
>> +             ext_info[i].name =3D kasprintf(GFP_KERNEL, "trigger_signal=
%d-%d",
>> +                     chan->channel, trigger->signal->id);
>> +             if (!ext_info[i].name) {
>> +                     err =3D -ENOMEM;
>> +                     goto err_name_alloc;
>> +             }
>> +             ext_info[i].private =3D (void *)&trigger->signal->id;
>> +             i++;
>> +
>> +             ext_info[i].name =3D kasprintf(GFP_KERNEL,
>> +                     "trigger_signal%d-%d_available",
>> +                     chan->channel, trigger->signal->id);
>> +             if (!ext_info[i].name) {
>> +                     err =3D -ENOMEM;
>> +                     goto err_name_alloc;
>> +             }
>> +             ext_info[i].private =3D (void *)&trigger->signal->id;
>> +     }
>> +
>> +     chan->ext_info =3D ext_info;
>> +
>> +     return 0;
>> +
>> +err_name_alloc:
>> +     while (i-- > num_default)
>> +             kfree(ext_info[i].name);
>> +     kfree(ext_info);
>> +     return err;
>> +}
>> +
>> +static void iio_counter_value_ext_info_free(
>> +     const struct iio_chan_spec *const channel)
>> +{
>> +     size_t i;
>> +     const char *const prefix =3D "trigger_signal";
>> +     const size_t prefix_len =3D strlen(prefix);
>> +
>> +     for (i =3D 0; channel->ext_info[i].name; i++)
>> +             if (!strncmp(channel->ext_info[i].name, prefix, prefix_len=
))
>> +                     kfree(channel->ext_info[i].name);
>> +     kfree(channel->ext_info);
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info iio_counter_signal_ext_info[=
] =3D {
>> +     {
>> +             .name =3D "name",
>> +             .shared =3D IIO_SEPARATE,
>> +             .read =3D iio_counter_signal_name_read
>> +     },
>> +     {}
>> +};
>> +
>> +static int iio_counter_channels_alloc(struct iio_counter *const counter=
)
>> +{
>> +     const size_t num_channels =3D counter->num_signals + counter->num_=
values +
>> +             counter->num_channels;
>> +     int err;
>> +     struct iio_chan_spec *channels;
>> +     size_t j;
>> +     struct iio_counter_value *value;
>> +     size_t i =3D counter->num_channels;
>> +     const struct iio_counter_signal *signal;
>> +
>> +     channels =3D kcalloc(num_channels, sizeof(*channels), GFP_KERNEL);
>
> Bring the calculation of num_channels down here - it will make it
> more obvious that this allows space for both sources of channel.
>
>> +     if (!channels)
>> +             return -ENOMEM;
>> +
>> +     /* If any channels were supplied on Counter registration,
>> +      * we add them here to the front of the array
>> +      */
>> +     memcpy(channels, counter->channels,
>> +             counter->num_channels * sizeof(*counter->channels));
>> +
>> +     /* Add channel for each Value */
>> +     for (j =3D 0; j < counter->num_values; j++) {
>> +             value =3D counter->values + j;
>> +
>> +             channels[i].type =3D IIO_COUNT;
>> +             channels[i].channel =3D counter->id;
>> +             channels[i].channel2 =3D value->id;
>> +             channels[i].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
>> +             channels[i].indexed =3D 1;
>> +             channels[i].counter =3D 1;
>> +
>> +             /* Add channels for Triggers associated with Value */
> Add channels?  'i' would need incrementing.   Also that's not what this f=
unction
> is doing that I can see...
>> +             err =3D iio_counter_value_ext_info_alloc(channels + i, val=
ue);
>> +             if (err)
>> +                     goto err_value_ext_info_alloc;
>> +
>> +             i++;
>> +     }
>> +
>> +     /* Add channel for each Signal */
>> +     for (j =3D 0; j < counter->num_signals; j++) {
>> +             signal =3D counter->signals + j;
>> +
>> +             channels[i].type =3D IIO_SIGNAL;
>> +             channels[i].channel =3D counter->id;
>> +             channels[i].channel2 =3D signal->id;
>> +             channels[i].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
>> +             channels[i].indexed =3D 1;
>> +             channels[i].counter =3D 1;
>> +             channels[i].ext_info =3D iio_counter_signal_ext_info;
>> +
>> +             i++;
>> +     }
>> +
>> +     counter->indio_dev->num_channels =3D num_channels;
>> +     counter->indio_dev->channels =3D channels;
>> +
>> +     return 0;
>> +
>> +err_value_ext_info_alloc:
>> +     while (i-- > counter->num_channels)
>> +             iio_counter_value_ext_info_free(channels + i);
>> +     kfree(channels);
>> +     return err;
>> +}
>> +
>> +static void iio_counter_channels_free(const struct iio_counter *const c=
ounter)
>> +{
>> +     size_t i =3D counter->num_channels + counter->indio_dev->num_chann=
els;
>> +     const struct iio_chan_spec *const chans =3D counter->indio_dev->ch=
annels;
>> +
>> +     while (i-- > counter->num_channels)
>> +             /* Only IIO_COUNT channels need to be freed here */
>> +             if (chans[i].type =3D=3D IIO_COUNT)
>> +                     iio_counter_value_ext_info_free(chans + i);
>> +
>> +     kfree(chans);
>> +}
>> +
>> +static int iio_counter_read_raw(struct iio_dev *indio_dev,
>> +     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_signal *signal;
>> +     struct iio_counter_value *value;
>> +
>> +     if (mask !=3D IIO_CHAN_INFO_RAW)
>> +             return -EINVAL;
>> +
>> +     switch (chan->type) {
>> +     /* Map read_raw to signal_read for Signal */
>> +     case IIO_SIGNAL:
>> +             if (!counter->ops->signal_read)
>> +                     return -EINVAL;
>> +
>> +             signal =3D iio_counter_signal_find_by_id(counter, chan->ch=
annel2);
>> +             if (!signal)
>> +                     return -EINVAL;
>> +
>> +             return counter->ops->signal_read(counter, signal, val, val=
2);
>> +     /* Map read_raw to value_read for Value */
>> +     case IIO_COUNT:
>> +             if (!counter->ops->value_read)
>> +                     return -EINVAL;
>> +
>> +             value =3D iio_counter_value_find_by_id(counter, chan->chan=
nel2);
>> +             if (!value)
>> +                     return -EINVAL;
>> +
>> +             return counter->ops->value_read(counter, value, val, val2)=
;
>> +     /* Map read_raw to read_raw for non-counter channel */
>> +     default:
>> +             if (counter->info && counter->info->read_raw)
>> +                     return counter->info->read_raw(indio_dev, chan, va=
l,
>> +                             val2, mask);
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int iio_counter_write_raw(struct iio_dev *indio_dev,
>> +     struct iio_chan_spec const *chan, int val, int val2, long mask)
>> +{
>> +     struct iio_counter *const counter =3D iio_priv_get_counter(indio_d=
ev);
>> +     struct iio_counter_signal *signal;
>> +     struct iio_counter_value *value;
>> +
>> +     if (mask !=3D IIO_CHAN_INFO_RAW)
>> +             return -EINVAL;
>> +
>> +     switch (chan->type) {
>> +     /* Map write_raw to signal_write for Signal */
>> +     case IIO_SIGNAL:
>> +             if (!counter->ops->signal_write)
>> +                     return -EINVAL;
>> +
>> +             signal =3D iio_counter_signal_find_by_id(counter, chan->ch=
annel2);
>> +             if (!signal)
>> +                     return -EINVAL;
>
>         Hmm. have to search is certainly a little ugly.  Particularly as =
the driver
>         would be able to maintain this as a lookup.  I'd be tempted to pa=
ss the
>         signal id down into the callback rather than finding the signal i=
n the core.
>         Might turn out messier though... :)
>
>> +
>> +             return counter->ops->signal_write(counter, signal, val, va=
l2);
>> +     /* Map write_raw to value_write for Value */
>> +     case IIO_COUNT:
>> +             if (!counter->ops->value_write)
>> +                     return -EINVAL;
>> +
>> +             value =3D iio_counter_value_find_by_id(counter, chan->chan=
nel2);
>
> Again, this mapping is a simple lookup in the driver I think, perhaps pus=
h
> it down there?
>
>> +             if (!value)
>> +                     return -EINVAL;
>> +
>> +             return counter->ops->value_write(counter, value, val, val2=
);
>> +     /* Map write_raw to write_raw for non-counter channel */
>> +     default:
>> +             if (counter->info && counter->info->write_raw)
>> +                     return counter->info->write_raw(indio_dev, chan, v=
al,
>> +                             val2, mask);
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int iio_counter_signals_validate(const struct iio_counter *const=
 counter)
>> +{
>> +     size_t i;
>> +     const struct iio_counter_signal *signal;
>> +     size_t j;
>> +     int curr_id;
>> +
>> +     /* At least one Signal must be defined */
>> +     if (!counter->num_signals || !counter->signals) {
>> +             pr_err("Counter '%d' Signals undefined\n", counter->id);
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i =3D 0; i < counter->num_signals; i++) {
>> +             signal =3D counter->signals + i;
>> +             /* No two Signals may share the same ID */
>> +             for (j =3D 0; j < i; j++) {
>> +                     curr_id =3D counter->signals[j].id;
>> +                     if (curr_id =3D=3D signal->id) {
>> +                             pr_err("Duplicate Counter '%d' Signal '%d'=
\n",
>> +                                             counter->id, signal->id);
>> +                             return -EEXIST;
>> +                     }
>> +             }
>> +             for (j =3D i + 1; j < counter->num_signals; j++) {
>> +                     curr_id =3D counter->signals[j].id;
>> +                     if (curr_id =3D=3D signal->id) {
>> +                             pr_err("Duplicate Counter '%d' Signal '%d'=
\n",
>> +                                             counter->id, signal->id);
>> +                             return -EEXIST;
>> +                     }
>> +             }
>
> Same as below.
>
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int iio_counter_triggers_validate(const int counter_id,
>> +     const struct iio_counter_value *const value)
>> +{
>> +     size_t i;
>> +     const struct iio_counter_trigger *trigger;
>> +     size_t j;
>> +     int curr_id;
>> +
>> +     /* At least one Trigger must be defined */
>> +     if (!value->num_triggers || !value->triggers) {
>> +             pr_err("Counter '%d' Value '%d' Triggers undefined\n",
>> +                     counter_id, value->id);
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* Ensure all Triggers have a defined Signal; this prevents a poss=
ible
>> +      * NULL pointer dereference when later validating Trigger Signal I=
Ds
>
> Fix comment syntax throughout...
>
>> +      */
>> +     for (i =3D 0; i < value->num_triggers; i++)
>> +             if (!value->triggers[i].signal) {
>> +                     pr_err("Counter '%d' Trigger '%zu' Signal undefine=
d\n",
>> +                             counter_id, i);
>> +                     return -EINVAL;
>> +             }
>> +
>> +     /* Verify validity of each Trigger */
>> +     for (i =3D 0; i < value->num_triggers; i++) {
>> +             trigger =3D value->triggers + i;
>> +             /* No two Trigger Signals may share the same ID */
>> +             for (j =3D 0; j < i; j++) {
>> +                     curr_id =3D value->triggers[j].signal->id;
>> +                     if (curr_id =3D=3D trigger->signal->id) {
>> +                             pr_err("Signal '%d' is already linked to C=
ounter '%d' Value '%d'\n",
>> +                                     trigger->signal->id, counter_id,
>> +                                     value->id);
>> +                             return -EEXIST;
>> +                     }
>> +             }
>> +             for (j =3D i + 1; j < value->num_triggers; j++) {
>> +                     curr_id =3D value->triggers[j].signal->id;
>> +                     if (curr_id =3D=3D trigger->signal->id) {
>> +                             pr_err("Signal '%d' is already linked to C=
ounter '%d' Value '%d'\n",
>> +                                     trigger->signal->id, counter_id,
>> +                                     value->id);
>> +                             return -EEXIST;
>> +                     }
>> +             }
> Again, one loop with the condition changed so it doesn't fault on the i =
=3D j case -- see below and
> note I'm reviewing backwards...
>
>
>> +
>> +             /* At least one trigger mode must be defined for each Trig=
ger */
>> +             if (!trigger->num_trigger_modes || !trigger->trigger_modes=
) {
>> +                     pr_err("Counter '%d' Signal '%d' trigger modes und=
efined\n",
>> +                             counter_id, trigger->signal->id);
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int iio_counter_values_validate(const struct iio_counter *const =
counter)
>> +{
>
> Hmm. Pretty heavy weight checking.  Ah well, up to you.
>
>> +     size_t i;
>> +     const struct iio_counter_value *value;
>> +     size_t j;
>> +     int curr_id;
>> +     int err;
>> +
>> +     /* At least one Value must be defined */
>> +     if (!counter->num_values || !counter->values) {
>> +             pr_err("Counter '%d' Values undefined\n", counter->id);
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* Verify validity of each Value */
>> +     for (i =3D 0; i < counter->num_values; i++) {
>> +             value =3D counter->values + i;
>> +             /* No two Values may share the same ID */
>> +             for (j =3D 0; j < i; j++) {
>
> Single loop with a slightly change to condition
> if ((i !=3D j) and (curr_id =3D=3D value->id))
>
>> +                     curr_id =3D counter->values[j].id;
>> +                     if (curr_id =3D=3D value->id) {
>> +                             pr_err("Duplicate Counter '%d' Value '%d'\=
n",
>> +                                     counter->id, value->id);
>> +                             return -EEXIST;
>> +                     }
>> +             }
>> +             for (j =3D i + 1; j < counter->num_values; j++) {
>> +                     curr_id =3D counter->values[j].id;
>> +                     if (curr_id =3D=3D value->id) {
>> +                             pr_err("Duplicate Counter '%d' Value '%d'\=
n",
>> +                                     counter->id, value->id);
>> +                             return -EEXIST;
>> +                     }
>> +             }
>> +
>> +             /* At least one function mode must be defined for each Val=
ue */
>> +             if (!value->num_function_modes || !value->function_modes) =
{
>> +                     pr_err("Counter '%d' Value '%d' function modes und=
efined\n",
>> +                             counter->id, value->id);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             /* Verify the Triggers associated with each Value */
>> +             err =3D iio_counter_triggers_validate(counter->id, value);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * iio_counter_register - register Counter to the system
>> + * @counter: pointer to IIO Counter to register
>> + *
>> + * This function piggybacks off of iio_device_register. First, the rele=
vant
>> + * Counter members are validated; the signals and values members must b=
e defined
>> + * and populated by valid Signal and Value structures respectively. Nex=
t, a
>> + * struct iio_dev is allocated by a call to iio_device_alloc and initia=
lized for
>> + * the Counter, IIO channels are allocated, the Counter address is stor=
ed as the
>> + * private data, and finally iio_device_register is called.
>> + */
>> +int iio_counter_register(struct iio_counter *const counter)
>> +{
>> +     const struct iio_info info_default =3D {
>> +             .read_raw =3D iio_counter_read_raw,
>> +             .write_raw =3D iio_counter_write_raw
>> +     };
>> +     int err;
>> +     struct iio_info *info;
>> +     struct iio_counter **priv;
>> +
>> +     if (!counter)
>> +             return -EINVAL;
>> +
>> +     /* Verify that Signals are valid and IDs do not conflict */
>> +     err =3D iio_counter_signals_validate(counter);
>> +     if (err)
>> +             return err;
>> +
>> +     /* Verify that Values are valid and IDs do not conflict;
> Fix multiline comment syntax to standard kernel syntax.
> /*
>  * Verify
>  */
>> +      * Triggers for each Value are also verified for validity
>> +      */
>> +     err =3D iio_counter_values_validate(counter);
>> +     if (err)
>> +             return err;
>> +
>> +     counter->indio_dev =3D iio_device_alloc(sizeof(counter));
>> +     if (!counter->indio_dev)
>> +             return -ENOMEM;
>> +
>> +     info =3D kmalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info) {
>> +             err =3D -ENOMEM;
>> +             goto err_info_alloc;
>> +     }
>> +     /* If an iio_info has been supplied than we use that,
>> +      * otherwise we set all callbacks to NULL; iio_counter_read_raw
>> +      * and iio_counter_write_raw is used for read_raw and write_raw
>> +      * for either case in order to support counter functionality
>> +      * (supplied read_raw/write_raw will be called from within
>> +      * iio_counter_read_raw/iio_counter_write_raw for non-counter
>> +      * channels)
>> +      */
>
>> +     if (counter->info) {
>> +             memcpy(info, counter->info, sizeof(*counter->info));
>> +             info->read_raw =3D iio_counter_read_raw;
>> +             info->write_raw =3D iio_counter_write_raw;
>> +     } else {
>> +             memcpy(info, &info_default, sizeof(info_default));
>> +     }
>> +
>> +     counter->indio_dev->info =3D info;
>> +     counter->indio_dev->modes =3D INDIO_DIRECT_MODE;

As I have said in the previous version, stm32 driver will not work with
this mode, so I need way to change it.
One solution could be to use iio_priv to store an iio_counter structure wit=
h
ops, arrays etc... Maybe even iio_counter structure could be hiden from dri=
vers.
It could require to split iio_counter allocation and registration to functi=
ons.

>> +     counter->indio_dev->name =3D counter->name;
>> +     counter->indio_dev->dev.parent =3D counter->dev;
>> +
>> +     /* IIO channels are allocated and set for Signals, Values, and Tri=
ggers;
>> +      * any auxiliary IIO channels provided in iio_counter are also set
>> +      */
>> +     err =3D iio_counter_channels_alloc(counter);
>> +     if (err)
>> +             goto err_channels_alloc;
>> +
>> +     /* Pointer to the counter is stored in indio_dev as a way to refer
>> +      * back to the counter from within various IIO callbacks
>> +      */
>> +     priv =3D iio_priv(counter->indio_dev);
>> +     memcpy(priv, &counter, sizeof(*priv));
>> +
>> +     err =3D iio_device_register(counter->indio_dev);
>> +     if (err)
>> +             goto err_iio_device_register;
>> +
>> +     return 0;
>> +
>> +err_iio_device_register:
>> +     iio_counter_channels_free(counter);
>> +err_channels_alloc:
>> +     kfree(info);
>> +err_info_alloc:
>> +     iio_device_free(counter->indio_dev);
>> +     return err;
>> +}
>> +EXPORT_SYMBOL(iio_counter_register);
>> +
>> +/**
>> + * iio_counter_unregister - unregister Counter from the system
>> + * @counter: pointer to IIO Counter to unregister
>> + *
>> + * The Counter is unregistered from the system. The indio_dev is unregi=
stered
>> + * and all allocated memory is freed.
>> + */
>> +void iio_counter_unregister(struct iio_counter *const counter)
>> +{
>> +     const struct iio_info *const info =3D counter->indio_dev->info;
>> +
>> +     if (!counter)
>> +             return;
>> +
>> +     iio_device_unregister(counter->indio_dev);
>> +
>> +     iio_counter_channels_free(counter);
>> +
>> +     kfree(info);
>> +     iio_device_free(counter->indio_dev);
>> +}
>> +EXPORT_SYMBOL(iio_counter_unregister);
>> +
>> +static void devm_iio_counter_unreg(struct device *dev, void *res)
>> +{
>> +     iio_counter_unregister(*(struct iio_counter **)res);
>> +}
>> +
>> +/**
>> + * devm_iio_counter_register - Resource-managed iio_counter_register
>> + * @dev: Device to allocate iio_counter for
>> + * @counter: pointer to IIO Counter to register
>> + *
>> + * Managed iio_counter_register. The IIO counter registered with this
>> + * function is automatically unregistered on driver detach. This functi=
on
>> + * calls iio_counter_register internally. Refer to that function for mo=
re
>> + * information.
>> + *
>> + * If an iio counter registered with this function needs to be unregist=
ered
>> + * separately, devm_iio_counter_unregister must be used.
>> + *
>> + * RETURNS:
>> + * 0 on success, negative error number on failure.
>> + */
>> +int devm_iio_counter_register(struct device *dev,
>> +     struct iio_counter *const counter)
>> +{
>> +     struct iio_counter **ptr;
>> +     int ret;
>> +
>> +     ptr =3D devres_alloc(devm_iio_counter_unreg, sizeof(*ptr), GFP_KER=
NEL);
>> +     if (!ptr)
>> +             return -ENOMEM;
>> +
>> +     *ptr =3D counter;
>> +     ret =3D iio_counter_register(counter);
>> +     if (!ret)
>> +             devres_add(dev, ptr);
>> +     else
>> +             devres_free(ptr);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL(devm_iio_counter_register);
>> +
>> +static int devm_iio_counter_match(struct device *dev, void *res, void *=
data)
>> +{
>> +     struct iio_counter **r =3D res;
>> +
>> +     if (!r || !*r) {
>> +             WARN_ON(!r || !*r);
>> +             return 0;
>> +     }
>> +
>> +     return *r =3D=3D data;
>> +}
>> +
>> +/**
>> + * devm_iio_counter_unregister - Resource-managed iio_counter_unregiste=
r
>> + * @dev: Device this iio_counter belongs to
>> + * @counter: the iio counter associated with the device
>> + *
>> + * Unregister iio counter registered with devm_iio_counter_register.
>> + */
>> +void devm_iio_counter_unregister(struct device *dev,
>> +     struct iio_counter *const counter)
>> +{
>> +     int rc;
>> +
>> +     rc =3D devres_release(dev, devm_iio_counter_unreg,
>> +             devm_iio_counter_match, counter);
>> +     WARN_ON(rc);
>> +}
>> +EXPORT_SYMBOL(devm_iio_counter_unregister);
>> diff --git a/include/linux/iio/counter.h b/include/linux/iio/counter.h
>> new file mode 100644
>> index 000000000000..35645406711a
>> --- /dev/null
>> +++ b/include/linux/iio/counter.h
>> @@ -0,0 +1,166 @@
>> +/*
>> + * Industrial I/O counter interface
>> + * Copyright (C) 2017 William Breathitt Gray
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +#ifndef _IIO_COUNTER_H_
>> +#define _IIO_COUNTER_H_
>> +
>> +#ifdef CONFIG_IIO_COUNTER
>> +
>> +#include <linux/device.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/iio/iio.h>
>> +
>> +/**
>> + * struct iio_counter_signal - IIO Counter Signal node
>> + * @id:              [DRIVER] unique ID used to identify signal
>> + * @name:    [DRIVER] device-specific signal name
>> + */
>> +struct iio_counter_signal {
>> +     int             id;
>> +     const char      *name;
>> +};
>> +
>> +/**
>> + * struct iio_counter_trigger - IIO Counter Trigger node
>> + * @mode:            [DRIVER] current trigger mode state
>> + * @trigger_modes:   [DRIVER] available trigger modes
>> + * @num_trigger_modes:       [DRIVER] number of modes specified in @tri=
gger_modes
>> + * @signal:          [DRIVER] pointer to associated signal
>> + */
>> +struct iio_counter_trigger {
>> +     unsigned int                    mode;
>> +     const char *const               *trigger_modes;
>> +     unsigned int                    num_trigger_modes;
>> +     struct iio_counter_signal       *signal;
>
> Are signals actually changeable? - Or is that pointer constant?
>
>> +};
>> +
>> +/**
>> + * struct iio_counter_value - IIO Counter Value node
>> + * @id:                      [DRIVER] unique ID used to identify value
>> + * @name:            [DRIVER] device-specific value name
>> + * @mode:            [DRIVER] current function mode state
>> + * @function_modes:  [DRIVER] available function modes
>> + * @num_function_modes:      [DRIVER] number of modes specified in @fun=
ction_modes
>> + * @triggers:                [DRIVER] array of triggers for initializat=
ion
>> + * @num_triggers:    [DRIVER] number of triggers specified in @triggers
>> + * @function_enum:   [INTERN] used internally to generate function attr=
ibutes
>> + */
>> +struct iio_counter_value {
>> +     int                     id;
>> +     const char              *name;
>> +     unsigned int            mode;
>> +     const char *const       *function_modes;
>> +     unsigned int            num_function_modes;
>> +
>> +     struct iio_counter_trigger      *triggers;
>> +     size_t                          num_triggers;
>> +
>> +     struct iio_enum         function_enum;
>> +};
>> +
>> +struct iio_counter;
>> +
>> +/**
>> + * struct iio_counter_ops - IIO Counter related callbacks
>> + * @signal_read:     function to request a signal value from the device=
.
>> + *                   Return value will specify the type of value return=
ed by
>> + *                   the device. val and val2 will contain the elements
>> + *                   making up the returned value.
>
> Add some detail on the importance of the return value.
>
>> + * @signal_write:    function to write a signal value to the device.
>> + *                      Parameters are interpreted the same as signal_r=
ead.
>
> You need a means of establishing the correct format for write (we needed =
it
> in IIO fairly early on too)
>
>> + * @trigger_mode_set:        function to set the trigger mode. mode is =
the index of
>> + *                   the requested mode from the value trigger_modes ar=
ray.
>> + * @trigger_mode_get:        function to get the current trigger mode. =
Return value
>> + *                   will specify the index of the current mode from th=
e
>> + *                   value trigger_modes array.
>> + * @value_read:              function to request a value value from the=
 device.
>> + *                   Return value will specify the type of value return=
ed by
>> + *                   the device. val and val2 will contain the elements
>> + *                   making up the returned value.
>> + * @value_write:     function to write a value value to the device.
>> + *                      Parameters are interpreted the same as value_re=
ad.
>> + * @value_function_set: function to set the value function mode. mode i=
s the
>> + *                   index of the requested mode from the value
>> + *                   function_modes array.
>> + * @value_function_get: function to get the current value function mode=
. Return
>> + *                   value will specify the index of the current mode f=
rom
>> + *                   the value function_modes array.
>> + */
>> +struct iio_counter_ops {
>> +     int (*signal_read)(struct iio_counter *counter,
>> +             struct iio_counter_signal *signal, int *val, int *val2);
>> +     int (*signal_write)(struct iio_counter *counter,
>> +             struct iio_counter_signal *signal, int val, int val2);
>> +     int (*trigger_mode_set)(struct iio_counter *counter,
>> +             struct iio_counter_value *value,
>> +             struct iio_counter_trigger *trigger, unsigned int mode);
>> +     int (*trigger_mode_get)(struct iio_counter *counter,
>> +             struct iio_counter_value *value,
>> +             struct iio_counter_trigger *trigger);
>> +     int (*value_read)(struct iio_counter *counter,
>> +             struct iio_counter_value *value, int *val, int *val2);
>> +     int (*value_write)(struct iio_counter *counter,
>> +             struct iio_counter_value *value, int val, int val2);
>> +     int (*value_function_set)(struct iio_counter *counter,
>> +             struct iio_counter_value *value, unsigned int mode);
>> +     int (*value_function_get)(struct iio_counter *counter,
>> +             struct iio_counter_value *value);
>> +};
>> +
>> +/**
>> + * struct iio_counter - IIO Counter data structure
>> + * @id:                      [DRIVER] unique ID used to identify counte=
r
>> + * @name:            [DRIVER] name of the device
>> + * @dev:             [DRIVER] device structure, should be assigned a pa=
rent
>> + *                   and owner
>> + * @ops:             [DRIVER] callbacks from driver for counter compone=
nts
>> + * @signals:         [DRIVER] array of signals for initialization
>> + * @num_signals:     [DRIVER] number of signals specified in @signals
>> + * @values:          [DRIVER] array of values for initialization
>> + * @num_values:              [DRIVER] number of values specified in @va=
lues
>> + * @channels:                [DRIVER] channel specification structure t=
able
>> + * @num_channels:    [DRIVER] number of channels specified in @channels
>> + * @info:            [DRIVER] callbacks and constant info from driver
>> + * @indio_dev:               [INTERN] industrial I/O device structure
>> + * @driver_data:     [DRIVER] driver data
>> + */
>> +struct iio_counter {
>
> Mentioned earlier - I think naming the device counter, is confusing.
> The counters should be named counter - call it iio_counter_device
> or iio_counter_group or something and keep counter for the things
> currently called value.
>
>> +     int                             id;
>> +     const char                      *name;
>> +     struct device                   *dev;
>> +     const struct iio_counter_ops    *ops;
>> +
>> +     struct iio_counter_signal       *signals;
>> +     size_t                          num_signals;
>> +     struct iio_counter_value        *values;
>> +     size_t                          num_values;
>> +
>> +     const struct iio_chan_spec      *channels;
>> +     size_t                          num_channels;
>> +     const struct iio_info           *info;
>> +
>> +     struct iio_dev  *indio_dev;
>> +     void            *driver_data;
>> +};
>> +
>> +int iio_counter_register(struct iio_counter *const counter);
>> +void iio_counter_unregister(struct iio_counter *const counter);
>> +int devm_iio_counter_register(struct device *dev,
>> +     struct iio_counter *const counter);
>> +void devm_iio_counter_unregister(struct device *dev,
>> +     struct iio_counter *const counter);
>> +
>> +#endif /* CONFIG_IIO_COUNTER */
>> +
>> +#endif /* _IIO_COUNTER_H_ */
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
