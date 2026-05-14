Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942613D7D8C
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743243; cv=none; b=OdvhxrlhPptAatyyxjo0dlV9wyIufhBgNq+txLWBZskfl8EQ36icwaa051tbHh4LNS9m9XJADOOzx1aiAYeXClO5yR1m8Yfiz2SjlmAQhHLJLV5DDwLzKOjyfHlNDo2awL+EU19qb95hM3o671JKv095yh7ZnldXxsdnyrpQZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743243; c=relaxed/simple;
	bh=ZulYaDZ2N9XXIWtdGiKHOKqvRY9okY1TNX4dzGcSjZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnK2GbC7T9Hn/at0zMLRrh2sJrVOzYeXPcZ8/wYQ6g48SK8EMjSUCRQVpxzqkdzANnKvkJp2NUu7g2PTVkqXAkBnJeYBSGEUhRGCXuybZTC8XRr/DkMc0IS1q6HKWtq/gcaFaCpK97aQXEqUAYNvZ2rSSfUoljvEIdQ6i7hWDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=tPhEUh1D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="tPhEUh1D"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e82c23840so37243055e9.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778743240; x=1779348040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojBKerXcsom5YLOUywnRgFuJgAkEyWjWD8C2JpwtbUw=;
        b=tPhEUh1D4DkZGMPerlaVlAQtKP+2wlqlC6D+PHsyU85+wBEdhm1BxSmusR25aOqlQ9
         W0oJut3zr1K69uqk7P7al2vlGQ2UAH9fmjMSrkbKnZ0GvHdw1y3NMpfAaKKd1rs8PdnU
         2f8TyPrHoWkNvNrMMVhpXgxsjZXvigAQvaC4+pqsySG10GJylwvtN5c1PqbK09bqgcLX
         urOi4RNjNNJuAnPlcJaWME86f3o1zX5QdtTCCwjozCmFcKPqynWbv02NyCBviKT18dqm
         h+TAuVNgDA8E3sC7VgrQ/IxhTGx0G5rQZtfmlMczEktY8+8lve3/gspCSqUFUIr/D2XF
         nYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778743240; x=1779348040;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojBKerXcsom5YLOUywnRgFuJgAkEyWjWD8C2JpwtbUw=;
        b=gJHcR+HJj4R2CxAcYgEV33EaAd30xe8VsKdVwhu2TREOxjmGxFBSp3Hmi6HGgs9awK
         m9Vkp8I1FvbWuNGN8mA0wrN4G2hCRTIa5eQCCKPgweIPm4S5xhqvjo1YLDiT6NgqgiiN
         gqjUBEBJajomN6PVr7ih7tRLZmr1LXVoZc4WFCUbChddaWYGW5RzMfsbVfdUBVy+UerC
         zoxvlLU4ou6xoFbfSjh10Yq8JUlr+fg1Df2RFgNIFuemp6to6lFTeIoAJQUuZNxg4gVK
         36ygR7uyoeDRPa/+ZQwPs50s+ADX/adH7Uk321rsH1YCKNTYpkHVsIdcNMBj1jjNJzUH
         s2Pw==
X-Forwarded-Encrypted: i=1; AFNElJ8LvEnYsEmludQCc05DzXnUHpPOwiFi6cVAUgZ/lnklysJNIIXEFXf6Bu2DW9dXXGodu4nbYaU7QF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1t6oXXSxqXZVBzl278+BldLzroEUF4WGRcy1DDPSrjqQRcd9
	jn28vInZ8GQ2pftvCMrMF92oBR02b5hD20LXUJCpmRs0pQyhfCZzNeAm2R9DVsMkKCY=
X-Gm-Gg: Acq92OG2WzucYNNkwzikyxfzp62wMGMLR5m1OZ4caErPQGODxcyg1XhMMjK1X5LgxDk
	Pdr9ihIhGOxbWolBNjmzu7AG362Zsd73b0j2RBWeY5pONPs4Z7FO20R1bHjWGUljjOEOdtY0CBU
	a7UulJHCXgh6cceYGRxlWwN7Lv8OCDapzKxMbikBnXagC3Dypc2BDZkmyVNxgrZzv6BfBI4QJZF
	P769Bi+fxUHng3rVBzq/JLlCBI0SH+pnPss7NaHv8bJZvTaUkpvXpOIVspfNF8+SbXZWt78oKw4
	dEQ5tx8GVpeFYQ1FopWjQ3JNvbBTP0a4whu7N8WmY0xjSKtGti/Qu4w63VZOdYIX1INkSjLSShe
	uy1/afJKWXg7trIWur0mY/f3CjMkazFYrBQ5Ss6tyNf8Z9Zh9hfEJjMwnfZaCS73BjNf3drINLK
	HsszQ4VoYEhMm5vDFHN86A1QHfP8+/MlBTP6vr
X-Received: by 2002:a05:600c:1547:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48fc9a02785mr93973495e9.5.1778743239978;
        Thu, 14 May 2026 00:20:39 -0700 (PDT)
Received: from archlinux ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdc6f0ab7sm22461275e9.15.2026.05.14.00.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 00:20:39 -0700 (PDT)
Date: Thu, 14 May 2026 09:20:38 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/11] m68k: stmark2: use ioport.h macros for resources
Message-ID: <cabngw2wuxh7cfx4cw4ik46dmxs72u47jyo6hcwgdd7a5whny2@dsp4cysetarw>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
 <agTcoVbImqMgfQy5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agTcoVbImqMgfQy5@ashevche-desk.local>

Hi Andy,

On 13.05.2026 23:18, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 11:14:33AM +0200, Angelo Dureghello wrote:
> 
> > Align also other resource declaration using DEFINE_RES_.
> 
> DEFINE_RES_*()
> 
> ...
> 
> >  static struct resource dspi_spi0_resource[] = {
> > -	[0] = {
> > -		.start = MCFDSPI_BASE0,
> > -		.end   = MCFDSPI_BASE0 + 0xFF,
> > -		.flags = IORESOURCE_MEM,
> > -		},
> > -	[1] = {
> > -		.start = 12,
> > -		.end   = 13,
> > -		.flags = IORESOURCE_DMA,
> > -	},
> > -	[2] = {
> > -		.start = MCF_IRQ_DSPI0,
> > -		.end   = MCF_IRQ_DSPI0,
> > -		.flags = IORESOURCE_IRQ,
> > -	},
> > +	DEFINE_RES_MEM(MCFDSPI_BASE0, 0x100),
> > +	DEFINE_RES_DMA(12),
> > +	DEFINE_RES_DMA(13),
> > +	DEFINE_RES_IRQ(MCF_IRQ_DSPI0),
> >  };
> 
> This conversion drops hard indices, would it be a problem (for example,
> some code modifies the fields based on the [hard coded] index...)?
> 
> If not, perhaps good to mention in the commit message and move IRQ to be the
> second one?
>

i can't see any directly-related code accessing these resources by index,
so would not change this if there isn't any risk. 
Also i see DEFINE_RES_() stuff widely used in other arch, so thios make me
think accessing by index is something wrong.

> -- 
> With Best Regards,
> Andy Shevchenko

Regards,
angelo

> 
> 
