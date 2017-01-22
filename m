Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33242 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAVVaS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 16:30:18 -0500
Received: by mail-qt0-f179.google.com with SMTP id v23so93274449qtb.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Jan 2017 13:30:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <37a77cc9-8ff0-1a46-8664-1ef8cbc48af6@kernel.org>
References: <20170120054100.902-1-matt@ranostay.consulting>
 <20170120054100.902-3-matt@ranostay.consulting> <alpine.DEB.2.02.1701220928420.30375@pmeerw.net>
 <37a77cc9-8ff0-1a46-8664-1ef8cbc48af6@kernel.org>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Sun, 22 Jan 2017 13:30:15 -0800
Message-ID: <CAJ_EiSRRDrJw9XjNsHxwXggjkgzHAxwUsSofwti+KaCHOp0CPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: health: add MAX30102 oximeter driver support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 22, 2017 at 4:21 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 22/01/17 09:00, Peter Meerwald-Stadler wrote:
>> On Thu, 19 Jan 2017, Matt Ranostay wrote:
>>
>>> MAX30102 is an heart rate and pulse oximeter sensor that works using
>>> two LEDS of different wavelengths, and detecting the light reflected
>>> back.
>>>
>>> This patchset adds support for both IR and RED LED channels which can
>>> be processed in userspace to determine heart rate and blood oxygen
>>> levels. The MAX30102 part isn't completely register and functional
>>> compatible with the existing MAX30100 driver.
>>
>> comments below
>>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> ---
>>>  drivers/iio/health/Kconfig    |  13 ++
>>>  drivers/iio/health/Makefile   |   1 +
>>>  drivers/iio/health/max30102.c | 478 ++++++++++++++++++++++++++++++++++=
++++++++
>>>  3 files changed, 492 insertions(+)
>>>  create mode 100644 drivers/iio/health/max30102.c
>>>
>>> diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
>>> index c5f004a8e447..a2ecb4c94c2a 100644
>>> --- a/drivers/iio/health/Kconfig
>>> +++ b/drivers/iio/health/Kconfig
>>> @@ -46,6 +46,19 @@ config MAX30100
>>>        To compile this driver as a module, choose M here: the
>>>        module will be called max30100.
>>>
>>> +config MAX30102
>>> +    tristate "MAX30102 heart rate and pulse oximeter sensor"
>>> +    depends on I2C
>>> +    select REGMAP_I2C
>>> +    select IIO_BUFFER
>>> +    select IIO_KFIFO_BUF
>>> +    help
>>> +      Say Y here to build I2C interface support for the Maxim
>>> +      MAX30102 heart rate, and pulse oximeter sensor.
>>> +
>>> +      To compile this driver as a module, choose M here: the
>>> +      module will be called max30102.
>>> +
>>>  endmenu
>>>
>>>  endmenu
>>> diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
>>> index 9955a2ae8df1..3558f9d64954 100644
>>> --- a/drivers/iio/health/Makefile
>>> +++ b/drivers/iio/health/Makefile
>>> @@ -7,3 +7,4 @@
>>>  obj-$(CONFIG_AFE4403)               +=3D afe4403.o
>>>  obj-$(CONFIG_AFE4404)               +=3D afe4404.o
>>>  obj-$(CONFIG_MAX30100)              +=3D max30100.o
>>> +obj-$(CONFIG_MAX30102)              +=3D max30102.o
>>> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max3010=
2.c
>>> new file mode 100644
>>> index 000000000000..3d18a63d2280
>>> --- /dev/null
>>> +++ b/drivers/iio/health/max30102.c
>>> @@ -0,0 +1,478 @@
>>> +/*
>>> + * max30102.c - Support for MAX30102 heart rate and pulse oximeter sen=
sor
>>> + *
>>> + * Copyright (C) 2017 Matt Ranostay <matt@ranostay.consulting>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modif=
y
>>> + * it under the terms of the GNU General Public License as published b=
y
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * TODO: proximity power saving feature
>>
>> link to datasheet and i2c address would be nice to have here
>>
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/err.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/of.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/kfifo_buf.h>
>>> +
>>> +#define MAX30102_REGMAP_NAME        "max30102_regmap"
>>> +#define MAX30102_DRV_NAME   "max30102"
>>> +
>>> +#define MAX30102_REG_INT_STATUS                     0x00
>>> +#define MAX30102_REG_INT_STATUS_PWR_RDY             BIT(0)
>>> +#define MAX30102_REG_INT_STATUS_PROX_INT    BIT(4)
>>> +#define MAX30102_REG_INT_STATUS_ALC_OVF             BIT(5)
>>> +#define MAX30102_REG_INT_STATUS_PPG_RDY             BIT(6)
>>> +#define MAX30102_REG_INT_STATUS_FIFO_RDY    BIT(7)
>>> +
>>> +#define MAX30102_REG_INT_ENABLE                     0x02
>>> +#define MAX30102_REG_INT_ENABLE_PROX_INT_EN BIT(4)
>>> +#define MAX30102_REG_INT_ENABLE_ALC_OVF_EN  BIT(5)
>>> +#define MAX30102_REG_INT_ENABLE_PPG_EN              BIT(6)
>>> +#define MAX30102_REG_INT_ENABLE_FIFO_EN             BIT(7)
>>> +#define MAX30102_REG_INT_ENABLE_MASK                0xf0
>>> +#define MAX30102_REG_INT_ENABLE_MASK_SHIFT  4
>>> +
>>> +#define MAX30102_REG_FIFO_WR_PTR            0x04
>>> +#define MAX30102_REG_FIFO_OVR_CTR           0x05
>>> +#define MAX30102_REG_FIFO_RD_PTR            0x06
>>> +#define MAX30102_REG_FIFO_DATA                      0x07
>>> +#define MAX30102_REG_FIFO_DATA_ENTRY_LEN    6

Actually found out this need to be samples + 1 to work. So will fix in
next revision

>>> +
>>> +#define MAX30102_REG_FIFO_CONFIG            0x08
>>> +#define MAX30102_REG_FIFO_CONFIG_AVG_4SAMPLES       BIT(1)
>>> +#define MAX30102_REG_FIFO_CONFIG_AVG_SHIFT  5
>>> +#define MAX30102_REG_FIFO_CONFIG_AFULL              BIT(0)
>>> +
>>> +#define MAX30102_REG_MODE_CONFIG            0x09
>>> +#define MAX30102_REG_MODE_CONFIG_MODE_SPO2_EN       BIT(0)
>>> +#define MAX30102_REG_MODE_CONFIG_MODE_HR_EN BIT(1)
>>> +#define MAX30102_REG_MODE_CONFIG_MODE_MASK  0x03
>>> +#define MAX30102_REG_MODE_CONFIG_PWR                BIT(7)
>>> +
>>> +#define MAX30102_REG_SPO2_CONFIG            0x0a
>>> +#define MAX30102_REG_SPO2_CONFIG_PULSE_411_US       0x03
>>> +#define MAX30102_REG_SPO2_CONFIG_SR_400HZ   0x03
>>> +#define MAX30102_REG_SPO2_CONFIG_SR_MASK    0x07
>>> +#define MAX30102_REG_SPO2_CONFIG_SR_MASK_SHIFT      2
>>> +#define MAX30102_REG_SPO2_CONFIG_ADC_4096_STEPS     BIT(0)
>>> +#define MAX30102_REG_SPO2_CONFIG_ADC_MASK_SHIFT     4
>>> +
>>> +#define MAX30102_REG_RED_LED_CONFIG         0x0c
>>> +#define MAX30102_REG_IR_LED_CONFIG          0x0d
>>> +
>>> +#define MAX30102_REG_TEMP_CONFIG            0x21
>>> +#define MAX30102_REG_TEMP_CONFIG_TEMP_EN    BIT(0)
>>> +
>>> +#define MAX30102_REG_TEMP_INTEGER           0x1f
>>> +#define MAX30102_REG_TEMP_FRACTION          0x20
>>
>> keep registers sorted?
>>
>>> +
>>> +struct max30102_data {
>>> +    struct i2c_client *client;
>>> +    struct iio_dev *indio_dev;
>>> +    struct mutex lock;
>>> +    struct regmap *regmap;
>>> +
>>> +    u8 buffer[8]; /* 2 x 18-bit (padded to 24-bits) channels + 2 bytes=
 pad */
