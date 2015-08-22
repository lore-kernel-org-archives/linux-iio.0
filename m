Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36854 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbbHVNwR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 09:52:17 -0400
Subject: Re: [PATCH v3 5/7] iio: Support triggered events
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1438174648-19296-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <55D055C9.4020409@kernel.org> <55D0EF57.5050304@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D87E8C.4030108@kernel.org>
Date: Sat, 22 Aug 2015 14:52:12 +0100
MIME-Version: 1.0
In-Reply-To: <55D0EF57.5050304@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/15 21:15, Vladimir Barinov wrote:
> Hi Jonathan,
> 
> Thank you for review.
> Find some comments below.
> 
> Regards,
> Vladimir
> 
> On 16.08.2015 12:20, Jonathan Cameron wrote:
>> On 29/07/15 13:57, Vladimir Barinov wrote:
>>> Support triggered events.
>>>
>>> This is useful for chips that don't have their own interrupt sources.
>>> It allows to use generic/standalone iio triggers for those drivers.
>> As we have concluded this is a good thing to have, I've take a closer
>> look at it.
>>
>> I think we need to slightly separate the buffer and event uses of
>> triggers as it's entirely plausible both might be enabled at the same
>> time.  Don't think this should be hard however.
>>
>> I can concieve of weird restrictions from certain hardware (particularly
>> where hardware buffers are concerned) in which events are not monitored
>> when we are reading through the buffer but we can tackle that when we
>> actually need to.
>>
>> Anyhow, few bits inline.  Thanks for your persistence with this!
>>
>> Jonathan
>>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> ---
>>> Changes in version 2:
>>> - initially added
>>> Changes in version 3:
>>> - fixed grammar in patch description
>>> - changed license header to match "GNU Public License v2 or later"
>>>
>>>   drivers/iio/Kconfig                        |  6 +++
>>>   drivers/iio/Makefile                       |  1 +
>>>   drivers/iio/industrialio-core.c            |  4 +-
>>>   drivers/iio/industrialio-trigger.c         | 12 +++++-
>>>   drivers/iio/industrialio-triggered-event.c | 68 ++++++++++++++++++++++++++++++
>>>   include/linux/iio/iio.h                    |  1 +
>>>   include/linux/iio/triggered_event.h        | 11 +++++
>>>   7 files changed, 99 insertions(+), 4 deletions(-)
>>>   create mode 100644 drivers/iio/industrialio-triggered-event.c
>>>   create mode 100644 include/linux/iio/triggered_event.h
>>>
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>> index 4011eff..8fcc92f 100644
>>> --- a/drivers/iio/Kconfig
>>> +++ b/drivers/iio/Kconfig
>>> @@ -58,6 +58,12 @@ config IIO_CONSUMERS_PER_TRIGGER
>>>       This value controls the maximum number of consumers that a
>>>       given trigger may handle. Default is 2.
>>>   +config IIO_TRIGGERED_EVENT
>>> +    tristate
>>> +    select IIO_TRIGGER
>>> +    help
>>> +      Provides helper functions for setting up triggered events.
>>> +
>>>   source "drivers/iio/accel/Kconfig"
>>>   source "drivers/iio/adc/Kconfig"
>>>   source "drivers/iio/amplifiers/Kconfig"
>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>> index 698afc2..40dc13e 100644
>>> --- a/drivers/iio/Makefile
>>> +++ b/drivers/iio/Makefile
>>> @@ -9,6 +9,7 @@ industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>>   industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>>>     obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>>> +obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
>>>   obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>>>     obj-y += accel/
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>> index 3524b0d..54d71ea 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -948,7 +948,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>>>   static void iio_dev_release(struct device *device)
>>>   {
>>>       struct iio_dev *indio_dev = dev_to_iio_dev(device);
>>> -    if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
>>> +    if (indio_dev->modes & (INDIO_BUFFER_TRIGGERED | INDIO_EVENT_TRIGGERED))
>>>           iio_device_unregister_trigger_consumer(indio_dev);
>>>       iio_device_unregister_eventset(indio_dev);
>>>       iio_device_unregister_sysfs(indio_dev);
>>> @@ -1218,7 +1218,7 @@ int iio_device_register(struct iio_dev *indio_dev)
>>>               "Failed to register event set\n");
>>>           goto error_free_sysfs;
>>>       }
>>> -    if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
>>> +    if (indio_dev->modes & (INDIO_BUFFER_TRIGGERED | INDIO_EVENT_TRIGGERED))
>>>           iio_device_register_trigger_consumer(indio_dev);
>>>         if ((indio_dev->modes & INDIO_ALL_BUFFER_MODES) &&
>>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
>>> index d31098e..72b63e7 100644
>>> --- a/drivers/iio/industrialio-trigger.c
>>> +++ b/drivers/iio/industrialio-trigger.c
>>> @@ -345,10 +345,18 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>>>         indio_dev->trig = trig;
>>>   -    if (oldtrig)
>>> +    if (oldtrig) {
>>> +        if (indio_dev->currentmode == INDIO_EVENT_TRIGGERED)
>>> +            iio_trigger_detach_poll_func(oldtrig,
>>> +                             indio_dev->pollfunc);
>>>           iio_trigger_put(oldtrig);
>>> -    if (indio_dev->trig)
>>> +    }
>>> +    if (indio_dev->trig) {
>>>           iio_trigger_get(indio_dev->trig);
>>> +        if (indio_dev->currentmode == INDIO_EVENT_TRIGGERED)
>>> +            iio_trigger_attach_poll_func(indio_dev->trig,
>>> +                             indio_dev->pollfunc);
>>> +    }
>>>         return len;
>>>   }
>>> diff --git a/drivers/iio/industrialio-triggered-event.c b/drivers/iio/industrialio-triggered-event.c
>>> new file mode 100644
>>> index 0000000..1e5ad33
>>> --- /dev/null
>>> +++ b/drivers/iio/industrialio-triggered-event.c
>>> @@ -0,0 +1,68 @@
>>> + /*
>>> + * Copyright (C) 2015 Cogent Embedded, Inc.
>>> + *
>>> + * This program is free software; you can redistribute  it and/or modify it
>>> + * under  the terms of  the GNU General  Public License as published by the
>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>> + * option) any later version.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/export.h>
>>> +#include <linux/module.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/triggered_event.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +
>>> +/**
>>> + * iio_triggered_event_setup() - Setup pollfunc for triggered event
>>> + * @indio_dev:        IIO device structure
>>> + * @pollfunc_bh:    Function which will be used as pollfunc bottom half
>>> + * @pollfunc_th:    Function which will be used as pollfunc top half
>>> + *
>>> + * This function combines some common tasks which will normally be performed
>>> + * when setting up a triggered event. It will allocate the pollfunc and
>>> + * set mode to use it for triggered event.
>>> + *
>>> + * Before calling this function the indio_dev structure should already be
>>> + * completely initialized, but not yet registered. In practice this means that
>>> + * this function should be called right before iio_device_register().
>>> + *
>>> + * To free the resources allocated by this function call
>>> + * iio_triggered_event_cleanup().
>>> + */
>>> +int iio_triggered_event_setup(struct iio_dev *indio_dev,
>>> +    irqreturn_t (*pollfunc_bh)(int irq, void *p),
>>> +    irqreturn_t (*pollfunc_th)(int irq, void *p))
>>> +{
>>> +    indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
>>> +                         pollfunc_th,
>>> +                         IRQF_ONESHOT,
>>> +                         indio_dev,
>>> +                         "%s_consumer%d",
>>> +                         indio_dev->name,
>>> +                         indio_dev->id);
>>> +    if (indio_dev->pollfunc == NULL)
>>> +        return -ENOMEM;
>>> +
>>> +    /* Flag that pollfunc is used for triggered event */
>>> +    indio_dev->modes |= INDIO_EVENT_TRIGGERED;
>>> +    indio_dev->currentmode = INDIO_EVENT_TRIGGERED;
>> Can conceive of a corner case here.  What if both buffer
>> and event are being triggered?  No real problem with
>> running them off the same trigger, but right now enabling
>> one will take out the other.
> To avoid conflict it should be separate pollfunc
> (indio_dev->pollfunc_event = ...) since we do runtime pollfunc
> attach/detach for both buffer and event interfaces.
Agreed.
> 
>>
>> Might also want to not enable triggered event mode
>> until we enable some events?
> I think it will need to change most drivers that use event interface since
> events are enabled inside them via write_event_config() callback or
> events may have already been enabled during driver probe.
Pretty much no devices come up with events enabled (might be a really
stupid one or two out there where there is no control over it other
than masking the interrupt).

