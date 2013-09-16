Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-205.synserver.de ([212.40.185.205]:1138 "EHLO
	smtp-out-204.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750728Ab3IPQwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 12:52:38 -0400
Message-ID: <523737B0.9080306@metafoo.de>
Date: Mon, 16 Sep 2013 18:54:08 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 25/27] staging:iio:mxs-lradc: Use iio_push_to_buffers_with_timestamp()
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-25-git-send-email-lars@metafoo.de> <201309161553.34371.marex@denx.de>
In-Reply-To: <201309161553.34371.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/2013 03:53 PM, Marek Vasut wrote:
> Dear Lars-Peter Clausen,
> 
>> Makes the code a bit shorter and less ugly.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Marek Vasut <marex@denx.de>
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index 7401230..9da64bf 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -625,13 +625,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq,
>> void *p) j++;
>>  	}
>>
>> -	if (iio->scan_timestamp) {
>> -		s64 *timestamp = (s64 *)((u8 *)lradc->buffer +
>> -					ALIGN(j, sizeof(s64)));
>> -		*timestamp = pf->timestamp;
>> -	}
>> -
>> -	iio_push_to_buffers(iio, lradc->buffer);
>> +	iio_push_to_buffers_with_timestamp(iio, lradc->buffer, pf->timestamp);
>>
>>  	iio_trigger_notify_done(iio->trig);
> 
> Indeed, this stuff was duplicated all around.
> 

Is that a acked-by? :)

- Lars

