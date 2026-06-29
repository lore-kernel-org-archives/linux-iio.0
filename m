Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B913E169E;
	Mon, 29 Jun 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743691; cv=none; b=Hg+pyZ5jkAc3bwqnNk+O48UdYrux6CBSPkkST0w3eGXXPVjXY7ZRSs3Ua36MLfCcK4Wv7ZXTSLqr0slWIjFX7Nfovhg0NZctGNU3gtrTX08QXCv0KADVjsMKaWg9TvlMLWO8JWZdxDZjxKVF7tJe55CVyk+t3QFxWAJCKKp0EmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743691; c=relaxed/simple;
	bh=BwZOJtCi29xG7YS74nuVxcsDkGYoCMCQK67EJ5IhvRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1UAoep3esep2Rpqa9hdEDjf+ZW2j9u5+TRLzEPU7jxVTvIkOHd1iFzjs3ZjF/BrfuDIqwMR0AAHzDFIvJGZ+55a44kFEcKSfHuWiZSKWWVeO6B4exvoTl6bY+UTPuuE/gIGeGeWUXa1iwO4lNLD0TD7nrPl1UYn6OJwXpKCO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMfT+ltQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMfT+ltQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782743690; x=1814279690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BwZOJtCi29xG7YS74nuVxcsDkGYoCMCQK67EJ5IhvRQ=;
  b=VMfT+ltQekK1/RO7WrrJ/MkI/ZaVXnXXOVGL1Zkq3Fsuf02hQhl8isKS
   LG7bz3O4/tZtPHXsTf5jVcCXQHv7tmXQziy37VEbf1r8hj9XjajzZ7CnT
   OwXu0umen1xzTjkBj85b+CSdkmDaOSusIKvO4v/Xk7MPQJ77sD0aPVzc4
   cy41YPWnY6qNDluYSBMKDUtZLIYAze+c8mQI/YcoTe/48P0J5Q+YAOpYa
   kWHI5Ii0Zjd3klf8pILEP8kgQH4v4n6XwESAtE0YpkiyWzEwoIVuwO+DI
   yZC7aMJ1tL8GMValeTXOuFqJjq1aPAA1xmJjQObzi+OwI/AY++h7Ytqyt
   Q==;
X-CSE-ConnectionGUID: ikYJnMYTSLSvyTLgQpzRvw==
X-CSE-MsgGUID: Kh0KdoKkSxaoH2yFtLqZww==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83483711"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83483711"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:34:34 -0700
X-CSE-ConnectionGUID: HJl0MlKUSf+1XUZwfoAVgQ==
X-CSE-MsgGUID: PLuHj14sS2qlDi4ZuR8RdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="276249136"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:34:31 -0700
Date: Mon, 29 Jun 2026 17:34:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <akKCdSRn1LzhwD-o@ashevche-desk.local>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
 <20260629-iio-ad3532r-support-v3-4-f6e4f4abebbe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-iio-ad3532r-support-v3-4-f6e4f4abebbe@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 04:31:07PM +0800, Kim Seer Paller wrote:
> The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
> dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
> bank 1 at 0x3000 for channels 8-15). It shares similar functionality
> with AD3530R (channel configuration, LDAC triggering, powerdown control),
> the main difference being the register address map due to the dual-bank
> architecture, handled by table-driven helpers.
> 
> Add AD3532R-specific register definitions, channel specs, per-bank
> register arrays, a dedicated ad3532r_set_dac_powerdown(), and per-chip
> regmap_config to limit debugfs-exposed register space to each variant's
> actual address range.

...

> +/* AD3532R/AD3532 has two register banks: bank 0 at 0x10xx, bank 1 at 0x30xx */

Split this to two comments, see below.

> +#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
> +#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
> +#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
> +#define AD3532R_OUTPUT_CONTROL_0		0x102A
> +#define AD3532R_REFERENCE_CONTROL_0		0x103C
> +#define AD3532R_SW_LDAC_TRIG_0			0x10E5
> +#define AD3532R_INPUT_CH_0			0x10EB

