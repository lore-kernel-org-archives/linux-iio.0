Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43269 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1LMNeF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2011 08:34:05 -0500
Message-ID: <4EE7543F.4060003@free-electrons.com>
Date: Tue, 13 Dec 2011 14:33:51 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 6/6] AT91: IIO: Add support for hardware triggers for
 the ADC
References: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com> <1323282340-24475-7-git-send-email-maxime.ripard@free-electrons.com> <4EE3799E.8030307@kernel.org> <4EE607E6.8020401@free-electrons.com> <4EE67229.2060007@kernel.org>
In-Reply-To: <4EE67229.2060007@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 12/12/2011 22:29, Jonathan Cameron wrote:
>>>> +static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>>>> +{
>>>> +	struct iio_poll_func *pf = p;
>>>> +	struct iio_dev *idev = pf->indio_dev;
>>>> +	struct at91_adc_state *st = iio_priv(idev);
>>>> +	struct iio_buffer *buffer = idev->buffer;
>>>> +	int len = 0;
>>>> +
>>> This doesn't look like stuff that should be in the fast patch.
>>> Could you cache the register to be read in the update_scan_mask
>>> callback then just run over them here?  Feels like that might
>>> be cleaner and lead to reads occuring faster.
>>
>> Hmm, I don't see any update_scan_mask callback neither in the code nor
>> in the patches sent to the ml, am I missing something ?
> sorry, update_scan_mode...  Went in with a patch called
> 
>     staging:iio: add hook to allow core to perform scan related config.
> 
> I think that merged a couple of days back..

Oh, right.

>>
>>>> +	if (!bitmap_empty(idev->active_scan_mask, idev->masklength)) {
>>>> +		int i, j;
>>>> +		for (i = 0, j = 0;
>>>> +		     i < bitmap_weight(idev->active_scan_mask,
>>>> +				       idev->masklength);
>>>> +		     i++) {
>>>> +			j = find_next_bit(buffer->scan_mask,
>>>> +					  idev->masklength,
>>>> +					  j);
>>>> +			st->buffer[i] = at91_adc_reg_read(st, AT91_ADC_CHR(j));
>>>> +			j++;
>>>> +			len += 2;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (buffer->scan_timestamp) {
>>>> +		s64 *timestamp = (s64 *)((u8 *)st->buffer + ALIGN(len,
>>>> +								  sizeof(s64)));
>>>> +		*timestamp = pf->timestamp;
>>>> +	}
>>>> +
>>>> +	buffer_store_to(buffer, (u8 *)st->buffer, pf->timestamp);
>>>> +
>>>> +	iio_trigger_notify_done(idev->trig);
>>>> +	st->irq_enabled = true;
>>>> +
>>>> +	/* Needed to ACK the DRDY interruption */
>>>> +	at91_adc_reg_read(st, AT91_ADC_LCDR);
>>> Still unsure why not threaded_irq and IRQF_ONESHOT.
>>
>> Oops, forgot to change it, sorry.
>>
>>> + I'd prefer to see that ack in try_reenable callback.
>>> Also, if we need to ack, then why do we need to disable
>>> the irq at all?  Surely it won't reoccur until we have
>>> acked?
>>
>> If we don't ACK the interrupt, it will be replayed again and again.
> Level interrupt?  May be some issues as it will occur prior to ack then...

Well, since the interrupt is disabled, I don't really see why it would
occur before the ACK.

>> Moreover, if we don't disable the interrupt, as we have no guarantee
>> about when the reading will actually occur, won't this screw things up
>> if the triggers keeps firing and we never enter in the handler that
>> store data in the buffer ?
> The irqf_oneshot stuff handles this fine.  Means only one instance is
> running at a time (done by masking the interrupt). Also ensures you
> don't miss any.

I don't really get how this would work with threaded irqs, except with a
major rework of the handlers.

Obviously, you want the DRDY handler to be the thread here. So the
interrupts will be disabled until the end of the at91_adc_eoc_trigger
handler, which in turn generates an interrupt for the poll functions.

But here, the interrupts will keep coming as we have not yet ACKd
anything, the interrupt being level triggered (because reads are in the
bottom half of the poll function).

So the solution here might be to run iio_trigger_poll_chained instead,
as we would run the iio thread function in the same context, with
disabled interrupts. But as iio_trigger_poll_chained is calling directly
the iio thread function, we would lose the call to
iio_pollfunc_store_time (which is our hard IRQ handler).

So a solution would be to:
1) Get the timestamp in the hard IRQ handler for the ADC interrupt, the
closest to the end of conversion IRQ
2) Move at91_adc_eoc_trigger to the threaded IRQ handler for the ADC
interrupt
3) In the latter handler, call iio_trigger_poll_chained, so that the
thread function of pollfunc is run with the ADC IRQ line disabled.

