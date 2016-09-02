Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49642 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbcIBPJA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 11:09:00 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
Subject: iio_push_event() race conditions
To: Jonathan Cameron <jic23@kernel.org>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <0e1e64ac-5c40-6319-1132-e5d7b2478f01@metafoo.de>
Date: Fri, 2 Sep 2016 17:08:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

A common pattern that we see with drivers that implement events is the
following. I did not check all driver, but all those that I checked followed
this pattern.

irqreturn_t event_callback(int irq, void *devid)
{
	struct iio_dev *indio_dev = devid;
	...
	iio_push_event(indio_dev, ...);
	
	return IRQ_HANDLED;
}

int driver_probe(struct device *dev)
{
	struct iio_dev *indio_dev;

	indio_dev = iio_device_alloc(...);

	request_irq(event_irq, event_callback, ..., indio_dev);

	return iio_device_register(indio_dev);
}

Now iio_push_event() accessed indio_dev->event_interface. The
event_interface is only allocated and assigned in iio_device_register()
though. This means there is a window of opportunity where the interrupt is
live and can trigger, but event_interface is still NULL. So we'll hit a NULL
pointer dereference if the IRQ fires before iio_device_register() completes.

I'm a bit conflicted on what is the best way to resolve this. On one hand
the correct approach appears to be to simply delay the requesting of the IRQ
until iio_device_register() has completed. On the other hand it is possible
to argue that users should be able to expect that it is safe to call APIs
that take a struct iio_dev if iio_device_alloc() succeeded.

The later approach also has the advantage that we only need to update
iio_push_event() rather than all drivers that use it. But raises the obvious
question what is the right behavior of iio_push_event() in case the event
interface has not been registered yet? Return an error? What should the
caller do if it encounters an error? Or maybe just silently become a no-op?

- Lars
