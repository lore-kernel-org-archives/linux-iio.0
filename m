Return-Path: <lars@metafoo.de>
Message-ID: <50269871.5030508@metafoo.de>
Date: Sat, 11 Aug 2012 19:37:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 22/22] staging:iio:adc: Add AD7791 driver
References: <1344616596-8026-1-git-send-email-lars@metafoo.de> <1344616596-8026-22-git-send-email-lars@metafoo.de> <alpine.DEB.2.01.1208111034270.5846@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1208111034270.5846@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/11/2012 10:41 AM, Peter Meerwald wrote:
> 
> two minor comments below
>

Thanks.

>>[...]
>> +static const char * const ad7791_sample_freq_avail[] = {
>> +	[AD7791_FILTER_RATE_120] = "120",
>> +	[AD7791_FILTER_RATE_100] = "100",
>> +	[AD7791_FILTER_RATE_33_3] = "33.3",
>> +	[AD7791_FILTER_RATE_20] = "20",
>> +	[AD7791_FILTER_RATE_16_6] = "16.6",
>> +	[AD7791_FILTER_RATE_16_7] = "16.7",
> 
> just curious; why is this not in strictly decreasing order?
> IIO_CONST_ATTR_SAMP_FREQ_AVAIL is...

It doesn't really matter, but to keep the indices in order.
AD7791_FILTER_RATE_16_6 is 0x4 and AD7791_FILTER_RATE_16_7 is 0x5.


> 
>> +	[AD7791_FILTER_RATE_13_3] = "13.3",
>> +	[AD7791_FILTER_RATE_9_5] = "9.5",
>> +};
>> +
