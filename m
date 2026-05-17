Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A51F91E3
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038578; cv=pass; b=VIET0tdWY8oTsYvSSX6mG0krJzUDFQ0KFiIV5MKsggpqfxY5Gt+KelRJBGlypszU5ZUTPk/TwgSgRrMRDbTKmzC2l2yqEhr8bfZydyLw7x6Y6FSbsHYFCqB07k9ye9Q41Sfn34YsEuekq3rKAJfUctbDPzkvDyYh4Wb3wHHKHCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038578; c=relaxed/simple;
	bh=9fkNUobK9tqmFCI1XWvGAdvhDFf8Vke0+JZv3ZM2vQo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sgtc4FlCcwMBDCFvt20NV57bh7gkVklfzQcvg/HrPq0j1lfIgapRgWdHbZIlICLckf5dHJNAQ53ZWl1V1+S82zkMuUNH8HUmYBGbCIPe81ulE75dIhf6YtcaR/a6bcg7HMKqHAIydpS0YJzOUxEOtJrwGWO5hZVnxzpIBCP+wbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=f6xc//KS; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="f6xc//KS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd124546379so304537266b.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779038575; cv=none;
        d=google.com; s=arc-20240605;
        b=C0gx8grFCbY7Le9GOAdD+Lno69sYyjGcc1PIngyIUE/s2uO8JfYGcSsVFM/7be6jqS
         F////Xp5dbnvroXfCsjXfUrjswy4mYVdxcBsoJpwZXLL55LjuYc7JFCofPoPHIhPnzZP
         G9XLOf7Wf6vzs7D+nVSjHE1bJnRuXjTAiQFLSwBU1199lWHRWdaNkjAOOcYMvM7zSWQC
         RdenVuWPWF8S+j9u1asNpdBmKwC9+fz9e9k8LcxHve6iFkQCygBz9/phpvtM07B64fMQ
         oosHFoH0MCW6/KMaQoh8BcOrPrnaKanz0570pBJjFr+kupG2s81YdpUA8xMcYw+LYSI6
         OCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=BLmdCKMgbw8MBhwcDBHMbfL3wvck7U926c1rh+9BXmI=;
        fh=dv9QohmXiHkd1TXGavrG+u/HwCsuXxYj0UvfPi3TAo8=;
        b=EQYwK+yEirG+nMsL9f92NiKCOOKKy1iDuaVCPo53R8duLd51lgTMBgWSX+MaGXcI/U
         m4NLmpogcn8T/EQGVmn8Lsny1wXu3SZyngi45iDWCHeTbMK8lJvVOo20QyMx+bYZ9Bkq
         GkWRwb6SLYlfHPRCPkvN7k7t15rFCuaYwnvApXjl5IgcaqJL97ElXXn5uf3KHDfbwkl6
         sVuNOockG/48qmHMu62Eg3ox6miTQpOv1QlspwcHDmQlBJ7uzB44Lu8PY9PDncXq8PrV
         yxKalY9iKnIfxAbtHzVhZ27/BYhgHKEU4mpFZhH7xXtxcRBFSY+ME3sbT9X3WJQ1XEN2
         IDXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779038575; x=1779643375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLmdCKMgbw8MBhwcDBHMbfL3wvck7U926c1rh+9BXmI=;
        b=f6xc//KSTgh/ExkOobckPVh7wd31vbli8BEDgvpxu8Nu0p8ibMhNSKNtzQObYje9wA
         UYpMEQQwrI0h0rwzWq6l5Dv0100byZYRko1MW1r8BHCuQAGOt+c1PgefRL+oL/OBwQ/f
         ACP2CzTfT2dGcakYpF81QFLA8GTH+45KBkOdhrZyfWxxMTDLSn2O3XCqBOdAMl/sG797
         7y33M/zRAoGCZ7LnPxGctqLPtcNqOW2wRRMp/Wp8oQyOmxVU470H3O8c5cJJFbSFHSUG
         lwuLk9dJWhqJX603F6ctwGynI/2CuRutnQOgANXhObICFsLFhJ8LtEd5Koyx4r2zDUzD
         d9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038575; x=1779643375;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BLmdCKMgbw8MBhwcDBHMbfL3wvck7U926c1rh+9BXmI=;
        b=UhM4lZNL2lXDYuWrDzFaHeqrgdwO0cVj9NW5VVn8J1vhlNIjSOjYYDHXZPgkbyZT9A
         MOC1/e6x8SJuwl3+/Ri+tBW6IW12MBY5B7eikfI9pqMWFpJhjG+OGjO4Zzsp7+J+msm0
         v8ZGCoIJ8TTLOJcsZgq/G/CrMt+GQH3tU6VoznkIhfFM3vi4ZDR0ZmPeep6yRWOFOVOO
         UYau2v1C/56ky+QWaSI46IfPX84meor/jkEIdC2HVnUwIkrgvBN4GAbulji9A0P2dy6C
         U3cBcRwBj8KjlQrUndtWrpY+7oIWA3sN5MCBG9dHnur9zwnHP6fWAHWlz+unyc2R02pB
         KYhw==
X-Forwarded-Encrypted: i=1; AFNElJ9KEsgGajK4a889XmDQUdHX+ZM10pHsuG2dXre2TjKrc/zPmvkTL+lJj1sXyAn0gAR4TaAyObAAhz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOG5d0WmuxeX4k4RdeIzKV+qM+Y61QCtD29gs5F0rpOx56420b
	eYLgqQXZ/13/zCFmH4SguTtYMZd0eSsWMZc+UkyLOc/xI521R3NbYrxlQZs+u3l1dojV1us4y+S
	w+9mVjmZpWPLm1sw+jrZ1p5S+GUFLjsdEX0nX2+ZqBw==
