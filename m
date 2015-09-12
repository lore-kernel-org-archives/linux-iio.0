Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35776 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbbILXLf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 19:11:35 -0400
Received: by lbpo4 with SMTP id o4so53937568lbp.2
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2015 16:11:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55F3F196.2060101@kernel.org>
References: <1441866654-10381-1-git-send-email-mranostay@gmail.com>
	<1441866654-10381-5-git-send-email-mranostay@gmail.com>
	<55F3F196.2060101@kernel.org>
Date: Sat, 12 Sep 2015 16:11:33 -0700
Message-ID: <CAKzfze9cMW3zwTij5rfPZSVTFhyeHE2B4BoeU1oO5-LZQZLMgA@mail.gmail.com>
Subject: Re: [RFC v4 4/4] iio: chemical: add SGX VZ89x VOC sensor support
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 12, 2015 at 2:34 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/09/15 07:30, Matt Ranostay wrote:
>> Add support for VZ89X sensors VOC and CO2 reporting channels in
>> percentage which can be converted to part per million.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> Coming along nicely.  My main comment in here is that the chemical type
> can easily enough be a modifier (except for the odd 'short' case)
> Hence I think they should be.
>> ---
>>  .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |  30 +++
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>  drivers/iio/Kconfig                                |   1 +
>>  drivers/iio/Makefile                               |   1 +
>>  drivers/iio/chemical/Kconfig                       |  15 ++
>>  drivers/iio/chemical/Makefile                      |   6 +
>>  drivers/iio/chemical/vz89x.c                       | 245 +++++++++++++++++++++
>>  7 files changed, 299 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>>  create mode 100644 drivers/iio/chemical/Kconfig
>>  create mode 100644 drivers/iio/chemical/Makefile
>>  create mode 100644 drivers/iio/chemical/vz89x.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>> new file mode 100644
>> index 0000000..74f2a35
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>> @@ -0,0 +1,30 @@
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_concentration_CO2_raw
>> +Date:                September 2015
>> +KernelVersion:       4.3
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the unscaled, and no offset applied CO2 gas percentage
>> +             value.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_concentration_VOC_short_raw
>> +Date:                September 2015
>> +KernelVersion:       4.3
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the raw calibration VOC value from the sensor.
>> +             This value has little application outside of calibration.
> So is this something that people are likely to need direct access to?
> Perhaps it is better placed in debugfs.
> If not I'd be tempted to do this one with a modifier of IIO_MOD_VOC and
> because it's a wierd bit of non standard abi use an extended name to
> say what it is.

Ok makes sense. Will update in v5

>
> (comments about using modifiers later in review).
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_concentration_tVOC_raw
>> +Date:                September 2015
>> +KernelVersion:       4.3
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the unscaled, and no offset applied total VOC gas
>> +             percentage value.
> I'd imagine anyone would assume that an undecorated VOC would be the total
> so I'd drop the t designation.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
>> +Date:                September 2015
>> +KernelVersion:       4.3
>> +Contact:     Matt Ranostay <mranostay@gmail.com>
>> +Description:
>> +             Get the unscaled sensor resistance value.
> You've already documented this in the main ABI.  Doesn't need to be here.
>
> Actually if you add modifiers for C02 / VOC then they should be in the main
> ABI docs rather than here.  I'd imagine you'll just end up with the
> 'special' raw VOC reading in this doc.
>
>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> index d77d412..a550216 100644
>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> @@ -88,6 +88,7 @@ ricoh,rs5c372b              I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>>  ricoh,rv5c386                I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>>  ricoh,rv5c387a               I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>>  samsung,24ad0xd1     S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
>> +sgx,vz89x            SGX Sensortech VZ89X Sensors
>>  sii,s35390a          2-wire CMOS real-time clock
>>  skyworks,sky81452    Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>>  st-micro,24c256              i2c serial eeprom  (24cxx)
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index 4011eff..9664e9c 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -61,6 +61,7 @@ config IIO_CONSUMERS_PER_TRIGGER
>>  source "drivers/iio/accel/Kconfig"
>>  source "drivers/iio/adc/Kconfig"
>>  source "drivers/iio/amplifiers/Kconfig"
>> +source "drivers/iio/chemical/Kconfig"
>>  source "drivers/iio/common/Kconfig"
>>  source "drivers/iio/dac/Kconfig"
>>  source "drivers/iio/frequency/Kconfig"
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index 698afc2..2288684 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>>  obj-y += accel/
>>  obj-y += adc/
>>  obj-y += amplifiers/
>> +obj-y += chemical/
>>  obj-y += common/
>>  obj-y += dac/
>>  obj-y += gyro/
>> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
>> new file mode 100644
>> index 0000000..8fb44e5
>> --- /dev/null
>> +++ b/drivers/iio/chemical/Kconfig
>> @@ -0,0 +1,15 @@
>> +#
>> +# Chemical sensors
>> +#
>> +
>> +menu "AQI VOC sensors"
> As Peter picked up on, expand your acronyms to make life easy for readers.
> I'm going to hazard a guess that at we'll end up with a more generic
> menu name to cover the other types of related sensors but that can change
> when it needs to.
Ok got it.