>>>> +
>>>> +	enable_irq(st->irq);
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>>  static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>>>>  {
>>>>  	struct iio_dev *idev = private;
>>>> @@ -92,13 +184,16 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>>>>  	if (!(status & AT91_ADC_DRDY))
>>>>  		return IRQ_HANDLED;
>>>>  
>>>> -	if (status & st->channels_mask) {
>>>> -		st->done = true;
>>>> +	if (iio_buffer_enabled(idev)) {
>>>> +		disable_irq_nosync(irq);
>>>> +		st->irq_enabled = false;
>>>> +		iio_trigger_poll(idev->trig, iio_get_time_ns());
>>>> +	} else {
>>>>  		st->last_value = at91_adc_reg_read(st, AT91_ADC_LCDR);
>>>> +		st->done = true;
>>>> +		wake_up_interruptible(&st->wq_data_avail);
>>>>  	}
>>>>  
>>>> -	wake_up_interruptible(&st->wq_data_avail);
>>>> -
>>>>  	return IRQ_HANDLED;
>>>>  }
>>>>  
>>>> @@ -110,8 +205,9 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>>>>  	int bit, idx = 0;
>>>>  
>>>>  	idev->num_channels = bitmap_weight(&pdata->channels_used,
>>>> -					   st->desc->num_channels);
>>>> -	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
>>>> +					   st->desc->num_channels) + 1;
>>>> +	chan_array = kcalloc(idev->num_channels + 1,
>>>> +			     sizeof(struct iio_chan_spec),
>>>>  			     GFP_KERNEL);
>>> Cosmetic change that should not be in this patch...
>>
>> Well, the number of allocated channels has been incremented by 1 for the
>> timestamp in the process, and while the diff makes it look that way, I
>> don't see any cosmetic change here.
> Ooops, missed that change in there. Sorry!
>>
>>>>  
>>>>  	if (chan_array == NULL)
>>>> @@ -122,6 +218,7 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>>>>  		chan->type = IIO_VOLTAGE;
>>>>  		chan->indexed = 1;
>>>>  		chan->channel = bit;
>>>> +		chan->scan_index = idx;
>>>>  		chan->scan_type.sign = 'u';
>>>>  		chan->scan_type.realbits = 10;
>>>>  		chan->scan_type.storagebits = 16;
>>>> @@ -129,6 +226,13 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>>>>  		idx++;
>>>>  	}
>>>>  
>>>> +	(chan_array + idx)->type = IIO_TIMESTAMP;
>>>> +	(chan_array + idx)->channel = -1;
>>>> +	(chan_array + idx)->scan_index = idx;
>>>> +	(chan_array + idx)->scan_type.sign = 's';
>>>> +	(chan_array + idx)->scan_type.realbits = 64;
>>>> +	(chan_array + idx)->scan_type.storagebits = 64;
>>>> +
>>>>  	idev->channels = chan_array;
>>>>  	return idev->num_channels;
>>>>  }
>>>> @@ -138,6 +242,152 @@ static void at91_adc_channel_remove(struct iio_dev *idev)
>>>>  	kfree(idev->channels);
>>>>  }
>>>>  
>>>> +static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>>>> +{
>>>> +	struct iio_dev *idev = trig->private_data;
>>>> +	struct at91_adc_state *st = iio_priv(idev);
>>>> +	struct iio_buffer *buffer = idev->buffer;
>>>> +	u32 status = at91_adc_reg_read(st, AT91_ADC_MR);
>>>> +	u8 bit;
>>>> +
>>>> +	if (state) {
>>>> +		size_t datasize = buffer_get_bytes_per_datum(buffer);
>>>> +		int i;
>>>> +
>>>> +		st->buffer = kmalloc(datasize, GFP_KERNEL);
>>>> +		if (st->buffer == NULL)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (i = 0; (st->desc->triggers + i) != NULL; i++) {
>>> I kind of feels here like we ought to be able to do better than matching
>>> by name.  After all, both ends of this match are controlled by this driver.
>>> Perhaps embed the iio_trigger structure in a device specific one and
>>> store some sort of reference in that?  Just feels a little odd as it
>>> currently stands...
>>
>> I agree on having a better dispatch mechanism, but maybe we could just
>> add a integer ID in the iio_trigger structure directly instead of
>> relying on some "heavy" structure manipulation. Of course, this ID would
>> have to be set in stone by the driver, juste like the channel part in
>> iio_chan_spec.
> Maybe...  I'd prefer a containing structure for now just because I don't
> have a feel for how common. In other cases where we have a single
> driver with multiple triggers (the userspace one, rtc etc) we handle
> this by having the private pointer point at the trigger rather than a
> containing structure.  I can see why you haven't done this here though...
> 
>>
>>>> +			char *name = kasprintf(GFP_KERNEL,
>>>> +					       "%s-dev%d-%s",
>>>> +					       idev->name,
>>>> +					       idev->id,
>>>> +					       st->desc->triggers[i].name);
>>>> +			if (name == NULL)
>>>> +				return -ENOMEM;
>>>> +
>>>> +			if (strcmp(idev->trig->name, name) == 0) {
>>>> +				status |= st->desc->triggers[i].value;
>>>> +				kfree(name);
>>>> +				break;
>>>> +			}
>>>> +
>>>> +			kfree(name);
>>>> +		}
>>>> +
>>>> +		if ((st->desc->triggers + i) == NULL)
>>>> +			return -EINVAL;
>>>> +
>>>> +		at91_adc_reg_write(st, AT91_ADC_MR, status);
>>>> +
>>>> +		for_each_set_bit(bit, buffer->scan_mask,
>>>> +				 st->desc->num_channels) {
>>>> +			struct iio_chan_spec const *chan = idev->channels + bit;
>>>> +			at91_adc_reg_write(st, AT91_ADC_CHER,
>>>> +					   AT91_ADC_CH(chan->channel));
>>>> +		}
>>>> +
>>>> +		at91_adc_reg_write(st, AT91_ADC_IER, AT91_ADC_DRDY);
>>>> +
>>>> +	} else {
>>>> +		at91_adc_reg_write(st, AT91_ADC_IDR, AT91_ADC_DRDY);
>>>> +		at91_adc_reg_write(st, AT91_ADC_MR,
>>>> +				   status & ~AT91_ADC_TRGEN);
>>>> +
>>>> +		for_each_set_bit(bit, buffer->scan_mask,
>>>> +				 st->desc->num_channels) {
>>>> +			at91_adc_reg_write(st, AT91_ADC_CHDR,
>>>> +					   AT91_ADC_CH(bit));
>>> Why do we need to look up the channel to turn it on, and not
>>> to turn it off?  Looks suspicious!
>>
>> Oh, right.
>>
>>> beware that things may well go wrong when we introduce multiple
>>> buffers.  I'm not sure that the scan configuration (which is
>>> what is actually happening here) should be in the trigger
>>> enable disable at all.  Is this just to get us back to a
>>> consistent state when not in triggered mode or is it
>>> needed to stop triggers occuring?
>>
>> Both actually. It sets us back into a state were we can safely either
>> use software triggers or setup a new capture. If we remove the setup of
>> the channels from here and put it into some callback, I'm quite certain
>> we will reach some corner cases when we come back from triggered mode,
>> with channels still enabled in IIO (and presumably in the hardware too)
>> and read into in_voltageX_raw...
> Then you make the in_voltageX_raw call do the channel setup rather than
> the other way around.  Lots of drivers doing precisely that...
> That way no corner cases matter as we sanity check that the setup is
> correct for whatever we want to do.  Tends to lead to simpler code as
> well overall.

But still, let's say I enable the ADC channels in the update_scan_mode
callback. If we setup a triggered capture, with, for example channels 1
and 3 enabled. After a while, we stop the capture, and perform a
software trigger on channel 3. The read_raw function enables the channel
(which is already enabled), wait for the conversion, and then disables
the channel. From the ADC point of view, only the channel 1 would be
enabled, while from the IIO point of view, channels 1 and 3 would be
enabled. This is the kind of corner case I was talking about.


Maxime
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
