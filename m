Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36346 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbcJAW3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 18:29:18 -0400
Received: by mail-qk0-f193.google.com with SMTP id m184so8422135qkb.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2016 15:29:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bankarsandhya512@gmail.com
In-Reply-To: <737de70d-80e5-a9b5-4522-8b66e6cd8ca6@kernel.org>
References: <20160929160133.GA5460@localhost.localdomain> <737de70d-80e5-a9b5-4522-8b66e6cd8ca6@kernel.org>
From: sandhya bankar <bankarsandhya512@gmail.com>
Date: Sun, 2 Oct 2016 03:59:17 +0530
Message-ID: <CAA3ASznew0CCzJaPMG00MDeDpHdAVLouuae2NObD6B2KcP+ZDw@mail.gmail.com>
Subject: Re: [PATCH v2] Staging: iio: meter: ade7753: Replace
 IIO_DEV_ATTR_SAMP_FREQ attribute with IIO_CHAN_INFO_SAMP_FREQ handlers.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 1, 2016 at 6:45 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/09/16 17:01, Sandhya Bankar wrote:
>> Moved functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
>> IIO_CHAN_INFO_SAMP_FREQ handlers. Added ade7753_read_raw() and
>> ade7753_write_raw() to allow reading/writing the element as well.
>>
>> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
> I'd forgotten this driver existed. There are a lot of similar
> elements in here that can be cleaned up if you want to take
> this further.
>
> Step 1. Convert all the attrs that are actually standard IIO abi.
> Step 2. Start looking at the custom ABI in here and consider what
> to do about it.  (might be a job for someone familiar with the
> hardware!)
>
> Anyhow, this doesn't actually work.
>
> Take a look at what calls the read_raw and write_raw functions
> and how the relevant sysfs attributes are instantiated.
>
> Lars, I think any major ABI work on this is going to need
> some input from Analog (or someone who actually has one of
> these!)...
>
> The energy meter drivers are somewhat of an open space when
> it comes to ABI definitions (there aren't really any yet!)

Hello,
     It doesn't work because I have not defined the attribute
IIO_CHAN_INFO* for sysfs. So, the attribute won't get exposed as a
sysfs file. Right ?
We typically use it as a channel attribute.
So, in this case, Should I create a channel, or is there another
possible way to do it ?

I am just curious to know that why the channel for this driver is not defined ?
Please suggest on same.


Thanks,
Sandhya






> Jonathan
>> ---
>> Changes in v2:
>> * Adding "Staging" keyword in subject line.
>>
>>  drivers/staging/iio/meter/ade7753.c | 155 +++++++++++++++++++++---------------
>>  1 file changed, 90 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
>> index 4b5f05f..a2b4a18 100644
>> --- a/drivers/staging/iio/meter/ade7753.c
>> +++ b/drivers/staging/iio/meter/ade7753.c
>> @@ -98,6 +98,94 @@ static int ade7753_spi_read_reg_16(struct device *dev,
>>       return 0;
>>  }
>>
>> +static int ade7753_read_raw_samp_freq(struct device *dev, int *val)
>> +{
>> +     int ret;
>> +     u16 t;
>> +
>> +     ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &t);
>> +     if (ret)
>> +             return ret;
>> +     t = (t >> 11) & 0x3;
>> +     *val = 27900 / (1 + t);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ade7753_write_raw_samp_freq(struct device *dev, int val)
>> +{
>> +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +     struct ade7753_state *st = iio_priv(indio_dev);
>> +     int ret;
>> +     u16 reg, t;
>> +
>> +     if (!val)
>> +             return -EINVAL;
>> +
>> +     t = 27900 / val;
>> +     if (t > 0)
>> +             t--;
>> +
>> +     if (t > 1)
>> +             st->us->max_speed_hz = ADE7753_SPI_SLOW;
>> +     else
>> +             st->us->max_speed_hz = ADE7753_SPI_FAST;
>> +
>> +     ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &reg);
>> +     if (ret)
>> +             goto out;
>> +
>> +     reg &= ~(3 << 11);
>> +     reg |= t << 11;
>> +
>> +     ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>> +
>> +out:
>> +     return ret;
>> +}
>> +
>> +static int ade7753_write_raw(struct iio_dev *indio_dev,
>> +                          struct iio_chan_spec const *chan,
>> +                          int val, int val2, long mask)
>> +{
>> +     int ret;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             if (val2)
>> +                     return -EINVAL;
>> +             mutex_lock(&indio_dev->mlock);
>> +             ret = ade7753_write_raw_samp_freq(&indio_dev->dev, val);
>> +             mutex_unlock(&indio_dev->mlock);
>> +             return ret;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int ade7753_read_raw(struct iio_dev *indio_dev,
>> +                         struct iio_chan_spec const *chan,
>> +                         int *val,
>> +                         int *val2,
>> +                         long mask)
>> +{
>> +     int ret;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             mutex_lock(&indio_dev->mlock);
>> +             ret = ade7753_read_raw_samp_freq(&indio_dev->dev, val);
>> +             mutex_unlock(&indio_dev->mlock);
>> +             return ret;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>  static int ade7753_spi_read_reg_24(struct device *dev,
>>               u8 reg_address,
>>               u32 *val)
>> @@ -383,82 +471,17 @@ err_ret:
>>       return ret;
>>  }
>>
>> -static ssize_t ade7753_read_frequency(struct device *dev,
>> -             struct device_attribute *attr,
>> -             char *buf)
>> -{
>> -     int ret;
>> -     u16 t;
>> -     int sps;
>> -
>> -     ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &t);
>> -     if (ret)
>> -             return ret;
>> -
>> -     t = (t >> 11) & 0x3;
>> -     sps = 27900 / (1 + t);
>> -
>> -     return sprintf(buf, "%d\n", sps);
>> -}
>> -
>> -static ssize_t ade7753_write_frequency(struct device *dev,
>> -             struct device_attribute *attr,
>> -             const char *buf,
>> -             size_t len)
>> -{
>> -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> -     struct ade7753_state *st = iio_priv(indio_dev);
>> -     u16 val;
>> -     int ret;
>> -     u16 reg, t;
>> -
>> -     ret = kstrtou16(buf, 10, &val);
>> -     if (ret)
>> -             return ret;
>> -     if (!val)
>> -             return -EINVAL;
>> -
>> -     mutex_lock(&indio_dev->mlock);
>> -
>> -     t = 27900 / val;
>> -     if (t > 0)
>> -             t--;
>> -
>> -     if (t > 1)
>> -             st->us->max_speed_hz = ADE7753_SPI_SLOW;
>> -     else
>> -             st->us->max_speed_hz = ADE7753_SPI_FAST;
>> -
>> -     ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &reg);
>> -     if (ret)
>> -             goto out;
>> -
>> -     reg &= ~(3 << 11);
>> -     reg |= t << 11;
>> -
>> -     ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>> -
>> -out:
>> -     mutex_unlock(&indio_dev->mlock);
>> -
>> -     return ret ? ret : len;
>> -}
>>
>>  static IIO_DEV_ATTR_TEMP_RAW(ade7753_read_8bit);
>>  static IIO_CONST_ATTR(in_temp_offset, "-25 C");
>>  static IIO_CONST_ATTR(in_temp_scale, "0.67 C");
>>
>> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>> -             ade7753_read_frequency,
>> -             ade7753_write_frequency);
>> -
>>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
>>
>>  static struct attribute *ade7753_attributes[] = {
>>       &iio_dev_attr_in_temp_raw.dev_attr.attr,
>>       &iio_const_attr_in_temp_offset.dev_attr.attr,
>>       &iio_const_attr_in_temp_scale.dev_attr.attr,
>> -     &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>       &iio_dev_attr_phcal.dev_attr.attr,
>>       &iio_dev_attr_cfden.dev_attr.attr,
>> @@ -496,6 +519,8 @@ static const struct attribute_group ade7753_attribute_group = {
>>
>>  static const struct iio_info ade7753_info = {
>>       .attrs = &ade7753_attribute_group,
>> +     .read_raw = &ade7753_read_raw,
>> +     .write_raw = &ade7753_write_raw,
>>       .driver_module = THIS_MODULE,
>>  };
>>
>>
>
