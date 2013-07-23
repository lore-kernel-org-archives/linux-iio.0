Return-Path: <lars@metafoo.de>
Message-ID: <51EE69FC.6020002@metafoo.de>
Date: Tue, 23 Jul 2013 13:33:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jingoo Han <jg1.han@samsung.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/2] staging: iio: replace strict_strto*() with kstrto*()
References: <001d01ce878e$0e76b710$2b642530$@samsung.com> <20130723112655.GR5585@mwanda>
In-Reply-To: <20130723112655.GR5585@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/23/2013 01:26 PM, Dan Carpenter wrote:
> On Tue, Jul 23, 2013 at 07:19:03PM +0900, Jingoo Han wrote:
>> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> index 38a158b..03766bb 100644
>> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>> @@ -87,7 +87,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>>  	bool enabled;
>>  	int ret;
>>  
>> -	ret = strict_strtoul(buf, 10, &val);
>> +	ret = kstrtoul(buf, 10, &val);
>>  	if (ret)
>>  		goto error_ret;
>>  
> 
> Btw, this function is not beautiful.

The whole driver is not beautiful ;) It will eventually be replaced with
something more generic, I wouldn't put too much effort into cleaning it up.

- Lars
