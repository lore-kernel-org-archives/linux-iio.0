Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49538 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbcKUPpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2016 10:45:40 -0500
Subject: Re: [RFC PATCH v2 3/7] iio: inkern: api for manipulating ext_info of
 iio channels
To: Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
 <1479419289-17553-4-git-send-email-peda@axentia.se>
 <d5cd7550-2cde-5beb-2cdb-ad6d501fc0ef@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6ea462c2-53ae-0f50-deb9-e500a97f2ac4@metafoo.de>
Date: Mon, 21 Nov 2016 16:45:29 +0100
MIME-Version: 1.0
In-Reply-To: <d5cd7550-2cde-5beb-2cdb-ad6d501fc0ef@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/2016 04:38 PM, Jonathan Cameron wrote:
> On 17/11/16 21:48, Peter Rosin wrote:
>> Extend the inkern api with functions for reading and writing ext_info
>> of iio channels.
> I'd like Lars' feedback on this one.
> 
> Superficially looks fine to me but I am not as familiar with this interface
> as Lars is ;) (he wrote it IIRC:)

The implementation looks OK. I'm not necessarily convinced about the concept
though, but the code is manageable so I guess it is OK.

The final version should add kernel API documentation for the new functions.

>> ---
>>  drivers/iio/inkern.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/iio/consumer.h |  6 +++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index cfca17ba2535..a8099b164222 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -850,3 +850,58 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(iio_write_channel_raw);
>> +
>> +int iio_get_channel_ext_info_count(struct iio_channel *chan)

should be unsigned.

>> +{
>> +	const struct iio_chan_spec_ext_info *ext_info;
>> +	unsigned int i = 0;
>> +
>> +	if (!chan->channel->ext_info)
>> +		return i;
>> +
>> +	for (ext_info = chan->channel->ext_info; ext_info->name; ext_info++)
>> +		++i;
>> +
>> +	return i;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
>> +
>> +ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
>> +				  const char *attr, char *buf)
>> +{
>> +	const struct iio_chan_spec_ext_info *ext_info;
>> +
>> +	if (!chan->channel->ext_info)
>> +		return -EINVAL;
>> +
>> +	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
>> +		if (strcmp(attr, ext_info->name))
>> +			continue;

You could factor the lookup out into a helper function that is used for both
read and write. And also stop searching once a match was found.

>> +
>> +		return ext_info->read(chan->indio_dev, ext_info->private,
>> +				      chan->channel, buf);
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
>> +
>> +ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>> +				   const char *buf, size_t len)
>> +{
>> +	const struct iio_chan_spec_ext_info *ext_info;
>> +
>> +	if (!chan->channel->ext_info)
>> +		return -EINVAL;
>> +
>> +	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
>> +		if (strcmp(attr, ext_info->name))
>> +			continue;
>> +
>> +		return ext_info->write(chan->indio_dev, ext_info->private,
>> +				       chan->channel, buf, len);
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
>> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
>> index 9a4f336d8b4a..471dece8729a 100644
>> --- a/include/linux/iio/consumer.h
>> +++ b/include/linux/iio/consumer.h
>> @@ -299,4 +299,10 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
>>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>>  	int *processed, unsigned int scale);
>>  
>> +int iio_get_channel_ext_info_count(struct iio_channel *chan);
>> +ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
>> +				  const char *attr, char *buf);
>> +ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>> +				   const char *buf, size_t len);
>> +
>>  #endif
>>
> 

