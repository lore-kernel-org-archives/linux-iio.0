Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35696 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbcHWUga (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 16:36:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so19631638wmg.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2016 13:35:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608230735270.12003@pmeerw.net>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
 <1471923894-12194-3-git-send-email-mranostay@gmail.com> <alpine.DEB.2.02.1608230735270.12003@pmeerw.net>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 23 Aug 2016 13:35:13 -0700
Message-ID: <CAKzfze92jT6cUMDWkycEvAC7TbyB=Ujx8fwe-uaL8Omy-7E-nA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: chemical: vz89x: add support for VZ89TE part
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 22, 2016 at 10:42 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> Add support the VZ89TE variant which removes the voc_short channel,
>> and has CRC check for data transactions.
>
> comments below
>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/iio/chemical/vz89x.c | 149 +++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 123 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
>> index f498228e044d..0347761ebdba 100644
>> --- a/drivers/iio/chemical/vz89x.c
>> +++ b/drivers/iio/chemical/vz89x.c
>> @@ -19,20 +19,33 @@
>>  #include <linux/mutex.h>
>>  #include <linux/init.h>
>>  #include <linux/i2c.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>
>>  #define VZ89X_REG_MEASUREMENT                0x09
>> +#define VZ89TE_REG_MEASUREMENT               0x0c
>> +
>> +#define VZ89X_REG_WRITE_SIZE         3
>> +#define VZ89TE_REG_WRITE_SIZE                6
>> +
>>  #define VZ89X_REG_MEASUREMENT_SIZE   6
>> +#define VZ89TE_REG_MEASUREMENT_SIZE  7
>>
>>  #define VZ89X_VOC_CO2_IDX            0
>>  #define VZ89X_VOC_SHORT_IDX          1
>>  #define VZ89X_VOC_TVOC_IDX           2
>>  #define VZ89X_VOC_RESISTANCE_IDX     3
>>
>> +#define VZ89TE_VOC_TVOC_IDX          0
>> +#define VZ89TE_VOC_CO2_IDX           1
>> +#define VZ89TE_VOC_RESISTANCE_IDX    2
>> +
>>  enum {
>>       VZ89X,
>> +     VZ89TE,
>>  };
>>
>>  struct vz89x_data {
>> @@ -79,6 +92,40 @@ static const struct iio_chan_spec vz89x_channels[] = {
>>               .info_mask_separate =
>>                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>               .address = VZ89X_VOC_RESISTANCE_IDX,
>> +             .scan_index = -1,
>> +             .scan_type = {
>
> scan_type with a scan_index of -1 is unexpected
>
>> +                     .endianness = IIO_LE,
>> +             },
>> +     },
>> +};
>> +
>> +static const struct iio_chan_spec vz89te_channels[] = {
>> +     {
>> +             .type = IIO_CONCENTRATION,
>> +             .channel2 = IIO_MOD_VOC,
>> +             .modified = 1,
>> +             .info_mask_separate =
>> +                     BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),
>> +             .address = VZ89TE_VOC_TVOC_IDX,
>> +     },
>> +
>> +     {
>> +             .type = IIO_CONCENTRATION,
>> +             .channel2 = IIO_MOD_CO2,
>> +             .modified = 1,
>> +             .info_mask_separate =
>> +                     BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),
>> +             .address = VZ89TE_VOC_CO2_IDX,
>> +     },
>> +     {
>> +             .type = IIO_RESISTANCE,
>> +             .info_mask_separate =
>> +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +             .address = VZ89TE_VOC_RESISTANCE_IDX,
>> +             .scan_index = -1,
>> +             .scan_type = {
>> +                     .endianness = IIO_BE,
>> +             },
>>       },
>>  };
>>
>> @@ -110,12 +157,27 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
>>       return !!(data->buffer[data->read_size - 1] > 0);
>>  }
>>
>> +/* VZ89TE device has a modified CRC-8 two complement check */
>> +static int vz89te_measurement_is_valid(struct vz89x_data *data)
>
> return bool maybe?
>
>> +{
>> +     u8 crc = 0;
>> +     int i, sum = 0;
>> +
>> +     for (i = 0; i < (data->read_size - 1); i++) {
>> +             sum = crc + data->buffer[i];
>> +             crc = sum;
>> +             crc += sum / 256;
>> +     }
>> +
>> +     return !((0xff - crc) == data->buffer[data->read_size - 1]);
>> +}
>> +
>>  static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
>>  {
>>       struct i2c_client *client = data->client;
>>       struct i2c_msg msg[2];
>>       int ret;
>> -     u8 buf[3] = { cmd, 0, 0};
>> +     u8 buf[6] = { cmd, 0, 0, 0, 0, 0xf3};
>>
>>       msg[0].addr = client->addr;
>>       msg[0].flags = client->flags;
>> @@ -173,11 +235,24 @@ static int vz89x_get_measurement(struct vz89x_data *data)
>>       return 0;
>>  }
>>
>> -static int vz89x_get_resistance_reading(struct vz89x_data *data)
>> +static int vz89x_get_resistance_reading(struct vz89x_data *data,
>> +                                     struct iio_chan_spec const *chan,
>> +                                     int *val)
>>  {
>> -     u8 *buf = &data->buffer[VZ89X_VOC_RESISTANCE_IDX];
>> +     u32 tmp = *((u32 *) ((u8 *) &data->buffer[chan->address]));
>> +
>> +     switch (chan->scan_type.endianness) {
>> +     case IIO_LE:
>> +             *val = le32_to_cpu(tmp) & GENMASK(23, 0);
>
> could use le32_to_cpup() probably
>
>> +             break;
>> +     case IIO_BE:
>> +             *val = be32_to_cpu(tmp) >> 8;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>>
>> -     return buf[0] | (buf[1] << 8);
>> +     return 0;
>>  }
>>
>>  static int vz89x_read_raw(struct iio_dev *indio_dev,
>> @@ -196,15 +271,15 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
>>               if (ret)
>>                       return ret;
>>
>> -             switch (chan->address) {
>> -             case VZ89X_VOC_CO2_IDX:
>> -             case VZ89X_VOC_SHORT_IDX:
>> -             case VZ89X_VOC_TVOC_IDX:
>> +             switch (chan->type) {
>> +             case IIO_CONCENTRATION:
>>                       *val = data->buffer[chan->address];
>>                       return IIO_VAL_INT;
>> -             case VZ89X_VOC_RESISTANCE_IDX:
>> -                     *val = vz89x_get_resistance_reading(data);
>> -                     return IIO_VAL_INT;
>> +             case IIO_RESISTANCE:
>> +                     ret = vz89x_get_resistance_reading(data, chan, val);
>> +                     if (!ret)
>> +                             return IIO_VAL_INT;
>> +                     break;
>>               default:
>>                       return -EINVAL;
>>               }
>> @@ -219,12 +294,12 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
>>               }
>>               break;
>>       case IIO_CHAN_INFO_OFFSET:
>> -             switch (chan->address) {
>> -             case VZ89X_VOC_CO2_IDX:
>> +             switch (chan->channel2) {
>> +             case IIO_MOD_CO2:
>>                       *val = 44;
>>                       *val2 = 250000;
>>                       return IIO_VAL_INT_PLUS_MICRO;
>> -             case VZ89X_VOC_TVOC_IDX:
>> +             case IIO_MOD_VOC:
>>                       *val = -13;
>>                       return IIO_VAL_INT;
>>               default:
>> @@ -241,11 +316,20 @@ static const struct iio_info vz89x_info = {
>>       .driver_module  = THIS_MODULE,
>>  };
>>
>> +static const struct of_device_id vz89x_dt_ids[] = {
>> +     { .compatible = "sgx,vz89x", .data = (void *) VZ89X },
>> +     { .compatible = "sgx,vz89te", .data = (void *) VZ89TE },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>> +
>>  static int vz89x_probe(struct i2c_client *client,
>>                      const struct i2c_device_id *id)
>>  {
>>       struct iio_dev *indio_dev;
>>       struct vz89x_data *data;
>> +     const struct of_device_id *of_id;
>> +     int chip_id;
>>
>>       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>       if (!indio_dev)
>> @@ -260,13 +344,15 @@ static int vz89x_probe(struct i2c_client *client,
>>       else
>>               return -EOPNOTSUPP;
>>
>> +     of_id = of_match_device(vz89x_dt_ids, &client->dev);
>> +     if (!of_id)
>> +             chip_id = id->driver_data;
>> +     else
>> +             chip_id = (unsigned long)of_id->data;
>> +
>>       i2c_set_clientdata(client, indio_dev);
>>       data->client = client;
>>       data->last_update = jiffies - HZ;
>> -     data->cmd = VZ89X_REG_MEASUREMENT;
>> -     data->write_size = 3;
>> -     data->read_size = VZ89X_REG_MEASUREMENT_SIZE;
>> -     data->valid = &vz89x_measurement_is_valid;
>>       mutex_init(&data->lock);
>>
>>       indio_dev->dev.parent = &client->dev;
>> @@ -274,24 +360,35 @@ static int vz89x_probe(struct i2c_client *client,
>>       indio_dev->name = dev_name(&client->dev);
>>       indio_dev->modes = INDIO_DIRECT_MODE;
>>
>> -     indio_dev->channels = vz89x_channels;
>> -     indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
>> +     switch (chip_id) {
>> +     case VZ89X:
>> +             indio_dev->channels = vz89x_channels;
>> +             indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
>
> other drivers often use a constant chip_info struct which is used to
> declare chip variants (less code, more data)

Yeah probably should have done this.. will fix in v2

>
>> +             data->cmd = VZ89X_REG_MEASUREMENT;
>> +             data->write_size = VZ89X_REG_WRITE_SIZE;
>> +             data->read_size = VZ89X_REG_MEASUREMENT_SIZE;
>> +             data->valid = &vz89x_measurement_is_valid;
>> +             break;
>> +     case VZ89TE:
>> +             indio_dev->channels = vz89te_channels;
>> +             indio_dev->num_channels = ARRAY_SIZE(vz89te_channels);
>> +             data->cmd = VZ89TE_REG_MEASUREMENT;
>> +             data->write_size = VZ89TE_REG_WRITE_SIZE;
>> +             data->read_size = VZ89TE_REG_MEASUREMENT_SIZE;
>> +             data->valid = &vz89te_measurement_is_valid;
>> +             break;
>> +     }
>>
>>       return devm_iio_device_register(&client->dev, indio_dev);
>>  }
>>
>>  static const struct i2c_device_id vz89x_id[] = {
>>       { "vz89x", VZ89X },
>> +     { "vz89te", VZ89TE },
>>       { }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, vz89x_id);
>>
>> -static const struct of_device_id vz89x_dt_ids[] = {
>> -     { .compatible = "sgx,vz89x", .data = (void *) VZ89X },
>> -     { }
>> -};
>> -MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>> -
>>  static struct i2c_driver vz89x_driver = {
>>       .driver = {
>>               .name   = "vz89x",
>>
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
