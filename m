Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37288 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbaGTMVm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 08:21:42 -0400
Message-ID: <53CBB4E2.1050007@kernel.org>
Date: Sun, 20 Jul 2014 13:24:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: accel: kxcjk-1013: Increment ref counter for
 indio_dev->trig
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1405557754-19601-6-git-send-email-srinivas.pandruvada@linux.intel.com> <53CBA830.3020306@metafoo.de>
In-Reply-To: <53CBA830.3020306@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/14 12:29, Lars-Peter Clausen wrote:
> On 07/17/2014 02:42 AM, Srinivas Pandruvada wrote:
>> Assigning indio_dev->trig is not a good idea, as this can result in
>> wrong reference count for trigger device. If assigned, it is better to
>> increment reference counter by calling iio_trigger_get.
>> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
>> with Jonathan.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>   drivers/iio/accel/kxcjk-1013.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index f5bb682..40ecf8b 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -1020,6 +1020,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>>           iio_trigger_set_drvdata(trig, indio_dev);
>>           data->trig = trig;
>>           indio_dev->trig = trig;
>> +        iio_trigger_get(indio_dev->trig);
>
> Hm, we should change the signature of iio_trigger_get() to return the
> trigger, this gets it more in sync with other ..._get() APIs in the
> kernel. Then the above two lines become indio_dev->trig =
> iio_trigger_get(trig).
Would make sense, but can occur after these fixes (more invasive) and these
ought to go in as fixes and stable etc.

J