X-Gm-Gg: Acq92OH7Qd5B7C8nao72C0yVgWKi82GgSlD5vXcTuqcPj+SDi6VoJ7p79oB0lmHx2Rx
	iDoScjN6JmBcRozS2VamtpjE+VuiePdbmekTt2PUVvOeaIEYpbGjWDNvAAc8IdRWCLxR3KXt+M9
	ysz9rnmFJq4uHzUJbukTNE+ujbHgOWyq5CwXyBVbS349Obx329cxqQ6L51UKTP0UBjpukrtL/Pf
	37z0kJvF1b1Gghmxn3OWK1oOTtcegEUkDKz3zDWl+Iys3z+ku2E4edEqL0UscwsA9PDvYx0i0eq
	A+5ETlnsJjwRWpEor83k/wAVVGo7uPvgiWGl
X-Received: by 2002:a17:907:94c8:b0:bab:d8e9:53a7 with SMTP id
 a640c23a62f3a-bd5178fa6eemr564439666b.29.1779038574485; Sun, 17 May 2026
 10:22:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 10:22:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 10:22:53 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Angelo Dureghello <adureghello@baylibre.com>, Steven King <sfking@fdwdc.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <CALSJ-wAqFni+OwSUcQS+KESfe7SbWMxc0aCURHtTZ93Rx6GZhw@mail.gmail.com>
 <CAMuHMdUMvoODD4huxqPb+Hj6Rdid1cSgvzuJdqvg_hRzviyFuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUMvoODD4huxqPb+Hj6Rdid1cSgvzuJdqvg_hRzviyFuA@mail.gmail.com>
Date: Sun, 17 May 2026 10:22:53 -0700
X-Gm-Features: AVHnY4LXmzt2FYulHGvc5U-cYyRCzVXS4ho7o5lb3LZyGzYNxvZblCBbDnNF3UY
Message-ID: <CALSJ-wAX_dBYYzLPOPxKZXQQPFQXhW0Oad6FezdZE2bXWfaBcA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Steven King <sfking@fdwdc.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, May 17, 2026 at 01:45:44PM +0200, Geert Uytterhoeven wrote:
> Hi Angelo,
>
> There's something wrong with "Mail-Followup-To:", which lists everyone,
> except for you...
>
> On Sun, 17 May 2026 at 11:11, Angelo Dureghello
> <adureghello@baylibre.com> wrote:
> > jfyi, for some reason i was not in to/cc, but i could grab the message
> > in lore.
>
> Might be related...
>

yes, imported the raw msg from lore but was not allowed to send from
lieer, so i removed In-Reply-To:, anyway, thread seems back ok now.

> > On Thu, May 14, 2026 at 10:54:32PM +1000, Greg Ungerer wrote:
> > > On 14/5/26 17:05, Angelo Dureghello wrote:
> > > > On 14.05.2026 11:27, Greg Ungerer wrote:
> > > > > On 13/5/26 19:14, Angelo Dureghello wrote:
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >
> > > > > > Later in this patchset, the mcf54415 DAC driver is added.
> > > > > > Considering some other different ColdFire cpu DACs exists, the DAC driver
> > > > > > is named as "mcf54415_dac", related to the mcf5441x family SoCs with
> > > > > > DACs (mcf54415/6/7/8).
> > > > > >
> > > > > > So updating DAC clock names to bind with proper driver name.
> > > > >
> > > > > I am not sure I like naming the clocks here with a prefix for the
> > > > > specific SoC part number this is in. It might be unlikely now, but
> > > > > what if another ColdFire family SoC member uses this same hardware block?
> > > > > That is very common amongst other hardware blocks within the ColdFire
> > > > > family. Can we come up with a name more specific to just this type
> > > > > of DAC hardware block?
> > > > >
> > > >
> > > > from a brief study, this 12bit DAC, and DAC module in general, is only on
> > > > this mcf45441x family. There are some ColdFire with ADC only, as those
> > > > mcf5249/53/82.
> > > > The mcf51mm/ag/je are the opnly to have a 5bit dacs, but these are mcus.
> > > > So, if i don't miss any existing model, the name may be correct,
> > > > unless we want rename it to a more generic mcf_dac.
> > >
> > > Yes, I would suggest just leaving it as is, "mcfdac".
> > > That is not currently used by any other ColdFire variants supported by
> > > the kernel.
> > >
> >
> > Ok, will fix this in a v3, just asking confirmation on the name to
> > Jonathan and all, since it involves iio too.
> >
> > Chaches are:
> > mcfdac
> > mcf-dac  or mcf_dac (we have drivers as vf610_dac and cio-dac)
>
> The clock names in arch/m68k/coldfire/m5441x.c are the names as
> specified by the producer side, not by the consumer side.

yes sorry, i confused DEFINE_CLK with CLKDEV_INIT where the driver name
must be set.

So sure, thanks, fixing clock names back as mcfdac in v3.

>
> > > > > > --- a/arch/m68k/coldfire/m5441x.c
> > > > > > +++ b/arch/m68k/coldfire/m5441x.c
> > > > > > @@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
> > > > > >    DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
> > > > > >    DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
> > > > > >    DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
> > > > > > -DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
> > > > > > -DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
> > > > > > +DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
> > > > > > +DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
> > > > > >    DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
> > > > > >    DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
> > > > > >    DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
> > > > > > @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
> > > > > >         CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
> > > > > >         CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
> > > > > >         CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
> > > > > > -       CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
> > > > > > -       CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
> > > > > > +       CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
> > > > > > +       CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
> > > > > >         CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
> > > > > >         CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
> > > > > >         CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

Regards,
angelo

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
