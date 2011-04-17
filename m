Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DAB3460.4080006@cam.ac.uk>
Date: Sun, 17 Apr 2011 19:41:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: michael.hennerich@analog.com,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 05/12] staging:iio:adis16400 replace unnecessary event
 line registration.
References: <1302702187-953-1-git-send-email-jic23@cam.ac.uk> <1302702187-953-6-git-send-email-jic23@cam.ac.uk> <4DA5AB5F.2060000@analog.com> <4DA5B708.5090404@cam.ac.uk>
In-Reply-To: <4DA5B708.5090404@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Michael,

Did my reply answer your question such that you don't mind me sending
these (well rebased version anyway) on to Greg?

I'm really not liking my 100 patch queue :(
> ...
>>>  	iio_device_unregister(indio_dev);
>>> diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
>>> index 36b5ff5..afa5e74 100644
>>> --- a/drivers/staging/iio/imu/adis16400_trigger.c
>>> +++ b/drivers/staging/iio/imu/adis16400_trigger.c
>>> @@ -15,21 +15,13 @@
>>>  /**
>>>   * adis16400_data_rdy_trig_poll() the event handler for the data rdy trig
>>>   **/
>>> -static int adis16400_data_rdy_trig_poll(struct iio_dev *dev_info,
>>> -				       int index,
>>> -				       s64 timestamp,
>>> -				       int no_test)
>>> +static irqreturn_t adis16400_data_rdy_trig_poll(int irq, void *private)
>>>  {
>>> -	struct adis16400_state *st = iio_dev_get_devdata(dev_info);
>>> -	struct iio_trigger *trig = st->trig;
>>> -
>>> -	iio_trigger_poll(trig, timestamp);
>>> -
>>> +	disable_irq_nosync(irq);
>>> +	iio_trigger_poll(private, iio_get_time_ns());
>>>   
>> Is it save to call  iio_trigger_poll() from the Top Half Hard-IRQ?
>> Instead of disable/enable irq shouldn't this be better a threaded_irq
>> with IRQF_ONESHOT?
> Yes. Actually after conversion to irq chips this is precisely what you
> want to do.  If you call it as threaded_irq with oneshot enabled,
> then the triggered devices can't have top halves.  That only really
> matters if you either want a timestamp or you want to flip a gpio
> to trigger the actual sampling.  Note we can't do top halves at all
> for software triggers. How to handle this is a corner I haven't cleaned
> up yet.
> 
> When we switch over to that approach you don't disable this irq at all.
> Rather you have the trigger_consumer as a threaded_irq with
> IRQF_ONESHOT set.  That serializes reads from the device and writing
> to the buffer implementation.  It's this serialization that motivates
> the disabling of irq's here.
> 
> Having said that, the reason it is like this here, is that it
> replicates what was previously happening.  Without the hardware
> I don't want to mess with it too much + most of this code is
> going to go away shortly anyway!
> 
> To illustrate, take a look at accel/lis3l02dq (bit of a weird case)
> or imu/adis16400 (untested right now) in 
> http://git.kernel.org/?p=linux/kernel/git/jic23/iio-onwards.git
> in a few mins (just pushed).
> 
> Ripping out the relevant bits...
> 
> from adis16400_trigger.c
> 
> static irqreturn_t adis16400_data_rdy_trig_poll(int irq, void *private)
> {
> 	iio_trigger_poll(private, iio_get_time_ns());
> 	return IRQ_HANDLED;
> }
> 
> int adis16400_probe_trigger(struct iio_dev *indio_dev)
> {
> ...
> 	ret = request_irq(st->us->irq,
> 			  adis16400_data_rdy_trig_poll,
> 			  IRQF_TRIGGER_RISING,
> 			  "adis16400",
> 			  st->trig);
> ...
> }
> 
> from adis16400_ring.c
> 
> static irqreturn_t adis16400_trigger_handler(int irq, void *p)
> {
> 	struct iio_poll_func *pf = p;
> 	struct iio_dev *indio_dev = pf->private_data;
> 	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
> 
> ... do stuff...
> 
> 	iio_trigger_notify_done(st->indio_dev->trig);
> ... clean up ...
> 	return IRQ_HANDLED;
> }
> 
> int adis16400_configure_ring(struct iio_dev *indio_dev)
> {
> ...
> 	indio_dev->pollfunc->private_data = indio_dev;
> 	indio_dev->pollfunc->h = &iio_pollfunc_store_time;
> 	indio_dev->pollfunc->thread = &adis16400_trigger_handler;
> 	indio_dev->pollfunc->type = IRQF_ONESHOT;
> 	indio_dev->pollfunc->name =
> 		kasprintf(GFP_KERNEL, "adis16400_consumer%d", indio_dev->id);
> 
> ...
> }
> 
> Sometimes some fiddling is needed in the reenable for the interrupt to make sure
> we don't get stuck with it high (for interrupts that don't clear unless a read
> occurs - see lis3l02dq).
> 
>>  
>>>  	return IRQ_HANDLED;
>>>  }
>>>  
>>> -IIO_EVENT_SH(data_rdy_trig, &adis16400_data_rdy_trig_poll);
>>> -
>>>  static IIO_TRIGGER_NAME_ATTR;
>>>  
>>>  static struct attribute *adis16400_trigger_attrs[] = {
>>> @@ -49,22 +41,9 @@ static int adis16400_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>>  {
>>>  	struct adis16400_state *st = trig->private_data;
>>>  	struct iio_dev *indio_dev = st->indio_dev;
>>> -	int ret = 0;
>>>  
>>>  	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>>> -	ret = adis16400_set_irq(&st->indio_dev->dev, state);
>>> -	if (state == false) {
>>> -		iio_remove_event_from_list(&iio_event_data_rdy_trig,
>>> -					   &indio_dev->interrupts[0]
>>> -					   ->ev_list);
>>> -		/* possible quirk with handler currently worked around
>>> -		   by ensuring the work queue is empty */
>>> -		flush_scheduled_work();
>>> -	} else {
>>> -		iio_add_event_to_list(&iio_event_data_rdy_trig,
>>> -				      &indio_dev->interrupts[0]->ev_list);
>>> -	}
>>> -	return ret;
>>> +	return adis16400_set_irq(&st->indio_dev->dev, state);
>>>  }
>>>  
>>>  /**
>>> @@ -85,12 +64,23 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
>>>  	struct adis16400_state *st = indio_dev->dev_data;
>>>  
>>>  	st->trig = iio_allocate_trigger();
>>> +	if (st->trig == NULL) {
>>> +		ret = -ENOMEM;
>>> +		goto error_ret;
>>> +	}
>>> +	ret = request_irq(st->us->irq,
>>> +			  adis16400_data_rdy_trig_poll,
>>> +			  IRQF_TRIGGER_RISING,
>>> +			  "adis16400",
>>> +			  st->trig);
>>>   
>>
>> threaded_irq with IRQF_ONESHOT?
>>
>>> +	if (ret)
>>> +		goto error_free_trig;
>>>  	st->trig->name = kasprintf(GFP_KERNEL,
>>>  				   "adis16400-dev%d",
>>>  				   indio_dev->id);
>>>  	if (!st->trig->name) {
>>>  		ret = -ENOMEM;
>>> -		goto error_free_trig;
>>> +		goto error_free_irq;
>>>  	}
>>>  	st->trig->dev.parent = &st->us->dev;
>>>  	st->trig->owner = THIS_MODULE;
>>> @@ -109,9 +99,11 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
>>>  
>>>  error_free_trig_name:
>>>  	kfree(st->trig->name);
>>> +error_free_irq:
>>> +	free_irq(st->us->irq, st->trig);
>>>  error_free_trig:
>>>  	iio_free_trigger(st->trig);
>>> -
>>> +error_ret:
>>>  	return ret;
>>>  }
>>>  
>>> @@ -121,5 +113,6 @@ void adis16400_remove_trigger(struct iio_dev *indio_dev)
>>>  
>>>  	iio_trigger_unregister(state->trig);
>>>  	kfree(state->trig->name);
>>> +	free_irq(state->us->irq, state->trig);
>>>  	iio_free_trigger(state->trig);
>>>  }
>>>   
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
