Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab3LQU3d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2013 15:29:33 -0500
Message-ID: <52B0B429.8020109@kernel.org>
Date: Tue, 17 Dec 2013 20:29:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	o.v.kravchenko@globallogic.com, stigge@antcom.de
Subject: Re: [PATCH 23/24] staging:iio:ad799x replaces IIO_ST macro with explicit
 entries to struct scan_type
References: <1386787542-19666-1-git-send-email-jic23@kernel.org> <1386787542-19666-24-git-send-email-jic23@kernel.org> <52AEBF77.1000800@metafoo.de>
In-Reply-To: <52AEBF77.1000800@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/16/13 08:53, Lars-Peter Clausen wrote:
> On 12/11/2013 07:45 PM, Jonathan Cameron wrote:
>> IIO_ST is going away as it is a pain to maintain. As an i2c driver, multi byte
>> words will be read by the driver in the native cpu endianness.
> 
> Are you sure about this? As far as I understand it the I2C message will be
> read byte by byte. The device sends the MSB first, so I think it should be
> IIO_BE.

Gah. I just spent 5 minutes writing an essay on the fact it was an smbus
word read call, only to realise I was looking at the wrong function and
this is done with a block read.  Doh.  You are quite right!  I'll
switch this one to IIO_BE.


> 
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/adc/ad799x_core.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
>> index 5ea36410f716..45e64d8bf29b 100644
>> --- a/drivers/staging/iio/adc/ad799x_core.c
>> +++ b/drivers/staging/iio/adc/ad799x_core.c
>> @@ -409,7 +409,13 @@ static const struct iio_event_spec ad799x_events[] = {
>>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>>  	.scan_index = (_index), \
>> -	.scan_type = IIO_ST('u', _realbits, 16, 12 - (_realbits)), \
>> +	.scan_type = { \
>> +		.sign = 'u', \
>> +		.realbits = (_realbits), \
>> +		.storagebits = 16, \
>> +		.shift = 12 - (_realbits), \
>> +		.endianness = IIO_CPU, \
>> +		}, \
>>  	.event_spec = _ev_spec, \
>>  	.num_event_specs = _num_ev_spec, \
>>  }
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
