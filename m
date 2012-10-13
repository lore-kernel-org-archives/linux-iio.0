Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:40705 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746Ab2JMQPp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 13 Oct 2012 12:15:45 -0400
Date: Sat, 13 Oct 2012 18:15:43 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: WARNING: at kernel/irq/handle.c, irq_default_primary_handler
 enabled interrupts
In-Reply-To: <5079914C.3030100@kernel.org>
Message-ID: <alpine.DEB.2.01.1210131814360.21539@pmeerw.net>
References: <alpine.DEB.2.01.1209280806040.15718@pmeerw.net> <alpine.DEB.2.01.1209290134230.8022@pmeerw.net> <5079914C.3030100@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> > it should be iio_trigger_poll_chained(), not iio_trigger_poll(), since 
> > this is an interrupt handler; this solves my WARN_ON()

> That's not the reason, it's because you are calling it from a bottom half.
> The nature of the trigger code is that it would normally be called from the
> top half (as it's normally just calling a tree of other interrupt handlers
> which may or may not have their own top halves.)
> 
> The chained call is probably ok, but does limit what other devices may use
> this as a trigger source.  Lars-Peter had another approach that is used
> in the sysfs trigger using irq_work_queues which might work here (I haven't
> thought about it in much depth...) see drivers/staging/triggers/iio-trig-sysfs.c

thank you for the pointer, will have a look

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
