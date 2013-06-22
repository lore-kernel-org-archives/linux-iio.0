Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46318 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3FVLtM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2013 07:49:12 -0400
Message-ID: <51C58F34.9010202@kernel.org>
Date: Sat, 22 Jun 2013 12:49:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC] gp2ap002a00f ambient light/proximity sensor
References: <1371470364-14475-1-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1371470364-14475-1-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/17/2013 12:59 PM, Jacek Anaszewski wrote:
> This driver in the current form supports:
>  - reading channels in 'one shot' mode through read_raw callback,
>  - three events - rising and falling ambient light events and 
>    rising proximity event. 
> 
> It has infrastructure for triggers implemented, but either it is
> not implemented properly or I don't know how to initialize it from
> user space.
> 
> What I'd like to achieve through this RFC is (besides regular review)
> gain some clarification on how to properly implemeint support for 
> both events and triggers. At first I'd like to mention that I managed
> to implement support for triggers without events. I did it by following
> implementations of the existing drivers that support triggers,
> but no events. Briefly, they perform following steps to setup
> a trigger:
> 
>  static irqreturn_t gp2ap002a00f_irq_handler(int irq, void *data)
>  {
>  	struct gp2ap002a00f_data *lgt = iio_priv(indio_dev);
>  
>  	// Filling the lgt->buffer with the output data from the 
> 	// device is performed here, according to the
> 	// indio_dev->active_scan_mask bits.
>  
>         iio_push_to_buffers(indio_dev, lgt->buffer);
>         iio_trigger_notify_done(indio_dev->trig);
>  }
THat's a fairly standard handler for the the trigger.  That is the trigger
interrupt handler itself fires off sub interrupts to any devices 'consuming'
it resulting in this function being called.
> 
> 
>  int gp2ap002a00f_trig_set_state(struct iio_trigger *trig, bool state)
>  {
>  	// Here a buffer is allocated/deallocated and the device 
> 	// related operations are performed to enable/disable 
> 	// generating data, according to the
> 	// indio_dev->active_scan_mask bits .
>  }
>  
>  
>  static const struct iio_trigger_ops gp2ap002a00f_trigger_ops = {
>  	.owner = THIS_MODULE,
>  	.set_trigger_state = &gp2ap002a00f_trig_set_state,
>  };
> 
>  iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
>                 gp2ap002a00f_irq_handler, &gp2ap002a00f_setup_ops);
> 
>  iio_trigger_alloc("%s-trigger", indio_dev->name);
> 
>  err = devm_request_threaded_irq(&client->dev, client->irq,
>                             iio_trigger_generic_data_rdy_poll,
This generic hander simply fires off the set of consumer interrupts.

>                             NULL,
>                             IRQF_TRIGGER_FALLING,
>                             data->trig->name,
>                             data->trig);
> 
>  data->trig->private_data = indio_dev;
>  data->trig->ops = &gp2ap002a00f_trigger_ops;
>  data->trig->dev.parent = &data->client->dev
> 
>  ret = iio_trigger_register(data->trig);
> 
> With the implementation shown above I can setup a trigger using
> generic_buffer application.
> 
> Nonetheless, drivers that implement both triggers and events
> are implemented in a somehow different manner (I followed
> recommended max1363 driver):
Note the max1363 does not supply a trigger of it's own.  That part
captures data on demand and has no 'data ready' signal or similar.
The above example of buffering suggests that this device has an internal
clock and fires a dataready interrupt at regular intervals when monitoring?

> 
> static irqreturn_t gp2ap002a00f_event_handler(int irq, void *data)
> {
>         iio_push_event(indio_dev,
>                        IIO_MOD_EVENT_CODE(
>                                 IIO_LIGHT,
>                                 SCAN_MODE_LIGHT_CLEAR,
>                                 IIO_MOD_LIGHT_CLEAR,
>                                 IIO_EV_TYPE_THRESH,
>                                 IIO_EV_DIR_RISING),
>                        iio_get_time_ns());
> 
> }
>
This handles the event interrupts, but does nothing about firing off
a trigger to any consumers.

>  err = iio_triggered_buffer_setup(indio_dev, NULL,
>        &gp2ap002a00f_trigger_handler, &gp2ap002a00f_buffer_setup_ops);
>
Just note that your event handler in the actual driver sleeps so should
the handler should be the 4th parameter with the 3rd null.
Note this causes some complexity for iio as 'normally' the triggers
are initialized from interrupt context.  To that end we play some
tricks.

Right now I can't actually find a driver doing this, I though the lis3l02dq
driver did, but it seems that one won't actually run both events and the
buffer at the same time.

Anyhow to sketch out the solution you want, combine a standard threaded
handler with the trick used in drivers/iio/trigger/iio-trig-sysfs.c in
which and irq_work queue is used to get us back into interrupt context
and fire off the trigger interrupts.

Mostly hardware designers make our lives easy by directing event and
dataready interrupts to different pins!

>  err = devm_request_threaded_irq(&client->dev, client->irq,
>                             &gp2ap002a00f_event_handler,
>                             NULL,
>                             IRQF_TRIGGER_FALLING,
>                             "gp2ap002a00f_event",
>                             indio_dev);
> 
> Enabling/disabling data generation seems to be handled by
> buffer_setup_ops' preenable/postenable/predisable callbacks.
> I've noticed also that there is update_scan_mode callback exploited
> in some of the implementations, which I suspect serves for updating
> scan_mode without the need for disabling a trigger?
No. To change a scan mask you must disconnect from the trigger.  If there
are other consumers this means the trigger will briefly stop whilst
this one is disconnected then resume for any other consumers.

> 
> With this implementation the trigger/current_trigger file is empty
> and generic_buffer application fails. Therefore I ask for
> clarification on what I am doing wrong here.
You aren't actually registering a trigger as far as I can see?

> 
> Regarding the remaining parts of the driver - I used flags, not bit
> fields as Jonathan requested in my driver for the lps331ap device
> because of the need for one flag for wait_event_timeout function.
> This flag is set in the interrupt handler and access to it must
> be atomic. I could have gone for bit fields for the rest of the
> flags in the driver, but I think that now the implementation
> is more consistent.
> 
> I've also noticed that once initialized triggers keep some
> IIO resources unreleased as execution of rmmod on the driver module
> fails even after triggered capture finish. Is it a known issue?
I have not observed this, perhaps you have not succesfully disconnected
the consumer from the trigger? (e.g. if current_trigger is not empty
it will not succeed).  There is a probable double free bug in the
trigger unregistering that we are chasing down a the moment in another
thread.

Jonathan
> 
> Thanks,
> Jacek Anaszewski
> 
> Jacek Anaszewski (1):
>   iio: gp2ap002a00f: Add a driver for the device.
> 
>  .../devicetree/bindings/iio/light/gp2ap002a00f.txt |   20 +
>  drivers/iio/light/Kconfig                          |   12 +
>  drivers/iio/light/Makefile                         |    1 +
>  drivers/iio/light/gp2ap002a00f.c                   | 1158 ++++++++++++++++++++
>  4 files changed, 1191 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap002a00f.txt
>  create mode 100644 drivers/iio/light/gp2ap002a00f.c
> 
