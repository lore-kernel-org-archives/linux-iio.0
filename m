Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36522 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcEHIzz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2016 04:55:55 -0400
Received: by mail-oi0-f47.google.com with SMTP id x201so182176840oif.3
        for <linux-iio@vger.kernel.org>; Sun, 08 May 2016 01:55:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17FC1367-F51B-4B0C-94C7-9984C838ECEC@jic23.retrosnub.co.uk>
References: <1462616744-9671-1-git-send-email-linus.walleij@linaro.org>
	<1462616744-9671-2-git-send-email-linus.walleij@linaro.org>
	<17FC1367-F51B-4B0C-94C7-9984C838ECEC@jic23.retrosnub.co.uk>
Date: Sun, 8 May 2016 10:55:54 +0200
Message-ID: <CACRpkdbEnTYFe=xd-u0JcyOGRrHydRSVBvYHsWvc1T8CsmJSQA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] iio: st_sensors: read surplus samples in trigger
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Crestez Dan Leonard <cdleonard@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 7, 2016 at 1:15 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:

> Shortens the race but doesn't prevent it that I can see..

I thought about it tonight, and I need to add one more thing
to make the solution perfect: avoid registering the interrupt
with IRQF_ONESHOT. That way the top half will always be
executed if a new IRQ comes in. The top half will be really
fast and always ready to recieve new IRQs. As the IRQ is
always edge-triggered on these devices, we need not worry
about the IRQ handler locking up: IRQF_ONESHOT is
essentially for level IRQs that just keep the line low until
you served the IRQ.

Then we need the top half to tell the bottom half that a new
IRQ has arrived.

Right now I am thinking about letting the top half increase an
atomic counter any time a new IRQ comes in and that way
we can check from the thread if a new IRQ arrived before
exiting.

We still need to re-check the status from I2C reads again:
as the interrupt line may be shared, some other device
could have fired the IRQ, but as long as the *last* thing we
check before exiting the thread is the irq counter, we should
be pretty safe. It would have the same precision as polling
the GPIO line anyways.

Let me cook a patch like this and you can see what I mean!

Yours,
Linus Walleij
