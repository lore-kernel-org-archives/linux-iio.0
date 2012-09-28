Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:32873 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab2I1Itv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Sep 2012 04:49:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by pmeerw.net (Postfix) with ESMTP id 4CC2EC50123
	for <linux-iio@vger.kernel.org>; Fri, 28 Sep 2012 10:49:48 +0200 (CEST)
Date: Fri, 28 Sep 2012 10:49:48 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: WARNING: at kernel/irq/handle.c, irq_default_primary_handler enabled
 interrupts
Message-ID: <alpine.DEB.2.01.1209280806040.15718@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I'm getting below warning (WARNING: at kernel/irq/handle.c:146, handler 
irq_default_primary_handler enabled interrupts) and I'm not sure how to 
deal with it

the driver does 

	request_threaded_irq(client->irq,
		NULL, si114x_irq,
		IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
		"si114x_irq", indio_dev);

and registers a trigger

si114x_irq() checks the irq status of the chip by reading and checking 
some register via i2c and then depending on the buffer being enabled or 
not

	if (iio_buffer_enabled(indio_dev))
        	iio_trigger_poll(indio_dev->trig, 0);
        else {
		data->got_data = true;
		wake_up_interruptible(&data->data_avail);
	}

there are a couple of questions:
(1) do I have to disable the irq manually?
(2) where to ack the irq status of the chip?
I'd rather not do it in the trigger_handler, as it might be called by some 
other, non-irq based trigger

thanks, regards, p.

[  124.945068] WARNING: at kernel/irq/handle.c:146 handle_irq_event_percpu+0x70/0x19c()
[  124.953216] irq 354 handler irq_default_primary_handler+0x0/0x14 enabled interrupts
[  124.961273] Modules linked in: si114x_new(O) industrialio_triggered_buffer kfifo_buf iio_trig_sx
[  124.972808] Backtrace: 
[  124.975372] [<c001184c>] (dump_backtrace+0x0/0x10c) from [<c02bd960>] (dump_stack+0x18/0x1c)
[  124.984222]  r6:c006be7c r5:00000009 r4:dead1eb8 r3:c04180cc
[  124.990203] [<c02bd948>] (dump_stack+0x0/0x1c) from [<c003109c>] (warn_slowpath_common+0x54/0x6)
[  124.999511] [<c0031048>] (warn_slowpath_common+0x0/0x6c) from [<c0031158>] (warn_slowpath_fmt+0)
[  125.009429]  r8:00000000 r7:00000000 r6:00000162 r5:c0424118 r4:deaf8480  r3:00000009
[  125.017791] [<c0031120>] (warn_slowpath_fmt+0x0/0x40) from [<c006be7c>] (handle_irq_event_percp)
[  125.028076]  r3:00000162 r2:c037b3c1
[  125.031799] [<c006be0c>] (handle_irq_event_percpu+0x0/0x19c) from [<c006c008>] (handle_irq_even)
[  125.041992] [<c006bfa8>] (handle_irq_event+0x0/0x7c) from [<c006e07c>] (handle_simple_irq+0xa8/)
[  125.051574]  r6:c0420f38 r5:dead0000 r4:c0424118 r3:00000000
[  125.057647] [<c006dfd4>] (handle_simple_irq+0x0/0xd8) from [<c006b7f8>] (generic_handle_irq+0x2)
[  125.067413]  r4:00000162 r3:c006dfd4
[  125.071136] [<c006b7d0>] (generic_handle_irq+0x0/0x38) from [<bf00deb4>] (iio_trigger_poll+0x38)
[  125.082153]  r4:deb47800 r3:00000001
[  125.085876] [<bf00de7c>] (iio_trigger_poll+0x0/0x60 [industrialio]) from [<bf021a7c>] (si114x_i)
[  125.097351]  r4:deac4800 r3:00000000
[  125.101074] [<bf021a34>] (si114x_irq+0x0/0x68 [si114x_new]) from [<c006c9a8>] (irq_thread+0xdc/)
[  125.110717]  r4:deaf8b80 r3:bf021a34
[  125.114562] [<c006c8cc>] (irq_thread+0x0/0x144) from [<c004cb4c>] (kthread+0x94/0xa4)
[  125.122772]  r8:00000000 r7:00000013 r6:c006c8cc r5:deaf8b80 r4:deb19c7c
[  125.129943] [<c004cab8>] (kthread+0x0/0xa4) from [<c0035e94>] (do_exit+0x0/0x748)
[  125.137817]  r6:c0035e94 r5:c004cab8 r4:deb19c7c
[  125.142700] ---[ end trace 611b64e0a5a44bc0 ]---


-- 

Peter Meerwald
+43-664-2444418 (mobile)
