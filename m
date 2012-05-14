Return-Path: <lars@metafoo.de>
Message-ID: <4FB1175C.4020008@metafoo.de>
Date: Mon, 14 May 2012 16:31:56 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org>
In-Reply-To: <4FAEB14A.8020408@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/12/2012 08:51 PM, Jonathan Cameron wrote:
> [...]
>> -static const struct iio_info max518_info = {
>> -	.attrs = &max518_attribute_group,
>> -	.driver_module = THIS_MODULE,
>> +#define MAX517_CHANNEL(chan) {				\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.output = 1,						\
>> +	.channel = (chan),					\
>> +	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
>> +	IIO_CHAN_INFO_SCALE_SEPARATE_BIT,			\
> I suppose the scan_type acts as kind of documentation, but
> it's not really relevant or necessary here... I'd scrap it.

I'd like to keep it, because I think it will be used in the future. E.g. for
buffer output, but also some other things might make use of it.

>> +	.scan_type = IIO_ST('u', 8, 8, 0),	\
>> +}
