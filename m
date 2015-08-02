Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36822 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbbHBV2G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 17:28:06 -0400
MIME-Version: 1.0
In-Reply-To: <55BDE5F8.9090201@metafoo.de>
References: <1438401484-22101-1-git-send-email-mranostay@gmail.com>
	<1438401484-22101-3-git-send-email-mranostay@gmail.com>
	<55BDE5F8.9090201@metafoo.de>
Date: Sun, 2 Aug 2015 14:28:02 -0700
Message-ID: <CAKzfze_ZNeSBo_hKn4ju1uNM4iyaFrvGo89Dv_80DK3Tfb24yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: proximity: add support for PulsedLight LIDAR
From: Matt Ranostay <mranostay@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Matt Porter <matt@ohporter.com>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 2, 2015 at 2:42 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/01/2015 05:58 AM, Matt Ranostay wrote:
> [...]
>> +
>> +struct lidar_data {
>> +     struct mutex lock;
>> +     struct iio_dev *indio_dev;
>> +     struct i2c_client *client;
>> +
>> +     /* config */
>> +     int calib_bias;
>> +
>> +     u16 buffer[5]; /* 2 byte distance + 8 byte timestamp */
>
> Needs to be in its own cacheline to avoid issues if the I2C controller is
> using DMA.

Ah though this was only needed for SPI.

>
>         u16 buffer[5] ____cacheline_aligned;
>
>> +};
> [...]
>> +static inline int lidar_read_byte(struct lidar_data *data, int reg)
>
> I'd drop the inline. The compiler is smart enough to figure out whether it
> makes sense to inline it or not.
>
Got it.

>> +{
>> +     struct i2c_client *client = data->client;
>> +     int ret;
>> +
>> +     ret = i2c_smbus_write_byte(client, reg);
>> +     if (ret < 0) {
>> +             dev_err(&client->dev, "cannot write addr value");
>> +             return ret;
>> +     }
>> +
>> +     ret = i2c_smbus_read_byte(client);
>> +     if (ret < 0) {
>> +             dev_err(&client->dev, "cannot read data value");
>> +             return ret;
>> +     }
>
> Instead of using a write_byte/read_byte combination rather use
> i2c_smbus_read_byte_data(). I think that will do the same, but in one atomic
> operation.
Yes I would normally do that but this device doesn't seem to support
that functionally, always returns zeros.

>
>> +
>> +     return ret;
>> +}
> [...]
>> +static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>> +{
>> +     int ret;
>> +     int val;
>> +
>> +     ret = lidar_read_byte(data, LIDAR_REG_DATA_HBYTE);
>> +     if (ret < 0)
>> +             return ret;
>> +     val = ret << 8;
>> +
>> +     ret = lidar_read_byte(data, LIDAR_REG_DATA_LBYTE);
>> +     if (ret < 0)
>> +             return ret;
>> +     val |= ret;
>> +
>> +     /* correct any possible overflow or underflow */
>> +     val += data->calib_bias / 10000;
>
> Typically calib bias is only meant for a offset correction that is done in
> hardware rather than in software. What's the usecase for doing it in
> kernelspace rather than in userspace?

There is hardware functionality for this but do does nothing more than
add/subtraction to the final result.
Could just drop it completely.

>
>> +     if (val < 0)
>> +             val = 0;
>> +
>> +     if (val > LIDAR_REG_DATA_MAX)
>> +             val = LIDAR_REG_DATA_MAX;
>> +
>> +     *reg = val;
>> +
>> +     return 0;
>> +}
> [...]
>> +static int lidar_read_raw(struct iio_dev *indio_dev,
>> +                       struct iio_chan_spec const *chan,
>> +                       int *val, int *val2, long mask)
>> +{
>> +     struct lidar_data *data = iio_priv(indio_dev);
>> +     int ret = -EINVAL;
>> +
>> +     if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW)
>> +             return -EBUSY;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW: {
>> +             u16 reg;
>> +
>> +             ret = lidar_get_measurement(data, &reg);
>> +             if (!ret) {
>> +                     *val = reg / 100;
>> +                     *val2 = (reg % 100) * 10000;
>> +                     ret = IIO_VAL_INT_PLUS_MICRO;
>
> The raw attribute is supposed to return the raw value as a IIO_VAL_INT. A
> scale attribute should be used to indicate the conversion factor to get the
> proper unit.
Ok makes sense.

>
>> +             }
>> +             break;
>> +     }
>> +     case IIO_CHAN_INFO_CALIBBIAS:
>> +             *val = 0;
>> +             *val2 = data->calib_bias;
>> +             ret = IIO_VAL_INT_PLUS_MICRO;
>> +             break;
>> +     }
>> +
>> +     mutex_unlock(&data->lock);
>> +
>> +     return ret;
>> +}
> [...]
>> +static struct iio_info lidar_info = {
>
> const
>
>> +     .driver_module = THIS_MODULE,
>> +     .read_raw = lidar_read_raw,
>> +     .write_raw = lidar_write_raw,
>> +};
> [...]
>> +static struct i2c_driver lidar_driver = {
>> +     .driver = {
>> +             .name   = LIDAR_DRV_NAME,
>> +             .owner  = THIS_MODULE,
>
> You added a DT vendor prefix, but there is no of match table for the driver.

So without of_match_table it isn't needed to have a vendor id?
"pulsedlight,lidar" maps to the i2c_device_id

>
>> +     },
>> +     .probe          = lidar_probe,
>> +     .remove         = lidar_remove,
>> +     .id_table       = lidar_id,
>> +};
>> +module_i2c_driver(lidar_driver);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
