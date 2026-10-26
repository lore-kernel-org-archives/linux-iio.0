Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010716;
	b=UMnzRqNxkC6AYGvk2hmxNw75q0Hm0FSazjL73/+ODswi7ylHfujLwqgQD3QqFCNJT670
	 vy29xgIokVASDX+IY7EnxYHh6MJdOohgGwtJ85lqWnu4o714c0Qj0hZesDX1DpkXK1SvD
	 J+2T7uE6mYyhYL+uMoGKeJivvlzXi9WNV87fzJOoU6951jUquOwGvP0+eFT88BB3iR3/w
	 1NDOeC7of35bauWumcjiilSMl2SIWQh4/xyr42UhRG3yk0GimZX565yl8LeH2ZbrFA+Yr
	 4xkxyqNy3gfC8ffjDpUfBzB9Mmu7r8cgByY6qZlafne4pGi1QepjN4CkNXtSH9rUNKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010716;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/HIhGXqA4xP0tvnc3uf9hmSWe+5xRVAu9Rr9DT23f/0=;
	b=y92RVkMAq8apZHkGIOpRCYwHltEkHXLbDMYdeiK6M60YlvYjZOv8j1GPZ5vbTVk7xmhl
	 Qmcde+03JUR4joqZnttLF9rJmBH8sN0OXHxUnjZCpUckn73SLGvXOXPpqV1SJX7zKUYro
	 ag1zbsjF6l+TquFaig3D665HGrmEQ8qWLHcHGBqGTlGKGxly4n/8FWUrVTwVY54qgztkh
	 uFfAKwdJ03OuMSZI9vZhvQB6vY5c8Ef+DDrZtgeVA6rWrF41woWwNBwj3v8q8knRlOr0u
	 rvb7hyVBh/MTLi/Fd1Zf7RHyWRtn461MfrogCXJeTrep1K4sWoqddodnMem0KiyvMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iFwI0wcZ;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE37606A31A;
	Mon, 26 Oct 2026 10:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iFwI0wcZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793010716; x=1824546716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1C5aiI1j1KZosMcIZTJUzOc6KzOLatfEvtaQlkoXwmA=;
  b=iFwI0wcZb5LeHydO+IVO1QDMOZQNVpYF+TQA5eyitvWksfKzQmCUu5TY
   +VEk0ovtZvh+LHfF6SjVL54tqpvmW+QIhALUfmuhuC01RB30pOzMROBNm
   m+Sj4tlOox1ajFf/jhddisgNrWcDPjufiTE12SDO+yAmx139kpfBny86/
   pGsul+nh5HT83JxbN6rrbvDpvKZTQFjB01psbHTmpqL8t/VltgjCA4+y6
   Wtc30ocdWfhO0pqAMzpv9e0LUYzffvnKsx7qS3Kn7gLL5bIjuNtwpxcAz
   Mc1Aj7nSCxCUtIppDw+6GHtajU5Mn5IzlfIZ7CukkmzLBX5ImLzDhCKQq
   A==;
X-CSE-ConnectionGUID: lFCqhDoESceBkIJEN7eh3w==
X-CSE-MsgGUID: DZLvHfopQCqDehXqVHBKrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1686329"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1686329"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:31:55 -0700
X-CSE-ConnectionGUID: wdgDOIzoQRavQaKAgncGkw==
X-CSE-MsgGUID: NuIN92+jR3a4UmobLJdD7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6087780"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:31:51 -0700
Date: Mon, 26 Oct 2026 12:31:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <at8sFe3BzYNTT1DL@ashevche-desk.local>
References: <20261026083631.48406-1-olivier@mgcrea.io>
 <20261026083631.48406-3-olivier@mgcrea.io>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026083631.48406-3-olivier@mgcrea.io>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 09:36:31AM +0100, Olivier Louvignes wrote:
