Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:39113 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194Ab2JSRzW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:55:22 -0400
Message-ID: <5081941A.8050305@metafoo.de>
Date: Fri, 19 Oct 2012 19:55:38 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio: Don't compare boolean values with true/false
References: <1350571399-17723-1-git-send-email-lars@metafoo.de> <508170BE.4060103@kernel.org>
In-Reply-To: <508170BE.4060103@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/2012 05:24 PM, Jonathan Cameron wrote:
> On 10/18/2012 03:43 PM, Lars-Peter Clausen wrote:
>> Fixes the following coccicheck warnings:
>> 	drivers/staging/iio/accel/lis3l02dq_ring.c:240:5-10: WARNING: Comparison to bool
>> 	drivers/staging/iio/iio_dummy_evgen.c:111:6-25: WARNING: Comparison to bool
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Can't say I can summon much enthusiasm for this patch..

Me neither, that's why I did not fix this up for the DAC drivers when I moved
them out of staging. But it turns out that existing coccicheck errors can cause
false positives in Fengguang Wu automated commit test scripts. We've seen a few
of these in the past. So I've to decided to just fix all coccicheck
warnings/error for IIO to avoid further false positives.

> Added to togreg branch.

Thanks.

>> ---
>>  drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
>>  drivers/staging/iio/iio_dummy_evgen.c      |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
>> index fa4190d..ee887e9 100644
>> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
>> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
>> @@ -237,7 +237,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>  	u8 t;
>>  
>>  	__lis3l02dq_write_data_ready_config(indio_dev, state);
>> -	if (state == false) {
>> +	if (!state) {
>>  		/*
>>  		 * A possible quirk with the handler is currently worked around
>>  		 * by ensuring outstanding read events are cleared.
>> diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
>> index 74e24e8..132d278 100644
>> --- a/drivers/staging/iio/iio_dummy_evgen.c
>> +++ b/drivers/staging/iio/iio_dummy_evgen.c
>> @@ -108,7 +108,7 @@ int iio_dummy_evgen_get_irq(void)
>>  
>>  	mutex_lock(&iio_evgen->lock);
>>  	for (i = 0; i < IIO_EVENTGEN_NO; i++)
>> -		if (iio_evgen->inuse[i] == false) {
>> +		if (!iio_evgen->inuse[i]) {
>>  			ret = iio_evgen->base + i;
>>  			iio_evgen->inuse[i] = true;
>>  			break;
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

