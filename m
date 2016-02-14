Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbcBNUCR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 14 Feb 2016 15:02:17 -0500
Subject: Re: [PATCH 2/2] iio: ina2xx: Remove trace_printk debug statments
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Titinger <mtitinger@baylibre.com>
References: <1455302063-8414-1-git-send-email-afd@ti.com>
 <1455302063-8414-2-git-send-email-afd@ti.com> <56BF2DD5.8070402@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56C0DD3C.8010606@ti.com>
Date: Sun, 14 Feb 2016 14:02:04 -0600
MIME-Version: 1.0
In-Reply-To: <56BF2DD5.8070402@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/13/2016 07:21 AM, Jonathan Cameron wrote:
> On 12/02/16 18:34, Andrew F. Davis wrote:
>> These are generally for devlopment use only, remove these
>> from performance-critical code, convert to dev_dbg elswhere.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Hm... Tracepoints are also somewhat considered to be ABI and
> hence it is possible some tooling relies on them.  Also they
> are very nearly free when not enabled.
>
> The fundamental reason they are here it to allow checking of whether
> the thread is ticking along fast enough to keep up with the incoming data.
> Can see this being useful on live platforms to debug sampling issues.
>

This looks more like development testing statements to see if the delay timer
adjustment algorithm is working well. If one is debugging sampling issues,
then they are always free to add any extra debugging lines they need.

> What do others think about this change?
>
> Andrew, what is driving your wish to change this?
>

v4.5-rc3 include/linux/kernel.h +609:

"This is intended as a debugging tool for the developer only.
Please refrain from leaving trace_printks scattered around in
your code."

> Jonathan
>> ---
>>   drivers/iio/adc/ina2xx-adc.c | 21 +++++++--------------
>>   1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>> index 61e8ae9..ba11b2e 100644
>> --- a/drivers/iio/adc/ina2xx-adc.c
>> +++ b/drivers/iio/adc/ina2xx-adc.c
>> @@ -440,7 +440,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>   	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>>   	unsigned short data[8];
>>   	int bit, ret, i = 0;
>> -	unsigned long buffer_us, elapsed_us;
>>   	s64 time_a, time_b;
>>   	unsigned int alert;
>>
>> @@ -464,8 +463,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>   				return ret;
>>
>>   			alert &= INA266_CVRF;
>> -			trace_printk("Conversion ready: %d\n", !!alert);
>> -
>>   		} while (!alert);
>>
>>   	/*
>> @@ -490,14 +487,9 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>   	iio_push_to_buffers_with_timestamp(indio_dev,
>>   					   (unsigned int *)data, time_a);
>>
>> -	buffer_us = (unsigned long)(time_b - time_a) / 1000;
>> -	elapsed_us = (unsigned long)(time_a - chip->prev_ns) / 1000;
>> -
>> -	trace_printk("uS: elapsed: %lu, buf: %lu\n", elapsed_us, buffer_us);
>> -
>>   	chip->prev_ns = time_a;
>>
>> -	return buffer_us;
>> +	return (unsigned long)(time_b - time_a) / 1000;
>>   };
>>
>>   static int ina2xx_capture_thread(void *data)
>> @@ -532,12 +524,13 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>>   	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>>   	unsigned int sampling_us = SAMPLING_PERIOD(chip);
>>
>> -	trace_printk("Enabling buffer w/ scan_mask %02x, freq = %d, avg =%u\n",
>> -		     (unsigned int)(*indio_dev->active_scan_mask),
>> -		     1000000/sampling_us, chip->avg);
>> +	dev_dbg(&indio_dev->dev, "Enabling buffer w/ scan_mask %02x, freq = %d, avg =%u\n",
>> +		(unsigned int)(*indio_dev->active_scan_mask),
>> +		1000000 / sampling_us, chip->avg);
>>
>> -	trace_printk("Expected work period: %u us\n", sampling_us);
>> -	trace_printk("Async readout mode: %d\n", chip->allow_async_readout);
>> +	dev_dbg(&indio_dev->dev, "Expected work period: %u us\n", sampling_us);
>> +	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
>> +		chip->allow_async_readout);
>>
>>   	chip->prev_ns = iio_get_time_ns();
>>
>>
>
