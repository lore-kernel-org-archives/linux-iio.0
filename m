Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44190 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3GTJTS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Jul 2013 05:19:18 -0400
Message-ID: <51EA5613.1080003@kernel.org>
Date: Sat, 20 Jul 2013 10:19:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio:trigger: Fix use_count race condition
References: <1373984921-24578-1-git-send-email-lars@metafoo.de> <4243054.pVIl63CpR1@ctocwl0124>
In-Reply-To: <4243054.pVIl63CpR1@ctocwl0124>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2013 04:34 PM, Denis CIOCCA wrote:
> Hi Lars,
> 
> works fine!
> Tested-by: Denis Ciocca <denis.ciocca@st.com>
> 
> Denis
> 
> On Tuesday, July 16, 2013 04:28:41 PM Lars-Peter Clausen wrote:
>> When using more than one trigger consumer it can happen that multiple
>> threads perform a read-modify-update cycle on 'use_count' concurrently.
>> This can cause updates to be lost and use_count can get stuck at non-zero
>> value, in which case the IIO core assumes that at least one thread is still
>> running and will wait for it to finish before running any trigger handlers
>> again. This effectively renders the trigger disabled and a reboot is
>> necessary before it can be used again. To fix this make use_count an atomic
>> variable. Also set it to the number of consumers before starting the first
>> consumer, otherwise it might happen that use_count drops to 0 even though
>> not all consumers have been run yet.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Nice clean solution. Thanks.

Applied to the fixes-togreg branch of iio.git.

>> ---
>> Changes since v1:
>> 	* Set use_count to CONFIG_IIO_CONSUMERS_PER_TRIGGER and call
>> 	  iio_trigger_notify_done for all subirqs that are not enabled to avoid a
>> 	  race which could be triggered if the irq was enabled or disabled while
>> 	  iio_trigger_poll() is running.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/iio/industrialio-trigger.c | 34 ++++++++++++++++++++++------------
>>  include/linux/iio/trigger.h        |  3 ++-
>>  2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-trigger.c
>> b/drivers/iio/industrialio-trigger.c index 4d6c7d8..47769ae 100644
>> --- a/drivers/iio/industrialio-trigger.c
>> +++ b/drivers/iio/industrialio-trigger.c
>> @@ -127,12 +127,17 @@ static struct iio_trigger
>> *iio_trigger_find_by_name(const char *name, void iio_trigger_poll(struct
>> iio_trigger *trig, s64 time)
>>  {
>>  	int i;
>> -	if (!trig->use_count)
>> -		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
>> -			if (trig->subirqs[i].enabled) {
>> -				trig->use_count++;
>> +
>> +	if (!atomic_read(&trig->use_count)) {
>> +		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>> +
>> +		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>> +			if (trig->subirqs[i].enabled)
>>  				generic_handle_irq(trig->subirq_base + i);
>> -			}
>> +			else
>> +				iio_trigger_notify_done(trig);
>> +		}
>> +	}
>>  }
>>  EXPORT_SYMBOL(iio_trigger_poll);
>>
>> @@ -146,19 +151,24 @@ EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
>>  void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time)
>>  {
>>  	int i;
>> -	if (!trig->use_count)
>> -		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
>> -			if (trig->subirqs[i].enabled) {
>> -				trig->use_count++;
>> +
>> +	if (!atomic_read(&trig->use_count)) {
>> +		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>> +
>> +		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>> +			if (trig->subirqs[i].enabled)
>>  				handle_nested_irq(trig->subirq_base + i);
>> -			}
>> +			else
>> +				iio_trigger_notify_done(trig);
>> +		}
>> +	}
>>  }
>>  EXPORT_SYMBOL(iio_trigger_poll_chained);
>>
>>  void iio_trigger_notify_done(struct iio_trigger *trig)
>>  {
>> -	trig->use_count--;
>> -	if (trig->use_count == 0 && trig->ops && trig->ops->try_reenable)
>> +	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
>> +		trig->ops->try_reenable)
>>  		if (trig->ops->try_reenable(trig))
>>  			/* Missed an interrupt so launch new poll now */
>>  			iio_trigger_poll(trig, 0);
>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>> index 3869c52..369cf2c 100644
>> --- a/include/linux/iio/trigger.h
>> +++ b/include/linux/iio/trigger.h
>> @@ -8,6 +8,7 @@
>>   */
>>  #include <linux/irq.h>
>>  #include <linux/module.h>
>> +#include <linux/atomic.h>
>>
>>  #ifndef _IIO_TRIGGER_H_
>>  #define _IIO_TRIGGER_H_
>> @@ -61,7 +62,7 @@ struct iio_trigger {
>>
>>  	struct list_head		list;
>>  	struct list_head		alloc_list;
>> -	int use_count;
>> +	atomic_t			use_count;
>>
>>  	struct irq_chip			subirq_chip;
>>  	int				subirq_base;--
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
