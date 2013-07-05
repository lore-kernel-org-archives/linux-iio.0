Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.206]:33585 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757050Ab3GEMls (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 08:41:48 -0400
Message-ID: <51D6BED7.6060703@digi.com>
Date: Fri, 5 Jul 2013 14:40:55 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-2-git-send-email-hector.palacios@digi.com> <201307051337.39215.marex@denx.de>
In-Reply-To: <201307051337.39215.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Marek,

On 07/05/2013 01:37 PM, Marek Vasut wrote:
> Dear Hector Palacios,
>
>> The LRADC virtual channels have an 18 bit field to store the sum of up
>> to 2^5 accumulated samples. The read_raw function however only operates
>> over a single sample (12 bit resolution).
>> In order to use this field for scaling operations, we need it to be the
>> exact resolution value of the LRADC.
>
> How would this work once the accumulation is supported?

As I see it, when you read a channel the driver should give you the 12-bit value 
either of one single sample or of N samples. If you are measuring an accumulation of N 
samples, the driver should divide the sum (the 18bit value) by N before returning the 
value to userland.

>
>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>> ---
>>   drivers/staging/iio/adc/mxs-lradc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index 163c638..d65a594 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -822,7 +822,7 @@ static const struct iio_buffer_setup_ops
>> mxs_lradc_buffer_ops = { .channel = (idx),					
> \
>>   	.scan_type = {						\
>>   		.sign = 'u',					\
>> -		.realbits = 18,					\
>> +		.realbits = 12,					\
>>   		.storagebits = 32,				\
>>   	},							\
>>   }
>
> Best regards,
> Marek Vasut
>


Best regards,
--
Hector Palacios
