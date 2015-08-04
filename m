Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:32987 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbbHDOVJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 10:21:09 -0400
MIME-Version: 1.0
In-Reply-To: <1438695613-6394-1-git-send-email-adriana.reus@intel.com>
References: <1438095798-10693-1-git-send-email-adriana.reus@intel.com>
	<1438695613-6394-1-git-send-email-adriana.reus@intel.com>
Date: Tue, 4 Aug 2015 17:21:06 +0300
Message-ID: <CAEnQRZDRH4O5xmiQec_1sLn_ZvLYVaYfjqo4Bbxs4OqGLM66DA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: Add support for UPISEMI uS5182d als and
 proximity sensor
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Adriana Reus <adriana.reus@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 4, 2015 at 4:40 PM, Adriana Reus <adriana.reus@intel.com> wrote:
> Add support for UPISEMI us5182d als and proximity sensor.
> Supports raw readings.
> Data sheet for this device can be found here:
> http://www.upi-semi.com/temp/uS5182D-DS-P0103-temp.pdf
>
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>

Looks good to me.  Thanks Adriana!

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  Changes since v1: added data-sheet link to commit message
>  drivers/iio/light/Kconfig   |  10 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/us5182d.c | 539 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 550 insertions(+)
>  create mode 100644 drivers/iio/light/us5182d.c
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index a459341..0aa819d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -285,6 +285,16 @@ config TSL4531
>          To compile this driver as a module, choose M here: the
>          module will be called tsl4531.
>
> +config US5182D
> +       tristate "UPISEMI light and proximity sensor"
> +       depends on I2C
> +       help
> +        If you say yes here you get support for the UPISEMI US5182D
> +        ambient light and proximity sensor.
> +
> +        This driver can also be built as a module.  If so, the module
> +        will be called us5182d.
> +
>  config VCNL4000
>         tristate "VCNL4000 combined ALS and proximity sensor"
>         depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 91c74c0..528cc8f 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -27,4 +27,5 @@ obj-$(CONFIG_STK3310)          += stk3310.o
>  obj-$(CONFIG_TCS3414)          += tcs3414.o
>  obj-$(CONFIG_TCS3472)          += tcs3472.o
>  obj-$(CONFIG_TSL4531)          += tsl4531.o
> +obj-$(CONFIG_US5182D)          += us5182d.o
>  obj-$(CONFIG_VCNL4000)         += vcnl4000.o
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> new file mode 100644
> index 0000000..6654bb0
> --- /dev/null
> +++ b/drivers/iio/light/us5182d.c
> @@ -0,0 +1,539 @@
> +/*
> + * Copyright (c) 2015 Intel Corporation
> + *
> + * Driver for UPISEMI us5182d Proximity and Ambient Light Sensor.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * To do: Interrupt support.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/mutex.h>
> +
> +#define US5182D_REG_CFG0               0x00
> +#define US5182D_REG_CFG1               0x01
> +#define US5182D_REG_CFG2               0x02
> +#define US5182D_REG_CFG3               0x03
> +#define US5182D_REG_CFG4               0x10
> +
> +/*
> + * Registers for tuning the auto dark current cancelling feature.
> + * DARK_TH(reg 0x27,0x28) - threshold (counts) for auto dark cancelling.
> + * when ALS  > DARK_TH --> ALS_Code = ALS - Upper(0x2A) * Dark
> + * when ALS < DARK_TH --> ALS_Code = ALS - Lower(0x29) * Dark
> + */
> +#define US5182D_REG_UDARK_TH                   0x27
> +#define US5182D_REG_DARK_AUTO_EN               0x2b
> +#define US5182D_REG_AUTO_LDARK_TH              0x29
> +#define US5182D_REG_AUTO_HDARK_TH              0x2a
> +
> +/*
> + * power-mode - oneshot, non-interrupt, word mode access for
> + * als code, th registers.
> + */
> +#define US5182D_REG_CFG0_DEFAULT               0x81
> +
> +/*
> + * no als fault queue, 16 bit als resolution (supports 12 and 14 also),
> + * max-range 12354.
> + */
> +#define US5182D_REG_CFG1_DEFAULT               0x10
> +
> +/*
> + * 16 bit resolution for PX, x16 sensing amplifier for px
> + * supports [x1 x2 x4 x8 x16 x32 x64 x128]
> + */
> +#define US5182D_REG_CFG2_DEFAULT               0x14
> +
> +/*
> + * led current : 100mA, supports [12.5 25 50 100] mA,
> + * interrupt source selection "px approach",
> + * [als or ps, als only, ps only, ps approach]
> + */
> +#define US5182D_REG_CFG3_DEFAULT               0x3C
> +
> +/*
> + * led frequency ADC Clock/2 from [ADC Clock/2, /4, /8, /10]
> + * automatic 50/60 Hz ripple rejection disabled.
> + */
> +#define US5182D_REG_CFG4_DEFAULT               0x00
> +
> +#define US5182D_REG_DARK_AUTO_EN_DEFAULT       0x80
> +#define US5182D_REG_AUTO_LDARK_TH_DEFAULT      0x16
> +#define US5182D_REG_AUTO_HDARK_TH_DEFAULT      0x00
> +
> +#define US5182D_REG_ADL                        0x0c
> +#define US5182D_REG_PDL                        0x0e
> +
> +#define US5182D_REG_MODE_STORE         0x21
> +#define US5182D_STORE_MODE             0x01
> +
> +#define US5182D_REG_CHIPID             0xb2
> +
> +#define US5182D_ONESHOT_EN_MASK                BIT(6)
> +#define US5182D_SHUTDOWN_EN_MASK       BIT(7)
> +#define US5182D_OPMODE_MASK            GENMASK(5, 4)
> +#define US5182D_AGAIN_MASK             0x07
> +#define US5182D_OPMODE_ALS             0x01
> +#define US5182D_OPMODE_PX              0x02
> +#define US5182D_OPMODE_SHIFT           4
> +#define US5182D_RESET_CHIP             0x01
> +
> +#define US5182D_CHIPID                 0x26
> +#define US5182D_DRV_NAME               "us5182d"
> +
> +#define US5182D_GA_RESOLUTION          1000
> +
> +#define READ_BYTE              1
> +#define READ_WORD              2
> +#define OPSTORE_SLEEP_TIME     20 /* ms */
> +
> +/* available ranges: [12354, 7065, 3998, 2202, 1285, 498, 256, 138] lux*/
> +static const int us5182d_scales[] = {188500, 107800, 61000, 33600, 19600, 7600,
> +                                    3900, 2100};
> +
> +/*
> + * experimental th's that work with US5182D sensor on evaluation board
> + * roughly between 12-32 lux
> + */
> +static u16 us5182d_dark_ths_vals[] = {170, 200, 512, 512, 800, 2000, 4000,
> +                                     8000};
> +
> +enum mode {
> +       ALS_PX,
> +       ALS_ONLY,
> +       PX_ONLY
> +};
> +
> +struct us5182d_data {
> +       struct i2c_client *client;
> +       /* protect opmode */
> +       struct mutex lock;
> +
> +       /* Glass attenuation factor */
> +       u32 ga;
> +
> +       /* Dark gain tuning */
> +       u16 lower_dark_th;
> +       u16 upper_dark_th;
> +       u16 *us5182d_dark_ths;
> +
> +       u8 opmode;
> +};
> +
> +static IIO_CONST_ATTR(in_illuminance_scale_available,
> +                     "0.0021 0.0039 0.0076 0.0196 0.0336 0.061 0.1078 0.1885");
> +
> +static struct attribute *us5182d_attrs[] = {
> +       &iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group us5182d_attr_group = {
> +       .attrs = us5182d_attrs,
> +};
> +
> +static const struct {
> +       u8 reg;
> +       u8 val;
> +} us5182d_regvals[] = {
> +       {US5182D_REG_CFG0, US5182D_REG_CFG0_DEFAULT},
> +       {US5182D_REG_CFG1, US5182D_REG_CFG1_DEFAULT},
> +       {US5182D_REG_CFG2, US5182D_REG_CFG2_DEFAULT},
> +       {US5182D_REG_CFG3, US5182D_REG_CFG3_DEFAULT},
> +       {US5182D_REG_MODE_STORE, US5182D_STORE_MODE},
> +       {US5182D_REG_CFG4, US5182D_REG_CFG4_DEFAULT},
> +};
> +
> +static const struct iio_chan_spec us5182d_channels[] = {
> +       {
> +               .type = IIO_LIGHT,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +                                     BIT(IIO_CHAN_INFO_SCALE),
> +       },
> +       {
> +               .type = IIO_PROXIMITY,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +       }
> +};
> +
> +static int us5182d_read(struct i2c_client *client, u8 reg, int len, u8 *val)
> +{
> +       struct i2c_msg msg[2] = {
> +               {
> +                       /* Write - use repeated start */
> +                       .addr = client->addr,
> +                       .flags = I2C_M_NOSTART,
> +                       .len = 1,
> +                       .buf = &reg
> +               },
> +               {
> +                       .addr = client->addr,
> +                       .flags = I2C_M_RD,
> +                       .len = len,
> +                       .buf = val
> +               }
> +       };
> +
> +       return i2c_transfer(client->adapter, msg, 2);
> +}
> +
> +static int us5182d_read_byte_data(struct i2c_client *client, u8 reg)
> +{
> +       u8 val[1];
> +       int ret;
> +
> +       ret = us5182d_read(client, reg, READ_BYTE, val);
> +       return (ret < 0) ? ret : val[0];
> +}
> +
> +static int us5182d_read_word_data(struct i2c_client *client, u8 reg)
> +{
> +       u8 val[2];
> +       int ret;
> +
> +       ret = us5182d_read(client, reg, READ_WORD, val);
> +       return (ret < 0) ? ret : (val[0] | (val[1] << 8));
> +}
> +
> +static int us5182d_get_als(struct us5182d_data *data)
> +{
> +       int ret;
> +       unsigned long result;
> +
> +       ret = us5182d_read_word_data(data->client,
> +                                    US5182D_REG_ADL);
> +       if (ret < 0)
> +               return ret;
> +
> +       result = ret * data->ga / US5182D_GA_RESOLUTION;
> +       if (result > 0xffff)
> +               result = 0xffff;
> +
> +       return result;
> +}
> +
> +static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
> +{
> +       int ret;
> +
> +       ret = us5182d_read_byte_data(data->client, US5182D_REG_CFG0);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = ret | US5182D_ONESHOT_EN_MASK;
> +
> +       /* update mode */
> +       ret = ret & ~US5182D_OPMODE_MASK;
> +       ret = ret | (mode << US5182D_OPMODE_SHIFT);
> +
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (mode == data->opmode)
> +               return 0;
> +
> +       data->opmode = mode;
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_MODE_STORE,
> +                                       US5182D_STORE_MODE);
> +       if (ret < 0)
> +               return ret;
> +       msleep(OPSTORE_SLEEP_TIME);
> +
> +       return 0;
> +}
> +
> +static int us5182d_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan, int *val,
> +                           int *val2, long mask)
> +{
> +       struct us5182d_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               switch (chan->type) {
> +               case IIO_LIGHT:
> +                       mutex_lock(&data->lock);
> +                       ret = us5182d_set_opmode(data, US5182D_OPMODE_ALS);
> +                       if (ret < 0)
> +                               goto out_err;
> +
> +                       ret = us5182d_get_als(data);
> +                       if (ret < 0)
> +                               goto out_err;
> +                       mutex_unlock(&data->lock);
> +                       *val = ret;
> +                       *val2 = 0;
> +                       return IIO_VAL_INT;
> +               case IIO_PROXIMITY:
> +                       mutex_lock(&data->lock);
> +                       ret = us5182d_set_opmode(data, US5182D_OPMODE_PX);
> +                       if (ret < 0)
> +                               goto out_err;
> +
> +                       ret = us5182d_read_word_data(data->client,
> +                                                    US5182D_REG_PDL);
> +                       if (ret < 0)
> +                               goto out_err;
> +                       mutex_unlock(&data->lock);
> +                       *val = ret;
> +                       *val2 = 0;
> +                       return  IIO_VAL_INT;
> +               default:
> +                       break;
> +               }
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               ret = us5182d_read_byte_data(data->client, US5182D_REG_CFG1);
> +               if (ret < 0)
> +                       return ret;
> +               *val = 0;
> +               ret = (ret & US5182D_AGAIN_MASK);
> +               *val2 = us5182d_scales[ret];
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return -EINVAL;
> +out_err:
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}
> +
> +static int us5182d_update_dark_th(struct us5182d_data *data, int index)
> +{
> +       __be16 dark_th = cpu_to_be16(data->us5182d_dark_ths[index]);
> +       u8 *bytes = (u8 *)&dark_th;
> +       int ret;
> +
> +       /* Registers Dark_Th (0x27 0x28) don't work in word mode accessing */
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_UDARK_TH,
> +                                       bytes[0]);
> +       if (ret < 0)
> +               return ret;
> +
> +       return i2c_smbus_write_byte_data(data->client, US5182D_REG_UDARK_TH + 1,
> +                                       bytes[1]);
> +}
> +
> +static int us5182d_apply_scale(struct us5182d_data *data, int index)
> +{
> +       int ret;
> +
> +       ret = us5182d_read_byte_data(data->client, US5182D_REG_CFG1);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = ret & (~US5182D_AGAIN_MASK);
> +       ret |= index;
> +
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG1, ret);
> +       if (ret < 0)
> +               return ret;
> +
> +       return us5182d_update_dark_th(data, index);
> +}
> +
> +static int us5182d_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan, int val,
> +                            int val2, long mask)
> +{
> +       struct us5182d_data *data = iio_priv(indio_dev);
> +       int i;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               if (val != 0)
> +                       return -EINVAL;
> +               for (i = 0; i < ARRAY_SIZE(us5182d_scales); i++)
> +                       if (val2 == us5182d_scales[i])
> +                               return us5182d_apply_scale(data, i);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct iio_info us5182d_info = {
> +       .driver_module  = THIS_MODULE,
> +       .read_raw = us5182d_read_raw,
> +       .write_raw = us5182d_write_raw,
> +       .attrs = &us5182d_attr_group,
> +};
> +
> +static int us5182d_reset(struct iio_dev *indio_dev)
> +{
> +       struct us5182d_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG3,
> +                                       US5182D_RESET_CHIP);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int us5182d_init(struct iio_dev *indio_dev)
> +{
> +       struct us5182d_data *data = iio_priv(indio_dev);
> +       int i, ret;
> +
> +       ret = us5182d_reset(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       data->opmode = 0;
> +       for (i = 0; i < ARRAY_SIZE(us5182d_regvals); i++) {
> +               ret = i2c_smbus_write_byte_data(data->client,
> +                                               us5182d_regvals[i].reg,
> +                                               us5182d_regvals[i].val);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void us5182d_get_platform_data(struct iio_dev *indio_dev)
> +{
> +       struct us5182d_data *data = iio_priv(indio_dev);
> +
> +       if (device_property_read_u32(&data->client->dev, "upisemi,glass-coef",
> +                                    &data->ga))
> +               data->ga = US5182D_GA_RESOLUTION;
> +       if (device_property_read_u16_array(&data->client->dev,
> +                                          "upisemi,dark-ths",
> +                                          data->us5182d_dark_ths,
> +                                          ARRAY_SIZE(us5182d_dark_ths_vals)))
> +               data->us5182d_dark_ths = us5182d_dark_ths_vals;
> +       if (device_property_read_u16(&data->client->dev,
> +                                    "upisemi,upper-dark-gain",
> +                                    &data->upper_dark_th))
> +               data->upper_dark_th = US5182D_REG_AUTO_HDARK_TH_DEFAULT;
> +       if (device_property_read_u16(&data->client->dev,
> +                                    "upisemi,lower-dark-gain",
> +                                    &data->lower_dark_th))
> +               data->lower_dark_th = US5182D_REG_AUTO_LDARK_TH_DEFAULT;
> +}
> +
> +static int  us5182d_dark_gain_config(struct iio_dev *indio_dev)
> +{
> +       struct us5182d_data *data = iio_priv(indio_dev);
> +       u8 index = US5182D_REG_CFG1_DEFAULT & US5182D_AGAIN_MASK;
> +       int ret;
> +
> +       ret = us5182d_update_dark_th(data, index);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_AUTO_LDARK_TH,
> +                                       data->lower_dark_th);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_AUTO_HDARK_TH,
> +                                       data->upper_dark_th);
> +       if (ret < 0)
> +               return ret;
> +
> +       return i2c_smbus_write_byte_data(data->client, US5182D_REG_DARK_AUTO_EN,
> +                                       US5182D_REG_DARK_AUTO_EN_DEFAULT);
> +}
> +
> +static int us5182d_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct us5182d_data *data;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data = iio_priv(indio_dev);
> +       i2c_set_clientdata(client, indio_dev);
> +       data->client = client;
> +
> +       mutex_init(&data->lock);
> +
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->info = &us5182d_info;
> +       indio_dev->name = US5182D_DRV_NAME;
> +       indio_dev->channels = us5182d_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(us5182d_channels);
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       ret = us5182d_read_byte_data(data->client, US5182D_REG_CHIPID);
> +       if (ret != US5182D_CHIPID)
> +               dev_warn(&data->client->dev,
> +                        "Failed to detect US5182 light chip\n");
> +
> +       us5182d_get_platform_data(indio_dev);
> +       ret = us5182d_init(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = us5182d_dark_gain_config(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       return iio_device_register(indio_dev);
> +}
> +
> +static int us5182d_remove(struct i2c_client *client)
> +{
> +       iio_device_unregister(i2c_get_clientdata(client));
> +       return i2c_smbus_write_byte_data(client, US5182D_REG_CFG0,
> +                                        US5182D_REG_CFG0_DEFAULT);
> +}
> +
> +static const struct acpi_device_id us5182d_acpi_match[] = {
> +       { "USD5182", 0},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, us5182d_acpi_match);
> +
> +static const struct i2c_device_id us5182d_id[] = {
> +               {"usd5182", 0},
> +               {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, us5182d_id);
> +
> +static struct i2c_driver us5182d_driver = {
> +       .driver = {
> +               .name = US5182D_DRV_NAME,
> +               .acpi_match_table = ACPI_PTR(us5182d_acpi_match),
> +       },
> +       .probe = us5182d_probe,
> +       .remove = us5182d_remove,
> +       .id_table = us5182d_id,
> +
> +};
> +module_i2c_driver(us5182d_driver);
> +
> +MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");
> +MODULE_DESCRIPTION("Driver for us5182d Proximity and Light Sensor");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
