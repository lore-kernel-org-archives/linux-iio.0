Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55842 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab3G3TzR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2013 15:55:17 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj13so2577978wib.5
        for <linux-iio@vger.kernel.org>; Tue, 30 Jul 2013 12:55:16 -0700 (PDT)
Received: from [192.168.2.129] ([91.178.17.172])
        by mx.google.com with ESMTPSA id j20sm30729247wie.7.2013.07.30.12.55.15
        for <linux-iio@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 12:55:15 -0700 (PDT)
Message-ID: <51F81A1D.7000003@gmail.com>
Date: Tue, 30 Jul 2013 21:55:09 +0200
From: Lo <dm81xx@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: continuous  mode driver for spi device with interrupt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

using the iio driver framework I wrote a driver for an eight channel 
ADC, connected via SPI and a interrupt line.
In polling mode (reading /sys/bus/iio/..../in_voltageX_raw) everything 
works fine, but this access is obviously not way I'd want to use to read 
lots of data.
Looking at other drivers (in staging/ kernel v3.2) I think the most 
appropriate way is to use the provided sw ring buffer ring_sw.c
I'm not sure if my ring setup is correct, can someone please comment on 
this?

My _probe function does the basic setup, inits a waitqueue and requests 
the irq line (a gpio):
iio->buffer = iio_sw_rb_allocate(iio);
iio->buffer->access = &ring_sw_access_funcs;
iio->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
	&my_poll_handler,
	IRQF_ONESHOT, //<-not sure about this flag
	iio,
	"my_consumer%d",//<-where is this for?
	iio->id);
iio->buffer->setup_ops = &my_ring_setup_ops;
iio->modes |= INDIO_BUFFER_TRIGGERED;//<-correct mode?

Where my access funcs are:
	.preenable = &my_buffer_preenable,
	.postenable = &iio_triggered_buffer_postenable,
	.predisable = &iio_triggered_buffer_predisable,
	.postdisable = &my_buffer_postdisable
where:
preenable just sets 
iio->buffer->access->set_bytes_per_datum(iio->buffer, 19);
and enables the irq
postenable disables the irq

My irq handler does basically this:
	disable_irq_nosync(irq);
	iio_trigger_poll(adc->trig, iio_get_time_ns());
	return IRQ_HANDLED;

My poll handler does this:
	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
	iio_trigger_notify_done(iio->trig);
	enable_irq(adc->spi->irq);
	return IRQ_HANDLED;

Is the approach of using the sw ring and the interrupt & poll_func more 
or less correct?
I've read ring.txt but still I get most of my kernel panics somewhere in 
ring of buffer management, so I must be doing something wrong there.
Is any (simple) driver recommended as reference? I see different 
approaches in different drivers and I can't test them.

--Lo
