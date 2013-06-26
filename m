Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34644 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab3FZOzE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 26 Jun 2013 10:55:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1Urr7f-0007TE-1R
	for linux-iio@vger.kernel.org; Wed, 26 Jun 2013 16:55:03 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2013 16:55:03 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2013 16:55:03 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH/RFC] gp2ap002a00f ambient light/proximity sensor
Date: Wed, 26 Jun 2013 16:54:50 +0200
Message-ID: <51CB00BA.9090903@samsung.com>
References: <1371470364-14475-1-git-send-email-j.anaszewski@samsung.com> <51C58F34.9010202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: s.nawrocki@samsung.com
In-Reply-To: <51C58F34.9010202@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/22/2013 01:49 PM, Jonathan Cameron wrote:
[...]
>> With the implementation shown above I can setup a trigger using
>> generic_buffer application.
>>
>> Nonetheless, drivers that implement both triggers and events
>> are implemented in a somehow different manner (I followed
>> recommended max1363 driver):
> Note the max1363 does not supply a trigger of it's own.  That part
> captures data on demand and has no 'data ready' signal or similar.
> The above example of buffering suggests that this device has an internal
> clock and fires a dataready interrupt at regular intervals when monitoring?

Yes.

>>
>> static irqreturn_t gp2ap002a00f_event_handler(int irq, void *data)
>> {
>>          iio_push_event(indio_dev,
>>                         IIO_MOD_EVENT_CODE(
>>                                  IIO_LIGHT,
>>                                  SCAN_MODE_LIGHT_CLEAR,
>>                                  IIO_MOD_LIGHT_CLEAR,
>>                                  IIO_EV_TYPE_THRESH,
>>                                  IIO_EV_DIR_RISING),
>>                         iio_get_time_ns());
>>
>> }
>>
> This handles the event interrupts, but does nothing about firing off
> a trigger to any consumers.
>
>>   err = iio_triggered_buffer_setup(indio_dev, NULL,
>>         &gp2ap002a00f_trigger_handler,&gp2ap002a00f_buffer_setup_ops);
>>
> Just note that your event handler in the actual driver sleeps so should
> the handler should be the 4th parameter with the 3rd null.
> Note this causes some complexity for iio as 'normally' the triggers
> are initialized from interrupt context.  To that end we play some
> tricks.
>
> Right now I can't actually find a driver doing this, I though the lis3l02dq
> driver did, but it seems that one won't actually run both events and the
> buffer at the same time.
>
> Anyhow to sketch out the solution you want, combine a standard threaded
> handler with the trick used in drivers/iio/trigger/iio-trig-sysfs.c in
> which and irq_work queue is used to get us back into interrupt context
> and fire off the trigger interrupts.

I've applied this solution in the second version of the patch.
It works, but I am getting a warning message.

WARNING: at kernel/irq/handle.c:146handle_irq_event_percpu+0x2a4/0x2b4()
irq 8 handler iio_pollfunc_store_time+0x0/0x38 enabled interrupts

on a call to iio_trigger_poll from my event irq handler. I suppose it 
isn't acceptable?

> Mostly hardware designers make our lives easy by directing event and
> dataready interrupts to different pins!

Unfortunately this is not the case :/

>>   err = devm_request_threaded_irq(&client->dev, client->irq,
>>                              &gp2ap002a00f_event_handler,
>>                              NULL,
>>                              IRQF_TRIGGER_FALLING,
>>                              "gp2ap002a00f_event",
>>                              indio_dev);
>>
>> Enabling/disabling data generation seems to be handled by
>> buffer_setup_ops' preenable/postenable/predisable callbacks.
>> I've noticed also that there is update_scan_mode callback exploited
>> in some of the implementations, which I suspect serves for updating
>> scan_mode without the need for disabling a trigger?
> No. To change a scan mask you must disconnect from the trigger.  If there
> are other consumers this means the trigger will briefly stop whilst
> this one is disconnected then resume for any other consumers.

So what does update_scan_mode callback offer what can't be accomplished
in a buffer_preenable callback?

I need to make enabling ambient light related triggers impossible
if proximity detection event is enabled. Is there a mechanism I can
exploit for this? Currently I am returning -EBUSY from buffer_preenable
callback but it doesn't have direct effect for the user, besides
kernel log "Buffer not started:buffer parameter update failed".
generic_buffer application starts without complaints, it just
doesn't display any data.

>>
>> With this implementation the trigger/current_trigger file is empty
>> and generic_buffer application fails. Therefore I ask for
>> clarification on what I am doing wrong here.
> You aren't actually registering a trigger as far as I can see?

Thank you for your explanation. Now triggers work, but with
reservations as above.

>>
>> Regarding the remaining parts of the driver - I used flags, not bit
>> fields as Jonathan requested in my driver for the lps331ap device
>> because of the need for one flag for wait_event_timeout function.
>> This flag is set in the interrupt handler and access to it must
>> be atomic. I could have gone for bit fields for the rest of the
>> flags in the driver, but I think that now the implementation
>> is more consistent.
>>
>> I've also noticed that once initialized triggers keep some
>> IIO resources unreleased as execution of rmmod on the driver module
>> fails even after triggered capture finish. Is it a known issue?
> I have not observed this, perhaps you have not succesfully disconnected
> the consumer from the trigger? (e.g. if current_trigger is not empty
> it will not succeed).  There is a probable double free bug in the
> trigger unregistering that we are chasing down a the moment in another
> thread.

I observed this also for lps331ap driver.
iio_triggered_buffer_cleanup is called in the gp2ap020a00f_remove
and it has no chance to be executed as this function is never called
on rmmod due to "module in use" issue.

Thanks,
Jacek

