Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:53193 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdDJNvp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2017 09:51:45 -0400
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iio: light: rpr0521 proximity offset read/write
 added
Date: Mon, 10 Apr 2017 13:36:36 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC4427@WILL-MAIL002.REu.RohmEu.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-4-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <a0865020-8002-efd9-e638-a52ebcc29d7d@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8.4.2017 18:07, Jonathan Cameron wrote:
> On 07/04/17 13:07, Mikko Koivunen wrote:
>> Added sysfs read/write proximity offset feature. Offset is read/write from
>> sensor registers. Values are proximity raw 10-bit values. After applying
>> offset value, output values will be (measured_raw - offset_value). Output
>> values are unsigned so offset value doesn't make output negative.
>>
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
>> ---
> A few bits and bobs inline.
>
> Jonathan

Fixing in patchset v3.

>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
>> Builds OK with torvalds/linux 4.9
>> checkpatch.pl OK.
>>
>> Patch v1->v2 changes:
>> read/write_ps_offset() rewritten with:
>>  -  static, __le16, cpu_to_le16(), sizeof()
>>
>>  drivers/iio/light/rpr0521.c |   53 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>> index e92a8bb..35c759b 100644
>> --- a/drivers/iio/light/rpr0521.c
>> +++ b/drivers/iio/light/rpr0521.c
>> @@ -30,6 +30,9 @@
>>  #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
>>  #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
>>  #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
>> +#define RPR0521_PS_OFFSET_LSB		0x53
>> +#define RPR0521_PS_OFFSET_MSB		0x54
> Not used, so drop it.
Ack.
>> +
> Given previous naming always has REG_ in it you should maintain that..
> Also, why the blank line here?

Ack.
>>  #define RPR0521_REG_ID			0x92
>>  
>>  #define RPR0521_MODE_ALS_MASK		BIT(7)
>> @@ -215,7 +218,9 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>>  		.type = IIO_PROXIMITY,
>>  		.address = RPR0521_CHAN_PXS,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_OFFSET) |
>>  			BIT(IIO_CHAN_INFO_SCALE),
> This blank line shouldn't be added here. Nothing to do with tis patch.
Ack.
>> +
>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>  	}
>>  };
>> @@ -402,6 +407,40 @@ static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
>>  		i);
>>  }
>>  
>> +static int rpr0521_read_ps_offset(struct rpr0521_data *data, int *offset)
>> +{
>> +	int ret;
>> +	__le16 buffer;
>> +
>> +	ret = regmap_bulk_read(data->regmap,
>> +		RPR0521_PS_OFFSET_LSB, &buffer, sizeof(buffer));
>> +
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Failed to read PS OFFSET register\n");
>> +		return ret;
>> +	}
>> +	*offset = le16_to_cpu(buffer);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpr0521_write_ps_offset(struct rpr0521_data *data, int offset)
>> +{
>> +	int ret;
>> +	__le16 buffer;
>> +
>> +	buffer = cpu_to_le16(offset & 0x3ff);
>> +	ret = regmap_raw_write(data->regmap,
>> +		RPR0521_PS_OFFSET_LSB, &buffer, sizeof(buffer));
>> +
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Failed to write PS OFFSET register\n");
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>  			    struct iio_chan_spec const *chan, int *val,
>>  			    int *val2, long mask)
>> @@ -458,6 +497,14 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>  			return ret;
>>  		return IIO_VAL_INT_PLUS_MICRO;
>>  
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		mutex_lock(&data->lock);
>> +		ret = rpr0521_read_ps_offset(data, val);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			return ret;
> Slight preference for a blank line here.

Disagree, but ack.

>
>> +		return IIO_VAL_INT;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -485,6 +532,12 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
>>  		mutex_unlock(&data->lock);
>>  		return ret;
>>  
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		mutex_lock(&data->lock);
>> +		ret = rpr0521_write_ps_offset(data, val);
>> +		mutex_unlock(&data->lock);
>> +		return ret;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
>>
>

