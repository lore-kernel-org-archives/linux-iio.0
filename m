Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1946E010;
	Fri, 18 Sep 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754066; cv=none; b=ffBYZsZ6kPh2ZePPOBiwtB/q+yg/AGJTeNO1+u5rF0DsTHDf6li/6zw+BzX6UkpWd+ZE3z3QHnn206DNRz1yV8/eFP0pdsScp5cM5QHnbqsr65yoLMDXu2q7DH17f6j4lttBkg4mpTnPif+4RSCAFJwtl47y92HKzQJDq3dn7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754066; c=relaxed/simple;
	bh=prij5PCUdQoil0rbyeqHDx5N+IveFQtqry9v0buczzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXli3Ca6H+aXqEFF3859NuL75P/A9AdugHV59b2rMX2xg1QpjeLmixTYvkiLYtU8qtpXlJL8cXrredub6qbn3fgx0+VFMHKjIKOAOTGsd2EyOnxtjEIeWGYUi5Ay+V33VA77sL+mXN3xEHJ+rRXC996zSFTHFgMcN/6GCo91HPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klb0wgBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klb0wgBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE0C1F000FF;
	Fri, 18 Sep 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789754059;
	bh=jf1Sg8JZNv68DkLQ9YM/PpRyl/DdqtnqTNtVqMW7pCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Klb0wgBf/SLgWj8gfV4cN6tyX52Ht6NPmHY80Oiah1HnBqO/OyUciZTIDi9BkPFl+
	 kVtM4MDrwL3iJ+Dk/0t3AaAekBg9bRyzcdefzbxTjxuIEhjb8dcgDVZPk9jdRN7OdI
	 LMGZig5sWRuoHAiWPcr+7SpWNuYKQHu27i4Oj2XHabTFt/dxwR3ueBfq3VstKbxvyC
	 AdTWPXpOPqP7ncNnv7LeerbxTpIM5NuWsruvwllc0f4393t8cH2oYPxlos/dV9NO5x
	 dI7koVgdfW93gUCUPDUTUS2xQtbdNyDCufvoJUpFbuz/kdK/aX6pyvQl6zfm5KCgdj
	 zRxyAidCalLFA==
Date: Fri, 18 Sep 2026 23:24:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Eugen Hristev <ehristev@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>, Stepan Ionichev <sozdayvek@gmail.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Frank Li <Frank.Li@nxp.com>,
	Piyush Patle <piyushpatle228@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Pei Xiao <xiaopei01@kylinos.cn>, Shi Hao <i.shihao.999@gmail.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	"open list:MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER" <linux-iio@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] iio: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <aq16x3gAOIslmNE4@parshuram>
References: <20260917203652.1279059-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917203652.1279059-1-Frank.Li@oss.nxp.com>

On 17-09-26, 16:36, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() accessor in IIO DMA consumers.
> 
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
> 
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.
> 
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
