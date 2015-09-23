Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:36425 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935015AbbIWDms (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2015 23:42:48 -0400
Received: by lacao8 with SMTP id ao8so12581432lac.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2015 20:42:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55FF02CB.4050101@kernel.org>
References: <1442201174-10975-1-git-send-email-mranostay@gmail.com>
	<1442201174-10975-5-git-send-email-mranostay@gmail.com>
	<alpine.DEB.2.02.1509141032260.16992@pmeerw.net>
	<55FF02CB.4050101@kernel.org>
Date: Tue, 22 Sep 2015 20:42:46 -0700
Message-ID: <CAKzfze-7R+TVFvejnoUDNYuyv7Or3xTw=5_rF7-O_T1S3m3rHg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: chemical: add SGX VZ89x VOC sensor support
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 20, 2015 at 12:02 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 14/09/15 09:35, Peter Meerwald wrote:
>>
>>> Add support for VZ89X sensors VOC and CO2 reporting channels in
>>> percentage which can be converted to part per million.
>>
>> can you make the proper changes for _CONCENTRATION etc. also for
>> tools/iio/iio_event_monitor.c?
> Rather than going through another complete version of this series,
> would you mind doing that as a follow up patch?
I'll do it as a follow on unless see below....  should IIO_RESISTANCE
to iio_event_monitor.c be added as well?


>
>>
>> and comment below
> I've fixed this up as chemical sensors when applying.

Actually have found a HW bug that affects one in like 1000 reads. Need
to submit one more series to workaround it.... so should I add the
previous to the next version?

>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>> ---
>>>  .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |   7 +
>>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>>  drivers/iio/Kconfig                                |   1 +
>>>  drivers/iio/Makefile                               |   1 +
>>>  drivers/iio/chemical/Kconfig                       |  15 ++
>>>  drivers/iio/chemical/Makefile                      |   6 +
>>>  drivers/iio/chemical/vz89x.c                       | 237 +++++++++++++++++++++
>>>  7 files changed, 268 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>>>  create mode 100644 drivers/iio/chemical/Kconfig
>>>  create mode 100644 drivers/iio/chemical/Makefile
>>>  create mode 100644 drivers/iio/chemical/vz89x.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>>> new file mode 100644
>>> index 0000000..c0c1ea9
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>>> @@ -0,0 +1,7 @@
>>> +What:               /sys/bus/iio/devices/iio:deviceX/in_concentration_VOC_short_raw
>>> +Date:               September 2015
>>> +KernelVersion:      4.3
>>> +Contact:    Matt Ranostay <mranostay@gmail.com>
>>> +Description:
>>> +            Get the raw calibration VOC value from the sensor.
>>> +            This value has little application outside of calibration.
>>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>> index d77d412..a550216 100644
>>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>> @@ -88,6 +88,7 @@ ricoh,rs5c372b             I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>>>  ricoh,rv5c386               I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>>>  ricoh,rv5c387a              I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>>>  samsung,24ad0xd1    S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
>>> +sgx,vz89x           SGX Sensortech VZ89X Sensors
>>>  sii,s35390a         2-wire CMOS real-time clock
>>>  skyworks,sky81452   Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>>>  st-micro,24c256             i2c serial eeprom  (24cxx)
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>> index 4011eff..9664e9c 100644
>>> --- a/drivers/iio/Kconfig
>>> +++ b/drivers/iio/Kconfig
>>> @@ -61,6 +61,7 @@ config IIO_CONSUMERS_PER_TRIGGER
>>>  source "drivers/iio/accel/Kconfig"
>>>  source "drivers/iio/adc/Kconfig"
>>>  source "drivers/iio/amplifiers/Kconfig"
>>> +source "drivers/iio/chemical/Kconfig"
>>>  source "drivers/iio/common/Kconfig"
>>>  source "drivers/iio/dac/Kconfig"
>>>  source "drivers/iio/frequency/Kconfig"
>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>> index 698afc2..2288684 100644
>>> --- a/drivers/iio/Makefile
>>> +++ b/drivers/iio/Makefile
>>> @@ -14,6 +14,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>>>  obj-y += accel/
>>>  obj-y += adc/
>>>  obj-y += amplifiers/
>>> +obj-y += chemical/
>>>  obj-y += common/
>>>  obj-y += dac/
>>>  obj-y += gyro/
>>> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
>>> new file mode 100644
>>> index 0000000..04906af
>>> --- /dev/null
>>> +++ b/drivers/iio/chemical/Kconfig
>>> @@ -0,0 +1,15 @@
>>> +#
>>> +# Chemical sensors
>>> +#
>>> +
>>> +menu "Indoor Air Quality sensors"
>>
>> the comment above says 'Chemical sensors', the menu item 'Indoor Air
>> Quality sensors' -- I guess an outdoor sensor would fit here as well...
> Lets just go with Chemical sensors.



>>
>>> +
>>> +config VZ89X
>>> +    tristate "SGX Sensortech MiCS VZ89X VOC sensor"
>>> +    depends on I2C
>>> +    help
>>> +      Say Y here to build I2C interface support for the SGX
>>> +      Sensortech MiCS VZ89X VOC (Volatile Organic Compounds)
>>> +      sensors
>>> +
>>> +endmenu
>>> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
>>> new file mode 100644
>>> index 0000000..7292f2d
>>> --- /dev/null
>>> +++ b/drivers/iio/chemical/Makefile
>>> @@ -0,0 +1,6 @@
>>> +#
>>> +# Makefile for IIO chemical sensors
>>> +#
>>> +
>>> +# When adding new entries keep the list in alphabetical order
>>> +obj-$(CONFIG_VZ89X)         += vz89x.o
>>> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
>>> new file mode 100644
>>> index 0000000..b454200
>>> --- /dev/null
>>> +++ b/drivers/iio/chemical/vz89x.c
>>> @@ -0,0 +1,237 @@
>>> +/*
>>> + * vz89x.c - Support for SGX Sensortech MiCS VZ89X VOC sensors
>>> + *
>>> + * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
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
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/init.h>
>>> +#include <linux/i2c.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +#define VZ89X_REG_MEASUREMENT               0x09
>>> +#define VZ89X_REG_MEASUREMENT_SIZE  6
>>> +
>>> +#define VZ89X_VOC_CO2_IDX           0
>>> +#define VZ89X_VOC_SHORT_IDX         1
>>> +#define VZ89X_VOC_TVOC_IDX          2
>>> +#define VZ89X_VOC_RESISTANCE_IDX    3
>>> +
>>> +struct vz89x_data {
>>> +    struct i2c_client *client;
>>> +    struct mutex lock;
>>> +    unsigned long last_update;
>>> +
>>> +    u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
>>> +};
>>> +
>>> +static const struct iio_chan_spec vz89x_channels[] = {
>>> +    {
>>> +            .type = IIO_CONCENTRATION,
>>> +            .channel2 = IIO_MOD_CO2,
>>> +            .modified = 1,
>>> +            .info_mask_separate =
>>> +                    BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),
>>> +            .address = VZ89X_VOC_CO2_IDX,
>>> +    },
>>> +    {
>>> +            .type = IIO_CONCENTRATION,
>>> +            .channel2 = IIO_MOD_VOC,
>>> +            .modified = 1,
>>> +            .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +            .address = VZ89X_VOC_SHORT_IDX,
>>> +            .extend_name = "short",
>>> +    },
>>> +    {
>>> +            .type = IIO_CONCENTRATION,
>>> +            .channel2 = IIO_MOD_VOC,
>>> +            .modified = 1,
>>> +            .info_mask_separate =
>>> +                    BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),
>>> +            .address = VZ89X_VOC_TVOC_IDX,
>>> +    },
>>> +    {
>>> +            .type = IIO_RESISTANCE,
>>> +            .info_mask_separate =
>>> +                    BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>> +            .address = VZ89X_VOC_RESISTANCE_IDX,
>>> +    },
>>> +};
>>> +
>>> +static IIO_CONST_ATTR(in_concentration_co2_scale, "0.00000698689");
>>> +static IIO_CONST_ATTR(in_concentration_voc_scale, "0.00000000436681223");
>>> +
>>> +static struct attribute *vz89x_attributes[] = {
>>> +    &iio_const_attr_in_concentration_co2_scale.dev_attr.attr,
>>> +    &iio_const_attr_in_concentration_voc_scale.dev_attr.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group vz89x_attrs_group = {
>>> +    .attrs = vz89x_attributes,
>>> +};
>>> +
>>> +static int vz89x_get_measurement(struct vz89x_data *data)
>>> +{
>>> +    int ret;
>>> +    int i;
>>> +
>>> +    /* sensor can only be polled once a second max per datasheet */
>>> +    if (!time_after(jiffies, data->last_update + HZ))
>>> +            return 0;
>>> +
>>> +    ret = i2c_smbus_write_word_data(data->client,
>>> +                                    VZ89X_REG_MEASUREMENT, 0);
>>> +    if (ret < 0)
>>> +            return ret;
>>> +
>>> +    for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
>>> +            ret = i2c_smbus_read_byte(data->client);
>>> +            if (ret < 0)
>>> +                    return ret;
>>> +            data->buffer[i] = ret;
>>> +    }
>>> +
>>> +    data->last_update = jiffies;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int vz89x_get_resistance_reading(struct vz89x_data *data)
>>> +{
>>> +    u8 *buf = &data->buffer[VZ89X_VOC_TVOC_IDX];
>>> +
>>> +    return buf[0] | (buf[1] << 8) | (buf[2] << 16);
>>> +}
>>> +
>>> +static int vz89x_read_raw(struct iio_dev *indio_dev,
>>> +                      struct iio_chan_spec const *chan, int *val,
>>> +                      int *val2, long mask)
>>> +{
>>> +    struct vz89x_data *data = iio_priv(indio_dev);
>>> +    int ret = -EINVAL;
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +            mutex_lock(&data->lock);
>>> +            ret = vz89x_get_measurement(data);
>>> +            mutex_unlock(&data->lock);
>>> +
>>> +            if (ret)
>>> +                    return ret;
>>> +
>>> +            switch (chan->address) {
>>> +            case VZ89X_VOC_CO2_IDX:
>>> +            case VZ89X_VOC_SHORT_IDX:
>>> +            case VZ89X_VOC_TVOC_IDX:
>>> +                    *val = data->buffer[chan->address];
>>> +                    return IIO_VAL_INT;
>>> +            case VZ89X_VOC_RESISTANCE_IDX:
>>> +                    *val = vz89x_get_resistance_reading(data);
>>> +                    return IIO_VAL_INT;
>>> +            default:
>>> +                    return -EINVAL;
>>> +            }
>>> +            break;
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +            switch (chan->type) {
>>> +            case IIO_RESISTANCE:
>>> +                    *val = 10;
>>> +                    return IIO_VAL_INT;
>>> +            default:
>>> +                    return -EINVAL;
>>> +            }
>>> +            break;
>>> +    case IIO_CHAN_INFO_OFFSET:
>>> +            switch (chan->address) {
>>> +            case VZ89X_VOC_CO2_IDX:
>>> +                    *val = 44;
>>> +                    *val2 = 250000;
>>> +                    return IIO_VAL_INT_PLUS_MICRO;
>>> +            case VZ89X_VOC_TVOC_IDX:
>>> +                    *val = -13;
>>> +                    return IIO_VAL_INT;
>>> +            default:
>>> +                    return -EINVAL;
>>> +            }
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static const struct iio_info vz89x_info = {
>>> +    .attrs          = &vz89x_attrs_group,
>>> +    .read_raw       = vz89x_read_raw,
>>> +    .driver_module  = THIS_MODULE,
>>> +};
>>> +
>>> +static int vz89x_probe(struct i2c_client *client,
>>> +                   const struct i2c_device_id *id)
>>> +{
>>> +    struct iio_dev *indio_dev;
>>> +    struct vz89x_data *data;
>>> +
>>> +    if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
>>> +                                 I2C_FUNC_SMBUS_BYTE))
>>> +            return -ENODEV;
>>> +
>>> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>> +    if (!indio_dev)
>>> +            return -ENOMEM;
>>> +
>>> +    data = iio_priv(indio_dev);
>>> +    i2c_set_clientdata(client, indio_dev);
>>> +    data->client = client;
>>> +    data->last_update = jiffies - HZ;
>>> +    mutex_init(&data->lock);
>>> +
>>> +    indio_dev->dev.parent = &client->dev;
>>> +    indio_dev->info = &vz89x_info,
>>> +    indio_dev->name = dev_name(&client->dev);
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +
>>> +    indio_dev->channels = vz89x_channels;
>>> +    indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
>>> +
>>> +    return devm_iio_device_register(&client->dev, indio_dev);
>>> +}
>>> +
>>> +static const struct i2c_device_id vz89x_id[] = {
>>> +    { "vz89x", 0 },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, vz89x_id);
>>> +
>>> +static const struct of_device_id vz89x_dt_ids[] = {
>>> +    { .compatible = "sgx,vz89x" },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>>> +
>>> +static struct i2c_driver vz89x_driver = {
>>> +    .driver = {
>>> +            .name   = "vz89x",
>>> +            .of_match_table = of_match_ptr(vz89x_dt_ids),
>>> +    },
>>> +    .probe = vz89x_probe,
>>> +    .id_table = vz89x_id,
>>> +};
>>> +module_i2c_driver(vz89x_driver);
>>> +
>>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>>> +MODULE_DESCRIPTION("SGX Sensortech MiCS VZ89X VOC sensors");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
>
