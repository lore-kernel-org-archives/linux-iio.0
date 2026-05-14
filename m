Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253F3A7D72
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742916; cv=none; b=Y/SdRj6R7saySS7GGmvhVUsHwbvTUNG0KmbZC4Itv74b0GDI7LtTQlynN0rpyxXUfgkOgaAnfbl9AtzYluTGyfnWshLNFt0aoe1ZRovh5L2GI94j2qdC4N1yvCm880fqAo9uaRxa3cMba9xxlNCuEoOXGve/1aX7Mlc0rKkFYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742916; c=relaxed/simple;
	bh=l+NFTLiwTFo0Y0mDMz8N3XAktp3gRZfqvr2Jmi+ta18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBRsF3dEJn6OlKhfzx3eCYXHZKv/vs7nfip1cGLQnwqabUGE1/9i3U/cp8AFonQ+jjNdzsTVS4gWnULvw2pAwRJcB2FccasCXCfPXKMgrqMXtMOacRY0B/Hrp4CTZiX7T0ocQszQbVXP1KRasGP2EKDsxcyg9e9Z4Nul9vbzpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kPPUTtSY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kPPUTtSY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44a14580111so5564837f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778742911; x=1779347711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb1yUNLCTgn66O03RLwbPulTwZS1mMXYrlXUWjjfA8I=;
        b=kPPUTtSY4tPVs1yng0X/ZXIWLCWeGzPVJeFJdO8FcymRD2bXI8ShMkAgVMM1NH5LVK
         YwZXXEFh1/OosAwd8KiduMim++cP7aPoTV0aIbgaeD3fNS3s2Bah6WXqztsGHlvpINM8
         xWhz/aj9qNsLugEi6G3ftD6i45mWzBdbWrueud7NNW0ew/tv5dZDJSlFEwpEvnimwF2b
         tRAtdoQmz7PqWOVVF0rMXCgDXjn6OpPZZnya5oX27Lf3m/W7M0XfR1hh1juY/O4Mwr57
         mNgSWB04R/tmImOs5Tm3c5SrZUhGr0B0LTLOlQoOLUTyro5xT0KGsbz90aq6LsCXeOqp
         gqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778742911; x=1779347711;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb1yUNLCTgn66O03RLwbPulTwZS1mMXYrlXUWjjfA8I=;
        b=pHgwmqtkh43kejfT5MtEyNSSWpzPss4J/Qvv2edxpLH1q1I97+uxe30mEN3NEQiC4W
         oYKGnQ9+2jhlkP2mYwCGctKglFElNtZmit60YesBr3cLc7Ta07tMzzSeDsYwApTigEay
         z9QrIYzmCqoi4EcB4nrsiPW/Ry5YTaERF4eAW4oYCPZaJdCcYk+DR0/O9zmh6Eb19+I1
         btGrGHwzlTdjBhABYdVq782hmW288mZuhbbnNCm0jfnuhzr25bauBXOnIFX81FYuO0NA
         Od+ytlbSANhRlcOMK0oeCAXSWRbxOrnhdey8aMrDgETt0ed5OJaBLD9DzbjQBDRFk0z+
         Aizg==
X-Forwarded-Encrypted: i=1; AFNElJ+ST2fdARXBii9FRs9H7oRQQUAH9BQT4hRK+xJvJR5R+bSdX068s0N9kPBHGC+FD0fy80l5CaW/VlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1fqgdPQ0cI0ah0ammGKrJxu7qUi7KeslmdGD88JiCHbyLxV9
	3Vk6cjPsP856WoaNZ2wd+A9ZpmgtHIdYPT77tOB0hGIXI7KdKpRrpVlHwQcmIUhzY4c=
X-Gm-Gg: Acq92OEAGerA0VLzJGpZ9H2Gq3sJsyOFAPD4woyJlaDHjmRF0v8Uw3aGuxKuqCBziz5
	K/DCOf/tKbexe1hMqT2NJErHjezza9pZtMoB0NrFSg0EWwpT5q1iRIWO55C9K0A2BnNFwpDdW0N
	MMzSeDvo+B5PIONZSoK3NRFMGKYSFDjY/fQkeFLHwrJsx+sWihZRNeiqLHICOLqvrKdqypkFnLi
	PBZcfn26Pwz8SA34umq0f88TnByc+hZ30yWNax/W9eQ+JeSRhlrbvK92WMJwRgHH+V7QQR3QIG5
	Z/U4vTNMDLbDqgEf3nwDoumAyob3u9AwRD+BfDujpe24q85Aqo8d8bRosKfVdX7IgZlr6EX4iUA
	/Jo+reCIDZNuO2G42qd0UMd6oMqHXIuQV1Me9F3hvvCSj/g3uJMfBEjLPG6fiYLFk2duydh9d9N
	Uod08s1iDlMKlA5yuEclWpOVwxTg==
X-Received: by 2002:a5d:588f:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-45c7814a552mr9697538f8f.11.1778742910811;
        Thu, 14 May 2026 00:15:10 -0700 (PDT)
Received: from archlinux ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a666fsm4327136f8f.36.2026.05.14.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 00:15:10 -0700 (PDT)
Date: Thu, 14 May 2026 09:15:09 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 08/11] m68k: stmark2: add mcf5441x DAC platform devices
Message-ID: <y4zg2d5zghoz3miqevutiin5swfnx5y2zew2zlv4jklxsyly5g@sxeyvth2tkrk>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
 <agTcEECgJvBydhe2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agTcEECgJvBydhe2@ashevche-desk.local>

Hi Andy,

On 13.05.2026 23:16, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 11:14:32AM +0200, Angelo Dureghello wrote:
> 
> > Add mcf5441x DAC platform devices.
> 
> ...
> 
> > +static struct resource dac0_resource[] = {
> > +	DEFINE_RES_MEM(MCFDAC_BASE0, 0x100),
> > +};
> > +
> > +static struct platform_device dac0_device = {
> > +	.name = "mcf54415_dac",
> > +	.id = 0,
> > +	.num_resources = ARRAY_SIZE(dac0_resource),
> > +	.resource = dac0_resource,
> > +};
> 
> It can be
> 
> static struct resource dac0_resource = DEFINE_RES_MEM(MCFDAC_BASE0, 0x100);
> 
> static struct platform_device dac0_device = {
> 	.name = "mcf54415_dac",
> 	.id = 0,
> 	.num_resources = 1,
> 	.resource = &dac0_resource,
> };
> 
> ...
> 
> Same for the rest. But I haven't seen the followups and don't know if those
> structures are going to be expanded. The commit message doesn't say anything
> about that. So I assume my suggestion valid.
> 

no. They are not going to be expanded, anyway, is there a real gain
using an hardcoded 1 there ?

Would not reissue a v3 for this honestly.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Regards,
angelo
