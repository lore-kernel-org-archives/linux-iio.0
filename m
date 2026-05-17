Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D835838B
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009104; cv=pass; b=L8vWOEaSdWfcyQzm04LHyh9I0IH3yvEgirtUSk1MuZHn2FG3OK/4rBHgRZUL+GlV5v1wymMVahwSPLVXvEiQ1NcsBPX1l1DDFfFUeu2rmziESAK0mD5DlrFckDILNX5aRMT0rVgBXhg4tY7f/AQvJ89XMxIhoOJKbdM0OAr8eoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009104; c=relaxed/simple;
	bh=9+gh0QigFMmNglFLKn5RyV4Y2hTZ1gkGy6kLSDD6tWU=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=kFzXhmo2hx9Z0zIMKxgNwIGbBy7PvJ5jKJpnStqPXqioo+/df09srqdopnhG/iBln/hdzvPwK2Mg2I2Kd5YV3piQZRFn2WAsMckduiZeHxt+dzIGmxbve7lxT0AWKwcDDh08y5nZMac3jn7pR+pA5uNjLVTKOgD5raI9KevIbp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=VmbNnWEv; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="VmbNnWEv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd0fc4c336eso292796366b.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 02:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779009095; cv=none;
        d=google.com; s=arc-20240605;
        b=E0UdBQTduEtBjc7FHX9l1n2jeJwAth6Ui0ATC3rk+m2523CcbQuntGpGeRNXTH4XG8
         z5zDGXeRUMgXR3S7dbYIinYfekvrfwhdLsO7tzasgwn47GOX63lhL3DMIdzg2GsfduiK
         cIfSXlLXS191e+lNIopVByzaPEKOGcim1PGcHT6AaT40TgZg6tbS/AmQKttO3K81ThsG
         /b7VnQl7jFcNJ+q9/xRoogvVKK0fwKTxsaUKWYp+amXTMpH0Vyv6UXs+0WKJkAEbrKB2
         w/41YAAO/1TbRrHQUtgPX392JRHSkOusH+gabGTi/I2eORMtNiwyl2XPUdLBbjVAEWT8
         t9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:mail-followup-to:from
         :dkim-signature;
        bh=l422bOv2RS6ft7h5IAvQA7ommw1CO4QZZ8y5UOnu3r4=;
        fh=3QZDJV8oX2vj6OOSCEUwJAJ6JBBoRGWPbHYKlEw/GXI=;
        b=A7Jv/zoRaR5DD38sjknLIorM/PjZU7sMeMZ5AeukQmVPXEsmUW4xv6Q/aVyM4NXCS8
         rTVChrpJT5H5AJ/V9iDz5hvK92vUblXY6bNl47KA8gZwmkmh7vKQOPqjQKp2//2hwQzf
         0/F6qr0+elSxxaCa13ICDRZM6ueJk5fGyg74/+3uquUiwnUAZvc/ImhY581M6mc9qo1W
         L7fnFjaPAwAlkBjxFGyko6jMIbXteDRc3/jTL8mOotOl1RtE3KWUMzZPY73h2GWfzG01
         o9O6prAissQpSZC3MFsAFoKbkfF91nt/XxSQySCaByKVkyBh0wW0dSqh44EL32nDiF85
         IeQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779009095; x=1779613895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:mail-followup-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l422bOv2RS6ft7h5IAvQA7ommw1CO4QZZ8y5UOnu3r4=;
        b=VmbNnWEvnTFdYLcb9x9cuesfZbKXePnmxAkU1hOV2h9ViKagJpTP8/pZIX3pme6QdW
         eWtGdcSz9fLl6zTLi6cXSazpM5FxnDemLyrWsSlHHhHtiiZjzJ+9tdD8w1ql0PcRrmcl
         2gGh8q97kEMEU5CoTrO8MhjLHxpZPw1TL5d0QbEeCvVdM2hiPPL9DeAOSNfAPl4zUAW1
         WXemEeytTmulc4ory1UZs5+YfDnS2hD/WPyfZ+24125ErEZhzBAY3hI9pi5GU9scqJiQ
         DWFI+YI26yLRAdwNsfnJcHN84Z6kBIoC9OGyCsm9hukE0Kt3867IFqdIqqnQikHNwG59
         l3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009095; x=1779613895;
        h=cc:to:subject:message-id:date:mime-version:mail-followup-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l422bOv2RS6ft7h5IAvQA7ommw1CO4QZZ8y5UOnu3r4=;
        b=IaFVX5/nGFLR0yYpgd5yTTtFFh9y1i6y7K47bo4gKpm7zGrnr6TPyKKlO/lkWf9j9E
         WrQHyQqlzN5JEd/tXqwq7NCZeatLhgrb8iEMwW3mGHiOkl7W36Bide93LhrKXBrFRisu
         IHru/V/oNOn4jkiyKTjmW6jbDGLTWgO5iMbzCQqu+BJ06p5NHbm7adVPAKk6bXiVC3ah
         ZK1Quzme4wGdPXMC2AkMxbw5NXR6H8nbN3zC+ZOZVXIEvMGXxXm6UfBAmDchgkjbooZe
         XYzTan/N1kFKxdtXPNLoqDKeB8E8V6X5KU5bh8jz+k1Qx2wuUCIHAjM+Asyo0/POWdhc
         lW1g==
