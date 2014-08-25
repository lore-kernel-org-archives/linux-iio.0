Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46753 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbaHYUl1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 16:41:27 -0400
Message-ID: <53FB9F75.5090505@kernel.org>
Date: Mon, 25 Aug 2014 21:41:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/8] iio: adc: ad_sigma_delta: Fix indio_dev->trig
 assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-4-git-send-email-srinivas.pandruvada@linux.intel.com> <53F83BF6.5080705@metafoo.de>
In-Reply-To: <53F83BF6.5080705@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/14 08:00, Lars-Peter Clausen wrote:
> On 08/22/2014 10:48 PM, Srinivas Pandruvada wrote:
>> This can result in wrong reference count for trigger device, call
>> iio_trigger_get to increment reference.
>> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
>> with Jonathan.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> 
> Thanks.
> 
>> ---
>>   drivers/iio/adc/ad_sigma_delta.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
>> index c55b81f..d10bd0c 100644
>> --- a/drivers/iio/adc/ad_sigma_delta.c
>> +++ b/drivers/iio/adc/ad_sigma_delta.c
>> @@ -472,7 +472,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
>>           goto error_free_irq;
>>
>>       /* select default trigger */
>> -    indio_dev->trig = sigma_delta->trig;
>> +    indio_dev->trig = iio_trigger_get(sigma_delta->trig);
>>
>>       return 0;
>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