Hmm.  True enough, the core has little knowledge of whether events are
enabled or not.  I guess attaching the poll function when it doesn't
do anything (no events enabled) is pretty low cost anyway so lets
leave it as it is.
> 
>>
>> Perhaps we need separate indio_dev->event_mode and
> event_modes ?
> This probably not necessary since iio stack checks for flags set in
> indio_dev->modes value.
>> indio_dev->current_event_mode fields to make the two
>> configurable independently?
> I think it works, but with separate indio_dev->pollfunc_event.
> 
> Should it be inidio_dev->current_event_mode or inidio_dev->currentmode_event for
> consistency?
Which ever looks best to you.
> 
> I will verify your idea with using one trigger for both event and buffer interface on hi8435 driver
> by adding buffer interface that I will try internally (will not send).
>
cool
>>
>> I get the feeling this particular feature is going to evolve
>> somewhat as we get a feel for how it is being used.
>>
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL(iio_triggered_event_setup);
>>> +
>>> +/**
>>> + * iio_triggered_event_cleanup() - Free resources allocated by iio_triggered_event_setup()
>>> + * @indio_dev: IIO device structure
>>> + */
>>> +void iio_triggered_event_cleanup(struct iio_dev *indio_dev)
>>> +{
>>> +    iio_dealloc_pollfunc(indio_dev->pollfunc);
>>> +}
>>> +EXPORT_SYMBOL(iio_triggered_event_cleanup);
>>> +
>>> +MODULE_AUTHOR("Vladimir Barinov");
>>> +MODULE_DESCRIPTION("IIO helper functions for setting up triggered events");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index f791482..b691ee0 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -294,6 +294,7 @@ static inline s64 iio_get_time_ns(void)
>>>   #define INDIO_BUFFER_TRIGGERED        0x02
>>>   #define INDIO_BUFFER_SOFTWARE        0x04
>>>   #define INDIO_BUFFER_HARDWARE        0x08
>>> +#define INDIO_EVENT_TRIGGERED        0x10
>>>     #define INDIO_ALL_BUFFER_MODES                    \
>>>       (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE)
>>> diff --git a/include/linux/iio/triggered_event.h b/include/linux/iio/triggered_event.h
>>> new file mode 100644
>>> index 0000000..e9894e9
>>> --- /dev/null
>>> +++ b/include/linux/iio/triggered_event.h
>>> @@ -0,0 +1,11 @@
>>> +#ifndef _LINUX_IIO_TRIGGERED_EVENT_H_
>>> +#define _LINUX_IIO_TRIGGERED_EVENT_H_
>>> +
>>> +#include <linux/interrupt.h>
>>> +
>>> +int iio_triggered_event_setup(struct iio_dev *indio_dev,
>>> +    irqreturn_t (*pollfunc_bh)(int irq, void *p),
>>> +    irqreturn_t (*pollfunc_th)(int irq, void *p));
>> We renamed the parameters of the equivalent buffer function recently
>> to avoid some confusion.  Could you follow that for this one as well.
> Ok
> 
>>
>>> +void iio_triggered_event_cleanup(struct iio_dev *indio_dev);
>>> +
>>> +#endif
>>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

