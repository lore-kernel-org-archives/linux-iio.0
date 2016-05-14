Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35640 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbcENRMa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 13:12:30 -0400
Subject: Re: [PATCH v2] iio: pressure: bmp280: add humidity support
To: Matt Ranostay <mranostay@gmail.com>,
	Matt Ranostay <matt.ranostay@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
References: <1462427850-19749-1-git-send-email-matt.ranostay@intel.com>
 <CAKzfze9sqJEUgijJyd11wqc9Co2nu1UDsg-BcaAbe3EnwDVBXA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <af50d8c5-3ae6-b403-2021-54af861b4f8b@kernel.org>
Date: Sat, 14 May 2016 18:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze9sqJEUgijJyd11wqc9Co2nu1UDsg-BcaAbe3EnwDVBXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/16 03:18, Matt Ranostay wrote:
> Adding Daniel who I forgot to CC in the initial submission
> 
> On Wed, May 4, 2016 at 10:57 PM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>> Enable humidity support for the BME280 part
>>
>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Looks great to me (one trivial nitpick inline).
Would be nice if the patch title mentioned the bme280 part number...

Would like an Ack from Vlad though before I apply it.
(always good to cc the original driver author - and Vlad was active recently + usually
gets back pretty quickly on patches).

Hohum. If manufacturers keep tacking more and more sensors into compatible parts
we'll eventually end up with all drivers in one common 'everything but the 
kitchen sink' directory in Kconfig.

Thanks,

Jonathan

