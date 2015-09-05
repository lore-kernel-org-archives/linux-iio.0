Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35733 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbIEW6m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 18:58:42 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1509051005300.23459@pmeerw.net>
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
	<1441432406-4761-5-git-send-email-mranostay@gmail.com>
	<alpine.DEB.2.02.1509050928240.23459@pmeerw.net>
	<3BCA5996-9CA8-4DB5-A387-EF6BC496F308@gmail.com>
	<alpine.DEB.2.02.1509051005300.23459@pmeerw.net>
Date: Sat, 5 Sep 2015 15:58:39 -0700
Message-ID: <CAKzfze_-03u7_kCQ6A5HahjeMn_HR_TdSfaV1M5QUTyZiotj3g@mail.gmail.com>
Subject: Re: [RFC v1 4/4] iio: chemical: add SGX VZ89x VOC sensor support
From: Matt Ranostay <mranostay@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 5, 2015 at 1:11 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>
>> >> Add support for VZ89X sensors VOC and CO2 reporting channels in
>> >> ppm/ppb units.
>> >
>> > comments below
>> > link to datasheet?
>>
>> I will post the links when I am not at the Oregon coast. Have no laptop atm...
>>
>> >
>> >> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> >> ---
>> >> .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>> >> drivers/iio/Kconfig                                |   1 +
>> >> drivers/iio/Makefile                               |   1 +
>> >> drivers/iio/chemical/Makefile                      |   6 +
>> >> drivers/iio/chemical/vz89x.c                       | 237 +++++++++++++++++++++
>> >> 5 files changed, 246 insertions(+)
>> >> create mode 100644 drivers/iio/chemical/Makefile
>> >> create mode 100644 drivers/iio/chemical/vz89x.c
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> >> index d77d412..a550216 100644
>> >> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> >> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> >> @@ -88,6 +88,7 @@ ricoh,rs5c372b        I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>> >> ricoh,rv5c386        I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>> >> ricoh,rv5c387a        I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>> >> samsung,24ad0xd1    S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
>> >> +sgx,vz89x        SGX Sensortech VZ89X Sensors
>> >> sii,s35390a        2-wire CMOS real-time clock
>> >> skyworks,sky81452    Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>> >> st-micro,24c256        i2c serial eeprom  (24cxx)
>> >> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> >> index 4011eff..9664e9c 100644
>> >> --- a/drivers/iio/Kconfig
>> >> +++ b/drivers/iio/Kconfig
>> >> @@ -61,6 +61,7 @@ config IIO_CONSUMERS_PER_TRIGGER
>> >> source "drivers/iio/accel/Kconfig"
>> >> source "drivers/iio/adc/Kconfig"
>> >> source "drivers/iio/amplifiers/Kconfig"
>> >> +source "drivers/iio/chemical/Kconfig"
>> >> source "drivers/iio/common/Kconfig"
>> >> source "drivers/iio/dac/Kconfig"
>> >> source "drivers/iio/frequency/Kconfig"
>> >> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> >> index 698afc2..2288684 100644
>> >> --- a/drivers/iio/Makefile
>> >> +++ b/drivers/iio/Makefile
>> >> @@ -14,6 +14,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>> >> obj-y += accel/
>> >> obj-y += adc/
>> >> obj-y += amplifiers/
>> >> +obj-y += chemical/
>> >> obj-y += common/
>> >> obj-y += dac/
>> >> obj-y += gyro/
>> >> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
>> >> new file mode 100644
>> >> index 0000000..7292f2d
>> >> --- /dev/null
>> >> +++ b/drivers/iio/chemical/Makefile
>> >> @@ -0,0 +1,6 @@
>> >> +#
>> >> +# Makefile for IIO chemical sensors
>> >> +#
>> >> +
>> >> +# When adding new entries keep the list in alphabetical order
>> >> +obj-$(CONFIG_VZ89X)        += vz89x.o
>> >> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
>> >> new file mode 100644
>> >> index 0000000..a596a22
>> >> --- /dev/null
>> >> +++ b/drivers/iio/chemical/vz89x.c
>> >> @@ -0,0 +1,237 @@
>> >> +/*
>> >> + * vz89x.c - Support for SGX Sensortech MiCS VZ89X VOC sensors
>> >> + *
>> >> + * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License as published by
>> >> + * the Free Software Foundation; either version 2 of the License, or
>> >> + * (at your option) any later version.
>> >> + *
>> >> + * This program is distributed in the hope that it will be useful,
>> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> >> + * GNU General Public License for more details.
>> >> + *
>> >> + */
>> >> +
>> >> +#include <linux/module.h>
>> >> +#include <linux/mutex.h>
>> >> +#include <linux/init.h>
>> >> +#include <linux/i2c.h>
>> >> +
>> >> +#include <linux/iio/iio.h>
>> >> +#include <linux/iio/sysfs.h>
>> >> +
>> >> +#define VZ89X_REG_MEASUREMENT        0x09
>> >> +#define VZ89X_REG_MEASUREMENT_SIZE    6
>> >> +
>> >> +#define VZ89X_VOC_CO2_IDX    0
>> >> +#define VZ89X_VOC_SHORT_IDX    1
>> >> +#define VZ89X_VOC_TVOC_IDX    2
>> >> +#define VZ89X_RESISTANCE_IDX    3
>> >> +
>> >> +struct vz89x_data {
>> >> +    struct i2c_client *client;
>> >> +    struct mutex lock;
>> >> +    unsigned long last_update;
>> >> +
>> >> +    u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
>> >> +};
>> >> +
>> >> +static const struct iio_chan_spec vz89x_channels[] = {
>> >> +    {
>> >> +        .type = IIO_CONCENTRATION,
>> >> +        .channel2 = IIO_MOD_PPM,
>> >> +        .modified = 1,
>> >> +        .info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
>> >> +            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> >> +        .address = VZ89X_VOC_CO2_IDX,
>> >> +        .extend_name = "CO2",
>> >> +    },
>> >> +    {
>> >> +        .type = IIO_CONCENTRATION,
>> >> +        .info_mask_separate =
>> >> +            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> >> +        .address = VZ89X_VOC_SHORT_IDX,
>> >> +        .extend_name = "VOC_short",
>> >> +    },
>> >> +    {
>> >> +        .type = IIO_CONCENTRATION,
>> >> +        .channel2 = IIO_MOD_PPB,
>> >> +        .modified = 1,
>> >> +        .info_mask_separate =
>> >> +            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> >> +        .address = VZ89X_VOC_TVOC_IDX,
>> >> +        .extend_name = "tVOC",
>> >> +    },
>> >> +    {
>> >> +        .type = IIO_RESISTANCE,
>> >> +        .info_mask_separate =
>> >> +            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> >> +        .address = VZ89X_RESISTANCE_IDX,
>> >> +    },
>> >> +};
>> >> +
>> >> +static int vz89x_get_measurement(struct vz89x_data *data)
>> >> +{
>> >> +    int ret;
>> >> +    int i;
>> >> +
>> >> +    /* sensor can only be polled once a second max per datasheet */
>> >> +    if (!time_after(jiffies, data->last_update + HZ))
>> >> +        return 0;
>> >> +
>> >> +    ret = i2c_smbus_write_word_data(data->client,
>> >> +                    VZ89X_REG_MEASUREMENT, 0);
>> >> +    if (ret < 0)
>> >> +        return ret;
>> >> +
>> >> +    for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
>> >> +        ret = i2c_smbus_read_byte(data->client);
>> >
>> > could a block transfer be used?
>>
>> Yah from the data sheet on i2c it can only do byte reads after the
>> "command write data of zero"... I'll know better I have this part in
>> hand.... But from Arduino hippies it seems I have gotten weird sensors
>> to work on this chipset....
>
> and the transfer is at most once per second, so no big performance deal
>
>>
>> >> +        if (ret < 0)
>> >> +            return ret;
>> >> +    }
>> >> +
>> >> +    data->last_update = jiffies;
>> >> +
>> >> +    return 0;
>> >> +}
>> >> +
>> >> +static int vz89x_get_resistance_reading(struct vz89x_data *data,
>> >> +                    struct iio_chan_spec const *chan)
>> >> +{
>> >> +    u8 *buf = &data->buffer[chan->address];
>> >
>> > I think only VZ89X_RESISTANCE_IDX as chan->address makes sense here?

Doesn't matter either, either way work for me.

>> >
>> >> +
>> >> +    return buf[0] | ((u16)buf[1] << 8) | ((u16)buf[2] << 16);
>> >
>> > why cast to u16? no cast is neccessary
>> Maybe but to be safe of compilers not getting the shift left values that could happen doesn't hurt
>
> (u16)buf[2] << 16
> u16 still makes no sense

D'oh missed that it should be u32 :)

>
>> >
>> >> +}
>> >> +
>> >> +static int vz89x_get_channel_scale(struct iio_chan_spec const *chan,
>> >> +                   int *val, int *val2)
>> >> +{
>> >> +    int ret = -EINVAL;
>> >> +
>> >> +    switch (chan->address) {
>> >> +    case VZ89X_VOC_CO2_IDX:
>> >> +        *val = 1600;
>> >> +        *val2 = 229;
>> >> +        ret = IIO_VAL_FRACTIONAL;
>> >
>> > return directly and save the break, no init of ret
>>
>> Old habits :)
>
> agree, matter of taste; but in this case is saves somes lines
>
>> >> +        break;
>> >> +    case VZ89X_VOC_SHORT_IDX:
>> >> +        *val = 0;
>> >> +        ret = IIO_VAL_INT;
>> >> +        break;
>> >> +    case VZ89X_VOC_TVOC_IDX:
>> >> +        *val = 1000;
>> >> +        *val2 = 229;
>> >> +        ret = IIO_VAL_FRACTIONAL;
>> >
>> > default
>> >
>> >> +    }
>> >> +
>> >> +    return ret;
>> >> +}
>> >> +
>> >> +static int vz89x_read_raw(struct iio_dev *indio_dev,
>> >> +              struct iio_chan_spec const *chan, int *val,
>> >> +              int *val2, long mask)
>> >> +{
>> >> +    struct vz89x_data *data = iio_priv(indio_dev);
>> >> +    int ret = -EINVAL;
>> >> +
>> >> +    switch (mask) {
>> >> +    case IIO_CHAN_INFO_RAW:
>> >> +        mutex_lock(&data->lock);
>> >> +        ret = vz89x_get_measurement(data);
>> >> +
>> >> +        if (chan->type == IIO_RESISTANCE)
>> >> +            *val = vz89x_get_resistance_reading(data, chan);
>> >
>> > chan argument is not needed

It is needed to get the chan->address in that function

>> >
>> >> +        else
>> >> +            *val = data->buffer[chan->address] - 13;
>> >
>> > maybe have this block after checking ret, operating on invalid data isn't
>> > well behaved :)
>> > what is 13? could this be incorporated in _OFFSET?
>> >
>>
>> Yeah if scale value wasn't calculated first... Need to ask them why 13.. I mean really
>
> I always have to look is up as well: it is (value + offset) * scale

Well in this case it is ((value - 13) * scale) + offset.

>
>> >> +
>> >> +        if (!ret)
>> >> +            ret = IIO_VAL_INT;
>> >> +
>> >> +        mutex_unlock(&data->lock);
>> >> +        break;
>> >> +    case IIO_CHAN_INFO_SCALE:
>> >> +        switch (chan->type) {
>> >> +        case IIO_RESISTANCE:
>> >> +            *val = 10;
>> >> +            ret = IIO_VAL_INT;
>> >> +            break;
>> >> +        case IIO_CONCENTRATION:
>> >> +            ret = vz89x_get_channel_scale(chan, val, val2);
>> >> +            break;
>> >> +        default:
>> >> +            ret = -EINVAL;
>> >> +        }
>> >> +        break;
>> >> +    case IIO_CHAN_INFO_OFFSET:
>> >> +        *val = 400;
>> >> +        ret = IIO_VAL_INT;
>> >> +        break;
>> >> +    }
>> >> +
>> >> +    return ret;
>> >> +}
>> >> +
>> >> +static const struct iio_info vz89x_info = {
>> >> +    .driver_module    = THIS_MODULE,
>> >> +    .read_raw    = vz89x_read_raw,
>> >> +};
>> >> +
>> >> +static int vz89x_probe(struct i2c_client *client,
>> >> +               const struct i2c_device_id *id)
>> >> +{
>> >> +    struct iio_dev *indio_dev;
>> >> +    struct vz89x_data *data;
>> >> +
>> >> +    if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
>> >> +                     I2C_FUNC_SMBUS_BYTE))
>> >> +        return -ENODEV;
>> >> +
>> >> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >> +    if (!indio_dev)
>> >> +        return -ENOMEM;
>> >> +
>> >> +    data = iio_priv(indio_dev);
>> >> +    i2c_set_clientdata(client, indio_dev);
>> >> +    data->client = client;
>> >> +    data->last_update = jiffies - HZ;
>> >> +    mutex_init(&data->lock);
>> >> +
>> >> +    indio_dev->dev.parent = &client->dev;
>> >> +    indio_dev->info = &vz89x_info,
>> >> +    indio_dev->name = dev_name(&client->dev);
>> >> +    indio_dev->modes = INDIO_DIRECT_MODE;
>> >> +
>> >> +    indio_dev->channels = vz89x_channels;
>> >> +    indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
>> >> +
>> >> +    return devm_iio_device_register(&client->dev, indio_dev);
>> >> +}
>> >> +
>> >> +static const struct i2c_device_id vz89x_id[] = {
>> >> +    { "vz89x", 0 },
>> >> +    { }
>> >> +};
>> >> +MODULE_DEVICE_TABLE(i2c, vz89x_id);
>> >> +
>> >> +static const struct of_device_id vz89x_dt_ids[] = {
>> >> +    { .compatible = "sgx,vz89x" },
>> >> +    { }
>> >> +};
>> >> +MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>> >> +
>> >> +static struct i2c_driver vz89x_driver = {
>> >> +    .driver = {
>> >> +        .name    = "vz89x",
>> >> +        .of_match_table = of_match_ptr(vz89x_dt_ids),
>> >> +    },
>> >> +    .probe = vz89x_probe,
>> >> +    .id_table = vz89x_id,
>> >> +};
>> >> +module_i2c_driver(vz89x_driver);
>> >> +
>> >> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>> >> +MODULE_DESCRIPTION("SGX Sensortech MiCS VZ89X VOC sensors");
>> >> +MODULE_LICENSE("GPL v2");
>> >
>> > --
>> >
>> > Peter Meerwald
>> > +43-664-2444418 (mobile)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
