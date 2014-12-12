Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46788 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966028AbaLLKRt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:17:49 -0500
Message-ID: <548AC0C7.90204@kernel.org>
Date: Fri, 12 Dec 2014 10:17:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: add iio_write_channel_raw
References: <1417041765-12782-1-git-send-email-dbaryshkov@gmail.com> <5488D0DB.2060400@gmx.de>
In-Reply-To: <5488D0DB.2060400@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/14 23:01, Hartmut Knaack wrote:
> Dmitry Eremin-Solenikov schrieb am 26.11.2014 um 23:42:
>> Introduce API for easy in-kernel setting of DAC values.
>>
> Looking good in general, but indentation of parameters could be
> improved to align with opening parenthesis. See inline.
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
I've fixed up both Lars and Hartmut's comments and applied to the
togreg branch of iio.git - initially pushed out as testing sometime
later today.  Lots to catch up with first ;)
>> ---
>>  drivers/iio/inkern.c         | 29 +++++++++++++++++++++++++++++
>>  include/linux/iio/consumer.h | 11 +++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index f084610..5b03e69 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -608,3 +608,32 @@ err_unlock:
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(iio_get_channel_type);
>> +
>> +static int iio_channel_write(struct iio_channel *chan, int val, int val2,
>> +	enum iio_chan_info_enum info)
> Here.
>> +{
>> +	int ret;
>> +
>> +	ret = chan->indio_dev->info->write_raw(chan->indio_dev,
>> +			chan->channel, val, val2, info);
> Here.
>> +
>> +	return ret;
>> +}
>> +
>> +int iio_write_channel_raw(struct iio_channel *chan, int val)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&chan->indio_dev->info_exist_lock);
>> +	if (chan->indio_dev->info == NULL) {
>> +		ret = -ENODEV;
>> +		goto err_unlock;
>> +	}
>> +
>> +	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
>> +err_unlock:
>> +	mutex_unlock(&chan->indio_dev->info_exist_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_write_channel_raw);
>> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
>> index 651f9a0..06f4688 100644
>> --- a/include/linux/iio/consumer.h
>> +++ b/include/linux/iio/consumer.h
>> @@ -151,6 +151,17 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
>>  int iio_read_channel_processed(struct iio_channel *chan, int *val);
>>  
>>  /**
>> + * iio_write_channel_raw() - write to a given channel
>> + * @chan:		The channel being queried.
>> + * @val:		Value being written.
>> + *
>> + * Note raw writes to iio channels are in dac counts and hence
>> + * scale will need to be applied if standard units required.
>> + */
>> +int iio_write_channel_raw(struct iio_channel *chan,
>> +			 int val);
> And here, everything would easily fit in just one line.
>> +
>> +/**
>>   * iio_get_channel_type() - get the type of a channel
>>   * @channel:		The channel being queried.
>>   * @type:		The type of the channel.
>>
> 