>>
>> not sure; is storagebits supposed to be power-of-2?
>> scantype documentation in iio.h doesn't state any requirement (but
>> probably should)
>>
> Yes - it must be or the demux stuff messes up.  Should add a note about t=
hat.
> Patches welcome!  We spent a while unwinding this in the ST drivers after
> some 24 bit devices turned up there.
>
>> why the padding? could use MAX30102_REG_FIFO_DATA_ENTRY_LEN (=3D=3D 6) i=
nstead
>> of 8?
>>
>>> +};
>>> +
>>> +static const struct regmap_config max30102_regmap_config =3D {
>>> +    .name =3D MAX30102_REGMAP_NAME,
>>> +
>>> +    .reg_bits =3D 8,
>>> +    .val_bits =3D 8,
>>> +};
>>> +
>>> +static const unsigned long max30102_scan_masks[] =3D {0x3, 0};
>>> +
>>> +static const struct iio_chan_spec max30102_channels[] =3D {
>>> +    {
>>> +            .type =3D IIO_INTENSITY,
>>> +            .channel2 =3D IIO_MOD_LIGHT_RED,
>>> +            .modified =3D 1,
>>> +
>>> +            .scan_index =3D 0,
>>> +            .scan_type =3D {
>>> +                    .sign =3D 'u',
>>> +                    .realbits =3D 18,
>>> +                    .storagebits =3D 24,
>>> +                    .endianness =3D IIO_BE,
>>> +            },
>>> +    },
>>> +    {
>>> +            .type =3D IIO_INTENSITY,
>>> +            .channel2 =3D IIO_MOD_LIGHT_IR,
>>> +            .modified =3D 1,
>>> +
>>> +            .scan_index =3D 1,
>>> +            .scan_type =3D {
>>> +                    .sign =3D 'u',
>>> +                    .realbits =3D 18,
>>> +                    .storagebits =3D 24,
>>> +                    .endianness =3D IIO_BE,
>>> +            },
>>> +    },
>>> +    {
>>> +            .type =3D IIO_TEMP,
>>> +            .info_mask_separate =3D
>>> +                    BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>> +            .scan_index =3D -1,
>>> +    },
>>> +};
>>> +
>>> +static int max30102_set_powermode(struct max30102_data *data, bool sta=
te)
>>> +{
>>> +    return regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
>>> +                              MAX30102_REG_MODE_CONFIG_PWR,
>>> +                              state ? 0 : MAX30102_REG_MODE_CONFIG_PWR=
);
>>> +}
>>> +
>>> +static int max30102_buffer_postenable(struct iio_dev *indio_dev)
>>> +{
>>> +    struct max30102_data *data =3D iio_priv(indio_dev);
>>> +
>>> +    return max30102_set_powermode(data, true);
>>> +}
>>> +
>>> +static int max30102_buffer_predisable(struct iio_dev *indio_dev)
>>> +{
>>> +    struct max30102_data *data =3D iio_priv(indio_dev);
>>> +
>>> +    return max30102_set_powermode(data, false);
>>> +}
>>> +
>>> +static const struct iio_buffer_setup_ops max30102_buffer_setup_ops =3D=
 {
>>> +    .postenable =3D max30102_buffer_postenable,
>>> +    .predisable =3D max30102_buffer_predisable,
>>> +};
>>> +
>>> +static inline int max30102_fifo_count(struct max30102_data *data)
>>
>> no inline please, let the compiler decide (as it does anyways ...)
>>
>>> +{
>>> +    unsigned int val;
>>> +    int ret;
>>> +
>>> +    ret =3D regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &val);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    /* FIFO has one sample slot left */
>>> +    if (val & MAX30102_REG_INT_STATUS_FIFO_RDY)
>>> +            return 1;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max30102_read_measurement(struct max30102_data *data)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret =3D i2c_smbus_read_i2c_block_data(data->client,
>>
>> this mixes regmap with direct i2c, isn't there another way?
> There was a proposal to do a 'repeated read' regmap operation which
> is basically what this is doing.  Not sure what happened to it
> though...

Yeah not sure.  However regmap_bulk_read() didn't seem to work.

>>
>>> +                                        MAX30102_REG_FIFO_DATA,
>>> +                                        MAX30102_REG_FIFO_DATA_ENTRY_L=
EN,
>>> +                                        (u8 *) &data->buffer);
>>> +
>>
>> what happens when ret is positive, but !=3D MAX30102_REG_FIFO_DATA_ENTRY=
_LEN?
>>
>>> +    return (ret =3D=3D MAX30102_REG_FIFO_DATA_ENTRY_LEN) ? 0 : ret;

