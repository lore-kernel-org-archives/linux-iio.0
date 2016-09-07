Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKzfze_NskaeJcJ=m=br3gqi_Voqzc4Bqb6Dd-BVT175utzRDQ@mail.gmail.com>
References: <1473138655-15626-1-git-send-email-matt@ranostay.consulting>
 <alpine.DEB.2.02.1609060715540.29281@pmeerw.net> <CAKzfze-dcEo5YozEqwObxvxdvjn0igcSr9fag2v+sQ-HAh0jjA@mail.gmail.com>
 <CAKzfze_NskaeJcJ=m=br3gqi_Voqzc4Bqb6Dd-BVT175utzRDQ@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 6 Sep 2016 19:22:02 -0700
Message-ID: <CAKzfze810Bza44nU3t2N5YSa7WQb8OQ6yyDEduYOukcTpWdvZQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: potentiostat: add LMP91000 support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <matt@ranostay.consulting>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 6, 2016 at 12:31 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> On Tue, Sep 6, 2016 at 12:14 AM, Matt Ranostay <mranostay@gmail.com> wrote:
>> On Mon, Sep 5, 2016 at 10:43 PM, Peter Meerwald-Stadler
>> <pmeerw@pmeerw.net> wrote:
>>>
>>>> Add support for the LMP91000 potentiostat which is used for chemical
>>>> sensing applications.
>>>
>>> minor comments below
>>>
>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>> ---
>>>>
>>>> Changes from v1:
>>>>  * Rename ti-adc1x1s.c driver to ti-adc161s626.c
>>>>  * Switch from iio_channel_read() to using the industrialio-buffer-cb
>>>>    interface
>>>>  * Process data in ADC trigger handler for buffer callbacks
>>>>  * Set the mux trigger to the ADC referenced by io-channels by default
>>>>
>>>> Changes from v2:
>>>>  * Fix configuration index shifting values
>>>>  * Switch from wait_for_completion_interruptible to wait_for_completion_timeout
>>>>
>>>> Changes from v3:
>>>>  * Fix order of probe function error rollback
>>>>
>>>> Changes from v4:
>>>>  * add iio_trigger_set_immutable() call
>>>>  * move iio_channel_*_all_cb calls to *_buffer_preenable/postenable
>>>>
>>>> .../bindings/iio/potentiostat/lmp91000.txt         |  30 ++
>>>>  drivers/iio/Kconfig                                |   1 +
>>>>  drivers/iio/Makefile                               |   1 +
>>>>  drivers/iio/potentiostat/Kconfig                   |  22 ++
>>>>  drivers/iio/potentiostat/Makefile                  |   6 +
>>>>  drivers/iio/potentiostat/lmp91000.c                | 397 +++++++++++++++++++++
>>>>  6 files changed, 457 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>>>  create mode 100644 drivers/iio/potentiostat/Kconfig
>>>>  create mode 100644 drivers/iio/potentiostat/Makefile
>>>>  create mode 100644 drivers/iio/potentiostat/lmp91000.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>>> new file mode 100644
>>>> index 000000000000..b9b621e94cd7
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>>> @@ -0,0 +1,30 @@
>>>> +* Texas Instruments LMP91000 potentiostat
>>>> +
>>>> +http://www.ti.com/lit/ds/symlink/lmp91000.pdf
>>>> +
>>>> +Required properties:
>>>> +
>>>> +  - compatible: should be "ti,lmp91000"
>>>> +  - reg: the I2C address of the device
>>>> +  - io-channels: the phandle of the iio provider
>>>> +
>>>> +  - ti,external-tia-resistor: if the property ti,tia-gain-ohm is not defined this
>>>> +    needs to be set to signal that an external resistor value is being used.
>>>> +
>>>> +Optional properties:
>>>> +
>>>> +  - ti,tia-gain-ohm: ohm value of the internal resistor for the transimpedance
>>>> +    amplifier. Must be 2750, 3500, 7000, 14000, 35000, 120000, or 350000 ohms.
>>>> +
>>>> +  - ti,rload-ohm: ohm value of the internal resistor load applied to the gas
>>>> +    sensor. Must be 10, 33, 50, or 100 (default) ohms.
>>>> +
>>>> +Example:
>>>> +
>>>> +lmp91000@48 {
>>>> +     compatible = "ti,lmp91000";
>>>> +     reg = <0x48>;
>>>> +     ti,tia-gain-ohm = <7500>;
>>>> +     ti,rload = <100>;
>>>> +     io-channels = <&adc>;
>>>> +};
>>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>>> index 505e921f0b19..ad5bbaefc18e 100644
>>>> --- a/drivers/iio/Kconfig
>>>> +++ b/drivers/iio/Kconfig
>>>> @@ -79,6 +79,7 @@ if IIO_TRIGGER
>>>>     source "drivers/iio/trigger/Kconfig"
>>>>  endif #IIO_TRIGGER
>>>>  source "drivers/iio/potentiometer/Kconfig"
>>>> +source "drivers/iio/potentiostat/Kconfig"
>>>>  source "drivers/iio/pressure/Kconfig"
>>>>  source "drivers/iio/proximity/Kconfig"
>>>>  source "drivers/iio/temperature/Kconfig"
>>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>>> index 20f649073462..f7369b77ed94 100644
>>>> --- a/drivers/iio/Makefile
>>>> +++ b/drivers/iio/Makefile
>>>> @@ -28,6 +28,7 @@ obj-y += light/
>>>>  obj-y += magnetometer/
>>>>  obj-y += orientation/
>>>>  obj-y += potentiometer/
>>>> +obj-y += potentiostat/
>>>>  obj-y += pressure/
>>>>  obj-y += proximity/
>>>>  obj-y += temperature/
>>>> diff --git a/drivers/iio/potentiostat/Kconfig b/drivers/iio/potentiostat/Kconfig
>>>> new file mode 100644
>>>> index 000000000000..1e3baf2cc97d
>>>> --- /dev/null
>>>> +++ b/drivers/iio/potentiostat/Kconfig
>>>> @@ -0,0 +1,22 @@
>>>> +#
>>>> +# Potentiostat drivers
>>>> +#
>>>> +# When adding new entries keep the list in alphabetical order
>>>> +
>>>> +menu "Digital potentiostats"
>>>> +
>>>> +config LMP91000
>>>> +     tristate "Texas Instruments LMP91000 potentiostat driver"
>>>> +     depends on I2C
>>>> +     select REGMAP_I2C
>>>> +     select IIO_BUFFER
>>>> +     select IIO_BUFFER_CB
>>>> +     select IIO_TRIGGERED_BUFFER
>>>> +     help
>>>> +       Say yes here to build support for the Texas Instruments
>>>> +       LMP91000 digital potentiostat chip.
>>>> +
>>>> +       To compile this driver as a module, choose M here: the
>>>> +       module will be called lmp91000
>>>> +
>>>> +endmenu
>>>> diff --git a/drivers/iio/potentiostat/Makefile b/drivers/iio/potentiostat/Makefile
>>>> new file mode 100644
>>>> index 000000000000..64d315ef4449
>>>> --- /dev/null
>>>> +++ b/drivers/iio/potentiostat/Makefile
>>>> @@ -0,0 +1,6 @@
>>>> +#
>>>> +# Makefile for industrial I/O potentiostat drivers
>>>> +#
>>>> +
>>>> +# When adding new entries keep the list in alphabetical order
>>>> +obj-$(CONFIG_LMP91000) += lmp91000.o
>>>> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
>>>> new file mode 100644
>>>> index 000000000000..ec4394581039
>>>> --- /dev/null
>>>> +++ b/drivers/iio/potentiostat/lmp91000.c
>>>> @@ -0,0 +1,397 @@
>>>> +/*
>>>> + * lmp91000.c - Support for Texas Instruments digital potentiostats
>>>> + *
>>>> + * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * TODO: bias voltage + polarity control, and multiple chip support
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/buffer.h>
>>>> +#include <linux/iio/consumer.h>
>>>> +#include <linux/iio/trigger.h>
>>>> +#include <linux/iio/trigger_consumer.h>
>>>> +#include <linux/iio/triggered_buffer.h>
>>>> +
>>>> +#define LMP91000_REG_LOCK            0x01
>>>> +#define LMP91000_REG_TIACN           0x10
>>>> +#define LMP91000_REG_TIACN_GAIN_SHIFT        2
>>>> +
>>>> +#define LMP91000_REG_REFCN           0x11
>>>> +#define LMP91000_REG_REFCN_EXT_REF   0x20
>>>> +#define LMP91000_REG_REFCN_50_ZERO   0x80
>>>> +
>>>> +#define LMP91000_REG_MODECN          0x12
>>>> +#define LMP91000_REG_MODECN_3LEAD    0x03
>>>> +#define LMP91000_REG_MODECN_TEMP     0x07
>>>> +
>>>> +#define LMP91000_DRV_NAME    "lmp91000"
>>>> +
>>>> +static const int lmp91000_tia_gain[] = { 0, 2750, 3500, 7000, 14000, 35000,
>>>> +                                      120000, 350000 };
>>>> +
>>>> +static const int lmp91000_rload[] = { 10, 33, 50, 100 };
>>>> +
>>>> +static const struct regmap_config lmp91000_regmap_config = {
>>>> +     .reg_bits = 8,
>>>> +     .val_bits = 8,
>>>> +};
>>>> +
>>>> +struct lmp91000_data {
>>>> +     struct regmap *regmap;
>>>> +     struct device *dev;
>>>> +
>>>> +     struct iio_trigger *trig;
>>>> +     struct iio_cb_buffer *cb_buffer;
>>>> +
>>>> +     struct completion completion;
>>>> +     u8 chan_select;
>>>> +
>>>> +     u32 buffer[4]; /* 64-bit data + 64-bit timestamp */
>>>> +};
>>>> +
>>>> +static const struct iio_chan_spec lmp91000_channels[] = {
>>>> +     { /* chemical channel mV */
>>>> +             .type = IIO_VOLTAGE,
>>>> +             .channel = 0,
>>>> +             .indexed = 1,
>>>> +             .address = LMP91000_REG_MODECN_3LEAD,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>> +             .scan_index = 0,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 32,
>>>> +                     .storagebits = 32,
>>>> +             },
>>>> +     },
>>>> +     IIO_CHAN_SOFT_TIMESTAMP(1),
>>>> +     { /* temperature channel mV */
>>>> +             .type = IIO_VOLTAGE,
>>>
>>> why not IIO_TEMP?
>>
>> Because isn't linear enough. and scaling value wouldn't help... Thoughts?
>
> Actually second look in the datasheet it is mostly linear.. probably
> can add an offset and scaling value.
>

Digging deeper into the datasheet ->
http://www.ti.com/lit/ds/symlink/lmp91000.pdf

"Although the temperature sensor is very linear, its response does
have a slight downward parabolic shape. This shape is very accurately
reflected in Table 1. "

So don't think we can really convert to IIO_TEMP since it isn't
completely linear scaling... Any thoughts on this?

> Thanks,
>
> Matt
>
>>
>>>
>>>> +             .channel = 1,
>>>> +             .indexed = 1,
>>>> +             .address = LMP91000_REG_MODECN_TEMP,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>> +             .scan_index = -1,
>>>> +     },
>>>> +};
>>>> +
>>>> +static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
>>>> +{
>>>> +     int state, ret;
>>>> +
>>>> +     ret = regmap_read(data->regmap, LMP91000_REG_MODECN, &state);
>>>> +     if (ret)
>>>> +             return -EINVAL;
>>>
>>> simply return ret?
>>
>> No real reason.
>>>
>>>> +
>>>> +     ret = regmap_write(data->regmap, LMP91000_REG_MODECN, channel);
>>>> +     if (ret)
>>>> +             return -EINVAL;
>>>> +
>>>> +     /* delay till first temperature reading is complete */
>>>> +     if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
>>>> +             usleep_range(3000, 4000);
>>>> +
>>>> +     data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
>>>> +
>>>> +     iio_trigger_poll_chained(data->trig);
>>>> +
>>>> +     ret = wait_for_completion_timeout(&data->completion, HZ);
>>>> +     reinit_completion(&data->completion);
>>>> +
>>>> +     if (!ret)
>>>> +             return -ETIMEDOUT;
>>>> +
>>>> +     *val = data->buffer[data->chan_select];
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static irqreturn_t lmp91000_buffer_handler(int irq, void *private)
>>>> +{
>>>> +     struct iio_poll_func *pf = private;
>>>> +     struct iio_dev *indio_dev = pf->indio_dev;
>>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>>> +     int ret, val;
>>>> +
>>>> +     memset(data->buffer, 0, sizeof(data->buffer));
>>>> +
>>>> +     ret = lmp91000_read(data, LMP91000_REG_MODECN_3LEAD, &val);
>>>> +     if (!ret) {
>>>> +             data->buffer[0] = val;
>>>> +             iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>>> +                                                iio_get_time_ns(indio_dev));
>>>> +     }
>>>> +
>>>> +     iio_trigger_notify_done(indio_dev->trig);
>>>> +
>>>> +     return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int lmp91000_read_raw(struct iio_dev *indio_dev,
>>>> +                          struct iio_chan_spec const *chan,
>>>> +                          int *val, int *val2, long mask)
>>>> +{
>>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>>> +     int ret;
>>>> +
>>>> +     if (mask != IIO_CHAN_INFO_RAW)
>>>> +             return -EINVAL;
>>>> +
>>>> +     ret = iio_channel_start_all_cb(data->cb_buffer);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     ret = lmp91000_read(data, chan->address, val);
>>>> +
>>>> +     iio_channel_stop_all_cb(data->cb_buffer);
>>>> +
>>>> +     if (!ret)
>>>> +             return IIO_VAL_INT;
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static const struct iio_info lmp91000_info = {
>>>> +     .driver_module = THIS_MODULE,
>>>> +     .read_raw = lmp91000_read_raw,
>>>> +};
>>>> +
>>>> +static int lmp91000_read_config(struct lmp91000_data *data)
>>>> +{
>>>> +     struct device *dev = data->dev;
>>>> +     struct device_node *np = dev->of_node;
>>>> +     unsigned int reg, val;
>>>> +     int i, ret;
>>>> +
>>>> +     ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>>>> +     if (ret) {
>>>> +             if (of_property_read_bool(np, "ti,external-tia-resistor"))
>>>> +                     val = 0;
>>>> +             else {
>>>> +                     dev_err(dev, "no ti,tia-gain-ohm defined");
>>>> +                     return ret;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     ret = -EINVAL;
>>>
>>> instead of fiddling with ret, one could check i >=
>>> ARRAY_SIZE(lmp91000_tia_gain) after the loop, matter of taste
>>
>> No issue with this.
>>>
>>>> +     for (i = 0; i < ARRAY_SIZE(lmp91000_tia_gain); i++) {
>>>> +             if (lmp91000_tia_gain[i] == val) {
>>>> +                     reg = i << LMP91000_REG_TIACN_GAIN_SHIFT;
>>>> +                     ret = 0;
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (ret) {
>>>> +             dev_err(dev, "invalid ti,tia-gain-ohm %d\n", val);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     ret = of_property_read_u32(np, "ti,rload-ohm", &val);
>>>> +     if (ret) {
>>>> +             val = 100;
>>>> +             dev_info(dev, "no ti,rload-ohm defined, default to %d\n", val);
>>>> +     }
>>>> +
>>>> +     ret = -EINVAL;
>>>> +     for (i = 0; i < ARRAY_SIZE(lmp91000_rload); i++) {
>>>> +             if (lmp91000_rload[i] == val) {
>>>> +                     reg |= i;
>>>> +                     ret = 0;
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (ret) {
>>>> +             dev_err(dev, "invalid ti,rload-ohm %d\n", val);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
>>>> +     regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
>>>> +     regmap_write(data->regmap, LMP91000_REG_REFCN, LMP91000_REG_REFCN_EXT_REF
>>>> +                                     | LMP91000_REG_REFCN_50_ZERO);
>>>> +     regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
>>>
>>> no retval checking
>>
>> Have no issues  with this as well!
>>>
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int lmp91000_buffer_cb(const void *val, void *private)
>>>> +{
>>>> +     struct iio_dev *indio_dev = private;
>>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>>> +
>>>> +     data->buffer[data->chan_select] = *((int *)val);
>>>> +     complete_all(&data->completion);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct iio_trigger_ops lmp91000_trigger_ops = {
>>>> +     .owner = THIS_MODULE,
>>>> +};
>>>> +
>>>
>>> drop newline
>>>
>>>> +
>>>> +static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
>>>> +{
>>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>>> +
>>>> +     return iio_channel_start_all_cb(data->cb_buffer);
>>>> +}
>>>> +
>>>> +static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
>>>> +{
>>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>>> +
>>>> +     iio_channel_stop_all_cb(data->cb_buffer);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
>>>> +     .preenable = lmp91000_buffer_preenable,
>>>> +     .postenable = iio_triggered_buffer_postenable,
>>>> +     .predisable = lmp91000_buffer_predisable,
>>>> +};
>>>> +
>>>> +static int lmp91000_probe(struct i2c_client *client,
>>>> +                       const struct i2c_device_id *id)
>>>> +{
>>>> +     struct device *dev = &client->dev;
>>>> +     struct lmp91000_data *data;
>>>> +     struct iio_dev *indio_dev;
>>>> +     int ret;
>>>> +
>>>> +     indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>>> +     if (!indio_dev)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     indio_dev->info = &lmp91000_info;
>>>> +     indio_dev->channels = lmp91000_channels;
>>>> +     indio_dev->num_channels = ARRAY_SIZE(lmp91000_channels);
>>>> +     indio_dev->name = LMP91000_DRV_NAME;
>>>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>>>> +     i2c_set_clientdata(client, indio_dev);
>>>> +
>>>> +     data = iio_priv(indio_dev);
>>>> +     data->dev = dev;
>>>> +     data->regmap = devm_regmap_init_i2c(client, &lmp91000_regmap_config);
>>>> +     if (IS_ERR(data->regmap)) {
>>>> +             dev_err(dev, "regmap initialization failed.\n");
>>>> +             return PTR_ERR(data->regmap);
>>>> +     }
>>>> +
>>>> +     data->trig = devm_iio_trigger_alloc(data->dev, "%s-mux%d",
>>>> +                                         indio_dev->name, indio_dev->id);
>>>> +     if (!data->trig) {
>>>> +             dev_err(dev, "cannot allocate iio trigger.\n");
>>>> +             return -ENOMEM;
>>>> +     }
>>>> +
>>>> +     data->trig->ops = &lmp91000_trigger_ops;
>>>> +     data->trig->dev.parent = dev;
>>>> +     init_completion(&data->completion);
>>>> +
>>>> +     ret = lmp91000_read_config(data);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>>> +                                      &lmp91000_buffer_handler,
>>>> +                                      &lmp91000_buffer_setup_ops);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     ret = iio_device_register(indio_dev);
>>>> +     if (ret)
>>>> +             goto error_unreg_buffer;
>>>> +
>>>> +     data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
>>>> +                                              indio_dev);
>>>> +     if (IS_ERR(data->cb_buffer)) {
>>>> +             if (PTR_ERR(data->cb_buffer) == -ENODEV)
>>>> +                     ret = -EPROBE_DEFER;
>>>> +             else
>>>> +                     ret = PTR_ERR(data->cb_buffer);
>>>> +
>>>> +             goto error_unreg_device;
>>>> +     }
>>>> +
>>>> +     ret = iio_trigger_register(data->trig);
>>>> +     if (ret) {
>>>> +             dev_err(dev, "cannot register iio trigger.\n");
>>>> +             goto error_unreg_cb_buffer;
>>>> +     }
>>>> +
>>>> +     return iio_trigger_set_immutable(iio_channel_cb_get_iio_dev(data->cb_buffer),
>>>> +                                      data->trig);
>>>> +
>>>> +error_unreg_cb_buffer:
>>>> +     iio_channel_release_all_cb(data->cb_buffer);
>>>> +
>>>> +error_unreg_device:
>>>> +     iio_device_unregister(indio_dev);
>>>> +
>>>> +error_unreg_buffer:
>>>> +     iio_triggered_buffer_cleanup(indio_dev);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int lmp91000_remove(struct i2c_client *client)
>>>> +{
>>>> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>>> +
>>>> +     iio_device_unregister(indio_dev);
>>>> +
>>>> +     iio_channel_stop_all_cb(data->cb_buffer);
>>>> +     iio_channel_release_all_cb(data->cb_buffer);
>>>> +
>>>> +     iio_triggered_buffer_cleanup(indio_dev);
>>>> +     iio_trigger_unregister(data->trig);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id lmp91000_of_match[] = {
>>>> +     { .compatible = "ti,lmp91000", },
>>>> +     { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, lmp91000_of_match);
>>>> +
>>>> +static const struct i2c_device_id lmp91000_id[] = {
>>>> +     { "lmp91000", 0 },
>>>> +     {}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(i2c, lmp91000_id);
>>>> +
>>>> +static struct i2c_driver lmp91000_driver = {
>>>> +     .driver = {
>>>> +             .name = LMP91000_DRV_NAME,
>>>> +             .of_match_table = of_match_ptr(lmp91000_of_match),
>>>> +     },
>>>> +     .probe = lmp91000_probe,
>>>> +     .remove = lmp91000_remove,
>>>> +     .id_table = lmp91000_id,
>>>> +};
>>>> +module_i2c_driver(lmp91000_driver);
>>>> +
>>>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>>>> +MODULE_DESCRIPTION("LMP91000 digital potentiostat");
>>>> +MODULE_LICENSE("GPL");
>>>>
>>>
>>> --
>>>
>>> Peter Meerwald-Stadler
>>> +43-664-2444418 (mobile)
