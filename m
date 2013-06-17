Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46233 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab3FQL7k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2013 07:59:40 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOJ00LYFDB2FAT0@mailout2.samsung.com> for
 linux-iio@vger.kernel.org; Mon, 17 Jun 2013 20:59:39 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: s.nawrocki@samsung.com, Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC] gp2ap002a00f ambient light/proximity sensor
Date: Mon, 17 Jun 2013 13:59:23 +0200
Message-id: <1371470364-14475-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver in the current form supports:
 - reading channels in 'one shot' mode through read_raw callback,
 - three events - rising and falling ambient light events and 
   rising proximity event. 

It has infrastructure for triggers implemented, but either it is
not implemented properly or I don't know how to initialize it from
user space.

What I'd like to achieve through this RFC is (besides regular review)
gain some clarification on how to properly implemeint support for 
both events and triggers. At first I'd like to mention that I managed
to implement support for triggers without events. I did it by following
implementations of the existing drivers that support triggers,
but no events. Briefly, they perform following steps to setup
a trigger:

 static irqreturn_t gp2ap002a00f_irq_handler(int irq, void *data)
 {
 	struct gp2ap002a00f_data *lgt = iio_priv(indio_dev);
 
 	// Filling the lgt->buffer with the output data from the 
	// device is performed here, according to the
	// indio_dev->active_scan_mask bits.
 
        iio_push_to_buffers(indio_dev, lgt->buffer);
        iio_trigger_notify_done(indio_dev->trig);
 }


 int gp2ap002a00f_trig_set_state(struct iio_trigger *trig, bool state)
 {
 	// Here a buffer is allocated/deallocated and the device 
	// related operations are performed to enable/disable 
	// generating data, according to the
	// indio_dev->active_scan_mask bits .
 }
 
 
 static const struct iio_trigger_ops gp2ap002a00f_trigger_ops = {
 	.owner = THIS_MODULE,
 	.set_trigger_state = &gp2ap002a00f_trig_set_state,
 };

 iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
                gp2ap002a00f_irq_handler, &gp2ap002a00f_setup_ops);

 iio_trigger_alloc("%s-trigger", indio_dev->name);

 err = devm_request_threaded_irq(&client->dev, client->irq,
                            iio_trigger_generic_data_rdy_poll,
                            NULL,
                            IRQF_TRIGGER_FALLING,
                            data->trig->name,
                            data->trig);

 data->trig->private_data = indio_dev;
 data->trig->ops = &gp2ap002a00f_trigger_ops;
 data->trig->dev.parent = &data->client->dev

 ret = iio_trigger_register(data->trig);

With the implementation shown above I can setup a trigger using
generic_buffer application.

Nonetheless, drivers that implement both triggers and events
are implemented in a somehow different manner (I followed
recommended max1363 driver):

static irqreturn_t gp2ap002a00f_event_handler(int irq, void *data)
{
        iio_push_event(indio_dev,
                       IIO_MOD_EVENT_CODE(
                                IIO_LIGHT,
                                SCAN_MODE_LIGHT_CLEAR,
                                IIO_MOD_LIGHT_CLEAR,
                                IIO_EV_TYPE_THRESH,
                                IIO_EV_DIR_RISING),
                       iio_get_time_ns());

}

 err = iio_triggered_buffer_setup(indio_dev, NULL,
       &gp2ap002a00f_trigger_handler, &gp2ap002a00f_buffer_setup_ops);

 err = devm_request_threaded_irq(&client->dev, client->irq,
                            &gp2ap002a00f_event_handler,
                            NULL,
                            IRQF_TRIGGER_FALLING,
                            "gp2ap002a00f_event",
                            indio_dev);

Enabling/disabling data generation seems to be handled by
buffer_setup_ops' preenable/postenable/predisable callbacks.
I've noticed also that there is update_scan_mode callback exploited
in some of the implementations, which I suspect serves for updating
scan_mode without the need for disabling a trigger?

With this implementation the trigger/current_trigger file is empty
and generic_buffer application fails. Therefore I ask for
clarification on what I am doing wrong here.

Regarding the remaining parts of the driver - I used flags, not bit
fields as Jonathan requested in my driver for the lps331ap device
because of the need for one flag for wait_event_timeout function.
This flag is set in the interrupt handler and access to it must
be atomic. I could have gone for bit fields for the rest of the
flags in the driver, but I think that now the implementation
is more consistent.

I've also noticed that once initialized triggers keep some
IIO resources unreleased as execution of rmmod on the driver module
fails even after triggered capture finish. Is it a known issue?

Thanks,
Jacek Anaszewski

Jacek Anaszewski (1):
  iio: gp2ap002a00f: Add a driver for the device.

 .../devicetree/bindings/iio/light/gp2ap002a00f.txt |   20 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/gp2ap002a00f.c                   | 1158 ++++++++++++++++++++
 4 files changed, 1191 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap002a00f.txt
 create mode 100644 drivers/iio/light/gp2ap002a00f.c

-- 
1.7.5.4

