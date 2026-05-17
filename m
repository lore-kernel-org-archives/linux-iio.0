Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5A1E4BE
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018360; cv=none; b=ij3H0GUaekEUnibhYiajzDnGVp6w973ZrUxO4EgaSP6h5TzcnikIJAQP9BQjCRicE0c1A5A1Dxk2aKufcdW6or069T/toUwurPflOhn3SDcyMDhYbSw6XG199yO0qVA+7/pGIAASASCgRa5FqCA9efYgxJi8/cjI8fWF2lWuHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018360; c=relaxed/simple;
	bh=Ki7uSf12wHsFlsoGgOnLrB4GgjB3XN6p+Cp/ZB3fCbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAlHuHHwdRpng82GtAz+wlYjenwrsjAPmPYrlb9P0lH4LGKpFbsBme1GMaLNNMCbcHDt0qx4bN2ftyRsP5QqPKcdmRpxRxszW0dqWLvdGLAiLhiAcUAx2+IcAGJX2UFTk39vqwi7wfLEok5AuC7cy9+z+KPTbgpYGwELKyuAQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-57754ec3462so520141e0c.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 04:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779018357; x=1779623157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DebYSPXyMA12y92kZcA8rAKkRRULfngBHwuM5CKJDc=;
        b=g/NetJWayGRK3l8CyZCHEwjpJFFVO/OVdwkzjSTluMZaBZvRH9Fsr+3f+gtwrP58EJ
         NBGxqVVCmVBqLibM6UEQ/GvErlJYuIGDefFlPWe85TYDpYHn5yDcrnnawZNi4L1jz2uh
         6e27qEvy0k+IjnCrZYWt0W+4jBZ6K2XEXAEfJWsqMWpnGCt0Injk0KlNkIHgyNvhbR1T
         GyMPv8PzlxpF9HpakGR3IbIkSS0PcuGGjO6hS5zkvCGzYY36fWYdVYpJXTqJtOJyyVeT
         U0o1fbQ+4fZx59PFdji7GAh0c/nsPsETGV6gvSR+L1AlZ1XP89477IpvEF3bCOjU8KAX
         5liw==
X-Forwarded-Encrypted: i=1; AFNElJ+RM2MhSHy1EOf8nsOXO3YIV5aMOoclBf4snDx4ZuXG2z8LnOXJEtY6Hncg3ZaW/mgZQCyj+eWUbc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtl+uQ9nLrVSHt7qYQnW+Kuy5eZe3v/Wn3d2Q4fkJBKO0cLIO
	8O6PcDT6i8Bo7OdvLqXASL7EUq41rw6uU8RZ9IJ7yxU5mFmsMK5m0uqT1g9CwlT2
X-Gm-Gg: Acq92OHKjc6Ta6u0xMcRdpca+XO7v6463JhdO7Eok7982zPD7bHO6GltPwWXMXZfcIn
	U/35t9eQqYe/afySvDTlS70Uh26zNsMqwk0iDjeL7IUiiDf104Wik8kJi3/C9i9bzaMQU6gLvm9
	Pf29/Z2oLlOceMPUXUI09l24Jv1ErrILq8EK7D27Ne2w50lKsk6CGC/mK2jbKX99KeqAh6hQL11
	XCQsEc9kh++Y16Thm8zPtqVb/C50RRZPhOk7bc/UTmOTmjmTgajyCInsPwB+rpWgfvWqlbn5F/s
	2vn5FmSC+EPCPYy2jBkYcgupAGlC0EmmrasjS0INl3SjOWqKPpygXjbDVsyEuloW4I/UQ4hGSLi
	C8lsRdnHVbpF1HkNf8SyQWUTTXXlGHHPRKIWT4kTVRbkhLPVQVtfyptujTYH6WHNi8jq5VWy1go
	YLEmMo7ZviLG8uwjYlGNr2EALMEvDehBARvrxbiTYx5wGH12CDnDmq+Id3LoRz