X-Forwarded-Encrypted: i=1; AFNElJ/JjVoB00+Hq3+7dfY89seWhk1RUwQNlK2ydzFZOhpZ8x5/dxlBv3rPQ7xCeIiWnHWNZXk6/O9K4qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRMMf2M+BSJ/N2FYF1fYrY9XeqJoNTIiPUnjXTItIvNE+3LAf
	Ptag130PRHbJwfboR6uWfl3AiDUZ+41ie6zHTD2Jmxj5NzU7l94edSdlW1rnvZrBKvg7wp5BvXZ
	zNgmWadv9Y1qmkReNMp/XjofrdSY7T1mKiD3x+r6WHA==
X-Gm-Gg: Acq92OHBqEhKQ6qpMazBb9rvPMcz8vYaMk8b53RTbqZ+WyARs6GMZ4t3Rn/f66+YDZo
	sskk5FTMFfI5cEr062mCBC1hRGZkVUR4dNnrdLbf6qZevMC0lgBTRS70aBQ4Vh8jHAzenuubKcO
	YD8jXShi+ntxeeTY/izEm8hQXc37oVMVoTIhI1/CDrpnZjw+9WpvxNNn5rKvwttGRu99Fim/OPF
	pEsvLGh/YmbD5d/NyXm7dX1NuiV4/s9+f6b67JGDP1V3nsvMAayULKyfGRwgK9M3ytywacc7nqJ
	F4G6UatoTs2QOUXhuqWYV7h6PmH3a2acNOGL
X-Received: by 2002:a17:906:ee83:b0:bd4:d6d6:b4bc with SMTP id
 a640c23a62f3a-bd517909091mr528852666b.27.1779009094955; Sun, 17 May 2026
 02:11:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 02:11:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 02:11:33 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 May 2026 02:11:33 -0700
X-Gm-Features: AVHnY4LQJhW2f1YyqOOc8oHDFb0_rhPBBBuqz4UdC8WHi2UPdjOoJsNG-CwUBBU
Message-ID: <CALSJ-wAqFni+OwSUcQS+KESfe7SbWMxc0aCURHtTZ93Rx6GZhw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
	Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

jfyi, for some reason i was not in to/cc, but i could grab the message
in lore.

On Thu, May 14, 2026 at 10:54:32PM +1000, Greg Ungerer wrote:
> Hi Angelo,
>
> On 14/5/26 17:05, Angelo Dureghello wrote:
> > Hi Greg,
> >
> > On 14.05.2026 11:27, Greg Ungerer wrote:
> > > Hi Angelo,
> > >
> > > On 13/5/26 19:14, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >
> > > > Later in this patchset, the mcf54415 DAC driver is added.
> > > > Considering some other different ColdFire cpu DACs exists, the DAC driver
> > > > is named as "mcf54415_dac", related to the mcf5441x family SoCs with
> > > > DACs (mcf54415/6/7/8).
> > > >
> > > > So updating DAC clock names to bind with proper driver name.
> > >
> > > I am not sure I like naming the clocks here with a prefix for the
> > > specific SoC part number this is in. It might be unlikely now, but
> > > what if another ColdFire family SoC member uses this same hardware block?
> > > That is very common amongst other hardware blocks within the ColdFire
> > > family. Can we come up with a name more specific to just this type
> > > of DAC hardware block?
> > >
> >
> > from a brief study, this 12bit DAC, and DAC module in general, is only on
> > this mcf45441x family. There are some ColdFire with ADC only, as those
> > mcf5249/53/82.
> > The mcf51mm/ag/je are the opnly to have a 5bit dacs, but these are mcus.
> > So, if i don't miss any existing model, the name may be correct,
> > unless we want rename it to a more generic mcf_dac.
>
> Yes, I would suggest just leaving it as is, "mcfdac".
> That is not currently used by any other ColdFire variants supported by
> the kernel.
>

Ok, will fix this in a v3, just asking confirmation on the name to
Jonathan and all, since it involves iio too.

Chaches are:
mcfdac
mcf-dac  or mcf_dac (we have drivers as vf610_dac and cio-dac)

Regards,
angelo

> Regards
> Greg
>
>



>
> > > Regards
> > > Greg
> > >
> > >
> >
> > Regards,
> > angelo
> > >
> > >
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > >    arch/m68k/coldfire/m5441x.c | 8 ++++----
> > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> > > > index 5b5e09ecf487..b724d7fc1a08 100644
> > > > --- a/arch/m68k/coldfire/m5441x.c
> > > > +++ b/arch/m68k/coldfire/m5441x.c
> > > > @@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
> > > >    DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
> > > >    DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
> > > >    DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
> > > > -DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
> > > > -DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
> > > > +DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
> > > > +DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
> > > >    DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
> > > >    DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
> > > >    DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
> > > > @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
> > > >    	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
> > > >    	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
> > > >    	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
> > > > -	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
> > > > -	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
> > > > +	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
> > > > +	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
> > > >    	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
> > > >    	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
> > > >    	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
> > > >
> > >
>
>
