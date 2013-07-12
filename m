Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58652 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533Ab3GLT43 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2013 15:56:29 -0400
Message-ID: <51E05F67.1050301@kernel.org>
Date: Fri, 12 Jul 2013 20:56:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:trigger: Fix use_count race condition
References: <1370974731-11878-1-git-send-email-lars@metafoo.de> <51B78371.1090908@kernel.org> <51B788E3.70008@metafoo.de> <51B78DA3.4000101@kernel.org>
In-Reply-To: <51B78DA3.4000101@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2013 09:50 PM, Jonathan Cameron wrote:
> On 06/11/2013 09:30 PM, Lars-Peter Clausen wrote:
>> On 06/11/2013 10:07 PM, Jonathan Cameron wrote:
>>> On 06/11/2013 07:18 PM, Lars-Peter Clausen wrote:
>>>> When using more than one trigger consumer it can happen that multiple threads
>>>> perform a read-modify-update cycle on 'use_count' concurrently. This can cause
>>>> updates to be lost and use_count can get stuck at non-zero value, in which case
>>>> the IIO core assumes that at least one thread is still running and will wait for
>>>> it to finish before running any trigger handlers again. This effectively renders
>>>> the trigger disabled and a reboot is necessary before it can be used again. To
>>>> fix this make use_count an atomic variable. Also set it to the number of
>>>> consumers before starting the first consumer, otherwise it might happen that
>>>> use_count drops to 0 even though not all consumers have been run yet.
>>>>
>>> I am a little worried there is a different race in here. Can't immediateliy get
>>> my head around whether it can actually occur. It would require a subirq thread
>>> to finish handling the interrupt during either trigger_poll or trigger_poll_chained.
>>>
>>> I can't immediately see what prevents this happening..
>>>
>>> One nasty option might be to ensure that we only launch num_consumers interrupts
>>> on without caring whether they are the ones we originally counted or not.
>>>
>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> ---
>>>>  drivers/iio/industrialio-trigger.c | 44 +++++++++++++++++++++++++++-----------
>>>>  include/linux/iio/trigger.h        |  3 ++-
>>>>  2 files changed, 33 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
>>>> index 4d6c7d8..a02ca65 100644
>>>> --- a/drivers/iio/industrialio-trigger.c
>>>> +++ b/drivers/iio/industrialio-trigger.c
>>>> @@ -126,13 +126,22 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
>>>>  
>>>>  void iio_trigger_poll(struct iio_trigger *trig, s64 time)
>>>>  {
>>>> +	unsigned int num_consumers;
>>>>  	int i;
>>>> -	if (!trig->use_count)
>>>> -		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
>>>> -			if (trig->subirqs[i].enabled) {
>>>> -				trig->use_count++;
>>>> +
>>>> +	if (!atomic_read(&trig->use_count)) {
>>>> +		num_consumers = 0;
>>>> +		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>>>> +			if (trig->subirqs[i].enabled)
>>>> +				num_consumers++;
>>>> +		}
>>>> +		atomic_set(&trig->use_count, num_consumers);
>>>> +
>>> Is there any chance the state of subirqs[i].enabled might have changed since
>>> it was queried above?
>>
>> hm, right.
>>
>>>
>>>> +		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>>>> +			if (trig->subirqs[i].enabled)
>>> how about,
>>>
>>> if (trig->subirqs[i].enabled && num_consumers--)
>>> as that would prevent the case of launching too many irq handlers.
>>
>> That wouldn't fix the case where the subirq was enabled. use_count would end
>> up with a positive value.
> Can't say I follow that given I can't see a way we'd end up with fewer enabled
> sub irqs on the second pass than the first.  Thus it would be fine as we would
> fire use_count subirqs, each of which would then decrement use_count.
> 
>> We can make a copy of enabled and use it for both
>> loops. Or use a spinlock protecting the triggers subirqs.
> 
> I suspect a spin lock is going to be the cleanest solution.
Lars, have you had any time to look at this?

I'm not sure when I'll get a chance unfortunately, busy weekend.

> 
>>
>>>
>>>>  				generic_handle_irq(trig->subirq_base + i);
>>>> -			}
>>>> +		}
>>>> +	}
>>>>  }
>>>>  EXPORT_SYMBOL(iio_trigger_poll);
>>>>  
>>>> @@ -145,20 +154,29 @@ EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
>>>>  
>>>>  void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time)
>>>>  {
>>>> +	unsigned int num_consumers;
>>>>  	int i;
>>>> -	if (!trig->use_count)
>>>> -		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
>>>> -			if (trig->subirqs[i].enabled) {
>>>> -				trig->use_count++;
>>>> -				handle_nested_irq(trig->subirq_base + i);
>>>> -			}
>>>> +
>>>> +	if (!atomic_read(&trig->use_count)) {
>>>> +		num_consumers = 0;
>>>> +		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>>>> +			if (trig->subirqs[i].enabled)
>>>> +				num_consumers++;
>>>> +		}
>>>> +		atomic_set(&trig->use_count, num_consumers);
>>>> +
>>>> +		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>>>> +			if (trig->subirqs[i].enabled)
>>>> +				generic_handle_irq(trig->subirq_base + i);
>>>> +		}
>>>> +	}
>>>>  }
>>>>  EXPORT_SYMBOL(iio_trigger_poll_chained);
>>>>  
>>>>  void iio_trigger_notify_done(struct iio_trigger *trig)
>>>>  {
>>>> -	trig->use_count--;
>>>> -	if (trig->use_count == 0 && trig->ops && trig->ops->try_reenable)
>>>> +	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
>>>> +		trig->ops->try_reenable)
>>>>  		if (trig->ops->try_reenable(trig))
>>>>  			/* Missed an interrupt so launch new poll now */
>>>>  			iio_trigger_poll(trig, 0);
>>>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>>>> index 3869c52..369cf2c 100644
>>>> --- a/include/linux/iio/trigger.h
>>>> +++ b/include/linux/iio/trigger.h
>>>> @@ -8,6 +8,7 @@
>>>>   */
>>>>  #include <linux/irq.h>
>>>>  #include <linux/module.h>
>>>> +#include <linux/atomic.h>
>>>>  
>>>>  #ifndef _IIO_TRIGGER_H_
>>>>  #define _IIO_TRIGGER_H_
>>>> @@ -61,7 +62,7 @@ struct iio_trigger {
>>>>  
>>>>  	struct list_head		list;
>>>>  	struct list_head		alloc_list;
>>>> -	int use_count;
>>>> +	atomic_t			use_count;
>>>>  
>>>>  	struct irq_chip			subirq_chip;
>>>>  	int				subirq_base;
>>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