Yeah I should make this more error-proof. Noted.

>>> +}
>>> +
>>> +static irqreturn_t max30102_interrupt_handler(int irq, void *private)
>>> +{
>>> +    struct iio_dev *indio_dev =3D private;
>>> +    struct max30102_data *data =3D iio_priv(indio_dev);
>>> +    int ret, cnt =3D 0;
>>> +
>>> +    mutex_lock(&data->lock);
>>> +
>>> +    while (cnt || (cnt =3D max30102_fifo_count(data)) > 0) {
>>> +            ret =3D max30102_read_measurement(data);
>>> +            if (ret)
>>> +                    break;
>>> +
>>> +            iio_push_to_buffers(data->indio_dev, data->buffer);
>>> +            cnt--;
>>> +    }
>>> +
>>> +    mutex_unlock(&data->lock);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int max30102_get_current_idx(unsigned int val, int *reg)
>>> +{
>>> +    /* each step is 0.200 mA */
>>
>> saying that it is 200 =C2=B5A saves some mental unit conversion effort (=
as
>> documented in DT and 200 in the code below)
>>
>>> +    *reg =3D val / 200;
>>> +
>>> +    return *reg > 0xff ? -EINVAL : 0;
>>> +}
>>> +
>>> +static int max30102_led_init(struct max30102_data *data)
>>> +{
>>> +    struct device *dev =3D &data->client->dev;
>>> +    struct device_node *np =3D dev->of_node;
>>> +    unsigned int val;
>>> +    int reg, ret;
>>> +
>>> +    ret =3D of_property_read_u32(np, "maxim,red-led-current-microamp",=
 &val);
>>> +    if (ret) {
>>> +            dev_info(dev, "no red-led-current-microamp set");
>>
>> \n missing, here and elsewhere

Noted.
>>
>>> +
>>> +            /* Default to 7 mA RED LED */
>>> +            val =3D 7000;
>>> +    }
>>> +
>>> +    ret =3D max30102_get_current_idx(val, &reg);
>>> +    if (ret) {
>>> +            dev_err(dev, "invalid RED LED current setting %d", val);
>>> +            return ret;
>>> +    }
>>> +
>>> +    ret =3D regmap_write(data->regmap, MAX30102_REG_RED_LED_CONFIG, re=
g);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    ret =3D of_property_read_u32(np, "maxim,ir-led-current-microamp", =
&val);
>>> +    if (ret) {
>>> +            dev_info(dev, "no ir-led-current-microamp set");
>>> +
>>> +            /* Default to 7 mA IR LED */
>>> +            val =3D 7000;
>>> +    }
>>> +
>>> +    ret =3D max30102_get_current_idx(val, &reg);
>>> +    if (ret) {
>>> +            dev_err(dev, "invalid IR LED current setting %d", val);
>>> +            return ret;
>>> +    }
>>> +
>>> +    return regmap_write(data->regmap, MAX30102_REG_IR_LED_CONFIG, reg)=
;
>>> +}
>>> +
>>> +static int max30102_chip_init(struct max30102_data *data)
>>> +{
>>> +    int ret;
>>> +
>>> +    /* setup LED current settings */
>>> +    ret =3D max30102_led_init(data);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    /* enable 18-bit HR + SPO2 readings at 100Hz */
>>> +    ret =3D regmap_write(data->regmap, MAX30102_REG_SPO2_CONFIG,
>>> +                            (MAX30102_REG_SPO2_CONFIG_ADC_4096_STEPS
>>> +                             << MAX30102_REG_SPO2_CONFIG_ADC_MASK_SHIF=
T) |
>>> +                            (MAX30102_REG_SPO2_CONFIG_SR_400HZ
>>
>> 100Hz in the comment vs 400Hz?

Should have noted the /* average 4 samples + generate FIFO interrupt
*/ from below.
So the sample rate of the part is 400hz but exposed to the FIFO is
only 100hz because of averaging

>>
>>> +                             << MAX30102_REG_SPO2_CONFIG_SR_MASK_SHIFT=
) |
>>> +                             MAX30102_REG_SPO2_CONFIG_PULSE_411_US);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    /* enable SPO2 mode */
>>> +    ret =3D regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
>>> +                             MAX30102_REG_MODE_CONFIG_MODE_MASK,
>>> +                             MAX30102_REG_MODE_CONFIG_MODE_HR_EN |
>>> +                             MAX30102_REG_MODE_CONFIG_MODE_SPO2_EN);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    /* average 4 samples + generate FIFO interrupt */
>>> +    ret =3D regmap_write(data->regmap, MAX30102_REG_FIFO_CONFIG,
>>> +                            (MAX30102_REG_FIFO_CONFIG_AVG_4SAMPLES
>>> +                             << MAX30102_REG_FIFO_CONFIG_AVG_SHIFT) |
>>> +                             MAX30102_REG_FIFO_CONFIG_AFULL);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    /* enable FIFO interrupt */
>>> +    return regmap_update_bits(data->regmap, MAX30102_REG_INT_ENABLE,
>>> +                             MAX30102_REG_INT_ENABLE_MASK,
>>> +                             MAX30102_REG_INT_ENABLE_FIFO_EN);
>>> +}
>>> +
>>> +static int max30102_read_temp(struct max30102_data *data, int *val)
>>> +{
>>> +    int ret;
>>> +    unsigned int reg;
>>> +
>>> +    ret =3D regmap_read(data->regmap, MAX30102_REG_TEMP_INTEGER, &reg)=
;
>>> +    if (ret < 0)
>>> +            return ret;
>>> +    *val =3D reg << 4;
>>> +
>>> +    ret =3D regmap_read(data->regmap, MAX30102_REG_TEMP_FRACTION, &reg=
);
>>> +    if (ret < 0)
>>> +            return ret;
>>> +
>>> +    *val |=3D reg & 0xf;
>>> +    *val =3D sign_extend32(*val, 11);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max30102_get_temp(struct max30102_data *data, int *val)
>>> +{
>>> +    int ret;
>>> +
>>> +    /* start acquisition */
>>> +    ret =3D regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
>>> +                             MAX30102_REG_TEMP_CONFIG_TEMP_EN,
>>> +                             MAX30102_REG_TEMP_CONFIG_TEMP_EN);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    msleep(35);
>>> +
>>> +    return max30102_read_temp(data, val);
>>> +}
>>> +
>>> +static int max30102_read_raw(struct iio_dev *indio_dev,
>>> +                         struct iio_chan_spec const *chan,
>>> +                         int *val, int *val2, long mask)
>>> +{
>>> +    struct max30102_data *data =3D iio_priv(indio_dev);
>>> +    int ret =3D -EINVAL;
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +            /*
>>> +             * Temperature reading can only be acquired while engine
>>> +             * is running
>>> +             */
>>> +            mutex_lock(&indio_dev->mlock);
>>> +
>>> +            if (!iio_buffer_enabled(indio_dev))
>>
>> unusual; why not start the engine and make the read work?
> Or don't support _raw at all.  If there is a need to start the buffer
> then why is anyone using the sysfs access?

Problem this takes a lot longer to read  and can't be done in the
buffer state without caching some value
But temperate reading is needed roughly every 10-15 seconds to
compensate the change on the RED led.

>>
>>> +                    ret =3D -EAGAIN;
>>> +            else {
>>> +                    ret =3D max30102_get_temp(data, val);
>>> +                    if (!ret)
>>> +                            ret =3D IIO_VAL_INT;
>>> +            }
>>> +
>>> +            mutex_unlock(&indio_dev->mlock);
>>> +            break;
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +            *val =3D 1;  /* 0.0625 */
>>> +            *val2 =3D 16;
>>> +            ret =3D IIO_VAL_FRACTIONAL;
>>> +            break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static const struct iio_info max30102_info =3D {
>>> +    .driver_module =3D THIS_MODULE,
>>> +    .read_raw =3D max30102_read_raw,
>>> +};
>>> +
>>> +static int max30102_probe(struct i2c_client *client,
>>> +                      const struct i2c_device_id *id)
>>> +{
>>> +    struct max30102_data *data;
>>> +    struct iio_buffer *buffer;
>>> +    struct iio_dev *indio_dev;
>>> +    int ret;
>>> +
>>> +    indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
>>> +    if (!indio_dev)
>>> +            return -ENOMEM;
>>> +
>>> +    buffer =3D devm_iio_kfifo_allocate(&client->dev);
>>> +    if (!buffer)
>>> +            return -ENOMEM;
>>> +
>>> +    iio_device_attach_buffer(indio_dev, buffer);
>>> +
>>> +    indio_dev->name =3D MAX30102_DRV_NAME;
>>> +    indio_dev->channels =3D max30102_channels;
>>> +    indio_dev->info =3D &max30102_info;
>>> +    indio_dev->num_channels =3D ARRAY_SIZE(max30102_channels);
>>> +    indio_dev->available_scan_masks =3D max30102_scan_masks;
>>> +    indio_dev->modes =3D (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
>>> +    indio_dev->setup_ops =3D &max30102_buffer_setup_ops;
>>> +
>>> +    data =3D iio_priv(indio_dev);
>>> +    data->indio_dev =3D indio_dev;
>>> +    data->client =3D client;
>>> +
>>> +    mutex_init(&data->lock);
>>> +    i2c_set_clientdata(client, indio_dev);
>>> +
>>> +    data->regmap =3D devm_regmap_init_i2c(client, &max30102_regmap_con=
fig);
>>> +    if (IS_ERR(data->regmap)) {
>>> +            dev_err(&client->dev, "regmap initialization failed.\n");
>>> +            return PTR_ERR(data->regmap);
>>> +    }
>>> +    max30102_set_powermode(data, false);
>>> +
>>> +    ret =3D max30102_chip_init(data);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    if (client->irq <=3D 0) {
>>> +            dev_err(&client->dev, "no valid irq defined\n");
>>> +            return -EINVAL;
>>> +    }
>>> +
>>> +    ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>>> +                                    NULL, max30102_interrupt_handler,
>>> +                                    IRQF_TRIGGER_FALLING | IRQF_ONESHO=
T,
>>> +                                    "max30102_irq", indio_dev);
>>> +    if (ret) {
>>> +            dev_err(&client->dev, "request irq (%d) failed\n", client-=
>irq);
>>> +            return ret;
>>> +    }
>>> +
>>> +    return iio_device_register(indio_dev);
>>> +}
>>> +
>>> +static int max30102_remove(struct i2c_client *client)
>>> +{
>>> +    struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
>>> +    struct max30102_data *data =3D iio_priv(indio_dev);
>>> +
>>> +    iio_device_unregister(indio_dev);
>>> +    max30102_set_powermode(data, false);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct i2c_device_id max30102_id[] =3D {
>>> +    { "max30102", 0 },
>>> +    {}
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, max30102_id);
>>> +
>>> +static const struct of_device_id max30102_dt_ids[] =3D {
>>> +    { .compatible =3D "maxim,max30102" },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, max30102_dt_ids);
>>> +
>>> +static struct i2c_driver max30102_driver =3D {
>>> +    .driver =3D {
>>> +            .name   =3D MAX30102_DRV_NAME,
>>> +            .of_match_table =3D of_match_ptr(max30102_dt_ids),
>>> +    },
>>> +    .probe          =3D max30102_probe,
>>> +    .remove         =3D max30102_remove,
>>> +    .id_table       =3D max30102_id,
>>> +};
>>> +module_i2c_driver(max30102_driver);
>>> +
>>> +MODULE_AUTHOR("Matt Ranostay <matt@ranostay.consulting>");
>>> +MODULE_DESCRIPTION("MAX30102 heart rate and pulse oximeter sensor");
>>> +MODULE_LICENSE("GPL");
>>>
>>
>
