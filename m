Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:52665 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964845Ab2I1Xo0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Sep 2012 19:44:26 -0400
Date: Sat, 29 Sep 2012 01:44:24 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
cc: maxime.ripard@free-electrons.com
Subject: Re: WARNING: at kernel/irq/handle.c, irq_default_primary_handler
 enabled interrupts
In-Reply-To: <alpine.DEB.2.01.1209280806040.15718@pmeerw.net>
Message-ID: <alpine.DEB.2.01.1209290134230.8022@pmeerw.net>
References: <alpine.DEB.2.01.1209280806040.15718@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello myself :),

> si114x_irq() checks the irq status of the chip by reading and checking 
> some register via i2c and then depending on the buffer being enabled or 
> not
> 
> 	if (iio_buffer_enabled(indio_dev))
>         	iio_trigger_poll(indio_dev->trig, 0);
>         else {
> 		data->got_data = true;
> 		wake_up_interruptible(&data->data_avail);
> 	}

it should be iio_trigger_poll_chained(), not iio_trigger_poll(), since 
this is an interrupt handler; this solves my WARN_ON()

iio_trigger_poll_chained() will call handle_nested_irq(), while 
iio_trigger_poll() calls generic_handle_irq()


I modelled my code after ad91_adc which has iio_trigger_poll() in 
at91_adc_eoc_trigger() together with disable_irq_nosync()/enable_irq() -- 
is this correct? not sure, my code uses threaded irq, at91_adc not so

comments?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
