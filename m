Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:46162 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaHWLvY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Aug 2014 07:51:24 -0400
Received: by mail-ob0-f196.google.com with SMTP id va2so2137692obc.3
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2014 04:51:23 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 23 Aug 2014 17:21:23 +0530
Message-ID: <CAJpWr0np0DjzQwhNWQ7DMXEmMLx5+jeN9qATXuuo3vRV1WMezA@mail.gmail.com>
Subject: seeking help on IIO triggers
From: Preethi Myneni <myneni.preethi@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan and all,

Thanks in advance. My name is Preethi, from India. I am writing an ADC
(6 channels) driver with the help of Linux IIO Subsystem. I am new to
IIO Subsystem and have done enough homework before requesting your
help in understanding my following specific requirement.

I don't have real time clock (RTC) support on my board but I have a
hardware Counter. I am planning to write a generic ADC IIO device
driver with the following approach

Inside my driver probe function, I am planning allocate kfifo buffer
and attach it to my device.

              buffer = iio_kfifo_allocate(indio_dev);
              iio_device_attach_buffer(indio_dev, buffer);

Then configure my on chip counter (timer) with some timeout value and
start the same. I will pass my Couner/Timer IRQ Number to the
following function.

            request_threaded_irq(irq, pollfunc_th, pollfunc_bh,
IRQF_ONESHOT, indio_dev->name, indio_dev);

            indio_dev->modes |=INDIO_BUFFER_TRIGGERED;

            iio_buffer_register(indio_dev, indio_dev->channels,
indio_dev->num_channels);

Once the counter overlaps (timeout occurs, as an example I will
program 1 milli second as timeout value), inside my interrupt thread
(poll function bottom half) I will program my ADC registers to start
Analog to Digital conversion on all 6 channels.
I will poll for End of Conversion (EOC) bit on each of the 6 channels.
Once it is set, I will copy the sampled Output data to Kernel buffer
allocated above.I need to poll for EOC bit because my ADC is not
providing any EOC interrupt.
Inside my counter overlap ISR (poll function bottom half), I am
planning to start Analog to digital conversion (single sample
conversion) on all the 6 channels (one-after-other). After reading
one-output-sample each on all 6 channels, at the bottom of my ISR, I
am planning to reprogram my counter (with 1 milli second timeout
value), enable the counter IRQ and after the timeout (inside my ISR) I
will repeat the conversion sequence.

With this approach I am planning to make sure that I will write only
one generic IIO ADC Device driver. I will not have any second IIO
Device driver which will provide the trigger. Please let me know if
this approach is not violating any principle of IIO Subsystem design.

Please let me know your suggestion on my above approach.

Thanks in advance.

Preethi.
