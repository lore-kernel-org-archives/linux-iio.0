Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41283 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3KRUw6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2013 15:52:58 -0500
In-Reply-To: <528A5C83.9020200@metafoo.de>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org> <1384701302-26564-8-git-send-email-jic23@kernel.org> <528A5C83.9020200@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 07/11] iio:adc:ad7793: use samp_freq element of info_mask_shared_by_all.
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 18 Nov 2013 20:52:51 +0000
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Message-ID: <f15d1256-ce32-48a8-8430-486eb9bae119@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 11/17/2013 04:14 PM, Jonathan Cameron wrote:
>> This replaces the previous use of a custom attribute to create the
>same
>> interface.  One big advantage is that this allows in kernel access.
>
>Looks mostly good, can probably also be merged without waiting for the
>reset
>of the series
>
>[...]
>> @@ -512,6 +457,10 @@ static int ad7793_read_raw(struct iio_dev
>*indio_dev,
>>  			*val -= offset;
>>  		}
>>  		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = st->chip_info->
>> +			sample_freq_avail[AD7793_MODE_RATE(st->mode)];
>> +		return IIO_VAL_INT;
>>  	}
>>  	return -EINVAL;
>>  }
>> @@ -551,6 +500,20 @@ static int ad7793_write_raw(struct iio_dev
>*indio_dev,
>>  				break;
>>  			}
>>  		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		if (val == 0)
>> +			return -EINVAL;
>> +
>> +		ret = -EINVAL;
>> +		for (i = 0; i < 16; i++)
>> +			if (val == st->chip_info->sample_freq_avail[i]) {
>> +				st->mode &= ~AD7793_MODE_RATE(-1);
>> +				st->mode |= AD7793_MODE_RATE(i);
>> +				ad_sd_write_reg(&st->sd, AD7793_REG_MODE,
>> +						sizeof(st->mode), st->mode);
>> +				ret = 0;
>> +			}
>
>In order to keep the indentation level low I'd put this into it's own
>function.
>
>> +		break;
>>  	default:
>>  		ret = -EINVAL;
>>  	}
>[...]
>>  #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
>>  const struct iio_chan_spec _name##_channels[] = { \
>>  	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0,
>\
>> -	0, 0, 0), \
>> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>>  	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0,
>\
>> -	0, 0, 0), \
>> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>>  	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0,
>\
>> -	0, 0, 0), \
>> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>>  	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0,
>\
>> -	0, 0, 0), \
>> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>>  	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0,
>\
>> -	0, 0, 0), \
>> +	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
>>  	IIO_CHAN_SOFT_TIMESTAMP(5), \
>>  }
>
>Do we actually have any channels that won't have the SAMP_FREQ
>attribute set?
Yes in one of the drivers ad7780 I think...

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
