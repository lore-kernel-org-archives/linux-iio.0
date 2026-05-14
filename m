Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECC3A3E94
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742318; cv=none; b=GHCSpJeIAUUmFHe4KxsRW6MLO+tJBExvBLhV2KZblR0/ireowbNABuXCNndZFsX9bqpunO0nE7teXEZKjYvNoiGWQfFoBMY86R1Orz7h4cpNX44OXK6ncQpmarx7aSiTtsdgz/xwsjogkwLXr4GLA9UHetqGbGfPGjg8XSbLkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742318; c=relaxed/simple;
	bh=rgFCXaiUGdzul7ROj3/Th0U/wrS3D9xf5VgX37RsF7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXvokTstlmC6rADAXaNxY/8QDhB9pzaDhs2KLazgrspTqOwNvJ2ahTRehlZtiWDU69hFjarHSdDWSTGzf0HIBulXkNrAy3xhYlwSmVyqMpuSgwKFavnegX8niyfa/kP2u3IOveQt95CBa2HCQhBc6giERGZ7nnefnAVQu5piogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=T+6vC2yG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="T+6vC2yG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so46844755e9.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778742314; x=1779347114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJwj6Gg8AyMk563HlPprgVFnntCvbQJUPOML6jrMsks=;
        b=T+6vC2yGFsfuOdgq0XCcZ9iuMTFpAH+Tm83B+98O/RO38gk1nl0YvoVQClrlWfzMpj
         MbBig+NdGhVt7lelupMqN4BaOlXy66/b7f8kNEXATARWEZG4RmFmwy/n9PNo63le9fmU
         sVwUxY4RVnqw/8Je+7rQG3SfyVLlNCbsPzk7ZWYJDUJEvrp9O46BmK/ALEoWF/4CXwP9
         UcC0wn1vr4UpEhMzmPj0MufuUZhEZTYRZsm0ZH58GH+ra0CJtmYe9B/kZueFsjpsZ1v/
         wwWPH5TqVKOCaTlDRTqt1JIMdjlthZfluXS2lKdqqiPE/4n4DUChvO4kPE88j1jEcQYV
         CYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778742314; x=1779347114;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJwj6Gg8AyMk563HlPprgVFnntCvbQJUPOML6jrMsks=;
        b=GA67VDr1IAXbb6+BAQVfRaDPykRMDilKBlmQONFWG7kgACcaea/LC7MLvB83//JT0m
         mWiEYmYnEqy+49TooqwJb5/Xg1H84UFEuqXc23Ydo8FNwnN28Qq3/L0qFlG1IeWJT7Ao
         ZyjPzyUCjKiO66egxGnpjBlJ/DJDZ8Wi7BQkQ5Qz3c9lVCiLZl8ItNudjKbfk0INqoke
         RixVIeoIxVCDu9wGKMzeQEJdeOssdRexEC2gsMc81yPSJJ9AImDtnNKzfXb7D/kLBZEd
         B+QF+jAzH5MTofLe6ovSDVcZsUYiHj76ULr5rCRVYxotYqWkbhUyoIUOeNRKXElGnQO7
         dxgg==
X-Forwarded-Encrypted: i=1; AFNElJ9QHTRfzGaZFIHFTbi4K3tYD+hK+q8FVkxicGluydv82plQy7nBAGIko5NK55XEv/er6wF6mZKefjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmryA+pQCvsonW0K4xMgOwpTdw3CcGtijw7xKyhCila8P/2Rg
	yKoa5LnHEt4cKvskzf31bcNUJTZnxPMpw+tdxjNYigxUGT1AtQxuA8URJ7sqNNlrKbg=
X-Gm-Gg: Acq92OH9HFUnt7eg+d9eF9xy7+viDrECOYGyCTUzmLKOjjuZW07IyQDzMBWYcLh3p0q
	aYNXOXue7Sb/8IUsTfigZy+JuxtuNzazxWt6ayl/1rsz86bKQsdhDbFvZNP6fRedWtmiAbCQBiV
	0Y1i+mkQQoVzwnDrbWmEmBDYQIO2XZVLRodon3xX3YRnl9wcH2CBM+54irK4gLNgzjO3nTnPdiy
	tT245VVI/FlfPlfjxfV9JBHw6gdHQx/ExPTSskR8Nwrw3wy18+sG7/sBDnzR3r+vZachfgvYVFn
	LE/TfN/Kax6ozDhIV7UBHplQ0O3xL9tl8HKjg1/nxjrdkfeKcxVhimAUTDgFpjErNQbR8DfHnBK
	AqxT8+YyAN+Pn/0hkE/WXXYcbgYnRaZ+W5XZcW54bC6lmTBDoU0c9nC+nvusrOqjk+kyRPkEHbC
	PnWFb0w4zYwo9UeLgORKB9e7UTkg==
X-Received: by 2002:a05:600c:41c7:b0:488:a502:8955 with SMTP id 5b1f17b1804b1-48fd6325dc2mr20118035e9.4.1778742313527;
        Thu, 14 May 2026 00:05:13 -0700 (PDT)
Received: from archlinux ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm4041073f8f.3.2026.05.14.00.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 00:05:13 -0700 (PDT)
Date: Thu, 14 May 2026 09:05:12 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
Message-ID: <ugda72734f6vn67jp6cz6hpkif55a5m4yey3yo2dswicqbyrdx@zk4lhc7k4dxu>
Mail-Followup-To: Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-3-fcdae50cf51a@baylibre.com>
 <734e2323-78dc-43c7-b5fc-0a35cc72e035@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <734e2323-78dc-43c7-b5fc-0a35cc72e035@linux-m68k.org>

Hi Greg,

On 14.05.2026 11:27, Greg Ungerer wrote:
> Hi Angelo,
> 
> On 13/5/26 19:14, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Later in this patchset, the mcf54415 DAC driver is added.
> > Considering some other different ColdFire cpu DACs exists, the DAC driver
> > is named as "mcf54415_dac", related to the mcf5441x family SoCs with
> > DACs (mcf54415/6/7/8).
> > 
> > So updating DAC clock names to bind with proper driver name.
> 
> I am not sure I like naming the clocks here with a prefix for the
> specific SoC part number this is in. It might be unlikely now, but
> what if another ColdFire family SoC member uses this same hardware block?
> That is very common amongst other hardware blocks within the ColdFire
> family. Can we come up with a name more specific to just this type
> of DAC hardware block?
> 

from a brief study, this 12bit DAC, and DAC module in general, is only on
this mcf45441x family. There are some ColdFire with ADC only, as those
mcf5249/53/82. 
The mcf51mm/ag/je are the opnly to have a 5bit dacs, but these are mcus.
So, if i don't miss any existing model, the name may be correct,
unless we want rename it to a more generic mcf_dac.

> Regards
> Greg
> 
> 

Regards,
angelo
> 
> 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >   arch/m68k/coldfire/m5441x.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> > index 5b5e09ecf487..b724d7fc1a08 100644
> > --- a/arch/m68k/coldfire/m5441x.c
> > +++ b/arch/m68k/coldfire/m5441x.c
> > @@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
> >   DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
> >   DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
> >   DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
> > -DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
> > -DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
> > +DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
> > +DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
> >   DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
> >   DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
> >   DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
> > @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
> >   	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
> >   	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
> >   	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
> > -	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
> > -	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
> > +	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
> > +	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
> >   	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
> >   	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
> >   	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
> > 
> 
