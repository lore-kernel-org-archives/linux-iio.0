Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:49044 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012Ab2B2OcU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Feb 2012 09:32:20 -0500
Message-ID: <4F4E36E6.1010704@free-electrons.com>
Date: Wed, 29 Feb 2012 15:32:06 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: IIO irq allocation fails on AT91SAM9G45
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everyone,

I'm working on adding the support for the AT91SAM9M10G45-EK board from
Atmel for the at91_adc driver I previously posted, and I encounter some
weird issue here.

When calling the iio_allocate_trigger
(http://lxr.free-electrons.com/source/drivers/staging/iio/industrialio-trigger.c?a=arm#L421)
from my driver on the G45, it returns ENOMEM, while on the
AT91SAM9G20-EK board, it works perfectly.

Digging a bit into it, it seems that the call to irq_alloc_descs is
returning the error (the value of CONFIG_IIO_CONSUMERS_PER_TRIGGER is 2
in my configuration, which seems pretty reasonable and is the default
value anyway), which is itself getting that return value from
irq_expand_nr_irqs.

Here, I'm left confused, I don't know this part of the kernel anymore,
and most importantly, it seems to be pretty-much arch-independant, while
the nature of my issue seems really platform-dependant.

Do you have any clue of what's going on here ?

Thanks,
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
