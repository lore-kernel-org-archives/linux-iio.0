Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41822 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbcHOQPx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 12:15:53 -0400
Subject: Re: [PATCH] iio: adc: at91: unbreak channel adc channel 3
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Anders Darander <anders@chargestorm.se>
References: <1470660136-12524-1-git-send-email-anders@chargestorm.se>
 <20160808135243.GA19793@piout.net>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <36ed1fcf-f6e9-62fe-b6fe-3a55431d387b@kernel.org>
Date: Mon, 15 Aug 2016 17:15:51 +0100
MIME-Version: 1.0
In-Reply-To: <20160808135243.GA19793@piout.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/08/16 14:52, Alexandre Belloni wrote:
> On 08/08/2016 at 14:42:16 +0200, Anders Darander wrote :
>> The driver always assumes that an input device has been created when
>> reading channel 3. This causes a kernel panic when dereferencing
>> st->ts_input.
>>
>> The change was introduced in
>> commit 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens
>> without TSMR"). Earlier versions only entered that part of the if-else
>> statement if only the following flags are set:
>>
>> AT91_ADC_IER_XRDY | AT91_ADC_IER_YRDY | AT91_ADC_IER_PRDY
>>
>> Signed-off-by: Anders Darander <anders@chargestorm.se>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Applied and marked for stable.

Thanks in particular for the thorough description!

Jonathan
> 
>> ---
>>  drivers/iio/adc/at91_adc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 52430ba..0438c68 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -381,8 +381,8 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
>>  		st->ts_bufferedmeasure = false;
>>  		input_report_key(st->ts_input, BTN_TOUCH, 0);
>>  		input_sync(st->ts_input);
>> -	} else if (status & AT91_ADC_EOC(3)) {
>> -		/* Conversion finished */
>> +	} else if (status & AT91_ADC_EOC(3) && st->ts_input) {
>> +		/* Conversion finished and we've a touchscreen */
>>  		if (st->ts_bufferedmeasure) {
>>  			/*
>>  			 * Last measurement is always discarded, since it can
>> -- 
>> 2.8.1
>>
> 

