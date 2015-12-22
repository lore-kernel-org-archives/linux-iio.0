Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33636 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbLVIoa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 03:44:30 -0500
Received: by mail-oi0-f45.google.com with SMTP id y66so104843459oig.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Dec 2015 00:44:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a5deeb3722254bd08d7a7e071fd42e7f@EMAIL.axentia.se>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
	<CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
	<566C6122.6040406@kernel.org>
	<85d1850f20c141b2952d93be72199fdf@EMAIL.axentia.se>
	<CACRpkdY9Nwg3B1bAJ53Y-tJJywC=ENvFR6S99+wUKzcUHTa5TQ@mail.gmail.com>
	<a5deeb3722254bd08d7a7e071fd42e7f@EMAIL.axentia.se>
Date: Tue, 22 Dec 2015 09:44:29 +0100
Message-ID: <CACRpkdbVnpdPUaMZRr-Lh27MZjM-CUwzgsy1QfzDR7tbHFPZWw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
From: Linus Walleij <linus.walleij@linaro.org>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Porter <mporter@konsulko.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 18, 2015 at 12:19 AM, Peter Rosin <peda@axentia.se> wrote:

> This all makes sense. The reason is that I'm not familiar with
> the kernel APIs. I have to wrap my head around how to set up
> work to be performed later, etc etc.

FWIW a random work to be performed later is a delayed work.
It can be queued on a global workqueue or you can create your
own workqueue. This is the latter way, it's even simpler if you
just use NULL as workqueue, it will then end up on the big
system workqueue. The workqueue in turn uses deferrable timers,
and these can also be used directly.

#include <linux/workqueue.h>

struct foo {
   struct workqueue_struct *foo_wq;
   struct delayed_work delayed_foo_work;
   ....
};

static void foo_work_cb(struct work_struct *work)
{
        struct foo *foo = container_of(work, struct foo, delayed_foo_work.work);

        ... do the work ...
};

main {
   INIT_DEFERRABLE_WORK(&foo->delayed_foo_work, foo_work_cb);
   queue_delayed_work(foo->foo_wq, &foo->delayed_foo_work, 6*HZ);
}

6*HZ means wait for 6 seconds as the delay is given in ticks (jiffies)
and the system does HZ ticks per second.

>> > I have realized that I could work with one-shot-interrupts. Then the
>> > urgency to disable interrupts go away, as only one interrupt would
>> > be served. That was not my immediate solution though, as I have been
>> > using isr type registers in this way several times before.
>>
>> That sounds like the right solution. With ONESHOT a threaded IRQ
>> will have its line masked until you return from the ISR thread. Would this
>> work for your usecase?
>
> The ISR thread would need to be able to disable further interrupts
> before it returned, is that possible without deadlock? If so, it's
> a good fit.

Yes that is what the ONESHOT flag means. So like this:

ret = request_threaded_irq(irqnum, NULL, foo_irq_handler,
                                   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
                                   "foo", foo);

To register a threaded oneshot IRQ that will run on a falling edge,
as a thread, until completed, masking its own interrupt line, but
no others.

The threaded handler can msleep(), mdelay()/udelay() etc since it
is a thread. usleep_range(a, b) is the best as the system can idle
while that happens, and can plan for a good wakeup point.

Yours,
Linus Walleij
