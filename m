Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:32961 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbKOQ0C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 11:26:02 -0500
Received: by oixx65 with SMTP id x65so60941698oix.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2015 08:26:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56485F18.7000608@kernel.org>
References: <1447445896-12655-1-git-send-email-linus.walleij@linaro.org>
	<56485F18.7000608@kernel.org>
Date: Sun, 15 Nov 2015 17:26:02 +0100
Message-ID: <CACRpkdYi9t_NBjWfBf4qr3XMx7zA62UkBRO-VF1fCUjuX48K_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: support active-low interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 15, 2015 at 11:31 AM, Jonathan Cameron <jic23@kernel.org> wrote:

>> This patch requires the previously sent patch to switch the
>> driver to request_any_context_irq().
>
> Really requires or will create some fuzz without it?  Looks like
> the latter so if we end up discussing that one for a while
> I might reorder.  Mind you early in this cycle anyway so
> no rush on this one!

I can put all three patches in a series and put this before that
patch, no problem.

> p.s. If anyone fancies adding support for the venerable
> lis3l02dq as well so we can kill off my ancient driver
> in staging that would be great! (I know I should do it
> myself probably but I can always hope someone else will
> get there first ;)

They are all so similar that I could probably code up
support from the datasheet.

However I have no hardware to test on...

Who submitted that driver in the first place?

Yours,
Linus Walleij