X-Received: by 2002:a05:6123:143:b0:56f:a329:6859 with SMTP id 71dfb90a1353d-5760bfc62f5mr6386632e0c.7.1779018357124;
        Sun, 17 May 2026 04:45:57 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f58feacsm4712394e0c.1.2026.05.17.04.45.56
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 04:45:56 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-628086439b6so1239728137.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 04:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+nJhSzDjq4jYLmtgzwwxrHcfRjI2w/hmw0P4EJ3GZHW1cXWZ+eQNkmpoC0NdwpNzbK9nAEbdc2wYI=@vger.kernel.org
X-Received: by 2002:a05:6102:1499:b0:632:1e2f:3a6f with SMTP id
 ada2fe7eead31-63a3f588eb4mr5593907137.24.1779018356258; Sun, 17 May 2026
 04:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALSJ-wAqFni+OwSUcQS+KESfe7SbWMxc0aCURHtTZ93Rx6GZhw@mail.gmail.com>
In-Reply-To: <CALSJ-wAqFni+OwSUcQS+KESfe7SbWMxc0aCURHtTZ93Rx6GZhw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 17 May 2026 13:45:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMvoODD4huxqPb+Hj6Rdid1cSgvzuJdqvg_hRzviyFuA@mail.gmail.com>
X-Gm-Features: AVHnY4LH2SV9naipvvuNwFBNfxwbLJEv_dNs2guuBciejeAs6rBKW5zfskaYVQw
Message-ID: <CAMuHMdUMvoODD4huxqPb+Hj6Rdid1cSgvzuJdqvg_hRzviyFuA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Steven King <sfking@fdwdc.com>, Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Angelo,

There's something wrong with "Mail-Followup-To:", which lists everyone,
except for you...

On Sun, 17 May 2026 at 11:11, Angelo Dureghello
<adureghello@baylibre.com> wrote:
> jfyi, for some reason i was not in to/cc, but i could grab the message
> in lore.

Might be related...

> On Thu, May 14, 2026 at 10:54:32PM +1000, Greg Ungerer wrote:
> > On 14/5/26 17:05, Angelo Dureghello wrote:
> > > On 14.05.2026 11:27, Greg Ungerer wrote:
> > > > On 13/5/26 19:14, Angelo Dureghello wrote:
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >
> > > > > Later in this patchset, the mcf54415 DAC driver is added.
> > > > > Considering some other different ColdFire cpu DACs exists, the DAC driver
> > > > > is named as "mcf54415_dac", related to the mcf5441x family SoCs with
> > > > > DACs (mcf54415/6/7/8).
> > > > >
> > > > > So updating DAC clock names to bind with proper driver name.
> > > >
> > > > I am not sure I like naming the clocks here with a prefix for the
> > > > specific SoC part number this is in. It might be unlikely now, but
> > > > what if another ColdFire family SoC member uses this same hardware block?
> > > > That is very common amongst other hardware blocks within the ColdFire
> > > > family. Can we come up with a name more specific to just this type
> > > > of DAC hardware block?
> > > >
> > >
> > > from a brief study, this 12bit DAC, and DAC module in general, is only on
> > > this mcf45441x family. There are some ColdFire with ADC only, as those
> > > mcf5249/53/82.
> > > The mcf51mm/ag/je are the opnly to have a 5bit dacs, but these are mcus.
> > > So, if i don't miss any existing model, the name may be correct,
> > > unless we want rename it to a more generic mcf_dac.
> >
> > Yes, I would suggest just leaving it as is, "mcfdac".
> > That is not currently used by any other ColdFire variants supported by
> > the kernel.
> >
>
> Ok, will fix this in a v3, just asking confirmation on the name to
> Jonathan and all, since it involves iio too.
>
> Chaches are:
> mcfdac
> mcf-dac  or mcf_dac (we have drivers as vf610_dac and cio-dac)

The clock names in arch/m68k/coldfire/m5441x.c are the names as
specified by the producer side, not by the consumer side.

> > > > > --- a/arch/m68k/coldfire/m5441x.c
> > > > > +++ b/arch/m68k/coldfire/m5441x.c
> > > > > @@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
> > > > >    DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
> > > > >    DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
> > > > > -DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
> > > > > -DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
> > > > > +DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
> > > > > +DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
> > > > > @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
> > > > >         CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
> > > > >         CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
> > > > >         CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
> > > > > -       CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
> > > > > -       CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
> > > > > +       CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
> > > > > +       CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
> > > > >         CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
> > > > >         CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
> > > > >         CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
