Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbDHHVs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 8 Apr 2015 03:21:48 -0400
Message-ID: <5524D708.7080101@nod.at>
Date: Wed, 08 Apr 2015 09:21:44 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>,
	Jonathan Cameron <jic23@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] timekeeping: Provide new API to get the current
 time resolution
References: <1428405156-6761-1-git-send-email-harald@ccbib.org> <1428405156-6761-2-git-send-email-harald@ccbib.org> <55245A9A.5070606@nod.at>
In-Reply-To: <55245A9A.5070606@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 08.04.2015 um 00:30 schrieb Richard Weinberger:
> Am 07.04.2015 um 13:12 schrieb Harald Geyer:
>> This patch series introduces a new function
>> u32 ktime_get_resolution_ns(void)
>> which allows to clean up some driver code.
>>
>> In particular the IIO subsystem has a function to provide timestamps for
>> events but no means to get their resolution. So currently the dht11 driver
>> tries to guess the resolution in a rather messy and convoluted way. We
>> can do much better with the new code.
>>
>> This API is not designed to be exposed to user space.
>>
>> This has been tested on i386, sunxi and mxs.
>>
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>> ---
>> changes since V1:
>> Improved commit message.
>>
>>  include/linux/timekeeping.h |    1 +
>>  kernel/time/timekeeping.c   |   17 +++++++++++++++++
>>  2 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
>> index 3eaae47..983b61e 100644
>> --- a/include/linux/timekeeping.h
>> +++ b/include/linux/timekeeping.h
>> @@ -163,6 +163,7 @@ extern ktime_t ktime_get(void);
>>  extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
>>  extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
>>  extern ktime_t ktime_get_raw(void);
>> +extern u32 ktime_get_resolution_ns(void);
>>  
>>  /**
>>   * ktime_get_real - get the real (wall-) time in ktime_t format
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 91db941..8efd964 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -586,6 +586,23 @@ ktime_t ktime_get(void)
>>  }
>>  EXPORT_SYMBOL_GPL(ktime_get);
>>  
>> +u32 ktime_get_resolution_ns(void)
>> +{
>> +	struct timekeeper *tk = &tk_core.timekeeper;
>> +	unsigned int seq;
>> +	u32 nsecs;
>> +
>> +	WARN_ON(timekeeping_suspended);
>> +
>> +	do {
>> +		seq = read_seqcount_begin(&tk_core.seq);
>> +		nsecs = tk->tkr.mult >> tk->tkr.shift;
>> +	} while (read_seqcount_retry(&tk_core.seq, seq));
>> +
>> +	return nsecs;
>> +}
>> +EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
> 
> Hmm, isn't this ktime_get_raw_ns()?

Whoops, it is of course not the same.

Thanks,
//richard
