Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33489 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbcF2NQe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 09:16:34 -0400
Received: by mail-ob0-f169.google.com with SMTP id xn17so24828993obc.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2016 06:16:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb094a04-00c1-489c-96b7-4e93708be808@kernel.org>
References: <1466583905-13199-1-git-send-email-linus.walleij@linaro.org> <cb094a04-00c1-489c-96b7-4e93708be808@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Jun 2016 15:08:44 +0200
Message-ID: <CACRpkdZ7Frw17n2uM5YGNemKmVtf7MK1CYuKrcfqVTP5kR+qKA@mail.gmail.com>
Subject: Re: [PATCH v8] iio: st_sensors: harden interrupt handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 26, 2016 at 12:44 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 22/06/16 09:25, Linus Walleij wrote:

>> - If no interrupt type is indicated from the DT/ACPI,
>>   choose IRQF_TRIGGER_HIGH so the above goes into action.
>
> This element is the tricky one. Previous default was (incorrectly)
> IRQF_RISING so any boards relying on that will be broken.

What happens is that it will request the interrupt controller (often
a GPIO with interrupt capabilities) to supply an active-high level
interrupt.

The cases where that doesn't work is when the interrupt controller
(i.e. often the GPIO driver) returns negative -EINVAL or similar from
its .set_type() callback.

> The problem here will be ancient boards with either wrong
> device tree bindings or none at all.  See stargate2.c

This appears to be using pxa27x-gpio, drivers/gpio/gpio-pxa.c
which has the same limitation as the Nomadik controller:
only edges.

So that explains why you saw the same annoying problem as
me.

> Clearly I can fix that one, but we still may get nasty
> surprises elsewhere.  Also fixing that will mean adding
> platform data which we haven't previously had...
>
> Is it that painful to stick to a rising default?

Let's do that then, surely it will be the best compromise right now.
Sending v9 soon-ish.

Yours,
Linus Walleij
