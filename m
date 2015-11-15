Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35438 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbKOQWc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 11:22:32 -0500
Received: by oige206 with SMTP id e206so72660673oig.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2015 08:22:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56477F1B.4000508@kernel.org>
References: <1447333964-10276-1-git-send-email-linus.walleij@linaro.org>
	<56477F1B.4000508@kernel.org>
Date: Sun, 15 Nov 2015 17:22:31 +0100
Message-ID: <CACRpkdbqVpjcZxZZX3s52aFMoTNC6_vcBU_BqtDna057c0EbSQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: request any context IRQ
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 14, 2015 at 7:36 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> The result of this as you've identified is that we may call the
> function iio_trigger_generic_data_ready_poll from either a thread
> context or a interrupt context.

Yeah. Somebody connected an ST accelerometer to an IRQ
line that sits on and I2C expander in my design, meaning it needs
to have a threaded interrupt handler, as it needs to talk I2C
to handle the IRQ.

So somehow I need to handle any context of IRQs on the
ST MEMS drivers.

> This then calls generic_handle_irq for each of devices hanging
> off the trigger and ultimately desc->handle_irq and on
> to handle_simple_irq (fun this isn't it ;) This calls onto
> handle_irq_event and after a few more jumps ends up at
> handle_irq_event_percpu in kernel/irq/handle.c

I start to get the feeling tglx should review how IIO triggers handle
IRQs... maybe he already has. This brings into the question how
that special trigger IRQ thread is created (haven't looked into
that).

> Now, we could restrict the st_sensors trigger to use by
> the device supplying it - we could then operate the
> entire trigger always in a state where sleeping is safe
> (and run it as a chained irq - entirely in a thread).
(...)
> Call request_any_context_irq.  If this returns IRQC_IS_HARDIRQ
> continue as normal.  If it returns IRQ_C_IS_NESTED we could
> note this fact and handle any child interrupts hanging off the
> device differently. In the first instance we could refuse
> to let any pollfuncs with a top half interrupt bind to the trigger.
> The trigger would then call iio_trigger_poll_chained to
> call the nested interrupts (fine I think?)
>
> Am I missing something here?  This turned out to be a rather
> deeper rabbit hole than I thought it would be when I started!

Well. Yeah. Well. Maybe the *real* solution in that case is
that all drivers should be creating a threaded IRQ handler and
call from their thread and get rid of this extra thread from
the trigger.

But I'm confused, becaus as of today what I am actually
changing:

> -       err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
> +       err = request_any_context_irq(sdata->get_irq_data_ready(indio_dev),

It *used* to be threaded all the time, but what I hear you saying
is that the IIO core was actually pretty happy with the hardirq/fastpath.
So I don't quite see why this was requested threaded in the first
place.

Yours,
Linus Walleij
