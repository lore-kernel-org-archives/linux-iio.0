Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46835 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbaHYUvB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 16:51:01 -0400
Message-ID: <53FBA1B2.50701@kernel.org>
Date: Mon, 25 Aug 2014 21:50:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 8/8] iio: meter: ade7758: Fix indio_dev->trig assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-9-git-send-email-srinivas.pandruvada@linux.intel.com> <53F83C03.50202@metafoo.de>
In-Reply-To: <53F83C03.50202@metafoo.de>
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
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git

Whole series marked for stable.  I debated whether this mades sense, but
concluded that it did given the nasty effect of the double free this
prevents.

Thanks,

J
> 
> Thanks.
> 
>> ---
>>   drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
>> index ea01b8f..6f45ce0 100644
>> --- a/drivers/staging/iio/meter/ade7758_trigger.c
>> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
>> @@ -85,7 +85,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>>       ret = iio_trigger_register(st->trig);
>>
>>       /* select default trigger */
>> -    indio_dev->trig = st->trig;
>> +    indio_dev->trig = iio_trigger_get(st->trig);
>>       if (ret)
>>           goto error_free_irq;
>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
