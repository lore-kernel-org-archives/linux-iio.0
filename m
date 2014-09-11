Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49137 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbaIKTfi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Sep 2014 15:35:38 -0400
Message-ID: <5411F8A5.5080501@linux.intel.com>
Date: Thu, 11 Sep 2014 12:31:49 -0700
From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 1/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
References: <cover.1410393352.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<6e2db76ca3688c86a36a5adcca0b89ecf436cebf.1410393352.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZAF1oaQOae1ihfB=je5Znugm+wc+ziEFO54MF9sf1qZcw@mail.gmail.com>
In-Reply-To: <CAEnQRZAF1oaQOae1ihfB=je5Znugm+wc+ziEFO54MF9sf1qZcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Daniel,

Thanks for your comments. Please find my reply inline.

On 09/11/2014 01:21 AM, Daniel Baluta wrote:
> On Thu, Sep 11, 2014 at 3:09 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> This patch adds a new driver for solteam opto JSA1212 proximity and
>> ambient light sensor.
>>
>> Basic details of the chip can be found here.
>>
>> http://www.solteamopto.com.tw/detail.php?ms=3&po_unit=2&pt_unit=29&p_unit=120
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> The code looks nice and clean. Few comments inline.
> Take them with a grain of salt since I'm new around linux-iio.
>
>> ---
>>   drivers/iio/light/Kconfig   |  10 +
>>   drivers/iio/light/Makefile  |   1 +
>>   drivers/iio/light/jsa1212.c | 487 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 498 insertions(+)
>>   create mode 100644 drivers/iio/light/jsa1212.c
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index bf05ca5..b81d8a3 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -99,6 +99,16 @@ config HID_SENSOR_PROX
>>            To compile this driver as a module, choose M here: the
>>            module will be called hid-sensor-prox.
>>
>> +config JSA1212
>> +       tristate "JSA1212 ALS and proximity sensor driver"
>> +       depends on I2C
>> +       help
>> +        Say Y here if you want to build a IIO driver for JSA1212
>> +        proximity & ALS sensor device.
>> +
>> +        To compile this driver as a module, choose M here:
>> +        the module will be called jsa1212.
>> +
>>   config SENSORS_LM3533
>>          tristate "LM3533 ambient light sensor"
>>          depends on MFD_LM3533
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index 8b8c09f..23c6aa9 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_GP2AP020A00F)    += gp2ap020a00f.o
>>   obj-$(CONFIG_HID_SENSOR_ALS)   += hid-sensor-als.o
>>   obj-$(CONFIG_HID_SENSOR_PROX)  += hid-sensor-prox.o
>>   obj-$(CONFIG_ISL29125)         += isl29125.o
>> +obj-$(CONFIG_JSA1212)          += jsa1212.o
>>   obj-$(CONFIG_SENSORS_LM3533)   += lm3533-als.o
>>   obj-$(CONFIG_LTR501)           += ltr501.o
>>   obj-$(CONFIG_SENSORS_TSL2563)  += tsl2563.o
>> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
>> new file mode 100644
>> index 0000000..9974bac
>> --- /dev/null
>> +++ b/drivers/iio/light/jsa1212.c
>> @@ -0,0 +1,487 @@
>> +/*
>> + * JSA1212 Ambient Light & Proximity Sensor Driver
>> + *
>> + * Copyright (c) 2014, Intel Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + */
> I think some TODO should be added here. I see that
> device supports interrupts + thresholds but they are
> not implemented.
I will be submitting patches for interrupt and event support soon.
May be we can add that info in TODO section.
>
> Also if there is a fix I2C slave address here is the place
> you should mention about it.
>
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
> I don't think you need irq.h and interrupt.h for the moment.
>
>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/regmap.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +/* JSA1212 reg address */
>> +#define JSA1212_CONF_REG               0x01
>> +#define JSA1212_INT_REG                        0x02
>> +#define JSA1212_PXS_LT_REG             0x03
>> +#define JSA1212_PXS_HT_REG             0x04
>> +#define JSA1212_ALS_TH1_REG            0x05
>> +#define JSA1212_ALS_TH2_REG            0x06
>> +#define JSA1212_ALS_TH3_REG            0x07
>> +#define JSA1212_PXS_DATA_REG           0x08
>> +#define JSA1212_ALS_DT1_REG            0x09
>> +#define JSA1212_ALS_DT2_REG            0x0A
>> +#define JSA1212_ALS_RNG_REG            0x0B
>> +#define JSA1212_MAX_REG                        0x0C
>> +
>> +/* JSA1212 reg masks */
>> +#define JSA1212_CONF_MASK              0xFF
>> +#define JSA1212_INT_MASK               0xFF
>> +#define JSA1212_PXS_LT_MASK            0xFF
>> +#define JSA1212_PXS_HT_MASK            0xFF
>> +#define JSA1212_ALS_TH1_MASK           0xFF
>> +#define JSA1212_ALS_TH2_LT_MASK                0x0F
>> +#define JSA1212_ALS_TH2_HT_MASK                0xF0
>> +#define JSA1212_ALS_TH3_MASK           0xFF
>> +#define JSA1212_PXS_DATA_MASK          0xFF
>> +#define JSA1212_ALS_DATA_MASK          0xFFF
> Is this 0xFF or 0x0FFF? How many bits of ALS data you have?
Its 12 bits. Rest are anyway zero.
>
>> +#define JSA1212_ALS_DT1_MASK           0xFF
>> +#define JSA1212_ALS_DT2_MASK           0x0F
>> +#define JSA1212_ALS_RNG_MASK           0x07
>> +#define JSA1212_REG_MASK               0xFF
>> +
>> +/* JSA1212 CONF REG bits */
>> +#define JSA1212_CONF_PXS_MASK          0x80
>> +#define JSA1212_CONF_PXS_ENABLE                0x80
>> +#define JSA1212_CONF_PXS_DISABLE       0x00
>> +#define JSA1212_CONF_ALS_MASK          0x04
>> +#define JSA1212_CONF_ALS_ENABLE                0x04
>> +#define JSA1212_CONF_ALS_DISABLE       0x00
>> +#define JSA1212_CONF_IRDR_MASK         0x08
>> +#define JSA1212_CONF_IRDR_ENABLE       0x08
>> +#define JSA1212_CONF_IRDR_DISABLE      0x00
>> +#define JSA1212_CONF_PXS_SLP_MASK      0x70
>> +#define JSA1212_CONF_PXS_SLP_0MS       0x70
>> +#define JSA1212_CONF_PXS_SLP_12MS      0x60
>> +#define JSA1212_CONF_PXS_SLP_50MS      0x50
>> +#define JSA1212_CONF_PXS_SLP_75MS      0x40
>> +#define JSA1212_CONF_PXS_SLP_100MS     0x30
>> +#define JSA1212_CONF_PXS_SLP_200MS     0x20
>> +#define JSA1212_CONF_PXS_SLP_400MS     0x10
>> +#define JSA1212_CONF_PXS_SLP_800MS     0x00
>> +
>> +/* JSA1212 INT REG bits */
>> +#define JSA1212_INT_CTRL_MASK          0x01
>> +#define JSA1212_INT_CTRL_EITHER                0x00
>> +#define JSA1212_INT_CTRL_BOTH          0x01
>> +#define JSA1212_INT_ALS_PRST_MASK      0x06
>> +#define JSA1212_INT_ALS_PRST_1CONV     0x00
>> +#define JSA1212_INT_ALS_PRST_4CONV     0x02
>> +#define JSA1212_INT_ALS_PRST_8CONV     0x04
>> +#define JSA1212_INT_ALS_PRST_16CONV    0x06
>> +#define JSA1212_INT_ALS_FLAG_MASK      0x08
>> +#define JSA1212_INT_ALS_FLAG_CLR       0x00
>> +#define JSA1212_INT_PXS_PRST_MASK      0x60
>> +#define JSA1212_INT_PXS_PRST_1CONV     0x00
>> +#define JSA1212_INT_PXS_PRST_4CONV     0x20
>> +#define JSA1212_INT_PXS_PRST_8CONV     0x40
>> +#define JSA1212_INT_PXS_PRST_16CONV    0x60
>> +#define JSA1212_INT_PXS_FLAG_MASK      0x80
>> +#define JSA1212_INT_PXS_FLAG_CLR       0x00
>> +
>> +/* JSA1212 ALS RNG REG bits */
>> +#define JSA1212_ALS_RNG_0_2048         0x00
>> +#define JSA1212_ALS_RNG_0_1024         0x01
>> +#define JSA1212_ALS_RNG_0_512          0x02
>> +#define JSA1212_ALS_RNG_0_256          0x03
>> +#define JSA1212_ALS_RNG_0_128          0x04
>> +
>> +/* JSA1212 INT threshold range */
>> +#define JSA1212_ALS_TH_MIN     0x0000
>> +#define JSA1212_ALS_TH_MAX     0x0FFF
>> +#define JSA1212_PXS_TH_MIN     0x00
>> +#define JSA1212_PXS_TH_MAX     0xFF
>> +
>> +#define JSA1212_ALS_DELAY_MS   0xC8
>> +#define JSA1212_PXS_DELAY_MS   0x64
>> +
>> +#define JSA1212_DRIVER_NAME    "jsa1212"
>> +#define JSA1212_REGMAP_NAME    "jsa1212_regmap"
>> +
>> +enum jsa1212_op_mode {
>> +       JSA1212_OPMODE_ALS_EN,
>> +       JSA1212_OPMODE_PXS_EN,
>> +};
>> +
>> +struct jsa1212_data {
>> +       struct i2c_client *client;
>> +       struct mutex lock;
>> +       u8 als_rng_idx;
>> +       bool als_en; /* ALS enable status */
>> +       bool pxs_en; /* proximity enable status */
>> +       struct regmap *regmap;
>> +};
>> +
>> +/* ALS range idx to val mapping */
>> +static const int jsa1212_als_range_val[] = {2048, 1024, 512, 256, 128,
>> +                                               128, 128, 128};
>> +
>> +/* Enables or disables ALS function based on status */
>> +static int jsa1212_als_enable(struct jsa1212_data *data, u8 status)
>> +{
>> +       int ret;
>> +
>> +       ret = regmap_update_bits(data->regmap, JSA1212_CONF_REG,
>> +                               JSA1212_CONF_ALS_MASK,
>> +                               status);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       data->als_en = status ? true : false;
> This could written as: data->als_en = !!status;
Both are same. I thought the first one is explicit and simple.
>> +
>> +       return ret;
>> +}
>> +
>> +/* Enables or disables PXS function based on status */
>> +static int jsa1212_pxs_enable(struct jsa1212_data *data, u8 status)
>> +{
>> +       int ret;
>> +
>> +       ret = regmap_update_bits(data->regmap, JSA1212_CONF_REG,
>> +                               JSA1212_CONF_PXS_MASK,
>> +                               status);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       data->pxs_en = status ? true : false;
> Ditto.
same as above.
>> +
>> +       return ret;
>> +}
>> +
>> +static int jsa1212_read_als_data(struct jsa1212_data *data,
>> +                               unsigned int *val)
>> +{
>> +       int ret;
>> +       u8 als_data[2];
>> +
>> +       ret = jsa1212_als_enable(data, JSA1212_CONF_ALS_ENABLE);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* Delay for data output */
>> +       msleep(JSA1212_ALS_DELAY_MS);
>> +
>> +       /* Read 12 bit data */
>> +       ret = regmap_bulk_read(data->regmap, JSA1212_ALS_DT1_REG, als_data, 2);
>> +       if (ret < 0) {
>> +               dev_err(&data->client->dev, "als data read err\n");
>> +               return ret;
>> +       }
> If this fails, I think you should disable ALS.
Agree. Will submit it in next patch.
>
>> +
>> +       *val = le16_to_cpup((__le16 *)als_data);
>> +
>> +       ret = jsa1212_als_enable(data, JSA1212_CONF_ALS_DISABLE);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
>> +static int jsa1212_read_pxs_data(struct jsa1212_data *data,
>> +                               unsigned int *val)
>> +{
>> +       int ret;
>> +       unsigned int pxs_data;
>> +
>> +       ret = jsa1212_pxs_enable(data, JSA1212_CONF_PXS_ENABLE);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* Delay for data output */
>> +       msleep(JSA1212_PXS_DELAY_MS);
>> +
>> +       /* Read out all data */
>> +       ret = regmap_read(data->regmap, JSA1212_PXS_DATA_REG, &pxs_data);
>> +       if (ret < 0) {
>> +               dev_err(&data->client->dev, "pxs data read err\n");
>> +               return ret;
>> +       }
> Ditto.
Same as above.
>> +
>> +       *val = pxs_data & JSA1212_PXS_DATA_MASK;
>> +
>> +       ret = jsa1212_pxs_enable(data, JSA1212_CONF_PXS_DISABLE);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
>> +static int jsa1212_read_raw(struct iio_dev *indio_dev,
>> +                               struct iio_chan_spec const *chan,
>> +                               int *val, int *val2, long mask)
>> +{
>> +       int ret;
>> +       struct jsa1212_data *data = iio_priv(indio_dev);
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               mutex_lock(&data->lock);
>> +               switch (chan->type) {
>> +               case IIO_LIGHT:
>> +                       ret = jsa1212_read_als_data(data, val);
>> +                       break;
>> +               case IIO_PROXIMITY:
>> +                       ret = jsa1212_read_pxs_data(data, val);
>> +                       break;
>> +               default:
>> +                       ret = -EINVAL;
>> +                       break;
>> +               }
>> +               ret = ret < 0 ? ret : IIO_VAL_INT;
>> +               mutex_unlock(&data->lock);
>> +               break;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               switch (chan->type) {
>> +               case IIO_LIGHT:
>> +                       *val = jsa1212_als_range_val[data->als_rng_idx];
>> +                       *val2 = BIT(12); /* Max 12 bit value */
>> +                       ret = IIO_VAL_FRACTIONAL;
>> +                       break;
> How can one change the scale? I'm fine with implementing
> jsa1212_write_raw in another patch.
Yes, It will be added in a separate patch. I just want the initial 
version to be simple.
>
>> +               default:
>> +                       ret = -EINVAL;
>> +                       break;
>> +               }
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct iio_chan_spec jsa1212_channels[] = {
>> +       {
>> +               .type = IIO_LIGHT,
>> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +                       BIT(IIO_CHAN_INFO_SCALE),
>> +       },
>> +       {
>> +               .type = IIO_PROXIMITY,
>> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +       }
>> +};
>> +
>> +static const struct iio_info jsa1212_info = {
>> +       .driver_module          = THIS_MODULE,
>> +       .read_raw               = &jsa1212_read_raw,
>> +};
>> +
>> +static int jsa1212_chip_init(struct jsa1212_data *data)
>> +{
>> +       int ret;
>> +
>> +       ret = regmap_write(data->regmap, JSA1212_CONF_REG,
>> +                               (JSA1212_CONF_PXS_SLP_50MS |
>> +                               JSA1212_CONF_IRDR_ENABLE));
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = regmap_write(data->regmap, JSA1212_INT_REG,
>> +                               JSA1212_INT_ALS_PRST_4CONV);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       data->als_rng_idx = JSA1212_ALS_RNG_0_2048;
>> +
>> +       return 0;
>> +}
>> +
>> +static bool jsa1212_is_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +       switch (reg) {
>> +       case JSA1212_PXS_DATA_REG:
>> +       case JSA1212_ALS_DT1_REG:
>> +       case JSA1212_ALS_DT2_REG:
>> +       case JSA1212_INT_REG:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>> +static struct regmap_config jsa1212_regmap_config = {
>> +       .name =  JSA1212_REGMAP_NAME,
>> +       .reg_bits = 8,
>> +       .val_bits = 8,
>> +       .max_register = JSA1212_MAX_REG,
>> +       .cache_type = REGCACHE_RBTREE,
>> +       .volatile_reg = jsa1212_is_volatile_reg,
>> +};
>> +
>> +static int jsa1212_probe(struct i2c_client *client,
>> +                            const struct i2c_device_id *id)
>> +{
>> +       struct jsa1212_data *jsa1212_data;
>> +       struct iio_dev *indio_dev;
>> +       struct regmap *regmap;
>> +       int ret;
>> +
>> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>> +               return -ENODEV;
>> +
>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*jsa1212_data));
>> +       if (!indio_dev)
>> +               return -ENOMEM;
>> +
>> +       regmap = devm_regmap_init_i2c(client, &jsa1212_regmap_config);
>> +       if (IS_ERR(regmap)) {
>> +               dev_err(&client->dev, "Regmap initialization failed.\n");
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       jsa1212_data = iio_priv(indio_dev);
>> +
>> +       i2c_set_clientdata(client, indio_dev);
>> +       jsa1212_data->client = client;
>> +       jsa1212_data->regmap = regmap;
>> +
>> +       mutex_init(&jsa1212_data->lock);
>> +
>> +       ret = jsa1212_chip_init(jsa1212_data);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       indio_dev->dev.parent = &client->dev;
>> +       indio_dev->channels = jsa1212_channels;
>> +       indio_dev->num_channels = ARRAY_SIZE(jsa1212_channels);
>> +       indio_dev->name = JSA1212_DRIVER_NAME;
>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +       indio_dev->info = &jsa1212_info;
>> +
>> +       ret = iio_device_register(indio_dev);
>> +       if (ret < 0) {
>> +               dev_err(&client->dev, "%s: register device failed\n", __func__);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> + /* power off the device */
>> +static int jsa1212_power_off(struct jsa1212_data *data)
>> +{
>> +       int ret;
>> +
>> +       mutex_lock(&data->lock);
>> +
>> +       ret = regmap_update_bits(data->regmap, JSA1212_CONF_REG,
>> +                               JSA1212_CONF_ALS_MASK |
>> +                               JSA1212_CONF_PXS_MASK,
>> +                               JSA1212_CONF_ALS_DISABLE |
>> +                               JSA1212_CONF_PXS_DISABLE);
>> +
>> +       if (ret < 0)
>> +               dev_err(&data->client->dev, "power off cmd failed\n");
>> +
>> +       mutex_unlock(&data->lock);
>> +
>> +       return ret;
>> +}
>> +
>> +
>> +static int jsa1212_remove(struct i2c_client *client)
>> +{
>> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +       struct jsa1212_data *data = iio_priv(indio_dev);
>> +       int ret;
>> +
>> +       iio_device_unregister(indio_dev);
>> +
>> +       ret = jsa1212_power_off(data);
>> +
>> +       return ret;
> No need for ret variable here. You could just return js1212_power_off(data);
Agree. Will  fix it.
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int jsa1212_suspend(struct device *dev)
>> +{
>> +       struct jsa1212_data *data;
>> +
>> +       data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +       return jsa1212_power_off(data);
>> +}
>> +
>> +static int jsa1212_resume(struct device *dev)
>> +{
>> +       int ret = 0;
>> +       struct jsa1212_data *data;
>> +
>> +       data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>> +
>> +       mutex_lock(&data->lock);
>> +
>> +       if (data->als_en) {
>> +               ret = jsa1212_als_enable(data, JSA1212_CONF_ALS_ENABLE);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "als resume failed\n");
>> +                       goto unlock_and_ret;
>> +               }
>> +       }
>> +
>> +       if (data->pxs_en) {
>> +               ret = jsa1212_pxs_enable(data, JSA1212_CONF_PXS_ENABLE);
>> +               if (ret < 0)
>> +                       dev_err(dev, "pxs resume failed\n");
>> +       }
>> +
>> +unlock_and_ret:
>> +       mutex_unlock(&data->lock);
>> +       return ret;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend, jsa1212_resume);
>> +
>> +#define JSA1212_PM_OPS (&jsa1212_pm_ops)
>> +#else
>> +#define JSA1212_PM_OPS NULL
>> +#endif
>> +
>> +static const struct acpi_device_id jsa1212_acpi_match[] = {
>> +       {"JSA1212", 0},
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
>> +
>> +static const struct i2c_device_id jsa1212_id[] = {
>> +       { JSA1212_DRIVER_NAME, 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, jsa1212_id);
>> +
>> +static struct i2c_driver jsa1212_driver = {
>> +       .driver = {
>> +               .name   = JSA1212_DRIVER_NAME,
>> +               .pm     = JSA1212_PM_OPS,
>> +               .owner  = THIS_MODULE,
>> +               .acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
>> +       },
>> +       .probe          = jsa1212_probe,
>> +       .remove         = jsa1212_remove,
>> +       .id_table       = jsa1212_id,
>> +};
>> +module_i2c_driver(jsa1212_driver);
>> +
>> +MODULE_AUTHOR("Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>");
>> +MODULE_DESCRIPTION("JSA1212 proximity/ambient light sensor driver");
>> +MODULE_LICENSE("GPL v2");
> thanks,
> Daniel.
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

