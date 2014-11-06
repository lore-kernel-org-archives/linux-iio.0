Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:61399 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaKFVQY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Nov 2014 16:16:24 -0500
Received: by mail-qc0-f182.google.com with SMTP id m20so1565194qcx.13
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2014 13:16:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415286177.7340.14.camel@spandruv-hsb-test>
References: <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com>
 <1415225452-21957-1-git-send-email-gwendal@chromium.org> <1415225452-21957-3-git-send-email-gwendal@chromium.org>
 <1415286177.7340.14.camel@spandruv-hsb-test>
From: Gwendal Grignou <gwendal@google.com>
Date: Thu, 6 Nov 2014 13:16:03 -0800
Message-ID: <CAMHSBOVrBGzLoGBGJFwXBKpzMZjE=WkYcYMQpbs6JeRgkDJ1EQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: ak8975: add definition structure per compass type
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 6, 2014 at 7:02 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Wed, 2014-11-05 at 14:10 -0800, Gwendal Grignou wrote:
>> For each type of compass supported (AK8975 and AK8963),
>> add a definition structure for register masks, important registers,
>> raw data interpretation.
>> This change will make integrating new type of devices easier.
>>
>> Remove i2c register cache. It is only used for one single register.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>>  drivers/iio/magnetometer/ak8975.c | 279 +++++++++++++++++++++++++-------------
>>  1 file changed, 184 insertions(+), 95 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
>> index 12f0b00..b170654 100644
>> --- a/drivers/iio/magnetometer/ak8975.c
>> +++ b/drivers/iio/magnetometer/ak8975.c
>> @@ -86,13 +86,153 @@
>>  #define AK8975_MAX_CONVERSION_TIMEOUT        500
>>  #define AK8975_CONVERSION_DONE_POLL_TIME 10
>>  #define AK8975_DATA_READY_TIMEOUT    ((100*HZ)/1000)
>> -#define RAW_TO_GAUSS_8975(asa) ((((asa) + 128) * 3000) / 256)
>> -#define RAW_TO_GAUSS_8963(asa) ((((asa) + 128) * 6000) / 256)
>> +
>> +/*
>> + * Precalculate scale factor (in Gauss units) for each axis and
>> + * store in the device data.
>> + *
>> + * This scale factor is axis-dependent, and is derived from 3 calibration
>> + * factors ASA(x), ASA(y), and ASA(z).
>> + *
>> + * These ASA values are read from the sensor device at start of day, and
>> + * cached in the device context struct.
>> + *
>> + * Adjusting the flux value with the sensitivity adjustment value should be
>> + * done via the following formula:
>> + *
>> + * Hadj = H * ( ( ( (ASA-128)*0.5 ) / 128 ) + 1 )
>> + * where H is the raw value, ASA is the sensitivity adjustment, and Hadj
>> + * is the resultant adjusted value.
>> + *
>> + * We reduce the formula to:
>> + *
>> + * Hadj = H * (ASA + 128) / 256
>> + *
>> + * H is in the range of -4096 to 4095.  The magnetometer has a range of
>> + * +-1229uT.  To go from the raw value to uT is:
>> + *
>> + * HuT = H * 1229/4096, or roughly, 3/10.
>> + *
>> + * Since 1uT = 0.01 gauss, our final scale factor becomes:
>> + *
>> + * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
>> + * Hadj = H * ((ASA + 128) * 0.003) / 256
>> + *
>> + * Since ASA doesn't change, we cache the resultant scale factor into the
>> + * device context in ak8975_setup().
>> + *
>> + * Given we use IIO_VAL_INT_PLUS_MICRO bit when displaying the scale, we
>> + * multiply the stored scale value by 1e6.
>> + */
>> +long ak8975_raw_to_gauss(u16 data)
> What about inline?
>> +{
>> +     return (((long)data + 128) * 3000) / 256;
>> +}
>> +
>> +/*
>> + * For AK8963, same calculation, but the device is less sensitive:
>> + *
>> + * H is in the range of +-8190.  The magnetometer has a range of
>> + * +-4912uT.  To go from the raw value to uT is:
>> + *
>> + * HuT = H * 4912/8190, or roughly, 6/10, instead of 3/10.
>> + */
>> +long ak8963_raw_to_gauss(u16 data)
> What about inline?
1 - This function is only used at setup time, so we don't have to inline them.
2 - Given the functions are use through pointer, in-lining does not
bring any performance improvement anyway.
>> +{
>> +     return (((long)data + 128) * 6000) / 256;
>> +}
>>
>>  /* Compatible Asahi Kasei Compass parts */
>>  enum asahi_compass_chipset {
>>       AK8975,
>>       AK8963,
>> +     AK_MAX_TYPE
>> +};
>> +
>> +enum ak_ctrl_reg_addr {
>> +     ST1,
>> +     ST2,
>> +     CNTL,
>> +     ASA_BASE,
>> +     MAX_REGS,
>> +     REGS_END,
>> +};
>> +
>> +enum ak_ctrl_reg_mask {
>> +     ST1_DRDY,
>> +     ST2_HOFL,
>> +     ST2_DERR,
>> +     CNTL_MODE,
>> +     MASK_END,
>> +};
>> +
>> +enum ak_ctrl_mode {
>> +     POWER_DOWN,
>> +     MODE_ONCE,
>> +     SELF_TEST,
>> +     FUSE_ROM,
>> +     MODE_END,
>> +};
>> +
>> +struct ak_def {
>> +     enum asahi_compass_chipset type;
>> +     long (*raw_to_gauss)(u16 data);
>> +     u16 range;
>> +     u8 ctrl_regs[REGS_END];
>> +     u8 ctrl_masks[MASK_END];
>> +     u8 ctrl_modes[MODE_END];
>> +     u8 data_regs[3];
>> +} ak_def_array[AK_MAX_TYPE] = {
>> +{
>> +     .type = AK8975,
>> +     .raw_to_gauss = ak8975_raw_to_gauss,
>> +     .range = 4096,
>> +     .ctrl_regs = {
>> +             AK8975_REG_ST1,
>> +             AK8975_REG_ST2,
>> +             AK8975_REG_CNTL,
>> +             AK8975_REG_ASAX,
>> +             AK8975_MAX_REGS},
>> +     .ctrl_masks = {
>> +             AK8975_REG_ST1_DRDY_MASK,
>> +             AK8975_REG_ST2_HOFL_MASK,
>> +             AK8975_REG_ST2_DERR_MASK,
>> +             AK8975_REG_CNTL_MODE_MASK},
>> +     .ctrl_modes = {
>> +             AK8975_REG_CNTL_MODE_POWER_DOWN,
>> +             AK8975_REG_CNTL_MODE_ONCE,
>> +             AK8975_REG_CNTL_MODE_SELF_TEST,
>> +             AK8975_REG_CNTL_MODE_FUSE_ROM},
>> +     .data_regs = {
>> +             AK8975_REG_HXL,
>> +             AK8975_REG_HYL,
>> +             AK8975_REG_HZL},
>> +},
>> +{
>> +     .type = AK8963,
>> +     .raw_to_gauss = ak8963_raw_to_gauss,
>> +     .range = 8190,
>> +     .ctrl_regs = {
>> +             AK8975_REG_ST1,
>> +             AK8975_REG_ST2,
>> +             AK8975_REG_CNTL,
>> +             AK8975_REG_ASAX,
>> +             AK8975_MAX_REGS},
>> +     .ctrl_masks = {
>> +             AK8975_REG_ST1_DRDY_MASK,
>> +             AK8975_REG_ST2_HOFL_MASK,
>> +             0,
>> +             AK8975_REG_CNTL_MODE_MASK},
>> +     .ctrl_modes = {
>> +             AK8975_REG_CNTL_MODE_POWER_DOWN,
>> +             AK8975_REG_CNTL_MODE_ONCE,
>> +             AK8975_REG_CNTL_MODE_SELF_TEST,
>> +             AK8975_REG_CNTL_MODE_FUSE_ROM},
>> +     .data_regs = {
>> +             AK8975_REG_HXL,
>> +             AK8975_REG_HYL,
>> +             AK8975_REG_HZL},
>> +},
>>  };
>>
>>  /*
>> @@ -100,40 +240,36 @@ enum asahi_compass_chipset {
>>   */
>>  struct ak8975_data {
>>       struct i2c_client       *client;
>> +     struct ak_def           *def;
>>       struct attribute_group  attrs;
>>       struct mutex            lock;
>>       u8                      asa[3];
>>       long                    raw_to_gauss[3];
>> -     u8                      reg_cache[AK8975_MAX_REGS];
>>       int                     eoc_gpio;
>>       int                     eoc_irq;
>>       wait_queue_head_t       data_ready_queue;
>>       unsigned long           flags;
>> -     enum asahi_compass_chipset chipset;
>> -};
>> -
>> -static const int ak8975_index_to_reg[] = {
>> -     AK8975_REG_HXL, AK8975_REG_HYL, AK8975_REG_HZL,
>> +     u8                      cntl_cache;
>>  };
>>
>>  /*
>> - * Helper function to write to the I2C device's registers.
>> + * Helper function to write to CNTL register.
>>   */
>> -static int ak8975_write_data(struct i2c_client *client,
>> -                          u8 reg, u8 val, u8 mask, u8 shift)
>> +static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
>>  {
>> -     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> -     struct ak8975_data *data = iio_priv(indio_dev);
>>       u8 regval;
>>       int ret;
>>
>> -     regval = (data->reg_cache[reg] & ~mask) | (val << shift);
>> -     ret = i2c_smbus_write_byte_data(client, reg, regval);
>> +     regval = (data->cntl_cache & ~data->def->ctrl_masks[CNTL_MODE]) |
>> +             data->def->ctrl_modes[mode];
>> +     ret = i2c_smbus_write_byte_data(
>> +             data->client, data->def->ctrl_regs[CNTL], regval);
>>       if (ret < 0) {
>> -             dev_err(&client->dev, "Write to device fails status %x\n", ret);
>>               return ret;
>>       }
>> -     data->reg_cache[reg] = regval;
>> +     data->cntl_cache = regval;
>> +     /* After mode change wait atleast 100us */
>> +     usleep_range(100, 500);
>>
>>       return 0;
>>  }
>> @@ -207,18 +343,15 @@ static int ak8975_setup(struct i2c_client *client)
>>       }
>>
>>       /* Write the fused rom access mode. */
>> -     ret = ak8975_write_data(client,
>> -                             AK8975_REG_CNTL,
>> -                             AK8975_REG_CNTL_MODE_FUSE_ROM,
>> -                             AK8975_REG_CNTL_MODE_MASK,
>> -                             AK8975_REG_CNTL_MODE_SHIFT);
>> +     ret = ak8975_set_mode(data, FUSE_ROM);
>>       if (ret < 0) {
>>               dev_err(&client->dev, "Error in setting fuse access mode\n");
>>               return ret;
>>       }
>>
>>       /* Get asa data and store in the device data. */
>> -     ret = i2c_smbus_read_i2c_block_data(client, AK8975_REG_ASAX,
>> +     ret = i2c_smbus_read_i2c_block_data(client,
>> +                                         data->def->ctrl_regs[ASA_BASE],
>>                                           3, data->asa);
>>       if (ret < 0) {
>>               dev_err(&client->dev, "Not able to read asa data\n");
>> @@ -226,11 +359,7 @@ static int ak8975_setup(struct i2c_client *client)
>>       }
>>
>>       /* After reading fuse ROM data set power-down mode */
>> -     ret = ak8975_write_data(client,
>> -                             AK8975_REG_CNTL,
>> -                             AK8975_REG_CNTL_MODE_POWER_DOWN,
>> -                             AK8975_REG_CNTL_MODE_MASK,
>> -                             AK8975_REG_CNTL_MODE_SHIFT);
>> +     ret = ak8975_set_mode(data, POWER_DOWN);
>>       if (ret < 0) {
>>               dev_err(&client->dev, "Error in setting power-down mode\n");
>>               return ret;
>> @@ -245,56 +374,9 @@ static int ak8975_setup(struct i2c_client *client)
>>               }
>>       }
>>
>> -/*
>> - * Precalculate scale factor (in Gauss units) for each axis and
>> - * store in the device data.
>> - *
>> - * This scale factor is axis-dependent, and is derived from 3 calibration
>> - * factors ASA(x), ASA(y), and ASA(z).
>> - *
>> - * These ASA values are read from the sensor device at start of day, and
>> - * cached in the device context struct.
>> - *
>> - * Adjusting the flux value with the sensitivity adjustment value should be
>> - * done via the following formula:
>> - *
>> - * Hadj = H * ( ( ( (ASA-128)*0.5 ) / 128 ) + 1 )
>> - *
>> - * where H is the raw value, ASA is the sensitivity adjustment, and Hadj
>> - * is the resultant adjusted value.
>> - *
>> - * We reduce the formula to:
>> - *
>> - * Hadj = H * (ASA + 128) / 256
>> - *
>> - * H is in the range of -4096 to 4095.  The magnetometer has a range of
>> - * +-1229uT.  To go from the raw value to uT is:
>> - *
>> - * HuT = H * 1229/4096, or roughly, 3/10.
>> - *
>> - * Since 1uT = 0.01 gauss, our final scale factor becomes:
>> - *
>> - * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
>> - * Hadj = H * ((ASA + 128) * 0.003) / 256
>> - *
>> - * Since ASA doesn't change, we cache the resultant scale factor into the
>> - * device context in ak8975_setup().
>> - */
>> -     if (data->chipset == AK8963) {
>> -             /*
>> -              * H range is +-8190 and magnetometer range is +-4912.
>> -              * So HuT using the above explanation for 8975,
>> -              * 4912/8190 = ~ 6/10.
>> -              * So the Hadj should use 6/10 instead of 3/10.
>> -              */
>> -             data->raw_to_gauss[0] = RAW_TO_GAUSS_8963(data->asa[0]);
>> -             data->raw_to_gauss[1] = RAW_TO_GAUSS_8963(data->asa[1]);
>> -             data->raw_to_gauss[2] = RAW_TO_GAUSS_8963(data->asa[2]);
>> -     } else {
>> -             data->raw_to_gauss[0] = RAW_TO_GAUSS_8975(data->asa[0]);
>> -             data->raw_to_gauss[1] = RAW_TO_GAUSS_8975(data->asa[1]);
>> -             data->raw_to_gauss[2] = RAW_TO_GAUSS_8975(data->asa[2]);
>> -     }
>> +     data->raw_to_gauss[0] = data->def->raw_to_gauss(data->asa[0]);
>> +     data->raw_to_gauss[1] = data->def->raw_to_gauss(data->asa[1]);
>> +     data->raw_to_gauss[2] = data->def->raw_to_gauss(data->asa[2]);
>>
>>       return 0;
>>  }
>> @@ -317,7 +399,7 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
>>               return -EINVAL;
>>       }
>>
>> -     ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST1);
>> +     ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
>>       if (ret < 0)
>>               dev_err(&client->dev, "Error in reading ST1\n");
>>
>> @@ -334,7 +416,8 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
>>       /* Wait for the conversion to complete. */
>>       while (timeout_ms) {
>>               msleep(AK8975_CONVERSION_DONE_POLL_TIME);
>> -             ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST1);
>> +             ret = i2c_smbus_read_byte_data(
>> +                             client, data->def->ctrl_regs[ST1]);
>>               if (ret < 0) {
>>                       dev_err(&client->dev, "Error in reading ST1\n");
>>                       return ret;
>> @@ -377,11 +460,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>>       mutex_lock(&data->lock);
>>
>>       /* Set up the device for taking a sample. */
>> -     ret = ak8975_write_data(client,
>> -                             AK8975_REG_CNTL,
>> -                             AK8975_REG_CNTL_MODE_ONCE,
>> -                             AK8975_REG_CNTL_MODE_MASK,
>> -                             AK8975_REG_CNTL_MODE_SHIFT);
>> +     ret = ak8975_set_mode(data, MODE_ONCE);
>>       if (ret < 0) {
>>               dev_err(&client->dev, "Error in setting operating mode\n");
>>               goto exit;
>> @@ -398,14 +477,15 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>>               goto exit;
>>
>>       /* This will be executed only for non-interrupt based waiting case */
>> -     if (ret & AK8975_REG_ST1_DRDY_MASK) {
>> -             ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST2);
>> +     if (ret & data->def->ctrl_masks[ST1_DRDY]) {
>> +             ret = i2c_smbus_read_byte_data(
>> +                             client, data->def->ctrl_regs[ST2]);
>>               if (ret < 0) {
>>                       dev_err(&client->dev, "Error in reading ST2\n");
>>                       goto exit;
>>               }
>> -             if (ret & (AK8975_REG_ST2_DERR_MASK |
>> -                        AK8975_REG_ST2_HOFL_MASK)) {
>> +             if (ret & (data->def->ctrl_masks[ST2_DERR] |
>> +                        data->def->ctrl_masks[ST2_HOFL])) {
>>                       dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
>>                       ret = -EINVAL;
>>                       goto exit;
>> @@ -414,7 +494,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>>
>>       /* Read the flux value from the appropriate register
>>          (the register is specified in the iio device attributes). */
>> -     ret = i2c_smbus_read_word_data(client, ak8975_index_to_reg[index]);
>> +     ret = i2c_smbus_read_word_data(client, data->def->data_regs[index]);
>>       if (ret < 0) {
>>               dev_err(&client->dev, "Read axis data fails\n");
>>               goto exit;
>> @@ -423,7 +503,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>>       mutex_unlock(&data->lock);
>>
>>       /* Clamp to valid range. */
>> -     *val = clamp_t(s16, ret, -4096, 4095);
>> +     *val = clamp_t(s16, ret, -data->def->range, data->def->range);
>>       return IIO_VAL_INT;
>>
>>  exit:
>> @@ -497,6 +577,7 @@ static int ak8975_probe(struct i2c_client *client,
>>       int eoc_gpio;
>>       int err;
>>       const char *name = NULL;
>> +     enum asahi_compass_chipset chipset;
>>
>>       /* Grab and set up the supplied GPIO. */
>>       if (client->dev.platform_data)
>> @@ -536,14 +617,20 @@ static int ak8975_probe(struct i2c_client *client,
>>
>>       /* id will be NULL when enumerated via ACPI */
>>       if (id) {
>> -             data->chipset =
>> -                     (enum asahi_compass_chipset)(id->driver_data);
>> +             chipset = (enum asahi_compass_chipset)(id->driver_data);
>>               name = id->name;
>>       } else if (ACPI_HANDLE(&client->dev))
>> -             name = ak8975_match_acpi_device(&client->dev, &data->chipset);
>> +             name = ak8975_match_acpi_device(&client->dev, &chipset);
>>       else
>>               return -ENOSYS;
>>
>> +     if (chipset >= AK_MAX_TYPE) {
>> +             dev_err(&client->dev, "AKM device type unsupported: %d\n",
>> +                     chipset);
>> +             return -ENODEV;
>> +     }
>> +
>> +     data->def = &ak_def_array[chipset];
>>       dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
>>
>>       /* Perform some basic start-of-day setup of the device. */
>> @@ -574,7 +661,9 @@ MODULE_DEVICE_TABLE(i2c, ak8975_id);
>>  static const struct of_device_id ak8975_of_match[] = {
>>       { .compatible = "asahi-kasei,ak8975", },
>>       { .compatible = "ak8975", },
>> -     { }
>> +     { .compatible = "asahi-kasei,ak8963", },
>> +     { .compatible = "ak8963", },
>> +     {}
>>  };
>>  MODULE_DEVICE_TABLE(of, ak8975_of_match);
>>
>
>
