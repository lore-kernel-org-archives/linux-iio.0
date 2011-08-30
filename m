Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49871 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1H3Jxw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 05:53:52 -0400
Message-ID: <4E5CB51C.5010809@cam.ac.uk>
Date: Tue, 30 Aug 2011 11:02:04 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: malas <malas@tcoe.iitm.ac.in>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: ad7793 adc rcv userspace test - passed succesfully
References: <20110824081952.M29386@tcoe.iitm.ac.in> <4E54B9D0.20903@cam.ac.uk> <20110824084734.M61257@tcoe.iitm.ac.in> <4E551DEF.4030805@cam.ac.uk> <20110829053753.M60985@tcoe.iitm.ac.in>
In-Reply-To: <20110829053753.M60985@tcoe.iitm.ac.in>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/29/11 06:39, malas wrote:
> 
> Dear Jonathan Cameron,
> 
> I last reported that after creating device node and opening it, read() call was failing.
> I got to fix this.
> 
> The reason was this:
> 4 functions are exported from ad7793 module to iio-ring module as ring setup ops:
> namely: 
>         .preenable = &ad7793_ring_preenable,
> 	.postenable = &iio_triggered_ring_postenable,
> 	.predisable = &iio_triggered_ring_predisable,
> 	.postdisable = &ad7793_ring_postdisable,
> 
> In the iio-ring modules "iio_store_ring_enable" function is invoked from user app,which
> inturn invokes the func "ad7793_ring_preenable" and subsequently driver's postenable
> function.
> 
> The "iio_triggered_ring_postenable" function then attaches the poll function to the ring
> trigger soft interrupt.
> 
> Since continuous mode was set and enabled the configured GPIO interrupt for capturing
> data ready signal (in ad7793_ring_preenable) as interrupt, iio_trigger_poll() invoked on
> interrupt (from drivers data rdy interrupt handler) failed to raise soft interrupt and
> as a consequence driver's ad7793_trigger_handler() was not invoked when data ready.
> 
> I patched as follows in ad7793.c:
> 
> 1. Moved irq enabling from ad7793_ring_preenable to ad7793_ring_postenable
> 2. Defined ad7793_ring_setup_ops ".postenable" as  ad7793_ring_postenable
> 3. In ad7793_ring_postenable, invoked &iio_triggered_ring_postenable and then enabled
> the data ready signalling GPIO interrupt.
Hmm.. That will fix the issue. Normally I'd expect to see the enable actually
happening in the trigger_set_state callback rather than there, but this device
shares the interrupt line with on of the spi signal lines so is messing with irq's
a lot more than normal so I guess that doesn't work?
> 
> Then, from user app after opening the device, Poll() for rcv data presence was
> successful and  read() call returned non-zero size . Could print the data from ring buffer.
> 
> Sincere thanks to you and Michael for guiding me through.
> 
> Take care.
> 
> regards
> Mala
> 
> 
> 
> 
> 