+ Blank line and a comment.

> +#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
> +#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
> +#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
> +#define AD3532R_OUTPUT_CONTROL_1		0x302A
> +#define AD3532R_REFERENCE_CONTROL_1		0x303C
> +#define AD3532R_SW_LDAC_TRIG_1			0x30E5
> +#define AD3532R_INPUT_CH_1			0x30EB
> +#define AD3532R_MAX_REG_ADDR			0x30F9

...

> +static int ad3532r_input_ch_reg(unsigned int channel)
> +{

Maybe

	unsigned int bank = channel / 8;
	unsigned int ch_in_reg = channel % 8;

> +	if (channel < 8)
> +		return 2 * channel + AD3532R_INPUT_CH_0;
> +
> +	return 2 * (channel - 8) + AD3532R_INPUT_CH_1;

	return 2 * ch_in_reg + (bank ? AD3532R_INPUT_CH_1 : AD3532R_INPUT_CH_0);

? This might need the correction in variable names. I tried to deduce them from
the _dac_powerdown() below. But if you think it makes things more complicated,
don't refactor.

> +}

...

> +static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	unsigned int bank, local_ch, reg_in_bank, ch_in_reg;
> +	unsigned int reg, pdmode, mask, val;
> +	bool powerdown;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);

May chan->channel be modified behind our back here?
If not, what's the point of protecting the below lines
(till IO)?

> +	bank = chan->channel / AD3530R_CH_PER_BANK;
> +	local_ch = chan->channel % AD3530R_CH_PER_BANK;
> +	reg_in_bank = local_ch / AD3530R_CH_PER_REG;
> +	ch_in_reg = local_ch % AD3530R_CH_PER_REG;
> +
> +	reg = bank ? AD3532R_OUTPUT_OPERATING_MODE_2 :
> +		     AD3532R_OUTPUT_OPERATING_MODE_0;
> +	reg += reg_in_bank;

	reg = reg_in_bank + bank ? AD3532R_OUTPUT_OPERATING_MODE_2 :
				   AD3532R_OUTPUT_OPERATING_MODE_0;

> +	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);

> +	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
> +	val = field_prep(mask, pdmode);
> +
> +	ret = regmap_update_bits(st->regmap, reg, mask, val);

Okay, now it's cleaner and we may make it even clearer:

	if (powerdown) {
		val = field_prep(mask, st->chan[chan->channel].powerdown_mode);
// Here is the question, do we even need a field_prep()?
		ret = regmap_update_bits(st->regmap, reg, mask, val);
	} else {
		ret = regmap_clear_bits(st->regmap, reg, mask);
	}

so pdmode variable is not needed.

> +	if (ret)
> +		return ret;
> +
> +	st->chan[chan->channel].powerdown = powerdown;
> +
> +	return len;
> +}

...

> +static int ad3532r_trigger_sw_ldac_reg(unsigned int channel)
> +{
> +	if (channel < 8)
> +		return AD3532R_SW_LDAC_TRIG_0;
> +
> +	return AD3532R_SW_LDAC_TRIG_1;
> +}

Taking the above, not sure if we benefit from the parametrized macros like

#define AD3532R_SW_LDAC_TRIG(channel)	\
	(((channel) < 8) ? AD3532R_SW_LDAC_TRIG_0 : AD3532R_SW_LDAC_TRIG_1)

...

> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -ENODEV;

> -	st->regmap = devm_regmap_init_spi(spi, &ad3530r_regmap_config);
> +	st->regmap = devm_regmap_init_spi(spi, st->chip_info->regmap_config);
>  	if (IS_ERR(st->regmap))
>  		return dev_err_probe(dev, PTR_ERR(st->regmap),
>  				     "Failed to init regmap");

> -	st->chip_info = spi_get_device_match_data(spi);
> -	if (!st->chip_info)
> -		return -ENODEV;

This is simply moved up, make it happen in a separate patch.

-- 
With Best Regards,
Andy Shevchenko


