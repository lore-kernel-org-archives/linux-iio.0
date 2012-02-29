Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44512 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab2B2UeU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Feb 2012 15:34:20 -0500
Message-ID: <4F4E8C0F.5090104@kernel.org>
Date: Wed, 29 Feb 2012 20:35:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: IIO irq allocation fails on AT91SAM9G45
References: <4F4E36E6.1010704@free-electrons.com>
In-Reply-To: <4F4E36E6.1010704@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/29/2012 02:32 PM, Maxime Ripard wrote:
> Hi everyone,
> 
> I'm working on adding the support for the AT91SAM9M10G45-EK board from
> Atmel for the at91_adc driver I previously posted, and I encounter some
> weird issue here.
> 
> When calling the iio_allocate_trigger
> (http://lxr.free-electrons.com/source/drivers/staging/iio/industrialio-trigger.c?a=arm#L421)
> from my driver on the G45, it returns ENOMEM, while on the
> AT91SAM9G20-EK board, it works perfectly.
> 
> Digging a bit into it, it seems that the call to irq_alloc_descs is
> returning the error (the value of CONFIG_IIO_CONSUMERS_PER_TRIGGER is 2
> in my configuration, which seems pretty reasonable and is the default
> value anyway), which is itself getting that return value from
> irq_expand_nr_irqs.
> 
> Here, I'm left confused, I don't know this part of the kernel anymore,
> and most importantly, it seems to be pretty-much arch-independant, while
> the nature of my issue seems really platform-dependant.
> 
> Do you have any clue of what's going on here ?
We ran into this originally on the pxa as well.   My guess is that
nr_irqs is not set high enough for that particular board.

Looking back I can find some mention of a nasty bit of code that
just adds a bit of padding but I can't find it now.

Anyhow, you probably have a line somewhere in the kernel log
saying something like:

[    0.000000] NR_IRQS:288 nr_irqs:296 296

NR_IRQS is typically the number of the SoC
nr_irqs should be large enough to accomodate those provided by
other peripherals.

I also have a vague recollection that the problem goes away entirely
with sparse irqs?

Michael, you commented on this issue originally, can you remember
any more details than me? (It seemed like I wrote plenty at the
time but I can't for the life of me fill in the missing details!)

