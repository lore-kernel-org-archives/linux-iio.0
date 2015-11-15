Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48155 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbKORcz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 12:32:55 -0500
Subject: Re: [PATCH] iio: st_sensors: request any context IRQ
To: Linus Walleij <linus.walleij@linaro.org>
References: <1447333964-10276-1-git-send-email-linus.walleij@linaro.org>
 <56477F1B.4000508@kernel.org>
 <CACRpkdbqVpjcZxZZX3s52aFMoTNC6_vcBU_BqtDna057c0EbSQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Thomas Gleixner <tglx@linutronix.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5648C1C2.1030300@kernel.org>
Date: Sun, 15 Nov 2015 17:32:50 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdbqVpjcZxZZX3s52aFMoTNC6_vcBU_BqtDna057c0EbSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/11/15 16:22, Linus Walleij wrote:
> Yeah. Somebody connected an ST accelerometer to an IRQ
> line that sits on and I2C expander in my design, meaning it needs
> to have a threaded interrupt handler, as it needs to talk I2C
> to handle the IRQ.
> 
> So somehow I need to handle any context of IRQs on the
> ST MEMS drivers.
Sure, clearly need some way around it and I've known it would come
up at some point for a while!

> 
>> > This then calls generic_handle_irq for each of devices hanging
>> > off the trigger and ultimately desc->handle_irq and on
>> > to handle_simple_irq (fun this isn't it ;) This calls onto
>> > handle_irq_event and after a few more jumps ends up at
>> > handle_irq_event_percpu in kernel/irq/handle.c

> I start to get the feeling tglx should review how IIO triggers handle
> IRQs... maybe he already has. 

Thomas did help us work it out via discussions about the design
back in 2011 when we moved to threaded interrupts.

Google fed me:
http://marc.info/?l=linux-kernel&m=129917247506111&w=2
which lines up with my local email threads from the time.

I'm having fun actually tracking down the archive for the email
threads related to the patches themselves.  The series is this one
http://www.spinics.net/lists/linux-iio/msg01563.html

(though there was definitely a v3 as the patch is:
d96d1337e339521a2bd56dc9d51fef140c1a49ee 
staging:iio: Add infrastructure for irq_chip based triggers

but I seem to have lost it locally (probably sat on some dead
PC in my old lab somewhere).

I remember a lot of this stuff came after a very detailed review
Arnd Bergman did which led to tidying up of how we did this and
other aspects of the subsystem (was very very helpful at that stage
as other reviews were all from guys working in IIO and not many of
us were very experienced!).

Not sure anything has fundamentally changed since then.
If tglx has time to take another look it would certainly be
welcome!  Any input on this particular problem also welcome.
(cc'd - Thomas, discussion is about the handling of interrupts
for IIO triggers where we split a single, typically real,
interrupt and feed it to any devices that are registered to
receive it - code is in
drivers/industrialio/industrialio-triggers.c.  Complexity
is that any trigger can be used by any device - including
stuff like timestamping, or capture pin wiggling which tends
to be in traditional irq top half.  In this case Linus
has an interrupt that is on a chip on an i2c bus so can't
drive that stuff...)

To all intents and purposes the IIO triggers are irq chips
so everything gets set up exactly the same way as if they were
hardware irqs.  Its very similar to what a lot of mfd devices
do though we effectively spread the interrupt out rather than
working out which device to send it to (as it needs to go to
all of them).

The nasty hoops are only jumped through when we
generate triggers in software (e.g. the sysfs trigger).  Fixing
it for your case would also allow us to hopefully drop some of
that complexity as well. 

>This brings into the question how
> that special trigger IRQ thread is created (haven't looked into
> that).
> 
The st sensors trigger never had a threaded part anyway so
I'm not sure why it was requesting it via the threaded_irq request.
That falls back to standard irq if no thread is provided though.

Jonathan