> The X1600's SAR ADC has four auxiliary channels, each with its own start
> bit, interrupt flag and 12-bit result, and none of the touchscreen or
> battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
> driver that exposes the four channels as voltages against the 3.3 V
> reference.
> 
> The registers are in chapter 19 of the X1600 programming manual. The
> ADC clock divider is even, as the manual has it (an odd value divides
> by one less); the vendor kernel writes the divider minus one, which
> gives a slightly faster clock than it asks for.
> 
> Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> behind adc-keys: all three read and report correctly.

...

> +config INGENIC_X1600_ADC
> +	tristate "Ingenic X1600 ADC driver"

Make this text...

> +	depends on MIPS || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the SAR ADC of the Ingenic X1600
> +	  SoC and its four auxiliary channels.

...

> +/*
> + * ADC driver for the Ingenic X1600 SoC

...and this comment along with the MODULE_DESCRIPTION() be the same.

> + * Copyright (c) 2026 Olivier Louvignes <olivier@mgcrea.io>
> + *
> + * The X1600's SAR ADC has four auxiliary channels, each with its own start
> + * bit, interrupt and 12-bit result (X1600 programming manual, chapter 19).
> + */

...

> +#define X1600_ADC_REG_DATA(ch)		(0x10 + ((ch) / 2) * 4)

> +#define X1600_ADC_DATA_MASK(ch)		(GENMASK(11, 0) << ((ch) % 2 * 16))

Drop /2 and %2 here, see below why. This probably need to have ch be renamed to
something else as it's like bank and shift.

...

> +#define X1600_ADC_CLK_RATE		1166667

Is this in Hz?

...

> +static int x1600_adc_read_raw_channel(struct x1600_adc *adc, unsigned int ch, int *val)
> +{
> +	int ret = 0;
> +	u32 data;
> +
> +	guard(mutex)(&adc->lock);
> +
> +	reinit_completion(&adc->done);
> +	writel(BIT(ch), adc->base + X1600_ADC_REG_STATUS);
> +	writel(readl(adc->base + X1600_ADC_REG_ENABLE) | BIT(ch),
> +	       adc->base + X1600_ADC_REG_ENABLE);
> +
> +	if (!wait_for_completion_timeout(&adc->done,
> +					 msecs_to_jiffies(X1600_ADC_TIMEOUT_MS)))
> +		ret = -ETIMEDOUT;
> +
> +	writel(readl(adc->base + X1600_ADC_REG_ENABLE) & ~BIT(ch),
> +	       adc->base + X1600_ADC_REG_ENABLE);
> +	if (ret)
> +		return ret;

> +	data = readl(adc->base + X1600_ADC_REG_DATA(ch));
> +	*val = field_get(X1600_ADC_DATA_MASK(ch), data);

This is the only case when these two macros are being used. While  / 2 and % 2
are power-of-2 based calculations, it's still make sense to have temporary
variable for both of them (see the proposed naming above) and use in a form

	bank = ch / 2;
	shift = ch % 2;

this can be optimised on some architectures to a single assembly instruction
(yes, both calculations). The problem is that they should be tighten to each
other so compiler sees it. In the current code they are go via macros and
compiler most likely can't deduce that.

All the above is based on the real life example, see 9b3cd5c7099f ("regmap:
place foo / 8 and foo % 8 closer to each other") for that.

> +	return 0;
> +}

...

> +	writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_CTRL);

It makes sense to have read and write wrappers that will add adc->base.

static inline u32 void x1600_read(adc, unsigned int offset)
{
	return readl(adc->base + offset);
}

static inline void x1600_write(adc, unsigned int offset, u32 value)
{
	writel(value, adc->base + offset);
}

Also you may consider using regmap MMIO.

...

> +	rate = clk_get_rate(adc->clk);
> +	div = clamp(round_up(DIV_ROUND_UP(rate, X1600_ADC_CLK_RATE), 2), 2UL, 254UL);

Wouldn't it be better to clamp the rate first and then divide with rounding up?

-- 
With Best Regards,
Andy Shevchenko


