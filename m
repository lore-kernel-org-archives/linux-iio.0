Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897D1367;
	Mon, 29 Jun 2026 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713136; cv=none; b=rM3xk1YBe6PuixQUOGDxARgP2QTVDM4wslsRpg4Y2EIbzJShsgXWNQ+k4i5d4BzT3M7PT40RXTVx50wTvZP0la1YaYA3dIViHWICq1ppPbf3EC5Iqr6++gxTWPrs4nwcNDlu5PuXwwhvkKUvWR7xYePijEIbJdZR/b5+A+jtvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713136; c=relaxed/simple;
	bh=iY967g1ZEXuRDMEeq8Z98MT4WkdJAVc0EMew914JPwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy3Y4yaojnCxSK4YvQdM948kEVHHSMRtqNb7RcQnsERQ0RUz9AcmN/MYHxdQdxkU+7c9zxPtTDR8pCgyv0cvzgo/LehpddYDf25LwvRF/6oiedbklxO5SGba3289vitpUNi5uVY1PcKZKwkL94DckiuovplRSMivaScJCgdIOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9MxmW6d; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9MxmW6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782713135; x=1814249135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iY967g1ZEXuRDMEeq8Z98MT4WkdJAVc0EMew914JPwE=;
  b=P9MxmW6dLV4eJc3E8uf5q7Us5e9C4MmxEncMfuhUrVbhP3xZxBmYYMX1
   7GYAhmVD/i5lekgpUdQpg1q5sBfqaj9bwqWjHyBBR5tlVasHIWMA/f4Zn
   1emzCrId0XdooeQ797cfDFCU+KlfEfqvOZ5I5WUDXJ3x3ODebVFGKapyB
   E/RHdvC6kAgi41HnE+iQ33UmHlYb+FkbEUQNk39poazZtTa3mR6szls0Q
   SgpR3F2T+JbfYUlBH2gYp3uvx0Ky1WHBM2UbKxPy4m0Z1dt+xmC/GScF4
   loHdMEv+EX6z46K6ucnTieYfeBo9Qfhmmk4l5A/TVzs2ERLhYRiQain/J
   g==;
X-CSE-ConnectionGUID: FcQH+UZpRKGPgIxLfYJRng==
X-CSE-MsgGUID: 1OlsZtXJTByaSZPtkJFnIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83533033"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83533033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 23:05:33 -0700
X-CSE-ConnectionGUID: X2Y08qLLQWiV8H/vMCy++g==
X-CSE-MsgGUID: r9Evo2xCRPm5B0mtFMWtOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="252000444"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 23:05:30 -0700
Date: Mon, 29 Jun 2026 09:05:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: David Lechner <dlechner@baylibre.com>, Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <akILJ0zG-g8rMzts@ashevche-desk.local>
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
 <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
 <6770a7af-06cc-4240-9b20-c299e7080ab1@baylibre.com>
 <b06005e0-b7bc-4967-ac7b-cb170219f131@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06005e0-b7bc-4967-ac7b-cb170219f131@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 04:33:00AM +0200, Petar Stepanovic wrote:

...

> >> +static const struct iio_chan_spec axiado_saradc_iio_channels[] = {
> >> +     AX_SARADC_CH(0, "adc0"),   AX_SARADC_CH(1, "adc1"),
> >> +     AX_SARADC_CH(2, "adc2"),   AX_SARADC_CH(3, "adc3"),
> >> +     AX_SARADC_CH(4, "adc4"),   AX_SARADC_CH(5, "adc5"),
> >> +     AX_SARADC_CH(6, "adc6"),   AX_SARADC_CH(7, "adc7"),
> >> +     AX_SARADC_CH(8, "adc8"),   AX_SARADC_CH(9, "adc9"),
> >> +     AX_SARADC_CH(10, "adc10"), AX_SARADC_CH(11, "adc11"),
> >> +     AX_SARADC_CH(12, "adc12"), AX_SARADC_CH(13, "adc13"),
> >> +     AX_SARADC_CH(14, "adc14"), AX_SARADC_CH(15, "adc15"),
> > Two columns looks a bit odd.
> 
> I will also reformat the channel table to one entry per line.

I think with a new approach David proposed, 4 per line will be also acceptable.

> >> +};

...

> >> +static void axiado_saradc_disable(void *data)
> >> +{
> >> +     struct axiado_saradc *info = data;
> >> +
> >> +     writel(AX_SARADC_GLOBAL_CTRL_PD, info->regs + AX_SARADC_GLOBAL_CTRL_REG);
> > People usual make read and write wrappers or use regmap to avoid having
> > to write `info->regs + AX_SARADC_GLOBAL_CTRL_REG` so many times.
> 
> My understanding is that simple read/write wrappers are not always
> preferred unless they provide additional value. Would switching the
> driver to regmap be acceptable here to avoid repeating the base address
> calculation?

This is the value of transition --> having that register base to be hidden and
not repeated all the times.

-- 
With Best Regards,
Andy Shevchenko


