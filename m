Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41176 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbIEPBN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 11:01:13 -0400
Subject: Re: [PATCH] Staging: iio: Move evgen interrupt generation to irq_work
To: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
References: <fb09b55f8341c66c575fa0924b560d335b1318e5.1439901090.git.cristina.opriceana@gmail.com>
 <55E4761A.6040503@kernel.org>
 <CAFA9rWNKf4ikqWtXvzO9_Vcst6fPDtUKyFhgzJft90WrAqgWjQ@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	octavian.purdila@intel.com, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Message-ID: <55EB03B4.2090706@kernel.org>
Date: Sat, 5 Sep 2015 16:01:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFA9rWNKf4ikqWtXvzO9_Vcst6fPDtUKyFhgzJft90WrAqgWjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/15 14:51, Cristina Georgiana Opriceana wrote:
> On Mon, Aug 31, 2015 at 6:43 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 18/08/15 13:55, Cristina Opriceana wrote:
>>> A more abstract way of handling interrupt generation in the dummy driver
>>> is represented by irq_work which substitutes the irq_chip, used to
>>> provide an IRQ line number. irq_work runs tasks from hardirq context,
>>> but in a NMI-safe environment and deals better with synchronization
>>> problems. An interrupt can be triggered by calling irq_work_queue()
>>> and the work will be performed by a pre-registered handler, which
>>> acts as a callback.
>>>
>>> Cc: Daniel Baluta <daniel.baluta@intel.com>
>>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
>> Hi Cristina,
>>
>> Sorry for the slow response on this!
>>
>> Anyhow, my main thought here is whether we can take advantage of the irq
>> work approach to allow a true simulation of an irq chip rather than
>> using the nested_irq as in the original.
>>
>> The suggestion in that original email was just to move from the 'naughty'
>> nested_irq call over to irq work, I wasn't suggesting dropping the irq chip.
> Some questions below.
> 
>> The aim of this is to allow the dummy driver to fully support
>> anything that can be done in a normal driver, without it being in anyway
>> modified in form from that of a normal hardware driver.
>>
>> The result of the change here is to move the actual example code
>> futher from a normal driver rather than nearer to it...
> 
> Totally agree on this, it does not reflect the code one would write in
> a normal driver. I designed it to be more like iio-trig-sysfs as I
> thought you suggested and left this aspect behind.
Sorry, I only meant to say use the irq work stuff that was first
seen (by me anyway!) in the iio-trig-sysfs
> 
>> Sorry for the confusion on this,
> I'll redo it, thanks for answering !
> 
> Cristina
> 
>> Jonathan
>>> ---
>>> This is the first draft for the irq_work replacement.
>>> As we want to move the iio dummy driver out of staging,
>>> we started to implement Jonathan's suggestions from here:
>>> <http://marc.info/?l=linux-iio&m=142403390705515&w=2>
>>>
>>>  drivers/staging/iio/iio_dummy_evgen.c         | 171 +++++++++-----------------
>>>  drivers/staging/iio/iio_dummy_evgen.h         |  15 ++-
>>>  drivers/staging/iio/iio_simple_dummy.c        |   6 +-
>>>  drivers/staging/iio/iio_simple_dummy.h        |   8 +-
>>>  drivers/staging/iio/iio_simple_dummy_events.c |  71 ++++-------
>>>  5 files changed, 105 insertions(+), 166 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
>>> index 6d38854..974ef8a 100644
>>> --- a/drivers/staging/iio/iio_dummy_evgen.c
>>> +++ b/drivers/staging/iio/iio_dummy_evgen.c
>>> @@ -25,132 +25,87 @@
>>>  #include <linux/iio/iio.h>
>>>  #include <linux/iio/sysfs.h>
>>>
>>> -/* Fiddly bit of faking and irq without hardware */
>>> -#define IIO_EVENTGEN_NO 10
>>> -/**
>>> - * struct iio_dummy_evgen - evgen state
>>> - * @chip: irq chip we are faking
>>> - * @base: base of irq range
>>> - * @enabled: mask of which irqs are enabled
>>> - * @inuse: mask of which irqs are connected
>>> - * @regs: irq regs we are faking
>>> - * @lock: protect the evgen state
>>> - */
>>> -struct iio_dummy_eventgen {
>>> -     struct irq_chip chip;
>>> -     int base;
>>> -     bool enabled[IIO_EVENTGEN_NO];
>>> -     bool inuse[IIO_EVENTGEN_NO];
>>> -     struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
>>> -     struct mutex lock;
>>> -};
>>> +static LIST_HEAD(iio_dummy_event_list);
>>> +static DEFINE_MUTEX(iio_dummy_event_list_mutex);
>>>
>>> -/* We can only ever have one instance of this 'device' */
>>> -static struct iio_dummy_eventgen *iio_evgen;
>>> -static const char *iio_evgen_name = "iio_dummy_evgen";
>>> -
>>> -static void iio_dummy_event_irqmask(struct irq_data *d)
>>> +struct iio_dummy_event *get_event(int index)
>>>  {
>>> -     struct irq_chip *chip = irq_data_get_irq_chip(d);
>>> -     struct iio_dummy_eventgen *evgen =
>>> -             container_of(chip, struct iio_dummy_eventgen, chip);
>>> +     struct list_head *ptr, *tmp;
>>> +     struct iio_dummy_event *iio_event = NULL;
>>>
>>> -     evgen->enabled[d->irq - evgen->base] = false;
>>> -}
>>> -
>>> -static void iio_dummy_event_irqunmask(struct irq_data *d)
>>> -{
>>> -     struct irq_chip *chip = irq_data_get_irq_chip(d);
>>> -     struct iio_dummy_eventgen *evgen =
>>> -             container_of(chip, struct iio_dummy_eventgen, chip);
>>> -
>>> -     evgen->enabled[d->irq - evgen->base] = true;
>>> +     mutex_lock(&iio_dummy_event_list_mutex);
>>> +     list_for_each_safe(ptr, tmp, &iio_dummy_event_list) {
>>> +             iio_event = list_entry(ptr, struct iio_dummy_event, l);
>>> +             if (iio_event->regs.reg_id == index)
>>> +                     break;
>>> +     }
>>> +     mutex_unlock(&iio_dummy_event_list_mutex);
>>> +     return iio_event;
>>>  }
>>>
>>> -static int iio_dummy_evgen_create(void)
>>> +int iio_dummy_evgen_create(struct iio_dev *indio_dev, int index)
>>>  {
>>> -     int ret, i;
>>> +     struct iio_dummy_event *iio_event;
>>>
>>> -     iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
>>> -     if (!iio_evgen)
>>> +     iio_event = kzalloc(sizeof(*iio_event), GFP_KERNEL);
>>> +     if (!iio_event)
>>>               return -ENOMEM;
>>>
>>> -     iio_evgen->base = irq_alloc_descs(-1, 0, IIO_EVENTGEN_NO, 0);
>>> -     if (iio_evgen->base < 0) {
>>> -             ret = iio_evgen->base;
>>> -             kfree(iio_evgen);
>>> -             return ret;
>>> -     }
>>> -     iio_evgen->chip.name = iio_evgen_name;
>>> -     iio_evgen->chip.irq_mask = &iio_dummy_event_irqmask;
>>> -     iio_evgen->chip.irq_unmask = &iio_dummy_event_irqunmask;
>>> -     for (i = 0; i < IIO_EVENTGEN_NO; i++) {
>>> -             irq_set_chip(iio_evgen->base + i, &iio_evgen->chip);
>>> -             irq_set_handler(iio_evgen->base + i, &handle_simple_irq);
>>> -             irq_modify_status(iio_evgen->base + i,
>>> -                               IRQ_NOREQUEST | IRQ_NOAUTOEN,
>>> -                               IRQ_NOPROBE);
>>> -     }
>>> -     mutex_init(&iio_evgen->lock);
>>> +     iio_event->dev = indio_dev;
>>> +     iio_event->regs.reg_id = index;
>>> +     mutex_lock(&iio_dummy_event_list_mutex);
>>> +     list_add(&iio_event->l, &iio_dummy_event_list);
>>> +     mutex_unlock(&iio_dummy_event_list_mutex);
>>> +
>>>       return 0;
>>>  }
>>> +EXPORT_SYMBOL_GPL(iio_dummy_evgen_create);
>>>
>>> -/**
>>> - * iio_dummy_evgen_get_irq() - get an evgen provided irq for a device
>>> - *
>>> - * This function will give a free allocated irq to a client device.
>>> - * That irq can then be caused to 'fire' by using the associated sysfs file.
>>> - */
>>> -int iio_dummy_evgen_get_irq(void)
>>> +void iio_dummy_init_work_handler(int index, void (*f)(struct irq_work *))
>>>  {
>>> -     int i, ret = 0;
>>> -
>>> -     if (!iio_evgen)
>>> -             return -ENODEV;
>>> +     struct iio_dummy_event *iio_event = get_event(index);
>>>
>>> -     mutex_lock(&iio_evgen->lock);
>>> -     for (i = 0; i < IIO_EVENTGEN_NO; i++)
>>> -             if (!iio_evgen->inuse[i]) {
>>> -                     ret = iio_evgen->base + i;
>>> -                     iio_evgen->inuse[i] = true;
>>> -                     break;
>>> -             }
>>> -     mutex_unlock(&iio_evgen->lock);
>>> -     if (i == IIO_EVENTGEN_NO)
>>> -             return -ENOMEM;
>>> -     return ret;
>>> +     if (iio_event)
>>> +             init_irq_work(&iio_event->work, f);
>>>  }
>>> -EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
>>> +EXPORT_SYMBOL_GPL(iio_dummy_init_work_handler);
>>>
>>> -/**
>>> - * iio_dummy_evgen_release_irq() - give the irq back.
>>> - * @irq: irq being returned to the pool
>>> - *
>>> - * Used by client driver instances to give the irqs back when they disconnect
>>> - */
>>> -void iio_dummy_evgen_release_irq(int irq)
>>> +struct iio_dummy_regs *iio_dummy_evgen_get_regs(int index)
>>>  {
>>> -     mutex_lock(&iio_evgen->lock);
>>> -     iio_evgen->inuse[irq - iio_evgen->base] = false;
>>> -     mutex_unlock(&iio_evgen->lock);
>>> -}
>>> -EXPORT_SYMBOL_GPL(iio_dummy_evgen_release_irq);
>>> +     struct iio_dummy_event *iio_event;
>>> +     struct iio_dummy_regs *regs = NULL;
>>>
>>> -struct iio_dummy_regs *iio_dummy_evgen_get_regs(int irq)
>>> -{
>>> -     return &iio_evgen->regs[irq - iio_evgen->base];
>>> +     iio_event = get_event(index);
>>> +     if (!iio_event)
>>> +             goto err_regs;
>>> +
>>> +     regs = &iio_event->regs;
>>> +err_regs:
>>> +     return regs;
>>>  }
>>>  EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
>>>
>>> -static void iio_dummy_evgen_free(void)
>>> +void iio_dummy_evgen_free(int index)
>>>  {
>>> -     irq_free_descs(iio_evgen->base, IIO_EVENTGEN_NO);
>>> -     kfree(iio_evgen);
>>> +     struct list_head *ptr, *tmp;
>>> +     struct iio_dummy_event *iio_event;
>>> +
>>> +     mutex_lock(&iio_dummy_event_list_mutex);
>>> +     list_for_each_safe(ptr, tmp, &iio_dummy_event_list) {
>>> +             iio_event = list_entry(ptr, struct iio_dummy_event, l);
>>> +             if (iio_event->regs.reg_id == index) {
>>> +                     list_del(ptr);
>>> +                     kfree(iio_event);
>>> +                     break;
>>> +             }
>>> +     }
>>> +     mutex_unlock(&iio_dummy_event_list_mutex);
>>>  }
>>> +EXPORT_SYMBOL_GPL(iio_dummy_evgen_free);
>>>
>>> +/* Do nothing upon release */
>>>  static void iio_evgen_release(struct device *dev)
>>>  {
>>> -     iio_dummy_evgen_free();
>>>  }
>>>
>>>  static ssize_t iio_evgen_poke(struct device *dev,
>>> @@ -159,6 +114,7 @@ static ssize_t iio_evgen_poke(struct device *dev,
>>>                             size_t len)
>>>  {
>>>       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>> +     struct iio_dummy_event *iio_event = get_event(this_attr->address);
>>>       unsigned long event;
>>>       int ret;
>>>
>>> @@ -166,12 +122,11 @@ static ssize_t iio_evgen_poke(struct device *dev,
>>>       if (ret)
>>>               return ret;
>>>
>>> -     iio_evgen->regs[this_attr->address].reg_id   = this_attr->address;
>>> -     iio_evgen->regs[this_attr->address].reg_data = event;
>>> -
>>> -     if (iio_evgen->enabled[this_attr->address])
>>> -             handle_nested_irq(iio_evgen->base + this_attr->address);
> 
> This will be subsituted with a call of irq_work_queue() which triggers
> an interrupt.
cool
> 
>>> -
>>> +     if (iio_event) {
>>> +             iio_event->regs.reg_data = event;
>>> +             /* trigger interrupt */
>>> +             irq_work_queue(&iio_event->work);
>>> +     }
>>>       return len;
>>>  }
>>>
>>> @@ -217,10 +172,6 @@ static struct device iio_evgen_dev = {
>>>
>>>  static __init int iio_dummy_evgen_init(void)
>>>  {
>>> -     int ret = iio_dummy_evgen_create();
>>> -
>>> -     if (ret < 0)
>>> -             return ret;
>>>       device_initialize(&iio_evgen_dev);
>>>       dev_set_name(&iio_evgen_dev, "iio_evgen");
>>>       return device_add(&iio_evgen_dev);
>>> diff --git a/drivers/staging/iio/iio_dummy_evgen.h b/drivers/staging/iio/iio_dummy_evgen.h
>>> index d044b94..b78b1eb 100644
>>> --- a/drivers/staging/iio/iio_dummy_evgen.h
>>> +++ b/drivers/staging/iio/iio_dummy_evgen.h
>>> @@ -1,13 +1,22 @@
>>>  #ifndef _IIO_DUMMY_EVGEN_H_
>>>  #define _IIO_DUMMY_EVGEN_H_
>>> +#include <linux/irq_work.h>
>>>
>>>  struct iio_dummy_regs {
>>>       u32 reg_id;
>>>       u32 reg_data;
>>>  };
>>>
>>> -struct iio_dummy_regs *iio_dummy_evgen_get_regs(int irq);
>>> -int iio_dummy_evgen_get_irq(void);
>>> -void iio_dummy_evgen_release_irq(int irq);
>>> +struct iio_dummy_event {
>>> +     struct iio_dev *dev;
>>> +     struct iio_dummy_regs regs;
>>> +     struct irq_work work;
>>> +     struct list_head l;
>>> +};
>>> +
>>> +int iio_dummy_evgen_create(struct iio_dev *indio_dev, int index);
>>> +void iio_dummy_init_work_handler(int index, void (*f)(struct irq_work *));
>>> +struct iio_dummy_regs *iio_dummy_evgen_get_regs(int index);
>>> +void iio_dummy_evgen_free(int index);
>>>
>>>  #endif /* _IIO_DUMMY_EVGEN_H_ */
>>> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
>>> index 381f90f..1ae082d 100644
>>> --- a/drivers/staging/iio/iio_simple_dummy.c
>>> +++ b/drivers/staging/iio/iio_simple_dummy.c
>>> @@ -635,7 +635,7 @@ static int iio_dummy_probe(int index)
>>>       /* Specify that device provides sysfs type interfaces */
>>>       indio_dev->modes = INDIO_DIRECT_MODE;
>>>
>>> -     ret = iio_simple_dummy_events_register(indio_dev);
>>> +     ret = iio_simple_dummy_events_register(indio_dev, index);
>>>       if (ret < 0)
>>>               goto error_free_device;
>>>
>>> @@ -651,7 +651,7 @@ static int iio_dummy_probe(int index)
>>>  error_unconfigure_buffer:
>>>       iio_simple_dummy_unconfigure_buffer(indio_dev);
>>>  error_unregister_events:
>>> -     iio_simple_dummy_events_unregister(indio_dev);
>>> +     iio_simple_dummy_events_unregister(index);
>>>  error_free_device:
>>>       iio_device_free(indio_dev);
>>>  error_ret:
>>> @@ -682,7 +682,7 @@ static void iio_dummy_remove(int index)
>>>       /* Buffered capture related cleanup */
>>>       iio_simple_dummy_unconfigure_buffer(indio_dev);
>>>
>>> -     iio_simple_dummy_events_unregister(indio_dev);
>>> +     iio_simple_dummy_events_unregister(index);
>>>
>>>       /* Free all structures */
>>>       iio_device_free(indio_dev);
>>> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
>>> index 8d00224..05b84f7 100644
>>> --- a/drivers/staging/iio/iio_simple_dummy.h
>>> +++ b/drivers/staging/iio/iio_simple_dummy.h
>>> @@ -78,19 +78,19 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
>>>                                      enum iio_event_info info, int val,
>>>                                      int val2);
>>>
>>> -int iio_simple_dummy_events_register(struct iio_dev *indio_dev);
>>> -void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev);
>>> +int iio_simple_dummy_events_register(struct iio_dev *indio_dev, int index);
>>> +void iio_simple_dummy_events_unregister(int index);
>>>
>>>  #else /* Stubs for when events are disabled at compile time */
>>>
>>>  static inline int
>>> -iio_simple_dummy_events_register(struct iio_dev *indio_dev)
>>> +iio_simple_dummy_events_register(struct iio_dev *indio_dev, int index)
>>>  {
>>>       return 0;
>>>  };
>>>
>>>  static inline void
>>> -iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
>>> +iio_simple_dummy_events_unregister(int index)
>>>  { };
>>>
>>>  #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
>>> diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
>>> index 73108ba..cf777b1 100644
>>> --- a/drivers/staging/iio/iio_simple_dummy_events.c
>>> +++ b/drivers/staging/iio/iio_simple_dummy_events.c
>>> @@ -155,23 +155,25 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
>>>
>>>  /**
>>>   * iio_simple_dummy_event_handler() - identify and pass on event
>>> - * @irq: irq of event line
>>> - * @private: pointer to device instance state.
>>> + * @work:    struct irq_work which handles interrupt generation
>>>   *
>>>   * This handler is responsible for querying the device to find out what
>>>   * event occurred and for then pushing that event towards userspace.
>>>   * Here only one event occurs so we push that directly on with locally
>>>   * grabbed timestamp.
>>>   */
>>> -static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
>>> +void iio_simple_dummy_event_handler(struct irq_work *work)
>>>  {
>>> -     struct iio_dev *indio_dev = private;
>>> +     struct iio_dummy_event *iio_event = container_of(work,
>>> +                                                     struct iio_dummy_event,
>>> +                                                     work);
>>> +     struct iio_dev *indio_dev = iio_event->dev;
>>>       struct iio_dummy_state *st = iio_priv(indio_dev);
>>>
>>>       dev_dbg(&indio_dev->dev, "id %x event %x\n",
>>> -             st->regs->reg_id, st->regs->reg_data);
>>> +             iio_event->regs.reg_id, iio_event->regs.reg_data);
>>>
>>> -     switch (st->regs->reg_data) {
>>> +     switch (iio_event->regs.reg_data) {
>>>       case 0:
>>>               iio_push_event(indio_dev,
>>>                              IIO_EVENT_CODE(IIO_VOLTAGE, 0, 0,
>>> @@ -209,59 +211,36 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
>>>       default:
>>>               break;
>>>       }
>>> -
>>> -     return IRQ_HANDLED;
>>>  }
>>>
>>>  /**
>>>   * iio_simple_dummy_events_register() - setup interrupt handling for events
>>> - * @indio_dev: device instance data
>>> + * @indio_dev:       device instance data
>>> + * @index:   integer which identifies the dummy instance
>>>   *
>>> - * This function requests the threaded interrupt to handle the events.
>>> - * Normally the irq is a hardware interrupt and the number comes
>>> - * from board configuration files.  Here we get it from a companion
>>> - * module that fakes the interrupt for us. Note that module in
>>> - * no way forms part of this example. Just assume that events magically
>>> - * appear via the provided interrupt.
>>> + * Normally the irq is a hardware interrupt and the number comes from
>>> + * board configuration files. Here, the interrupt generation is handled
>>> + * by a companion module that will generate hardware interrupts using
>>> + * the irq_work API. Note that module in no way forms part of this example.
>>> + * Just assume that events magically appear via the provided interrupt.
>>>   */
>>> -int iio_simple_dummy_events_register(struct iio_dev *indio_dev)
>>> +int iio_simple_dummy_events_register(struct iio_dev *indio_dev, int index)
>>>  {
>>> -     struct iio_dummy_state *st = iio_priv(indio_dev);
>>>       int ret;
>>>
>>> -     /* Fire up event source - normally not present */
>>> -     st->event_irq = iio_dummy_evgen_get_irq();
>>> -     if (st->event_irq < 0) {
>>> -             ret = st->event_irq;
>>> -             goto error_ret;
>>> -     }
>>> -     st->regs = iio_dummy_evgen_get_regs(st->event_irq);
>>> -
>>> -     ret = request_threaded_irq(st->event_irq,
>>> -                                NULL,
>> It's this null that I never liked.  The one thing you 'always'
>> do on an event is grab a timestamp in the top half handler.  With
>> the nested irq handler we could never do that (as not in irq context).
> 
> In my approach, the handler run on the irq_work would be initialized
> here with iio_simple_dummy_event_handler and replace the
> request_threaded_irq() call. Are you suggesting to keep the
> request_threaded_irq() call also?
Yes. Keep the whole apparent interrupt flow.  That way the 'example'
looks just like a normal driver working wiht real interrupts.
> 
>>> -                                &iio_simple_dummy_event_handler,
> 
> Then, what should be run on the irq_work handler? Maybe initialize the
> irq_work with this handler and keep the request_threaded_irq call just
> formal?
The irq work should call handle_simple_irq (I think) instead of
handle_nested_irq.  The upshot is that the top half of the interrupt
is called (from an interrupt context) instead of just the bottom half
(in the threaded interrupt world, the bottom half is now the thread).
If you dig around in kernel/irq/chip.c and kernel/irq/handle.c you can
see how these two functions differ.  Basically the nested one simply
calls the thread function directly whereas the simple version calls
the 'handler' first and depending on result of that may wake up the
thread or not (in this case it always will!).

That makes it look just like a normal hardware interrupt.
I'd then grab and store the timestamp in the top half and then use it in
the thread (as this is how most normal drivers will do it).

Afterall the point of this driver is to provide 'documentation' for
real hardware drivers (with the added benefit of letting us test new
stuff without having to mess around with finding the right bits of
hardware :)

Jonathan
> 
>>> -                                IRQF_ONESHOT,
>>> -                                "iio_simple_event",
>>> -                                indio_dev);
>>> -     if (ret < 0)
>>> -             goto error_free_evgen;
>>> +     ret = iio_dummy_evgen_create(indio_dev, index);
>>> +     if (ret)
>>> +             return ret;
>>> +     /* register handler */
>>> +     iio_dummy_init_work_handler(index, iio_simple_dummy_event_handler);
>>>       return 0;
>>> -
>>> -error_free_evgen:
>>> -     iio_dummy_evgen_release_irq(st->event_irq);
>>> -error_ret:
>>> -     return ret;
>>>  }
>>>
>>>  /**
>>> - * iio_simple_dummy_events_unregister() - tidy up interrupt handling on remove
>>> - * @indio_dev: device instance data
>>> + * iio_simple_dummy_events_unregister()
>>> + * @index:   device instance identification
>>>   */
>>> -void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
>>> +void iio_simple_dummy_events_unregister(int index)
>>>  {
>>> -     struct iio_dummy_state *st = iio_priv(indio_dev);
>>> -
>>> -     free_irq(st->event_irq, indio_dev);
>>> -     /* Not part of normal driver */
>>> -     iio_dummy_evgen_release_irq(st->event_irq);
>>> +      iio_dummy_evgen_free(index);
>>>  }
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

