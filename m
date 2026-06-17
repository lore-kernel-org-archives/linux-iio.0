Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8739280C;
	Wed, 17 Jun 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689441; cv=none; b=RXro5d7Ox7d3HSYDoVAv85g1OIaU76ULrWQW+F2jKpLH1ey8JwKRuna906NkAdNUiOVIFeydtHxo96U6fe5o41rN3Z0BWg52M0dluOiutQs+M2PgA1O//fDwnFxGCrwq1e6zhAYLFA2ReWP52JkWJwMYbabQ3maPI+3m6B+BTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689441; c=relaxed/simple;
	bh=PJRUrD9zZfvxEp95vYDkf9Io499+vXWD3N/tqWUsuhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ7hUX7sz93RlX/NcVEQNZCG5Q9k46PUB1/fRA3DJAhJneswpWs/JNJM85lX1pUoo+9i6ZZVpAuaBvSf0ZpPU8zBxVAUF2GAbwsrKeZTxj3EVFJufuArCx3eaN/qWy3CNbZioMTcKwvvY/u7mNTw0NQgmR4GGNbAcBorz6Eahog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0jo7Afj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0jo7Afj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781689441; x=1813225441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJRUrD9zZfvxEp95vYDkf9Io499+vXWD3N/tqWUsuhs=;
  b=e0jo7Afjy4mEvIdYxxqvo+Nucp73Iec3Ygrvu9yYAcodfRTNo1/abY81
   +79eyVc+RK6xPcOhEs7yf5te06xlq4oPrfVneAGDMnxWMpmMWSuDbN95E
   5oHGGBIh0KYcasV020dX3b26DYyx/jzC5V799+7xQAFME97BgD8GH4FLx
   4XOjjpwSyZOlGHi56fMIMBZwyk7rJitFC1HwKENn32UDZRB1/6ZMrc5yU
   FP1AyIW/uPhcC4ANtf2Fktaqdx6xoG7f8pruEVUEI423/02bhAHb/OCpM
   0BVYVSL8W1IXxvAOc9AUCNIfCkCc1IkKUYnrgVhQ2hveviZICotUv0oBo
   g==;
X-CSE-ConnectionGUID: KOLyGQLzSW6Z1etfhObGAA==
X-CSE-MsgGUID: g0eiS3sKTZ+Ziuij7TMjUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82534251"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82534251"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:43:56 -0700
X-CSE-ConnectionGUID: KqEF+XwPTGGdSxcdFhXqFA==
X-CSE-MsgGUID: zVMyIUsrS06+OMMQYl0JoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="246888272"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:43:52 -0700
Date: Wed, 17 Jun 2026 12:43:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v3 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <ajJsVdQPdkpfIyLG@ashevche-desk.local>
References: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
 <20260616-mt6323-adc-v3-2-1c27c588185d@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-mt6323-adc-v3-2-1c27c588185d@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 05:15:40PM +0300, Roman Vivchar via B4 Relay wrote:

> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
> 
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.

...

> +static int mt6323_auxadc_prepare_channel(struct mt6323_auxadc *auxadc)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(map, MT6323_AUXADC_CON19, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* The ADC is idle. */
> +	if (!(val & AUXADC_CON19_DECI_GDLY_MASK))
> +		return 0;

> +	ret = regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19, val,
> +				       !(val & AUXADC_ADC19_BUSY_MASK),
> +				       10, 500);

Still can be amended.

	ret = regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19,
				       val, !(val & AUXADC_ADC19_BUSY_MASK),
				       10, 500);

(no need to resend just for this).

> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(map, MT6323_AUXADC_CON19,
> +				 AUXADC_CON19_DECI_GDLY_MASK);
> +}

-- 
With Best Regards,
Andy Shevchenko


