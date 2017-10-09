Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45382 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbdJIMfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2017 08:35:20 -0400
Received: by mail-qt0-f173.google.com with SMTP id p1so5366217qtg.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Oct 2017 05:35:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171008144117.5ba4d6a6@archlinux>
References: <cover.1507220144.git.vilhelm.gray@gmail.com> <699d043348fdb4053ed7f6f7dafb8512c7d73589.1507220144.git.vilhelm.gray@gmail.com>
 <20171008144117.5ba4d6a6@archlinux>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 9 Oct 2017 14:35:18 +0200
Message-ID: <CA+M3ks4YfbWdiAeuNL2DudBDdj6pd7Hpuc=pQx_w1DoxiQV+XA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: Add dummy counter driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-10-08 15:41 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
> On Thu,  5 Oct 2017 14:14:38 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch introduces the dummy counter driver. The dummy counter driver
>> serves as a reference implementation of a driver that utilizes the
>> Generic Counter interface.
>
> This is great - I was planning to write one of these to try out the
> interface and you've already done it :)

May I suggest you to write a gpio-counter driver instead ? (that was
in my todo list)
It is more or less the same than this driver but instead of simulate the signal
it could use gpio to them provide a software quadratic counter.

Benjamin

>>
>> Writing individual '1' and '0' characters to the Signal attributes
>> allows a user to simulate a typical Counter Signal input stream for
>> evaluation; the Counter will evaluate the Signal data based on the
>> respective trigger mode for the associated Signal, and trigger the
>> associated counter function specified by the respective function mode.
>> The current Value value may be read, and the Value value preset by a
>> write.
>>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
> Comments are more generic suggestions for improving the example than
> general comments on the ABI - that all seems to make reasonable sense
> (other than when the documents contain the wonderful
> Value value - not confusing at all ;)
>
>> ---
>>  drivers/iio/counter/Kconfig         |  15 ++
>>  drivers/iio/counter/Makefile        |   1 +
>>  drivers/iio/counter/dummy-counter.c | 293 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 309 insertions(+)
>>  create mode 100644 drivers/iio/counter/dummy-counter.c
>>
>> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
>> index c8becfe78e28..494aed40e9c9 100644
>> --- a/drivers/iio/counter/Kconfig
>> +++ b/drivers/iio/counter/Kconfig
>> @@ -22,6 +22,21 @@ config 104_QUAD_8
>>         The base port addresses for the devices may be configured via the base
>>         array module parameter.
>>
>> +config DUMMY_COUNTER
>> +     tristate "Dummy counter driver"
>> +     help
>> +       Select this option to enable the dummy counter driver. The dummy
>> +       counter driver serves as a reference implementation of a driver that
>> +       utilizes the Generic Counter interface.
>> +
>> +       Writing individual '1' and '0' characters to the Signal attributes
>> +       allows a user to simulate a typical Counter Signal input stream for
>> +       evaluation; the Counter will evaluate the Signal data based on the
>> +       respective trigger mode for the associated Signal, and trigger the
>> +       associated counter function specified by the respective function mode.
>> +       The current Value value may be read, and the Value value preset by a
>> +       write.
>> +
>>  config STM32_LPTIMER_CNT
>>       tristate "STM32 LP Timer encoder counter driver"
>>       depends on MFD_STM32_LPTIMER || COMPILE_TEST
>> diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
>> index 1b9a896eb488..8c2ef0115426 100644
>> --- a/drivers/iio/counter/Makefile
>> +++ b/drivers/iio/counter/Makefile
>> @@ -5,4 +5,5 @@
>>  # When adding new entries keep the list in alphabetical order
>>
>>  obj-$(CONFIG_104_QUAD_8)     += 104-quad-8.o
>> +obj-$(CONFIG_DUMMY_COUNTER)  += dummy-counter.o
>>  obj-$(CONFIG_STM32_LPTIMER_CNT)      += stm32-lptimer-cnt.o
>> diff --git a/drivers/iio/counter/dummy-counter.c b/drivers/iio/counter/dummy-counter.c
>> new file mode 100644
>> index 000000000000..6ecc9854894f
>> --- /dev/null
>> +++ b/drivers/iio/counter/dummy-counter.c
>> @@ -0,0 +1,293 @@
>> +/*
>> + * Dummy counter driver
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
>> +#include <linux/errno.h>
>> +#include <linux/iio/counter.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/types.h>
>> +
>> +#define DUMCNT_NUM_COUNTERS 2
>> +/**
>> + * struct dumcnt - private data structure
>> + * @counter: instance of the iio_counter
>> + * @counts:  array of accumulation values
>> + * @states:  array of input line states
>> + */
>> +struct dumcnt {
>> +     struct iio_counter counter;
>> +     unsigned int counts[DUMCNT_NUM_COUNTERS];
>> +     unsigned int states[DUMCNT_NUM_COUNTERS];
>> +};
>> +
>> +static int dumcnt_signal_read(struct iio_counter *counter,
>> +     struct iio_counter_signal *signal, int *val, int *val2)
>> +{
>> +     struct dumcnt *const priv = counter->driver_data;
>> +     *val = priv->states[signal->id];
>> +
>> +     return IIO_VAL_INT;
>> +}
>> +
>> +static int dumcnt_signal_write(struct iio_counter *counter,
>> +     struct iio_counter_signal *signal, int val, int val2)
>> +{
>
> This is an odd one to have in the generic interface.
> What real hardware does writing the state make sense for?
> If it is only fake drivers - figure out a way to do it without
> having to add to the generic interfaces.
>
>> +     struct dumcnt *const priv = counter->driver_data;
>> +     const unsigned int id = signal->id;
>> +     const unsigned int prev_state = priv->states[id];
>> +     struct iio_counter_value *const value = counter->values + id;
>> +     const unsigned int function_mode = value->mode;
>> +     const unsigned int trigger_mode = value->triggers[0].mode;
>> +     unsigned int triggered = 0;
>> +
>> +     if (val && val != 1)
>> +             return -EINVAL;
>> +
>> +     /* If no state change then just exit */
>> +     if (prev_state == val)
>> +             return 0;
>> +
>> +     priv->states[id] = val;
>> +
>> +     switch (trigger_mode) {
>> +     /* "none" case */
>> +     case 0:
>> +             return 0;
>> +     /* "rising edge" case */
>> +     case 1:
>> +             if (!prev_state)
>> +                     triggered = 1;
>> +             break;
>> +     /* "falling edge" case */
>> +     case 2:
>> +             if (prev_state)
>> +                     triggered = 1;
>> +             break;
>> +     /* "both edges" case */
>> +     case 3:
>> +             triggered = 1;
>> +             break;
>> +     }
>> +
>> +     /* If counter function triggered */
>> +     if (triggered)
>> +             /* "increase" case */
>> +             if (function_mode)
>> +                     priv->counts[id]++;
>> +             /* "decrease" case */
>> +             else
>> +                     priv->counts[id]--;
>> +
>> +     return 0;
>> +}
>> +
>> +static int dumcnt_trigger_mode_set(struct iio_counter *counter,
>> +     struct iio_counter_value *value, struct iio_counter_trigger *trigger,
>> +     unsigned int mode)
>> +{
>> +     if (mode >= trigger->num_trigger_modes)
>> +             return -EINVAL;
>> +
>> +     trigger->mode = mode;
>> +
>> +     return 0;
>> +}
>> +
>> +static int dumcnt_trigger_mode_get(struct iio_counter *counter,
>> +     struct iio_counter_value *value, struct iio_counter_trigger *trigger)
>> +{
>> +     return trigger->mode;
>> +}
>> +
>> +static int dumcnt_value_read(struct iio_counter *counter,
>> +     struct iio_counter_value *value, int *val, int *val2)
>> +{
>> +     struct dumcnt *const priv = counter->driver_data;
>> +
>> +     *val = priv->counts[value->id];
>> +
>> +     return IIO_VAL_INT;
>> +}
>> +
>> +static int dumcnt_value_write(struct iio_counter *counter,
>> +     struct iio_counter_value *value, int val, int val2)
>> +{
>> +     struct dumcnt *const priv = counter->driver_data;
>> +
>> +     priv->counts[value->id] = val;
>> +
>> +     return 0;
>> +}
>> +
>> +static int dumcnt_value_function_set(struct iio_counter *counter,
>> +     struct iio_counter_value *value, unsigned int mode)
>> +{
>> +     if (mode >= value->num_function_modes)
>> +             return -EINVAL;
>> +
>> +     value->mode = mode;
>> +
>> +     return 0;
>> +}
>> +
>> +static int dumcnt_value_function_get(struct iio_counter *counter,
>> +     struct iio_counter_value *value)
>> +{
>> +     return value->mode;
>
> If it's called function in the function name, call it function in
> the structure as well rather than mode.
>
>> +}
>> +
>> +static const struct iio_counter_ops dumcnt_ops = {
>> +     .signal_read = dumcnt_signal_read,
>> +     .signal_write = dumcnt_signal_write,
>> +     .trigger_mode_get = dumcnt_trigger_mode_get,
>> +     .trigger_mode_set = dumcnt_trigger_mode_set,
>> +     .value_read = dumcnt_value_read,
>> +     .value_write = dumcnt_value_write,
>> +     .value_function_set = dumcnt_value_function_set,
>> +     .value_function_get = dumcnt_value_function_get
>> +};
>> +
>> +static const char *const dumcnt_function_modes[] = {
>> +     "decrease",
>
> I think increment was used somewhere in the docs... It's
> clearer, but you need to document this ABI to stop having
> subtle variations of it like this (even if I imagined it ;)
>
>> +     "increase"
>> +};
>> +
>> +#define DUMCNT_SIGNAL(_id, _name) {  \
>> +     .id = _id,                      \
>> +     .name = _name                   \
>> +}
>> +
>> +static const struct iio_counter_signal dumcnt_signals[] = {
>> +     DUMCNT_SIGNAL(0, "Signal A"), DUMCNT_SIGNAL(1, "Signal B")
>> +};
>> +
>> +#define DUMCNT_VALUE(_id, _name) {                                   \
>> +     .id = _id,                                                      \
>> +     .name = _name,                                                  \
>> +     .mode = 0,                                                      \
>> +     .function_modes = dumcnt_function_modes,                        \
>> +     .num_function_modes = ARRAY_SIZE(dumcnt_function_modes)         \
>> +}
>> +
>> +static const struct iio_counter_value dumcnt_values[] = {
>> +     DUMCNT_VALUE(0, "Count A"), DUMCNT_VALUE(1, "Count B")
>> +};
>> +
>> +static const char *const dumcnt_trigger_modes[] = {
>
> As mentioned below, use an enum for the index as then you can make it obvious
> what 0 means when you set the mode to it later.
>
>> +     "none",
>> +     "rising edge",
>> +     "falling edge",
>> +     "both edges"
>> +};
>> +
>> +static int dumcnt_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct iio_counter_signal *signals;
>> +     const size_t num_signals = ARRAY_SIZE(dumcnt_signals);
>
> Don't bother with local variable - makes it less obvious what
> is going on.
>
>> +     struct iio_counter_value *values;
>> +     const size_t num_values = ARRAY_SIZE(dumcnt_values);
>
> Local variable doesn't add anything and if anything makes
> it slightly harder to check what is going on.
>
>> +     struct iio_counter_trigger *triggers;
>> +     int i;
>> +     struct dumcnt *dumcnt;
>> +
>> +     signals = devm_kmalloc(dev, sizeof(dumcnt_signals), GFP_KERNEL);
>> +     if (!signals)
>> +             return -ENOMEM;
>> +
>> +     memcpy(signals, dumcnt_signals, sizeof(dumcnt_signals));
>
> devm_kmemdup?
>> +
>> +     values = devm_kmalloc(dev, sizeof(dumcnt_values), GFP_KERNEL);
>> +     if (!values)
>> +             return -ENOMEM;
>> +
>> +     memcpy(values, dumcnt_values, sizeof(dumcnt_values));
>
> devm_kmemdup?
>
>> +
>> +     /* Associate values with their respective signals */
>> +     for (i = 0; i < num_values; i++) {
>> +             triggers = devm_kmalloc(dev, sizeof(*triggers), GFP_KERNEL);
>> +             if (!triggers)
>> +                     return -ENOMEM;
>> +
>> +             triggers->mode = 0;
>
> Use an enum for the dumcn_trigger_modes array index then specify by enum value
> here.  Will make it more readable.
>
>> +             triggers->trigger_modes = dumcnt_trigger_modes;
>> +             triggers->num_trigger_modes = ARRAY_SIZE(dumcnt_trigger_modes);
>> +             triggers->signal = &signals[i];
>> +
>> +             values[i].triggers = triggers;
>> +             values[i].num_triggers = 1;
>> +     }
>> +
>> +     dumcnt = devm_kzalloc(dev, sizeof(*dumcnt), GFP_KERNEL);
>> +     if (!dumcnt)
>> +             return -ENOMEM;
>> +
>> +     dumcnt->counter.name = dev_name(dev);
>> +     dumcnt->counter.dev = dev;
>> +     dumcnt->counter.ops = &dumcnt_ops;
>> +     dumcnt->counter.signals = signals;
>> +     dumcnt->counter.num_signals = num_signals;
>> +     dumcnt->counter.values = values;
>> +     dumcnt->counter.num_values = num_values;
>> +     dumcnt->counter.driver_data = dumcnt;
>> +
>> +     return devm_iio_counter_register(dev, &dumcnt->counter);
>> +}
>> +
>> +static struct platform_device *dumcnt_device;
>
> Support multiple instances - nick this stuff from the
> IIO dummy driver or more specifically the
> industrialio-sw-device.c
>
>> +
>> +static struct platform_driver dumcnt_driver = {
>> +     .driver = {
>> +             .name = "104-quad-8"
>
> Don't do that!  Give it it's own name.
>
>> +     }
>> +};
>> +
>> +static void __exit dumcnt_exit(void)
>> +{
>> +     platform_device_unregister(dumcnt_device);
>> +     platform_driver_unregister(&dumcnt_driver);
>> +}
>> +
>> +static int __init dumcnt_init(void)
>> +{
>> +     int err;
>> +
>
> General thing, but if we are going to upstream this with the subsystem,
> make device instantiation happen via configfs.
>
>> +     dumcnt_device = platform_device_alloc(dumcnt_driver.driver.name, -1);
>> +     if (!dumcnt_device)
>> +             return -ENOMEM;
>> +
>> +     err = platform_device_add(dumcnt_device);
>> +     if (err)
>> +             goto err_platform_device;
>> +
>> +     err = platform_driver_probe(&dumcnt_driver, dumcnt_probe);
>> +     if (err)
>> +             goto err_platform_driver;
>> +
>> +     return 0;
>> +
>> +err_platform_driver:
>> +     platform_device_del(dumcnt_device);
>> +err_platform_device:
>> +     platform_device_put(dumcnt_device);
>> +     return err;
>> +}
>> +
>> +module_init(dumcnt_init);
>> +module_exit(dumcnt_exit);
>> +
>> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
>> +MODULE_DESCRIPTION("Dummy counter driver");
>> +MODULE_LICENSE("GPL v2");