>> ---
>>
>> changes from v1:
>>  * rework to use new multiple chip selection method
>>  * fix issue with humidity coefficients being off by one
>>  * fixed incorrect shifted coefficients
>>  * added oversampling configuration for humidity
>>
>>  drivers/iio/pressure/bmp280.c | 200 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 198 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
>> index 2f1498e..1876b50 100644
>> --- a/drivers/iio/pressure/bmp280.c
>> +++ b/drivers/iio/pressure/bmp280.c
>> @@ -10,6 +10,7 @@
>>   * Datasheet:
>>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
>>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
>> + * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
>>   */
>>
>>  #define pr_fmt(fmt) "bmp280: " fmt
>> @@ -23,6 +24,8 @@
>>  #include <linux/iio/sysfs.h>
>>
>>  /* BMP280 specific registers */
>> +#define BMP280_REG_HUMIDITY_LSB                0xFE
>> +#define BMP280_REG_HUMIDITY_MSB                0xFD
>>  #define BMP280_REG_TEMP_XLSB           0xFC
>>  #define BMP280_REG_TEMP_LSB            0xFB
>>  #define BMP280_REG_TEMP_MSB            0xFA
>> @@ -31,7 +34,17 @@
>>  #define BMP280_REG_PRESS_MSB           0xF7
>>
>>  #define BMP280_REG_CONFIG              0xF5
>> +#define BMP280_REG_CTRL_MEAS           0xF4
>>  #define BMP280_REG_STATUS              0xF3
>> +#define BMP280_REG_CTRL_HUMIDITY       0xF2
>> +
>> +/* Due to non linear mapping, and data sizes we can't do a bulk read */
>> +#define BMP280_REG_COMP_H1             0xA1
>> +#define BMP280_REG_COMP_H2             0xE1
>> +#define BMP280_REG_COMP_H3             0xE3
>> +#define BMP280_REG_COMP_H4             0xE4
>> +#define BMP280_REG_COMP_H5             0xE5
>> +#define BMP280_REG_COMP_H6             0xE7
>>
>>  #define BMP280_REG_COMP_TEMP_START     0x88
>>  #define BMP280_COMP_TEMP_REG_COUNT     6
>> @@ -46,6 +59,15 @@
>>  #define BMP280_FILTER_8X               (BIT(3) | BIT(2))
>>  #define BMP280_FILTER_16X              BIT(4)
>>
>> +#define BMP280_OSRS_HUMIDITY_MASK      (BIT(2) | BIT(1) | BIT(0))
>> +#define BMP280_OSRS_HUMIDITIY_X(osrs_h)        ((osrs_h) << 0)
>> +#define BMP280_OSRS_HUMIDITY_SKIP      0
>> +#define BMP280_OSRS_HUMIDITY_1X                BMP280_OSRS_HUMIDITIY_X(1)
>> +#define BMP280_OSRS_HUMIDITY_2X                BMP280_OSRS_HUMIDITIY_X(2)
>> +#define BMP280_OSRS_HUMIDITY_4X                BMP280_OSRS_HUMIDITIY_X(3)
>> +#define BMP280_OSRS_HUMIDITY_8X                BMP280_OSRS_HUMIDITIY_X(4)
>> +#define BMP280_OSRS_HUMIDITY_16X       BMP280_OSRS_HUMIDITIY_X(5)
>> +
>>  #define BMP280_OSRS_TEMP_MASK          (BIT(7) | BIT(6) | BIT(5))
>>  #define BMP280_OSRS_TEMP_SKIP          0
>>  #define BMP280_OSRS_TEMP_X(osrs_t)     ((osrs_t) << 5)
>> @@ -92,6 +114,7 @@
>>
>>  #define BMP180_CHIP_ID                 0x55
>>  #define BMP280_CHIP_ID                 0x58
>> +#define BME280_CHIP_ID                 0x60
>>  #define BMP280_SOFT_RESET_VAL          0xB6
>>
>>  struct bmp280_data {
>> @@ -103,6 +126,7 @@ struct bmp280_data {
>>         /* log of base 2 of oversampling rate */
>>         u8 oversampling_press;
>>         u8 oversampling_temp;
>> +       u8 oversampling_humid;
>>
>>         /*
>>          * Carryover value from temperature conversion, used in pressure
>> @@ -120,9 +144,13 @@ struct bmp280_chip_info {
>>         const int *oversampling_press_avail;
>>         int num_oversampling_press_avail;
>>
>> +       const int *oversampling_humid_avail;
>> +       int num_oversampling_humid_avail;
>> +
>>         int (*chip_config)(struct bmp280_data *);
>>         int (*read_temp)(struct bmp280_data *, int *);
>>         int (*read_press)(struct bmp280_data *, int *, int *);
>> +       int (*read_humid)(struct bmp280_data *, int *, int *);
>>  };
>>
>>  /*
>> @@ -143,12 +171,18 @@ static const struct iio_chan_spec bmp280_channels[] = {
>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>>                                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>         },
>> +       {
>> +               .type = IIO_HUMIDITYRELATIVE,
>> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>> +                                     BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>> +       },
>>  };
>>
>>  static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
>>  {
>>         switch (reg) {
>>         case BMP280_REG_CONFIG:
>> +       case BMP280_REG_CTRL_HUMIDITY:
>>         case BMP280_REG_CTRL_MEAS:
>>         case BMP280_REG_RESET:
>>                 return true;
>> @@ -160,6 +194,8 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
>>  static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>>         switch (reg) {
>> +       case BMP280_REG_HUMIDITY_LSB:
>> +       case BMP280_REG_HUMIDITY_MSB:
>>         case BMP280_REG_TEMP_XLSB:
>>         case BMP280_REG_TEMP_LSB:
>>         case BMP280_REG_TEMP_MSB:
>> @@ -177,7 +213,7 @@ static const struct regmap_config bmp280_regmap_config = {
>>         .reg_bits = 8,
>>         .val_bits = 8,
>>
>> -       .max_register = BMP280_REG_TEMP_XLSB,
>> +       .max_register = BMP280_REG_HUMIDITY_LSB,
>>         .cache_type = REGCACHE_RBTREE,
>>
>>         .writeable_reg = bmp280_is_writeable_reg,
>> @@ -185,6 +221,70 @@ static const struct regmap_config bmp280_regmap_config = {
>>  };
>>
>>  /*
>> + * Returns humidity in percent, resolution is 0.01 percent. Output value of
>> + * "47445" represents 47445/1024 = 46.333 %RH.
>> + *
>> + * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
>> + */
>> +
>> +static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>> +                                     s32 adc_humidity)
>> +{
>> +       struct device *dev = &data->client->dev;
>> +       unsigned int H1, H3, tmp;
>> +       int H2, H4, H5, H6, ret, var;
>> +
>> +       ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &H1);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to read H1 comp value\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &tmp, 2);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to read H2 comp value\n");
>> +               return ret;
>> +       }
>> +       H2 = sign_extend32(le16_to_cpu(tmp), 15);
>> +
>> +       ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &H3);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to read H3 comp value\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &tmp, 2);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to read H4 comp value\n");
>> +               return ret;
>> +       }
>> +       H4 = sign_extend32(((be16_to_cpu(tmp) >> 4) & 0xff0) |
>> +                         (be16_to_cpu(tmp) & 0xf), 11);
>> +
>> +       ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &tmp, 2);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to read H5 comp value\n");
>> +               return ret;
>> +       }
>> +       H5 = sign_extend32(((le16_to_cpu(tmp) >> 4) & 0xfff), 11);
>> +
>> +       ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to read H6 comp value\n");
>> +               return ret;
>> +       }
>> +       H6 = sign_extend32(tmp, 7);
>> +
>> +       var = ((s32)data->t_fine) - 76800;
>> +       var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var)) + 16384) >> 15)
>> +               * (((((((var * H6) >> 10) * (((var * H3) >> 11) + 32768)) >> 10)
>> +               + 2097152) * H2 + 8192) >> 14);
>> +       var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;
>> +
>> +       return var >> 12;
>> +};
>> +
>> +/*
>>   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
>>   * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
>>   * value.
>> @@ -324,6 +424,34 @@ static int bmp280_read_press(struct bmp280_data *data,
>>         return IIO_VAL_FRACTIONAL;
>>  }
>>
>> +static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>> +{
>> +       int ret;
>> +       __be16 tmp = 0;
>> +       s32 adc_humidity;
>> +       u32 comp_humidity;
>> +
>> +       /* Read and compensate temperature so we get a reading of t_fine. */
>> +       ret = bmp280_read_temp(data, NULL);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
>> +                              (u8 *) &tmp, 2);
>> +       if (ret < 0) {
>> +               dev_err(&data->client->dev, "failed to read humidity\n");
>> +               return ret;
>> +       }
>> +
>> +       adc_humidity = be16_to_cpu(tmp);
>> +       comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>> +
>> +       *val = comp_humidity;
>> +       *val2 = 1024;
>> +
>> +       return IIO_VAL_FRACTIONAL;
>> +}
>> +
>>  static int bmp280_read_raw(struct iio_dev *indio_dev,
>>                            struct iio_chan_spec const *chan,
>>                            int *val, int *val2, long mask)
>> @@ -336,6 +464,9 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>>         switch (mask) {
>>         case IIO_CHAN_INFO_PROCESSED:
>>                 switch (chan->type) {
>> +               case IIO_HUMIDITYRELATIVE:
>> +                       ret = data->chip_info->read_humid(data, val, val2);
>> +                       break;
>>                 case IIO_PRESSURE:
>>                         ret = data->chip_info->read_press(data, val, val2);
>>                         break;
>> @@ -349,6 +480,10 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>>                 break;
>>         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>                 switch (chan->type) {
>> +               case IIO_HUMIDITYRELATIVE:
>> +                       *val = 1 << data->oversampling_humid;
>> +                       ret = IIO_VAL_INT;
>> +                       break;
>>                 case IIO_PRESSURE:
>>                         *val = 1 << data->oversampling_press;
>>                         ret = IIO_VAL_INT;
>> @@ -372,6 +507,23 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>>         return ret;
>>  }
>>
>> +static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
>> +                                              int val)
>> +{
>> +       int i;
>> +       const int *avail = data->chip_info->oversampling_humid_avail;
>> +       const int n = data->chip_info->num_oversampling_humid_avail;
>> +
>> +       for (i = 0; i < n; i++) {
>> +               if (avail[i] == val) {
>> +                       data->oversampling_humid = ilog2(val);
>> +
>> +                       return data->chip_info->chip_config(data);
>> +               }
>> +       }
>> +       return -EINVAL;
>> +}
>> +
>>  static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
>>                                                int val)
>>  {
>> @@ -417,6 +569,9 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
>>         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>                 mutex_lock(&data->lock);
>>                 switch (chan->type) {
>> +               case IIO_HUMIDITYRELATIVE:
>> +                       ret = bmp280_write_oversampling_ratio_humid(data, val);
>> +                       break;
>>                 case IIO_PRESSURE:
>>                         ret = bmp280_write_oversampling_ratio_press(data, val);
>>                         break;
>> @@ -535,6 +690,37 @@ static const struct bmp280_chip_info bmp280_chip_info = {
>>         .read_press = bmp280_read_press,
>>  };
>>
>> +static int bme280_chip_config(struct bmp280_data *data)
>> +{
>> +       int ret = bmp280_chip_config(data);
>> +       u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
>> +                                 BMP280_OSRS_HUMIDITY_MASK, osrs);
>> +}
>> +
>> +static const struct bmp280_chip_info bme280_chip_info = {
>> +       .regmap_config = &bmp280_regmap_config,
>> +
>> +       .oversampling_temp_avail = bmp280_oversampling_avail,
>> +       .num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>> +
>> +       .oversampling_press_avail = bmp280_oversampling_avail,
>> +       .num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>> +
>> +       .oversampling_humid_avail = bmp280_oversampling_avail,
>> +       .num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>> +
>> +       .chip_config = bme280_chip_config,
>> +       .read_temp = bmp280_read_temp,
>> +       .read_press = bmp280_read_press,
>> +       .read_humid = bmp280_read_humid,
>> +};
>> +
If I'm being really fussy - only one blank line here.
>> +
>>  static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
>>  {
>>         switch (reg) {
>> @@ -849,21 +1035,29 @@ static int bmp280_probe(struct i2c_client *client,
>>         indio_dev->dev.parent = &client->dev;
>>         indio_dev->name = id->name;
>>         indio_dev->channels = bmp280_channels;
>> -       indio_dev->num_channels = ARRAY_SIZE(bmp280_channels);
>>         indio_dev->info = &bmp280_info;
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>
>>         switch (id->driver_data) {
>>         case BMP180_CHIP_ID:
>> +               indio_dev->num_channels = 2;
>>                 data->chip_info = &bmp180_chip_info;
>>                 data->oversampling_press = ilog2(8);
>>                 data->oversampling_temp = ilog2(1);
>>                 break;
>>         case BMP280_CHIP_ID:
>> +               indio_dev->num_channels = 2;
>>                 data->chip_info = &bmp280_chip_info;
>>                 data->oversampling_press = ilog2(16);
>>                 data->oversampling_temp = ilog2(2);
>>                 break;
>> +       case BME280_CHIP_ID:
>> +               indio_dev->num_channels = 3;
>> +               data->chip_info = &bme280_chip_info;
>> +               data->oversampling_press = ilog2(16);
>> +               data->oversampling_humid = ilog2(16);
>> +               data->oversampling_temp = ilog2(2);
>> +               break;
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -895,6 +1089,7 @@ static const struct acpi_device_id bmp280_acpi_match[] = {
>>         {"BMP0280", BMP280_CHIP_ID },
>>         {"BMP0180", BMP180_CHIP_ID },
>>         {"BMP0085", BMP180_CHIP_ID },
>> +       {"BME0280", BME280_CHIP_ID },
>>         { },
>>  };
>>  MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>> @@ -903,6 +1098,7 @@ static const struct i2c_device_id bmp280_id[] = {
>>         {"bmp280", BMP280_CHIP_ID },
>>         {"bmp180", BMP180_CHIP_ID },
>>         {"bmp085", BMP180_CHIP_ID },
>> +       {"bme280", BME280_CHIP_ID },
>>         { },
>>  };
>>  MODULE_DEVICE_TABLE(i2c, bmp280_id);
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

