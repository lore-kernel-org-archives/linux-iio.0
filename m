Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcGET57 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 15:57:59 -0400
Subject: Re: [RFC 2/2] iio: potentiostat: add LMP91000 support
To: Matt Ranostay <mranostay@gmail.com>
References: <1467497127-32431-1-git-send-email-mranostay@gmail.com>
 <1467497127-32431-3-git-send-email-mranostay@gmail.com>
 <5e18f0c4-c761-1884-9109-b22dbf8574ff@kernel.org>
 <CAKzfze9oskFmyNWeoU+pHhnXEx0kLfZryKKLyud-dULhoUZYeA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c4ace0a4-95fd-199d-3d21-f462dac6d1ea@kernel.org>
Date: Tue, 5 Jul 2016 20:57:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze9oskFmyNWeoU+pHhnXEx0kLfZryKKLyud-dULhoUZYeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/16 22:59, Matt Ranostay wrote:
> On Sun, Jul 3, 2016 at 6:41 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 02/07/16 23:05, Matt Ranostay wrote:
>>> Add support for the LMP91000 potentiostat which is used for chemical
>>> sensing applications.
>> Step one.  I had to look up what a potentiostat was... So perhaps a brief
>> idiots guide in the intro to the patch?
>> :)
>>
>> This clearly raises some interesting questions... I'll put comments on that
>> in the cover letter and more or less stick to reviewing code alone here.
>>
>>
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>> ---
>>>  .../bindings/iio/potentiostat/lmp91000.txt         |  28 ++
>>>  drivers/iio/Kconfig                                |   1 +
>>>  drivers/iio/Makefile                               |   1 +
>>>  drivers/iio/potentiostat/Kconfig                   |  21 ++
>>>  drivers/iio/potentiostat/Makefile                  |   6 +
>>>  drivers/iio/potentiostat/lmp91000.c                | 303 +++++++++++++++++++++
>>>  6 files changed, 360 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>>  create mode 100644 drivers/iio/potentiostat/Kconfig
>>>  create mode 100644 drivers/iio/potentiostat/Makefile
>>>  create mode 100644 drivers/iio/potentiostat/lmp91000.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>> new file mode 100644
>>> index 000000000000..636c548cedee
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>> @@ -0,0 +1,28 @@
>>> +* Texas Instruments LMP91000 potentiostat
>>> +
>>> +http://www.ti.com/lit/ds/symlink/lmp91000.pdf
>>> +
>>> +Required properties:
>>> +
>>> +  - compatible: should be "ti,lmp91000"
>>> +  - reg: the I2C address of the device
>>> +  - io-channels: the phandle and channel of the iio provider
>>> +
>>> +Optional properties:
>>> +
>>> +  - ti,tia-gain-ohm: ohm value on the feedback loop for the transimpedance
>>> +    amplifier. Must be 0 (external resistor, default), 2750, 3500, 7000, 14000,
>>> +    35000, 120000, or 350000 ohms.
>> Better perhaps to have an explicit entry to say use the external resistor?
>> If nothing else, it ought to be infinite resistance for that not 0.
>>
> 
> 
>> Also does it ever make sense to change this at runtime or is it a case of
>> being matched to a particular probe?
> 
> I mean it doesn't in theory damage anything but probably an un-needed
> runtime configuration complexity.
> 
>>> +
>>> +  - ti,rload-ohm: ohm value of the internal resistor load applied to the gas
>>> +    sensor. Must be 10, 33, 50, or 100 (default) ohms.
>> Again, make sense to ever change at runtime?  Guessing there is still a best
>> value for a given probe even if sometimes it might want 'tweaking'.
>>
>> No idea - never even seen one of these probes that I know of ;)
> 
> Actually the load resistor value is documented in the sensor
> datasheet, and never changes.
> An incorrect value could in theory shorter the life of the sensor.
Cool. Perhaps expand the description to make this clear?
> 
>>> +
>>> +Example:
>>> +
>>> +lmp91000@48 {
>>> +     compatible = "ti,lmp91000";
>>> +     reg = <0x48>;
>>> +     ti,tia-gain-ohm = <7500>;
>>> +     ti,rload = <100>;
>>> +     io-channels = <&adc1x1s 0>;
>>> +};
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>> index 6743b18194fb..a31a8cf2c330 100644
>>> --- a/drivers/iio/Kconfig
>>> +++ b/drivers/iio/Kconfig
>>> @@ -87,6 +87,7 @@ if IIO_TRIGGER
>>>     source "drivers/iio/trigger/Kconfig"
>>>  endif #IIO_TRIGGER
>>>  source "drivers/iio/potentiometer/Kconfig"
>>> +source "drivers/iio/potentiostat/Kconfig"
>>>  source "drivers/iio/pressure/Kconfig"
>>>  source "drivers/iio/proximity/Kconfig"
>>>  source "drivers/iio/temperature/Kconfig"
>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>> index 87e4c4369e2f..2b6e2762a886 100644
>>> --- a/drivers/iio/Makefile
>>> +++ b/drivers/iio/Makefile
>>> @@ -29,6 +29,7 @@ obj-y += light/
>>>  obj-y += magnetometer/
>>>  obj-y += orientation/
>>>  obj-y += potentiometer/
>>> +obj-y += potentiostat/
>> I wonder if grouping analog front ends in at subdirectory above this
>> might make sense?  Feels like we may get some more.  We already have
>> 'amplifiers' that could be moved into that directory as well.
>>
>> Or for now we could just have both this and amplifiers in an
>> 'Analog front ends' directory and break them up into their own directories
>> if we get too many to handle in a single dir in the future?  I don't really
>> mind but would like this an amplifiers grouped together in some way.
>>
>>>  obj-y += pressure/
>>>  obj-y += proximity/
>>>  obj-y += temperature/
>>> diff --git a/drivers/iio/potentiostat/Kconfig b/drivers/iio/potentiostat/Kconfig
>>> new file mode 100644
>>> index 000000000000..591682c05ae9
>>> --- /dev/null
>>> +++ b/drivers/iio/potentiostat/Kconfig
>>> @@ -0,0 +1,21 @@
>>> +#
>>> +# Potentiostat drivers
>>> +#
>>> +# When adding new entries keep the list in alphabetical order
>>> +
>>> +menu "Digital potentiostats"
>>> +
>>> +config LMP91000
>>> +     tristate "Texas Instruments LMP91000 potentiostat driver"
>>> +     depends on I2C
>>> +     select REGMAP_I2C
>>> +     select IIO_BUFFER
>>> +     select IIO_TRIGGERED_BUFFER
>>> +     help
>>> +       Say yes here to build support for the Texas Instruments
>>> +       LMP91000 digital potentiostat chip.
>>> +
>>> +       To compile this driver as a module, choose M here: the
>>> +       module will be called lmp91000
>>> +
>>> +endmenu
>>> diff --git a/drivers/iio/potentiostat/Makefile b/drivers/iio/potentiostat/Makefile
>>> new file mode 100644
>>> index 000000000000..64d315ef4449
>>> --- /dev/null
>>> +++ b/drivers/iio/potentiostat/Makefile
>>> @@ -0,0 +1,6 @@
>>> +#
>>> +# Makefile for industrial I/O potentiostat drivers
>>> +#
>>> +
>>> +# When adding new entries keep the list in alphabetical order
>>> +obj-$(CONFIG_LMP91000) += lmp91000.o
>>> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
>>> new file mode 100644
>>> index 000000000000..fe90172eac28
>>> --- /dev/null
>>> +++ b/drivers/iio/potentiostat/lmp91000.c
>>> @@ -0,0 +1,303 @@
>>> +/*
>>> + * lmp91000.c - Support for Texas Instruments digital potentiostats
>>> + *
>>> + * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * TODO: bias voltage + polarity control, and multiple chip support
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/of.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/consumer.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +
>>> +#define LMP91000_REG_LOCK            0x01
>>> +#define LMP91000_REG_TIACN           0x10
>>> +#define LMP91000_REG_TIACN_GAIN_SHIFT        2
>>> +
>>> +#define LMP91000_REG_REFCN           0x11
>>> +#define LMP91000_REG_REFCN_EXT_REF   0x20
>>> +#define LMP91000_REG_REFCN_50_ZERO   0x80
>>> +
>>> +#define LMP91000_REG_MODECN          0x12
>>> +#define LMP91000_REG_MODECN_3LEAD    0x03
>>> +#define LMP91000_REG_MODECN_TEMP     0x07
>>> +
>>> +#define LMP91000_DRV_NAME    "lmp91000"
>>> +
>>> +static const int lmp91000_tia_gain[] = { 0, 2750, 3500, 7000, 14000, 35000,
>>> +                                      120000, 350000 };
>>> +
>>> +static const int lmp91000_rload[] = { 10, 33, 50, 100 };
>>> +
>>> +static const struct regmap_config lmp91000_regmap_config = {
>>> +     .reg_bits = 8,
>>> +     .val_bits = 8,
>>> +};
>>> +
>>> +struct lmp91000_data {
>>> +     struct regmap *regmap;
>>> +     struct device *dev;
>>> +     struct iio_channel *vout_chan;
>>> +
>>> +     u8 buffer[16]; /* 32-bit data + 32-bit padding + 64-bit timestamp */
>>> +};
>>> +
>>> +static const struct iio_chan_spec lmp91000_channels[] = {
>>> +     { /* chemical channel mV */
>>> +             .type = IIO_VOLTAGE,
>>> +             .channel = 0,
>>> +             .indexed = 1,
>>> +             .address = LMP91000_REG_MODECN_3LEAD,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +             .scan_index = 0,
>>> +             .scan_type = {
>>> +                     .sign = 's',
>>> +                     .realbits = 32,
>>> +                     .storagebits = 32,
>>> +             },
>>> +     },
>>> +     IIO_CHAN_SOFT_TIMESTAMP(1),
>>> +     { /* temperature channel mV */
>>> +             .type = IIO_VOLTAGE,
>>> +             .channel = 1,
>>> +             .indexed = 1,
>>> +             .address = LMP91000_REG_MODECN_TEMP,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +             .scan_index = -1,
>>> +     },
>>> +};
>>> +
>>> +static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
>>> +{
>>> +     int state, ret;
>>> +
>>> +     ret = regmap_read(data->regmap, LMP91000_REG_MODECN, &state);
>>> +     if (ret)
>>> +             return -EINVAL;
>>> +
>>> +     ret = regmap_write(data->regmap, LMP91000_REG_MODECN, channel);
>>> +     if (ret)
>>> +             return -EINVAL;
>>> +
>>> +     /* delay till first temperature reading is complete */
>>> +     if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
>>> +             usleep_range(3000, 4000);
>>> +
>>> +     ret = iio_read_channel_raw(data->vout_chan, val);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static irqreturn_t lmp91000_trigger_handler(int irq, void *private)
>>> +{
>>> +     struct iio_poll_func *pf = private;
>>> +     struct iio_dev *indio_dev = pf->indio_dev;
>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>> +     int ret, val;
>>> +
>>> +     ret = lmp91000_read(data, LMP91000_REG_MODECN_3LEAD, &val);
>>> +     if (!ret) {
>>> +             *((int *) data->buffer) = val;
>>> +             iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>> +                                                iio_get_time_ns());
>>> +     }
>>> +
>>> +     iio_trigger_notify_done(indio_dev->trig);
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int lmp91000_read_raw(struct iio_dev *indio_dev,
>>> +                          struct iio_chan_spec const *chan,
>>> +                          int *val, int *val2, long mask)
>>> +{
>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>> +     int ret;
>>> +
>>> +     if (mask != IIO_CHAN_INFO_RAW)
>>> +             return -EINVAL;
>>> +
>>> +     if (iio_device_claim_direct_mode(indio_dev))
>>> +             return -EBUSY;
>>> +
>>> +     ret = lmp91000_read(data, chan->address, val);
>>> +     if (!ret)
>>> +             ret = IIO_VAL_INT;
>>> +
>>> +     iio_device_release_direct_mode(indio_dev);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static const struct iio_info lmp91000_info = {
>>> +     .driver_module = THIS_MODULE,
>>> +     .read_raw = lmp91000_read_raw,
>>> +};
>>> +
>>> +static int lmp91000_read_config(struct lmp91000_data *data)
>>> +{
>>> +     struct device *dev = data->dev;
>>> +     struct device_node *np = dev->of_node;
>>> +     int i, val1, val2, ret;
>>> +
>>> +     ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val1);
>>> +     if (ret) {
>>> +             val1 = 0;
>>> +             dev_info(dev, "no ti,tia-gain-ohm defined, default to external\n");
>>> +     }
>>> +
>>> +     ret = of_property_read_u32(np, "ti,rload-ohm", &val2);
>>> +     if (ret) {
>>> +             val2 = 100;
>>> +             dev_info(dev, "no ti,rload-ohm defined, default to %d\n", val2);
>>> +     }
>>> +
>> I'd reorder this to have the property followed by it's use together.
>> Not terribly keen on variables with names as generic as val1 and val2 either.
>>> +     ret = -EINVAL;
>>> +     for (i = 0; i < ARRAY_SIZE(lmp91000_tia_gain); i++) {
>>> +             if (lmp91000_tia_gain[i] == val1) {
>>> +                     val1 = i;
>>> +                     ret = 0;
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>> +     if (ret) {
>>> +             dev_err(dev, "invalid ti,tia-gain-ohm %d", val1);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = -EINVAL;
>>> +     for (i = 0; i < ARRAY_SIZE(lmp91000_rload); i++) {
>>> +             if (lmp91000_rload[i] == val2) {
>>> +                     val2 = i;
>>> +                     ret = 0;
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>> +     if (ret) {
>>> +             dev_err(dev, "invalid ti,rload-ohm %d", val2);
>>> +             return ret;
>>> +     }
>>> +
>>> +     regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
>> Error handling?
>>> +     regmap_write(data->regmap, LMP91000_REG_TIACN,
>>> +                             (val1 << LMP91000_REG_TIACN_GAIN_SHIFT) | val2);
>>> +     regmap_write(data->regmap, LMP91000_REG_REFCN, LMP91000_REG_REFCN_EXT_REF
>>> +                                     | LMP91000_REG_REFCN_50_ZERO);
>>> +     regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int lmp91000_probe(struct i2c_client *client,
>>> +                       const struct i2c_device_id *id)
>>> +{
>>> +     struct device *dev = &client->dev;
>>> +     struct lmp91000_data *data;
>>> +     struct iio_dev *indio_dev;
>>> +     struct iio_channel *vout_chan;
>>> +     int ret;
>>> +
>>> +     vout_chan = iio_channel_get(dev, NULL);
>>> +     if (IS_ERR(vout_chan))
>>> +             return -EPROBE_DEFER;
>>> +
>>> +     indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>> +     if (!indio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     indio_dev->info = &lmp91000_info;
>>> +     indio_dev->channels = lmp91000_channels;
>>> +     indio_dev->num_channels = ARRAY_SIZE(lmp91000_channels);
>>> +     indio_dev->name = LMP91000_DRV_NAME;
>>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>>> +     i2c_set_clientdata(client, indio_dev);
>>> +
>>> +     data = iio_priv(indio_dev);
>>> +     data->dev = dev;
>>> +     data->vout_chan = vout_chan;
>>> +     data->regmap = devm_regmap_init_i2c(client, &lmp91000_regmap_config);
>>> +     if (IS_ERR(data->regmap)) {
>>> +             dev_err(dev, "regmap initialization failed.\n");
>>> +             return PTR_ERR(data->regmap);
>>> +     }
>>> +
>>> +     ret = lmp91000_read_config(data);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>> +                                      lmp91000_trigger_handler, NULL);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = iio_device_register(indio_dev);
>>> +     if (ret)
>>> +             goto error_unreg_buffer;
>>> +
>>> +     return 0;
>>> +
>>> +error_unreg_buffer:
>>> +     iio_triggered_buffer_cleanup(indio_dev);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int lmp91000_remove(struct i2c_client *client)
>>> +{
>>> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +     struct lmp91000_data *data = iio_priv(indio_dev);
>>> +
>>> +     iio_device_unregister(indio_dev);
>>> +     iio_triggered_buffer_cleanup(indio_dev);
>>> +     iio_channel_release(data->vout_chan);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct of_device_id lmp91000_of_match[] = {
>>> +     { .compatible = "ti,lmp91000", },
>>> +     { },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, lmp91000_of_match);
>>> +
>>> +static const struct i2c_device_id lmp91000_id[] = {
>>> +     { "lmp91000", 0 },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, lmp91000_id);
>>> +
>>> +static struct i2c_driver lmp91000_driver = {
>>> +     .driver = {
>>> +             .name = LMP91000_DRV_NAME,
>>> +             .of_match_table = of_match_ptr(lmp91000_of_match),
>>> +     },
>>> +     .probe = lmp91000_probe,
>>> +     .remove = lmp91000_remove,
>>> +     .id_table = lmp91000_id,
>>> +};
>>> +module_i2c_driver(lmp91000_driver);
>>> +
>>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>>> +MODULE_DESCRIPTION("LMP91000 digital potentiostat");
>>> +MODULE_LICENSE("GPL");
>>>
>>

