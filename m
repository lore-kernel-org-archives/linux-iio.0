Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44538 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab2CBJD3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Mar 2012 04:03:29 -0500
Message-ID: <4F508CD0.20906@free-electrons.com>
Date: Fri, 02 Mar 2012 10:03:12 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: IIO irq allocation fails on AT91SAM9G45
References: <4F4E36E6.1010704@free-electrons.com> <4F4E8C0F.5090104@kernel.org> <20120229204853.GE16999@n2100.arm.linux.org.uk>
In-Reply-To: <20120229204853.GE16999@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 29/02/2012 21:48, Russell King - ARM Linux a =E9crit :
> On Wed, Feb 29, 2012 at 08:35:27PM +0000, Jonathan Cameron wrote:
>> On 02/29/2012 02:32 PM, Maxime Ripard wrote:
>>> Hi everyone,
>>>
>>> I'm working on adding the support for the AT91SAM9M10G45-EK board f=
rom
>>> Atmel for the at91_adc driver I previously posted, and I encounter =
some
>>> weird issue here.
>>>
>>> When calling the iio_allocate_trigger
>>> (http://lxr.free-electrons.com/source/drivers/staging/iio/industria=
lio-trigger.c?a=3Darm#L421)
>>> from my driver on the G45, it returns ENOMEM, while on the
>>> AT91SAM9G20-EK board, it works perfectly.
>>>
>>> Digging a bit into it, it seems that the call to irq_alloc_descs is
>>> returning the error (the value of CONFIG_IIO_CONSUMERS_PER_TRIGGER =
is 2
>>> in my configuration, which seems pretty reasonable and is the defau=
lt
>>> value anyway), which is itself getting that return value from
>>> irq_expand_nr_irqs.
>>>
>>> Here, I'm left confused, I don't know this part of the kernel anymo=
re,
>>> and most importantly, it seems to be pretty-much arch-independant, =
while
>>> the nature of my issue seems really platform-dependant.
>>>
>>> Do you have any clue of what's going on here ?
>> We ran into this originally on the pxa as well.   My guess is that
>> nr_irqs is not set high enough for that particular board.
>>
>> Looking back I can find some mention of a nasty bit of code that
>> just adds a bit of padding but I can't find it now.
>>
>> Anyhow, you probably have a line somewhere in the kernel log
>> saying something like:
>>
>> [    0.000000] NR_IRQS:288 nr_irqs:296 296
>>
>> NR_IRQS is typically the number of the SoC
>> nr_irqs should be large enough to accomodate those provided by
>> other peripherals.
>>
>> I also have a vague recollection that the problem goes away entirely
>> with sparse irqs?
>=20
> Yes, because IRQs will be allocated above the last figure on that
> line, up to IRQ_BITMAP_BITS which happens to be 8192 above NR_IRQS.
>=20
> There's an issue though: if your on-SoC IRQ controller is already
> using irq_alloc_descs(), it will fail if you want it to grab IRQs
> below the last figure on that line, because those will have already
> been allocated for you.

Ok, so using either the sparse irqs or changing the definition of
NR_IRQS from 192 to 224 makes the problem go away.

I guess the reason because I was not seeing this issue with the G20 is
because it has less interrupt sources.

Anyway, I'm not sure about the augmenting the NR_IRQS fix. It seems to
work pretty well, but might it have some weird side-effects ?

Should I send a patch for it, or should I find another way to fix this =
?

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
