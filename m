Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35942 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcFWOUz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2016 10:20:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so18442682lfe.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jun 2016 07:20:54 -0700 (PDT)
MIME-Version: 1.0
From: Micka <mickamusset@gmail.com>
Date: Thu, 23 Jun 2016 16:20:53 +0200
Message-ID: <CAF+MRt=SEz_q-Gq-6Fbxb4VNQaBWY=8uSwA0F-oWOjbOk7EKng@mail.gmail.com>
Subject: Kernel 4.4 : mma8452 driver bug
To: martin.kepplinger@theobroma-systems.com,
	christoph.muellner@theobroma-systems.com,
	"jic23@kernel.org" <jic23@kernel.org>, knaack.h@gmx.de,
	"lars@metafoo.de" <lars@metafoo.de>, pmeerw@pmeerw.net,
	martink@posteo.de, Robert Nelson <robertcnelson@gmail.com>,
	javier@osg.samsung.com
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm using your driver on the kernel 4.4 and I got this message :

[   24.145906] irq 94: nobody cared (try booting with the "irqpoll" option)
[   24.146025] CPU: 0 PID: 219 Comm: irq/94-mma8452 Not tainted 4.4.13-bone11 #9
[   24.146033] Hardware name: Generic AM33XX (Flattened Device Tree)
[   24.146085] [<c0013e85>] (unwind_backtrace) from [<c0011eb9>]
(show_stack+0x11/0x14)
[   24.146109] [<c0011eb9>] (show_stack) from [<c005f739>]
(__report_bad_irq+0x25/0x90)
[   24.146124] [<c005f739>] (__report_bad_irq) from [<c005f9b3>]
(note_interrupt+0x1c3/0x200)
[   24.146138] [<c005f9b3>] (note_interrupt) from [<c005e01b>]
(handle_irq_event_percpu+0xfb/0x154)
[   24.146151] [<c005e01b>] (handle_irq_event_percpu) from
[<c005e095>] (handle_irq_event+0x21/0x2c)
[   24.146164] [<c005e095>] (handle_irq_event) from [<c005fe51>]
(handle_level_irq+0x5d/0x9c)
[   24.146177] [<c005fe51>] (handle_level_irq) from [<c005d965>]
(generic_handle_irq+0x1d/0x28)
[   24.146198] [<c005d965>] (generic_handle_irq) from [<c039e531>]
(omap_gpio_irq_handler+0xb9/0xe4)
[   24.146215] [<c039e531>] (omap_gpio_irq_handler) from [<c005dfab>]
(handle_irq_event_percpu+0x8b/0x154)
[   24.146227] [<c005dfab>] (handle_irq_event_percpu) from
[<c005e095>] (handle_irq_event+0x21/0x2c)
[   24.146240] [<c005e095>] (handle_irq_event) from [<c005fe51>]
(handle_level_irq+0x5d/0x9c)
[   24.146253] [<c005fe51>] (handle_level_irq) from [<c005d965>]
(generic_handle_irq+0x1d/0x28)
[   24.146265] [<c005d965>] (generic_handle_irq) from [<c005db07>]
(__handle_domain_irq+0x3b/0x80)
[   24.146284] [<c005db07>] (__handle_domain_irq) from [<c066b68d>]
(__irq_svc+0x4d/0x74)
[   24.146299] [<c066b68d>] (__irq_svc) from [<c005e982>]
(irq_thread_fn+0x32/0x38)
[   24.146312] [<c005e982>] (irq_thread_fn) from [<c005eb9b>]
(irq_thread+0xdf/0x148)
[   24.146333] [<c005eb9b>] (irq_thread) from [<c0040643>] (kthread+0xa3/0xb8)
[   24.146350] [<c0040643>] (kthread) from [<c000ea95>]
(ret_from_fork+0x11/0x1c)
[   24.146357] handlers:
[   24.146405] [<c005e0a1>] irq_default_primary_handler threaded
[<bf94d101>] mma8452_interrupt [mma8452]
[   24.146580] Disabling IRQ #94

is it a bug from the driver or is it my fault ?

Micka,
