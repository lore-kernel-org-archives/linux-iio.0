Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1461505931-21884-2-git-send-email-akinobu.mita@gmail.com>
References: <1461505931-21884-1-git-send-email-akinobu.mita@gmail.com> <1461505931-21884-2-git-send-email-akinobu.mita@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 26 Apr 2016 20:21:41 -0700
Message-ID: <CAKzfze_U835vkSvXCpcPxE3wuUZTraFEMy88mouXyExQYhq-9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: pressure: bmp280: add support for BMP180
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Vlad Dogaru <vlad.dogaru@intel.com>,
	Christoph Mair <christoph.mair@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 24, 2016 at 6:52 AM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> This adds support for the BMP180 to the bmp280 iio driver.
>
> The BMP180 has already been supported by misc/bmp085 driver but it
> doesn't use iio framework.  This change adds the kconfig dependency
> not to be selected both of them in order to avoid any issues.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: Christoph Mair <christoph.mair@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
> * v3
> - use single line comment style where possible suggested by Jonathan Cameron
> - remove double casts for calibration coefficients by using adequate data
>   types, suggested by Jonathan Cameron
>
>  drivers/iio/pressure/Kconfig  |   5 +-
>  drivers/iio/pressure/bmp280.c | 367 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 356 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index e8f60db..31e5d36 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -6,11 +6,12 @@
>  menu "Pressure sensors"
>
>  config BMP280
> -       tristate "Bosch Sensortec BMP280 pressure sensor driver"
> +       tristate "Bosch Sensortec BMP180 and BMP280 pressure sensor driver"
>         depends on I2C
> +       depends on !(BMP085_I2C=y || BMP085_I2C=m)
>         select REGMAP_I2C
>         help
> -        Say yes here to build support for Bosch Sensortec BMP280
> +        Say yes here to build support for Bosch Sensortec BMP180 and BMP280
>          pressure and temperature sensor.
>
>          To compile this driver as a module, choose M here: the module
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index a2602d8..dcf3b0a 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -1,12 +1,15 @@
>  /*
>   * Copyright (c) 2014 Intel Corporation
>   *
> - * Driver for Bosch Sensortec BMP280 digital pressure sensor.
> + * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> + * Datasheet:
> + * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> + * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
>   */
>
>  #define pr_fmt(fmt) "bmp280: " fmt
> @@ -15,9 +18,11 @@
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/regmap.h>
> +#include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>
> +/* BMP280 specific registers */
>  #define BMP280_REG_TEMP_XLSB           0xFC
>  #define BMP280_REG_TEMP_LSB            0xFB
>  #define BMP280_REG_TEMP_MSB            0xFA
> @@ -26,10 +31,7 @@
>  #define BMP280_REG_PRESS_MSB           0xF7
>
>  #define BMP280_REG_CONFIG              0xF5
> -#define BMP280_REG_CTRL_MEAS           0xF4
>  #define BMP280_REG_STATUS              0xF3
> -#define BMP280_REG_RESET               0xE0
> -#define BMP280_REG_ID                  0xD0
>
>  #define BMP280_REG_COMP_TEMP_START     0x88
>  #define BMP280_COMP_TEMP_REG_COUNT     6
> @@ -65,6 +67,28 @@
>  #define BMP280_MODE_FORCED             BIT(0)
>  #define BMP280_MODE_NORMAL             (BIT(1) | BIT(0))
>
> +/* BMP180 specific registers */
> +#define BMP180_REG_OUT_XLSB            0xF8
> +#define BMP180_REG_OUT_LSB             0xF7
> +#define BMP180_REG_OUT_MSB             0xF6
> +
> +#define BMP180_REG_CALIB_START         0xAA
> +#define BMP180_REG_CALIB_COUNT         22
> +
> +#define BMP180_MEAS_SCO                        BIT(5)
> +#define BMP180_MEAS_TEMP               (0x0E | BMP180_MEAS_SCO)
> +#define BMP180_MEAS_PRESS_X(oss)       ((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
> +#define BMP180_MEAS_PRESS_1X           BMP180_MEAS_PRESS_X(0)
> +#define BMP180_MEAS_PRESS_2X           BMP180_MEAS_PRESS_X(1)
> +#define BMP180_MEAS_PRESS_4X           BMP180_MEAS_PRESS_X(2)
> +#define BMP180_MEAS_PRESS_8X           BMP180_MEAS_PRESS_X(3)
> +
> +/* BMP180 and BMP280 common registers */
> +#define BMP280_REG_CTRL_MEAS           0xF4
> +#define BMP280_REG_RESET               0xE0
> +#define BMP280_REG_ID                  0xD0
> +
> +#define BMP180_CHIP_ID                 0x55
>  #define BMP280_CHIP_ID                 0x58
>  #define BMP280_SOFT_RESET_VAL          0xB6
>
> @@ -72,6 +96,7 @@ struct bmp280_data {
>         struct i2c_client *client;
>         struct mutex lock;
>         struct regmap *regmap;
> +       const struct bmp280_chip_info *chip_info;
>
>         /*
>          * Carryover value from temperature conversion, used in pressure
> @@ -80,9 +105,17 @@ struct bmp280_data {
>         s32 t_fine;
>  };
>
> +struct bmp280_chip_info {
> +       const struct regmap_config *regmap_config;
> +
> +       int (*chip_config)(struct bmp280_data *);
> +       int (*read_temp)(struct bmp280_data *, int *);
> +       int (*read_press)(struct bmp280_data *, int *, int *);
> +};
> +
>  /*
>   * These enums are used for indexing into the array of compensation
> - * parameters.
> + * parameters for BMP280.
>   */
>  enum { T1, T2, T3 };
>  enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> @@ -290,10 +323,10 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>         case IIO_CHAN_INFO_PROCESSED:
>                 switch (chan->type) {
>                 case IIO_PRESSURE:
> -                       ret = bmp280_read_press(data, val, val2);
> +                       ret = data->chip_info->read_press(data, val, val2);
>                         break;
>                 case IIO_TEMP:
> -                       ret = bmp280_read_temp(data, val);
> +                       ret = data->chip_info->read_temp(data, val);
>                         break;
>                 default:
>                         ret = -EINVAL;
> @@ -315,7 +348,7 @@ static const struct iio_info bmp280_info = {
>         .read_raw = &bmp280_read_raw,
>  };
>
> -static int bmp280_chip_init(struct bmp280_data *data)
> +static int bmp280_chip_config(struct bmp280_data *data)
>  {
>         int ret;
>
> @@ -344,6 +377,296 @@ static int bmp280_chip_init(struct bmp280_data *data)
>         return ret;
>  }
>
> +static const struct bmp280_chip_info bmp280_chip_info = {
> +       .regmap_config = &bmp280_regmap_config,
> +       .chip_config = bmp280_chip_config,
> +       .read_temp = bmp280_read_temp,
> +       .read_press = bmp280_read_press,
> +};
> +
> +static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case BMP280_REG_CTRL_MEAS:
> +       case BMP280_REG_RESET:
> +               return true;
> +       default:
> +               return false;
> +       };
> +}
> +
> +static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case BMP180_REG_OUT_XLSB:
> +       case BMP180_REG_OUT_LSB:
> +       case BMP180_REG_OUT_MSB:
> +       case BMP280_REG_CTRL_MEAS:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static const struct regmap_config bmp180_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +
> +       .max_register = BMP180_REG_OUT_XLSB,
> +       .cache_type = REGCACHE_RBTREE,
> +
> +       .writeable_reg = bmp180_is_writeable_reg,
> +       .volatile_reg = bmp180_is_volatile_reg,
> +};
> +
> +static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
> +{
> +       int ret;
> +       const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
> +       unsigned int delay_us;
> +       unsigned int ctrl;
> +
> +       ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
> +       if (ret)
> +               return ret;
> +
> +       if (ctrl_meas == BMP180_MEAS_TEMP)
> +               delay_us = 4500;
> +       else
> +               delay_us = conversion_time_max[ilog2(8)];
> +
> +       usleep_range(delay_us, delay_us + 1000);
> +
> +       ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
> +       if (ret)
> +               return ret;
> +
> +       /* The value of this bit reset to "0" after conversion is complete */
> +       if (ctrl & BMP180_MEAS_SCO)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
> +{
> +       int ret;
> +       __be16 tmp = 0;
> +
> +       ret = bmp180_measure(data, BMP180_MEAS_TEMP);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 2);
> +       if (ret)
> +               return ret;
> +
> +       *val = be16_to_cpu(tmp);
> +
> +       return 0;
> +}
> +
> +/*
> + * These enums are used for indexing into the array of calibration
> + * coefficients for BMP180.
> + */
> +enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> +
> +struct bmp180_calib {
> +       s16 AC1;
> +       s16 AC2;
> +       s16 AC3;
> +       u16 AC4;
> +       u16 AC5;
> +       u16 AC6;
> +       s16 B1;
> +       s16 B2;
> +       s16 MB;
> +       s16 MC;
> +       s16 MD;
> +};
> +
> +static int bmp180_read_calib(struct bmp280_data *data,
> +                            struct bmp180_calib *calib)
> +{
> +       int ret;
> +       int i;
> +       __be16 buf[BMP180_REG_CALIB_COUNT / 2];
> +
> +       ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
> +                              sizeof(buf));
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       /* None of the words has the value 0 or 0xFFFF */
> +       for (i = 0; i < ARRAY_SIZE(buf); i++) {
> +               if (buf[i] == cpu_to_be16(0) || buf[i] == cpu_to_be16(0xffff))
> +                       return -EIO;
> +       }
> +
> +       calib->AC1 = be16_to_cpu(buf[AC1]);
> +       calib->AC2 = be16_to_cpu(buf[AC2]);
> +       calib->AC3 = be16_to_cpu(buf[AC3]);
> +       calib->AC4 = be16_to_cpu(buf[AC4]);
> +       calib->AC5 = be16_to_cpu(buf[AC5]);
> +       calib->AC6 = be16_to_cpu(buf[AC6]);
> +       calib->B1 = be16_to_cpu(buf[B1]);
> +       calib->B2 = be16_to_cpu(buf[B2]);
> +       calib->MB = be16_to_cpu(buf[MB]);
> +       calib->MC = be16_to_cpu(buf[MC]);
> +       calib->MD = be16_to_cpu(buf[MD]);
> +
> +       return 0;
> +}
> +
> +/*
> + * Returns temperature in DegC, resolution is 0.1 DegC.
> + * t_fine carries fine temperature as global value.
> + *
> + * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
> + */
> +static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
> +{
> +       int ret;
> +       s32 x1, x2;
> +       struct bmp180_calib calib;
> +
> +       ret = bmp180_read_calib(data, &calib);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev,
> +                       "failed to read calibration coefficients\n");
> +               return ret;
> +       }
> +
> +       x1 = ((adc_temp - calib.AC6) * calib.AC5) >> 15;
> +       x2 = (calib.MC << 11) / (x1 + calib.MD);
> +       data->t_fine = x1 + x2;
> +
> +       return (data->t_fine + 8) >> 4;
> +}
> +
> +static int bmp180_read_temp(struct bmp280_data *data, int *val)
> +{
> +       int ret;
> +       s32 adc_temp, comp_temp;
> +
> +       ret = bmp180_read_adc_temp(data, &adc_temp);
> +       if (ret)
> +               return ret;
> +
> +       comp_temp = bmp180_compensate_temp(data, adc_temp);
> +
> +       /*
> +        * val might be NULL if we're called by the read_press routine,
> +        * who only cares about the carry over t_fine value.
> +        */
> +       if (val) {
> +               *val = comp_temp * 100;
> +               return IIO_VAL_INT;
> +       }
> +
> +       return 0;
> +}
> +
> +static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
> +{
> +       int ret;
> +       __be32 tmp = 0;
> +       u8 oss = ilog2(8);
> +
> +       ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 3);
> +       if (ret)
> +               return ret;
> +
> +       *val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
> +
> +       return 0;
> +}
> +
> +/*
> + * Returns pressure in Pa, resolution is 1 Pa.
> + *
> + * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
> + */
> +static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
> +{
> +       int ret;
> +       s32 x1, x2, x3, p;
> +       s32 b3, b6;
> +       u32 b4, b7;
> +       s32 oss = ilog2(8);
> +       struct bmp180_calib calib;
> +
> +       ret = bmp180_read_calib(data, &calib);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev,
> +                       "failed to read calibration coefficients\n");
> +               return ret;
> +       }
> +
> +       b6 = data->t_fine - 4000;
> +       x1 = (calib.B2 * (b6 * b6 >> 12)) >> 11;
> +       x2 = calib.AC2 * b6 >> 11;
> +       x3 = x1 + x2;
> +       b3 = ((((s32)calib.AC1 * 4 + x3) << oss) + 2) / 4;
> +       x1 = calib.AC3 * b6 >> 13;
> +       x2 = (calib.B1 * ((b6 * b6) >> 12)) >> 16;
> +       x3 = (x1 + x2 + 2) >> 2;
> +       b4 = calib.AC4 * (u32)(x3 + 32768) >> 15;
> +       b7 = ((u32)adc_press - b3) * (50000 >> oss);
> +       if (b7 < 0x80000000)
> +               p = (b7 * 2) / b4;
> +       else
> +               p = (b7 / b4) * 2;
> +
> +       x1 = (p >> 8) * (p >> 8);
> +       x1 = (x1 * 3038) >> 16;
> +       x2 = (-7357 * p) >> 16;
> +
> +       return p + ((x1 + x2 + 3791) >> 4);
> +}
> +
> +static int bmp180_read_press(struct bmp280_data *data,
> +                            int *val, int *val2)
> +{
> +       int ret;
> +       s32 adc_press;
> +       u32 comp_press;
> +
> +       /* Read and compensate temperature so we get a reading of t_fine. */
> +       ret = bmp180_read_temp(data, NULL);
> +       if (ret)
> +               return ret;
> +
> +       ret = bmp180_read_adc_press(data, &adc_press);
> +       if (ret)
> +               return ret;
> +
> +       comp_press = bmp180_compensate_press(data, adc_press);
> +
> +       *val = comp_press;
> +       *val2 = 1000;
> +
> +       return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int bmp180_chip_config(struct bmp280_data *data)
> +{
> +       return 0;
> +}
> +
> +static const struct bmp280_chip_info bmp180_chip_info = {
> +       .regmap_config = &bmp180_regmap_config,
> +       .chip_config = bmp180_chip_config,
> +       .read_temp = bmp180_read_temp,
> +       .read_press = bmp180_read_press,
> +};
> +
>  static int bmp280_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
> @@ -367,7 +690,19 @@ static int bmp280_probe(struct i2c_client *client,
>         indio_dev->info = &bmp280_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> -       data->regmap = devm_regmap_init_i2c(client, &bmp280_regmap_config);
> +       switch (id->driver_data) {
> +       case BMP180_CHIP_ID:
> +               data->chip_info = &bmp180_chip_info;
> +               break;
> +       case BMP280_CHIP_ID:
> +               data->chip_info = &bmp280_chip_info;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       data->regmap = devm_regmap_init_i2c(client,
> +                                       data->chip_info->regmap_config);
>         if (IS_ERR(data->regmap)) {
>                 dev_err(&client->dev, "failed to allocate register map\n");
>                 return PTR_ERR(data->regmap);
> @@ -376,13 +711,13 @@ static int bmp280_probe(struct i2c_client *client,
>         ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
>         if (ret < 0)
>                 return ret;
> -       if (chip_id != BMP280_CHIP_ID) {
> +       if (chip_id != id->driver_data) {
>                 dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
>                         BMP280_CHIP_ID, chip_id);

BMP280_CHIP_ID should be id->driver_data as well

>                 return -EINVAL;
>         }
>
> -       ret = bmp280_chip_init(data);
> +       ret = data->chip_info->chip_config(data);
>         if (ret < 0)
>                 return ret;
>
> @@ -390,13 +725,17 @@ static int bmp280_probe(struct i2c_client *client,
>  }
>
>  static const struct acpi_device_id bmp280_acpi_match[] = {
> -       {"BMP0280", 0},
> +       {"BMP0280", BMP280_CHIP_ID },
> +       {"BMP0180", BMP180_CHIP_ID },
> +       {"BMP0085", BMP180_CHIP_ID },
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>
>  static const struct i2c_device_id bmp280_id[] = {
> -       {"bmp280", 0},
> +       {"bmp280", BMP280_CHIP_ID },
> +       {"bmp180", BMP180_CHIP_ID },
> +       {"bmp085", BMP180_CHIP_ID },
>         { },
>  };
>  MODULE_DEVICE_TABLE(i2c, bmp280_id);
> @@ -412,5 +751,5 @@ static struct i2c_driver bmp280_driver = {
>  module_i2c_driver(bmp280_driver);
>
>  MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
> -MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP280 pressure and temperature sensor");
> +MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
>  MODULE_LICENSE("GPL v2");
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
