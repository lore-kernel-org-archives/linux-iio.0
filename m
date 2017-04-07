Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:52516 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933248AbdDGMBN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 08:01:13 -0400
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: light: rpr0521 proximity offset read/write
 added
Date: Fri, 7 Apr 2017 11:46:04 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC1F7E@WILL-MAIL002.REu.RohmEu.com>
References: <1491390546-22054-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491390546-22054-4-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <alpine.DEB.2.20.1704051402070.5514@vps.pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5.4.2017 15:03, Peter Meerwald-Stadler wrote:
> nOn Wed, 5 Apr 2017, Mikko Koivunen wrote:
>
>> Added sysfs read/write proximity offset feature. Offset is read/write from
>> sensor registers. Values are proximity raw 10-bit values. After applying
>> offset value, output values will be (measured_raw - offset_value). Output
>> values are unsigned so offset value doesn't make output negative.
> comments below

Fixing to patchset v2.

>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
>> Builds OK with torvalds/linux 4.9
>> checkpatch.pl OK.
>>
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
>> ---
>>  drivers/iio/light/rpr0521.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>> index 13e2f9a..579bf6d 100644
>> --- a/drivers/iio/light/rpr0521.c
>> +++ b/drivers/iio/light/rpr0521.c
>> @@ -30,6 +30,9 @@
>>  #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
>>  #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
>>  #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
>> +#define RPR0521_PS_OFFSET_LSB		0x53
>> +#define RPR0521_PS_OFFSET_MSB		0x54
>> +
>>  #define RPR0521_REG_ID			0x92
>>  
>>  #define RPR0521_MODE_ALS_MASK		BIT(7)
>> @@ -214,7 +217,9 @@ struct rpr0521_data {
>>  		.type = IIO_PROXIMITY,
>>  		.address = RPR0521_CHAN_PXS,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_OFFSET) |
>>  			BIT(IIO_CHAN_INFO_SCALE),
>> +
>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>  	}
>>  };
>> @@ -400,6 +405,42 @@ static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
>>  		i);
>>  }
>>  
>> +int rpr0521_read_ps_offset(struct rpr0521_data *data, int *offset)
> static
>
>> +{
>> +	int ret;
>> +	u8 buffer[2];
> __le16
>
>> +
>> +	ret = regmap_bulk_read(data->regmap,
>> +		RPR0521_PS_OFFSET_LSB, &buffer, 2);
> sizeof(buffer)
>
>> +
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Failed to read PS OFFSET register\n");
>> +		return ret;
>> +	}
>> +	*offset = buffer[0] + (buffer[1] << 8);
> le16_to_cpu()
>
>> +
>> +	return ret;
>> +}
>> +
>> +int rpr0521_write_ps_offset(struct rpr0521_data *data, int offset)
> static
>
>> +{
>> +	int ret;
>> +	u8 buffer[2];
> __le16
>
>> +
>> +	buffer[0] = offset & 0xff;
>> +	buffer[1] = (offset >> 8) & (BIT(0) | BIT(1));
>> +
>> +	ret = regmap_raw_write(data->regmap,
>> +		RPR0521_PS_OFFSET_LSB, &buffer, 2);
> sizeof(buffer)
>
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
>> @@ -456,6 +497,14 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>  			return ret;
>>  		return IIO_VAL_INT_PLUS_MICRO;
>>  
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		mutex_lock(&data->lock);
>> +		ret = rpr0521_read_ps_offset(data, val);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			return ret;
>> +		return IIO_VAL_INT;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -483,6 +532,12 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
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

