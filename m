Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31766488210;
	Sun, 20 Sep 2026 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946766; cv=none; b=u/thEVBett5wPMtApb0lablNuHoBXLcwFZH0hkyiroXpfu1yb++6Nsh7s05Rmiuz1rO1FWZjC+pWpbN74v3BygjY7SC+PMj6gcW9sC3WVwG4GRP+YDJRWcnTp0S1B3nQTRggA+F8igHSt2v/Uo+pIxt79Ded1lXQiyErtXVjxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946766; c=relaxed/simple;
	bh=FbScpXhMWehUBrX4m3r9npwatVRgC4t0vDoJH4HVE+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKhikz64mz1UAinfVb/+fLXFM+X00O5WNMO6BdOOT5M3vt4hiMfBQtPnuMJ/J6uaZmsbHURUYgJs+8jCopILMbap27I03ZMsTP8maZqz6XNh+ju38D9qkzvNZ9M6jAvmrSHGKIY/GPCfvDDh0mn3huPIWMbo0goNJ01ePk+bzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqV5NwmP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqV5NwmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7401F000FF;
	Sun, 20 Sep 2026 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789946764;
	bh=VpEmr/e3ukCd0czHB3NsTxN/yKr60rTN8HisxDGMEl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EqV5NwmPD3ytRoFsnfM7vY/sXFX0byGf5f75kKNQoxx8WPsdyfr+Hq4EfvSGiTiGC
	 KPwPuSXl4zw+D6QpKXiUu/rJzKVHzbfOFhD+Fpj1v603tNXAwQ5BoQfcDN99JV1V3S
	 vh2OYmlI36y/zqYH3DfucLVYIyf6dymY3aEnR+b0O3emz1xoTAocu+Niez5Okdyk6i
	 43BSBC+haao6gw6DCIMlIQI2BImgtTzGP+gUptrP2K+oSceE8P7wHtksod5sLhqVhJ
	 9ssYb3M+44hq+IK7owZB8EGRaEIrPVuMDmm26gVgksUGbSurM4XjsyvfMhrijQErwm
	 m9XmmpgSqUo9w==
Date: Mon, 21 Sep 2026 00:26:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank.Li@oss.nxp.com, Eugen Hristev <ehristev@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Felix Gu <ustc.gu@gmail.com>, Stepan Ionichev
 <sozdayvek@gmail.com>, Shuvam Pandey <shuvampandey1@gmail.com>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Frank Li <Frank.Li@nxp.com>, Piyush
 Patle <piyushpatle228@gmail.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, "Rob Herring (Arm)" <robh@kernel.org>, Pei
 Xiao <xiaopei01@kylinos.cn>, Shi Hao <i.shihao.999@gmail.com>, Kees Cook
 <kees+treewide@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, "open list:MICROCHIP SAMA5D2-COMPATIBLE ADC
 DRIVER" <linux-iio@vger.kernel.org>, "moderated list:ARM/Microchip (AT91)
 SoC support" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, imx@lists.linux.dev,
 vkoul@kernel.org
Subject: Re: [PATCH 1/1] iio: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <20260921002600.7c3d5630@jic23-hlaptop>
In-Reply-To: <aqzefLjkj6VrLR1b@ashevche-desk.local>
References: <20260917203652.1279059-1-Frank.Li@oss.nxp.com>
	<aqzefLjkj6VrLR1b@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 09:47:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Sep 17, 2026 at 04:36:26PM -0400, Frank.Li@oss.nxp.com wrote:
> 
> > Replace direct dma_chan::device::dev access with the proper
> > dmaengine_get_dma_device() accessor in IIO DMA consumers.
> > 
> > chan->device->dev is not always the device used for DMA mapping.
> > Some DMA engines support per-channel IOMMU mappings, so different
> > channels may use different DMA devices.  dmaengine_get_dma_device()
> > returns the correct device for each channel.
> > 
> > This also prepares for making the DMA engine provider data structures
> > private. DMA consumers should not access DMA engine internals directly.  
> 
> ...
> 
> >  drivers/iio/adc/at91-sama5d2_adc.c                 |  9 ++++++---
> >  drivers/iio/adc/nxp-sar-adc.c                      |  2 +-
> >  drivers/iio/adc/stm32-adc.c                        | 10 ++++++----
> >  drivers/iio/adc/stm32-dfsdm-adc.c                  |  4 ++--
> >  drivers/iio/adc/ti_am335x_adc.c                    |  4 ++--
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  5 +++--  
> 
> Strictly speaking this is two patches, one per ADC folder and the other against
> IIO core. But this one is not a big one, so up to Jonathan.
Agreed that would be ideal but I don't care enough for a v2!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Applied to the testing branch of iio.git (material for next merge window)
That will turn up in linux-next once tests are done and I remember to push.

Thanks,

Jonathan

> 