>
>> +
>> +config VZ89X
>> +     tristate "SGX Sensortech MiCS VZ89X VOC sensor"
>> +     depends on I2C
>> +     help
>> +       Say Y here to build I2C interface support for the SGX
>> +       Sensortech MiCS VZ89X VOC (Volatile Organic Compounds)
>> +       sensors
>> +
>> +endmenu
>> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
>> new file mode 100644
>> index 0000000..7292f2d
>> --- /dev/null
>> +++ b/drivers/iio/chemical/Makefile
>> @@ -0,0 +1,6 @@
>> +#
>> +# Makefile for IIO chemical sensors
>> +#
>> +
>> +# When adding new entries keep the list in alphabetical order
>> +obj-$(CONFIG_VZ89X)          += vz89x.o
>> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
>> new file mode 100644
>> index 0000000..847f853
>> --- /dev/null
>> +++ b/drivers/iio/chemical/vz89x.c
>> @@ -0,0 +1,245 @@
>> +/*
>> + * vz89x.c - Support for SGX Sensortech MiCS VZ89X VOC sensors
>> + *
>> + * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#define VZ89X_REG_MEASUREMENT                0x09
>> +#define VZ89X_REG_MEASUREMENT_SIZE   6
>> +
>> +#define VZ89X_VOC_CO2_IDX            0
>> +#define VZ89X_VOC_SHORT_IDX          1
>> +#define VZ89X_VOC_TVOC_IDX           2
>> +#define VZ89X_VOC_RESISTANCE_IDX     3
>> +
>> +struct vz89x_data {
>> +     struct i2c_client *client;
>> +     struct mutex lock;
>> +     unsigned long last_update;
>> +
>> +     u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
>> +};
>> +
>> +static const struct iio_chan_spec vz89x_channels[] = {
>> +     {
>> +             .type = IIO_CONCENTRATION,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
>> +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +             .address = VZ89X_VOC_CO2_IDX,
>> +             .extend_name = "CO2",
> I think that the gas types we are likely to seen sensors for are actually
> relatively few in number so we should effectively enforce the ABI by
> using modifiers for these.
>
> IIO_MOD_CO2
> IIO_MOD_VOC
> and for the _short one that's wierd and likely to be device specific so
> using an extended name on top of the VOC modifier is fine.
>
> The other big reason for this is when you get a threshold sensor for these
> (I'm sure one will be along at somepoint).  The event codes do not encode
> the extended name in anyway so both the C02 and VOC sensors would give
> the same code.  Use a modifier and it all becomes straight forward.
>
> Note that adding modifiers also includes updating the bits in tools/iio
> to understand the new modifiers.
>
>> +     },
>> +     {
>> +             .type = IIO_CONCENTRATION,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +             .address = VZ89X_VOC_SHORT_IDX,
>> +             .extend_name = "VOC_short",
>> +     },
>> +     {
>> +             .type = IIO_CONCENTRATION,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
>> +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +             .address = VZ89X_VOC_TVOC_IDX,
>> +             .extend_name = "tVOC",
>> +     },
>> +     {
>> +             .type = IIO_RESISTANCE,
>> +             .info_mask_separate =
>> +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +             .address = VZ89X_VOC_RESISTANCE_IDX,
>> +     },
>> +};
>> +
>> +static int vz89x_get_measurement(struct vz89x_data *data)
>> +{
>> +     int ret;
>> +     int i;
>> +
>> +     /* sensor can only be polled once a second max per datasheet */
>> +     if (!time_after(jiffies, data->last_update + HZ))
>> +             return 0;
>> +
>> +     ret = i2c_smbus_write_word_data(data->client,
>> +                                     VZ89X_REG_MEASUREMENT, 0);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
>> +             ret = i2c_smbus_read_byte(data->client);
>> +             if (ret < 0)
>> +                     return ret;
>> +             data->buffer[i] = ret;
>> +     }
>> +
>> +     data->last_update = jiffies;
>> +
>> +     return 0;
>> +}
>> +
>> +static int vz89x_get_resistance_reading(struct vz89x_data *data)
>> +{
>> +     u8 *buf = &data->buffer[VZ89X_VOC_TVOC_IDX];
>> +
>> +     return buf[0] | ((u16)buf[1] << 8) | ((u32)buf[2] << 16);
>> +}
>> +
>> +static int vz89x_get_channel_scale(struct iio_chan_spec const *chan,
>> +                                int *val, int *val2)
>> +{
>> +     switch (chan->address) {
>> +     case VZ89X_VOC_CO2_IDX:
>> +             *val = 1600;
>> +             *val2 = 229;
>> +             return IIO_VAL_FRACTIONAL;
>> +     case VZ89X_VOC_TVOC_IDX:
>> +             *val = 1000;
>> +             *val2 = 229;
>> +             return IIO_VAL_FRACTIONAL;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int vz89x_read_raw(struct iio_dev *indio_dev,
>> +                       struct iio_chan_spec const *chan, int *val,
>> +                       int *val2, long mask)
>> +{
>> +     struct vz89x_data *data = iio_priv(indio_dev);
>> +     int ret = -EINVAL;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             mutex_lock(&data->lock);
>> +             ret = vz89x_get_measurement(data);
>> +             mutex_unlock(&data->lock);
>> +
>> +             if (ret)
>> +                     return ret;
>> +
>> +             switch (chan->address) {
>> +             case VZ89X_VOC_CO2_IDX:
>> +                     *val = 0;
>> +                     *val2 = data->buffer[chan->address];
>> +                     return IIO_VAL_INT_PLUS_MICRO;
>
> This is unusual for a raw reading.  Normally you'd output it as
> IIO_VAL_INT and take up the device by 1e6 in the scale factor.
> (mainly because you can only output integer values via the buffered
> interface - but it's become a convention in general).
> I wouldn't guarantee all tools will cope with it otherwise.

Yeah the reason i did it this way is calculation is    (value - 13) *
scale + offset.    But I probably could change the maths around to
make this more sane.

Also got my hardware today for this today. So I can test driver out finally..

>> +             case VZ89X_VOC_SHORT_IDX:
>> +                     *val = data->buffer[chan->address];
>> +                     return IIO_VAL_INT;
>> +             case VZ89X_VOC_TVOC_IDX:
>> +                     *val = 0;
>> +                     *val2 = data->buffer[chan->address];
> Same is true for this one.
>> +                     return IIO_VAL_INT_PLUS_NANO;
>> +             case VZ89X_VOC_RESISTANCE_IDX:
>> +                     *val = vz89x_get_resistance_reading(data);
>> +                     return IIO_VAL_INT;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +             break;
>> +     case IIO_CHAN_INFO_SCALE:
>> +             switch (chan->type) {
>> +             case IIO_RESISTANCE:
>> +                     *val = 10;
>> +                     return IIO_VAL_INT;
>> +             case IIO_CONCENTRATION:
>> +                     return vz89x_get_channel_scale(chan, val, val2);
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +             break;
>> +     case IIO_CHAN_INFO_OFFSET:
>> +             switch (chan->address) {
>> +             case VZ89X_VOC_CO2_IDX:
>> +                     *val = 0;
>> +                     *val2 = 44250;
>> +                     return IIO_VAL_INT_PLUS_NANO;
>> +             case VZ89X_VOC_TVOC_IDX:
>> +                     *val = 0;
>> +                     *val2 = -13;
>> +                     return IIO_VAL_INT_PLUS_NANO;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static const struct iio_info vz89x_info = {
>> +     .driver_module  = THIS_MODULE,
>> +     .read_raw       = vz89x_read_raw,
>> +};
>> +
>> +static int vz89x_probe(struct i2c_client *client,
>> +                    const struct i2c_device_id *id)
>> +{
>> +     struct iio_dev *indio_dev;
>> +     struct vz89x_data *data;
>> +
>> +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
>> +                                  I2C_FUNC_SMBUS_BYTE))
>> +             return -ENODEV;
>> +
>> +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     data = iio_priv(indio_dev);
>> +     i2c_set_clientdata(client, indio_dev);
>> +     data->client = client;
>> +     data->last_update = jiffies - HZ;
>> +     mutex_init(&data->lock);
>> +
>> +     indio_dev->dev.parent = &client->dev;
>> +     indio_dev->info = &vz89x_info,
>> +     indio_dev->name = dev_name(&client->dev);
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +     indio_dev->channels = vz89x_channels;
>> +     indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
>> +
>> +     return devm_iio_device_register(&client->dev, indio_dev);
>> +}
>> +
>> +static const struct i2c_device_id vz89x_id[] = {
>> +     { "vz89x", 0 },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, vz89x_id);
>> +
>> +static const struct of_device_id vz89x_dt_ids[] = {
>> +     { .compatible = "sgx,vz89x" },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>> +
>> +static struct i2c_driver vz89x_driver = {
>> +     .driver = {
>> +             .name   = "vz89x",
>> +             .of_match_table = of_match_ptr(vz89x_dt_ids),
>> +     },
>> +     .probe = vz89x_probe,
>> +     .id_table = vz89x_id,
>> +};
>> +module_i2c_driver(vz89x_driver);
>> +
>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>> +MODULE_DESCRIPTION("SGX Sensortech MiCS VZ89X VOC sensors");
>> +MODULE_LICENSE("GPL v2");
>>
>
