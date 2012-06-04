Return-Path: <lars@metafoo.de>
Message-ID: <4FCD16AB.5020909@metafoo.de>
Date: Mon, 04 Jun 2012 22:12:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 01/18] iio: Add helper functions for enum style channel
 attributes
References: <1338802588-10585-1-git-send-email-lars@metafoo.de> <20120604105510.GB4400@mwanda>
In-Reply-To: <20120604105510.GB4400@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/04/2012 12:55 PM, Dan Carpenter wrote:
> On Mon, Jun 04, 2012 at 11:36:11AM +0200, Lars-Peter Clausen wrote:
>> +ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
>> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
>> +{
>> +	const struct iio_enum *e = (const struct iio_enum *)priv;
>> +	unsigned int i;
>> +	size_t len = 0;
>> +
>> +	if (!e->num_items)
>> +		return 0;
>> +
>> +	for (i = 0; i < e->num_items; ++i)
>> +		len += snprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
>> +
>> +	/* replace last space with a newline */
>> +	buf[len - 1] = '\n';
>> +
> 
> It would be better to use scnprintf() here instead of snprintf().
> snprintf() returns the number of characters that would have been
> printed if there were space (not counting the NULL), so len - 1 can
> be beyond the end of the array.

It's even worse, if len is greater than PAGE_SIZE we'll pass a pretty large
number for the buffer size to snprintf and it will happily write beyond the
buffers limits. So as it is right now the snprintf isn't really any better than
a sprintf. I'll resend the patch with scnprintf.

Thanks,
- Lars
