Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40457 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab3G3V2K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2013 17:28:10 -0400
Message-ID: <51F83DFE.6010107@kernel.org>
Date: Tue, 30 Jul 2013 23:28:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lo <dm81xx@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: continuous  mode driver for spi device with interrupt
References: <51F81A1D.7000003@gmail.com>
In-Reply-To: <51F81A1D.7000003@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 20:55, Lo wrote:
> Hello,
> 
> using the iio driver framework I wrote a driver for an eight channel ADC, connected via SPI and a interrupt line.
> In polling mode (reading /sys/bus/iio/..../in_voltageX_raw) everything works fine, but this access is obviously not way
> I'd want to use to read lots of data.
> Looking at other drivers (in staging/ kernel v3.2) I think the most appropriate way is to use the provided sw ring
> buffer ring_sw.c
> I'm not sure if my ring setup is correct, can someone please comment on this?
> 
> My _probe function does the basic setup, inits a waitqueue and requests the irq line (a gpio):
> iio->buffer = iio_sw_rb_allocate(iio);
> iio->buffer->access = &ring_sw_access_funcs;
> iio->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
>     &my_poll_handler,
>     IRQF_ONESHOT, //<-not sure about this flag
>     iio,
>     "my_consumer%d",//<-where is this for?
Naming for the interrupt.  Basically this is a variable number of arguements
function so you can roll in creating the naming string with this call
(in this case the iio->id is the only additional arguement afte the formatting.
>     iio->id);
> iio->buffer->setup_ops = &my_ring_setup_ops;
> iio->modes |= INDIO_BUFFER_TRIGGERED;//<-correct mode?
yes
> 
> Where my access funcs are:
>     .preenable = &my_buffer_preenable,
>     .postenable = &iio_triggered_buffer_postenable,
>     .predisable = &iio_triggered_buffer_predisable,
>     .postdisable = &my_buffer_postdisable
> where:
> preenable just sets iio->buffer->access->set_bytes_per_datum(iio->buffer, 19);

The kfifo always contains aligned data. Hence it will be padded to the largest
sized element.  The only way it would correctly be 19 would be to have 19 8 bit
or lower channels.  Seems unlikely.  Also why doesn't the generic
function work for your case?

> and enables the irq
> postenable disables the irq
> 
> My irq handler does basically this:
>     disable_irq_nosync(irq);
Don't think you should need this if using the ONESHOT flag as it should be
masked until handled. It's late here though so I might be completly wrong :)

>     iio_trigger_poll(adc->trig, iio_get_time_ns());
>     return IRQ_HANDLED;
> 
> My poll handler does this:
>     ring->access->store_to(ring, (u8 *)data, pf->timestamp);
>     iio_trigger_notify_done(iio->trig);
>     enable_irq(adc->spi->irq);
>     return IRQ_HANDLED;
Looks fine.
> 
> Is the approach of using the sw ring and the interrupt & poll_func more or less correct?
> I've read ring.txt but still I get most of my kernel panics somewhere in ring of buffer management, so I must be doing
> something wrong there.
> Is any (simple) driver recommended as reference? I see different approaches in different drivers and I can't test them.
Take a look at the dummy driver (still in drivers/staging/iio) as that can be tested
without any hardware. (iio_simple_dummy
> 
> --Lo
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
