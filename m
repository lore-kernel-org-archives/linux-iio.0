Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF275339391;
	Mon, 10 Aug 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386456; cv=none; b=KKGKvizC4M8x5Q9X+2o6pOsfpfThw76RLAttIkTkFcY2SJSqXqSn4PyLg3DveeYQl68pOQR7nJhqPsQ3oKKJ5I95+YuimdIZ3cdSUY4OcU8035WHc0jISrlgOtuFbqlgkbzNpPfacqy4+Mhs4AclZVMc10T0sa2ZSP9yF7QiKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386456; c=relaxed/simple;
	bh=8h7g0wplfTmMtiDtt71tGq38X0APIXuCqV22D46BWvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYqnhfOGvEqiEZzhcaOf2an2UVYUtHg7KkfKD0pslE6LltsmAopJ2Uqk9eJw9v5Z6KJ98PODreGlhDnHq+stffo/tlMDJgm4VBR4tARHO34KUluD7IwD+qQU0skcmDdMrIZNPNpnDeBkJwdck0zJ+L3imLWzTHHPXBgwoJYkC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bONE1qHH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bONE1qHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786386455; x=1817922455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8h7g0wplfTmMtiDtt71tGq38X0APIXuCqV22D46BWvQ=;
  b=bONE1qHHTBQltxV+HPUlJBP7aD2FGVtnZmx8Q9Ot0JMju1g6lpedbJY+
   2WHXnK2Ekf7OnzfxdicluJnAwrh5qTwnr+qW+L6IO14tYzmcGefAYBvIP
   4b+ECuY/SKJvSm8mHT7MAxZhnpF5+Ftz03i4mA0TbBwWi6K+gVggaFk2+
   YmHuRk6h1XFaSC1ZBqm79YC5yrAHcmTABRm4w0SrixB/eoP/e70xvJW5Z
   hcK2k+G7SopBFtdPwJC2ZbfPMrwHw3Q/vTSc77ZJfK/UnpPper8FCWGHh
   Y7E2LOd7v5Li3QobfuslH4uFZwFdGy5l9q0q8PO482Je/KtdmzB6zDlI4
   g==;
X-CSE-ConnectionGUID: 1BJMX8dBQk2nbIyQR0rBaQ==
X-CSE-MsgGUID: wjkMB2/ETOqkRRs3bEh8Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97564149"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97564149"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:27:33 -0700
X-CSE-ConnectionGUID: 14oKCL5+TX6VP6+LCmVvtw==
X-CSE-MsgGUID: JSCe0SpWT/6vj6a6CCF1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="293040054"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:27:30 -0700
Date: Mon, 10 Aug 2026 21:27:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <anoYDi-bt-t6ZeeD@ashevche-desk.local>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
 <20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 07:49:36AM -0700, Petar Stepanovic wrote:
> Add support for the SARADC controller found on Axiado AX3000 and
> AX3005 SoCs.
> 
> The driver supports single-shot voltage reads through the IIO
> subsystem. The number of available input channels is selected from
> the SoC match data, allowing AX3000 and AX3005 variants to use the
> same driver.

...

> +/* MANUAL_CTRL register fields */

^^^

> +#define AX_SARADC_MANUAL_CTRL_ENABLE	BIT(0)
> +#define AX_SARADC_MANUAL_CTRL_CH_SEL_MASK	GENMASK(4, 1)
> +
> +#define AX_RESOLUTION_BITS	10
> +#define AX_SARADC_CONV_CYCLES	13
> +#define AX_SARADC_CONV_DELAY_MARGIN_US	10
> +
> +struct axiado_saradc {
> +	struct regmap *regmap;
> +	struct mutex lock; /* Serializes ADC conversions. */

Choose the same style for all single-line comments (here is a period present
while in the above, for instance, there is none).

> +	unsigned long clk_rate;
> +	int vref_uV;
> +};

...

> +static int axiado_saradc_conversion(struct axiado_saradc *info,
> +				    struct iio_chan_spec const *chan, int *val)
> +{
> +	unsigned long usecs;
> +	unsigned int regval;
> +	int ret;
> +
> +	guard(mutex)(&info->lock);
> +
> +	/* Select the channel to be used and trigger conversion */
> +	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
> +			   AX_SARADC_MANUAL_CTRL_ENABLE |
> +			   FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	/* Hardware requires 13 conversion cycles at clk_rate */

> +	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
> +			     info->clk_rate);

I think it's okay to have this on a single line (83 characters).

> +	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
> +
> +	ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
> +
> +	/* Best effort to stop manual conversion. */
> +	regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
> +
> +	if (ret)
> +		return ret;
> +
> +	*val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);
> +
> +	return 0;
> +}

...

> +	soc_data = device_get_match_data(dev);
> +	if (!soc_data)
> +		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");

-ENODATA

-- 
With Best Regards,
Andy Shevchenko


