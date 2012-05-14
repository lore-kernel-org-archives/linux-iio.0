Return-Path: <lars@metafoo.de>
Message-ID: <4FB14BCA.9090102@metafoo.de>
Date: Mon, 14 May 2012 20:15:38 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [RFC 1/8] iio: Add helper functions for enum style channel attributes
References: <1336751635-7934-1-git-send-email-lars@metafoo.de> <4FB14411.6070408@kernel.org>
In-Reply-To: <4FB14411.6070408@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/14/2012 07:42 PM, Jonathan Cameron wrote:
> On 05/11/2012 04:53 PM, Lars-Peter Clausen wrote:
>> We often have the case were we do have a enum style channel attribute. These
>> attributes have in common that they are a list of string values which usually
>> map in a 1-to-1 fashion to integer values.
>>
>> This patch implements some common helper code for implementing enum style
>> channel attributes using extended channel attributes. The helper functions take
>> care of converting between the string and integer values, as well providing a
>> function for "_available" attributes which list all available enum items.
>>
> General principal is good, but needs some documentation :)

Oops, yes wanted to add that before sending the patches out, but well looks
like I forgot about it.

> 
> Also couple of trivial points inline.
> 
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/iio/industrialio-core.c |   57 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/iio/iio.h         |   32 ++++++++++++++++++++++
>>  2 files changed, 89 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index b39a587..241be03 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -288,6 +288,63 @@ static ssize_t iio_write_channel_ext_info(struct device *dev,
>>  			       this_attr->c, buf, len);
>>  }
>>  
>> +ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
>> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +	const struct iio_enum *e = (const struct iio_enum *)priv;
>> +	char *tmp = buf;
>> +	unsigned int i;
>> +
>> +	if (!e->num_items)
>> +		return 0;
>> +
> Best to add some santify checking on the length of the resulting string
> given it's technically unbounded.

I guess if we hit the PAGE_SIZE limit something went seriously wrong anyway,
but yeah I'll add a check.

>> +	for (i = 0; i < e->num_items; ++i)
>> +		tmp += sprintf(tmp, "%s ", e->items[i]);
>> +
>> +	/* replace last space with a newline */
>> +	*(tmp - 1) = '\n';
>> +
>> +	return tmp - buf;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_enum_available_read);
>> +
>> +ssize_t iio_enum_read(struct iio_dev *indio_dev,
>> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +	const struct iio_enum *e = (const struct iio_enum *)priv;
>> +	int i;
>> +
>> +	i = e->get(indio_dev, chan);
>> +	if (i < 0)
>> +		return i;
>> +	else if (i >= e->num_items)
>> +		return -EINVAL;
>> +
>> +	return sprintf(buf, "%s\n", e->items[i]);
>> +}
>> +EXPORT_SYMBOL_GPL(iio_enum_read);
>> +
>> +ssize_t iio_enum_write(struct iio_dev *indio_dev,
>> +	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
>> +	size_t len)
>> +{
>> +	const struct iio_enum *e = (const struct iio_enum *)priv;
>> +	unsigned int i;
>> +	int ret;
>> +
> excess brackets.

While it would be legal C I think it really hurts readability to remove them.
Also CodingStyle says that they are only optional if they are enclosing only a
single statements.

>> +	for (i = 0; i < e->num_items; i++) {
>> +		if (sysfs_streq(buf, e->items[i]))
>> +			break;
>> +	}
>> +
