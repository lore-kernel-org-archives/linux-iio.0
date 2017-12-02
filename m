Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdLBNeI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 08:34:08 -0500
Date: Sat, 2 Dec 2017 13:34:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartosz =?UTF-8?B?R28=?= =?UTF-8?B?xYJhc3pld3NraQ==?=
        <bartekgola@gmail.com>, linux-iio@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-gpio@vger.kernel.org,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: Re: [RFC] Periodic Output, Timestamped Input
Message-ID: <20171202133403.10651f76@archlinux>
In-Reply-To: <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com>
References: <87ineapo5w.fsf@linux.intel.com>
        <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com>
        <87shcxw5n3.fsf@linux.intel.com>
        <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 29 Nov 2017 23:54:32 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Nov 29, 2017 at 2:56 PM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
> > Me:  
> >> For the other thing: timestamping of GPIO events, we already
> >> support timestamps for userspace GPIOs, but all it does is use
> >> the kernel time, see gpiolib.c:
> >>
> >> static irqreturn_t lineevent_irq_thread(int irq, void *p)
> >> {
> >>         struct lineevent_state *le = p;
> >>         struct gpioevent_data ge;
> >>         int ret, level;
> >>
> >>         ge.timestamp = ktime_get_real_ns();
> >>         level = gpiod_get_value_cansleep(le->desc);  
> >
> > this is running as a thread with interrupts enabled, AFAICT. This means
> > this thread can be preempted at least on PREEMPT_RT kernels, so your
> > timestamp can be wrong, right?  
> 
> Yes, it can be off. What we should do to get i better is
> something like what I did in:
> drivers/iio/gyro/mpu3050-core.c
> 
> Here I have both a hard and a soft IRQ handler (fast/slow if
> you like) and take the timestamp in the hard IRQ, then use
> it in the thread.

I did timing tests for both a long time back but I doubt things have
changed much.  To do fusion you ideally smooth the result on the basis
you are fairly sure the internal clock is better than even then jitter
we get in an interrupt.

No idea where the absolute numbers went though I'm afraid.
Perhaps Gregor can provide more info?

Not sure who else is doing sensor fusion currently...

> 
> This should be done identically in gpiolib to increase precision
> in the general case.
> 
> I was thinking about it already when implementing it but it fell
> out of my mind. I'm putting in on my TODO. (CC to bartosz
> who might be interested, he's using these ABIs quite a bit.)
> 
> Yours,
> Linus Walleij

