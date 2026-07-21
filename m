Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D73480357;
	Tue, 21 Jul 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630342; cv=none; b=O7MqC03a/WKOCyXQOieVejh1ru2CQaf8pTPnO0pNmM02ayv66gsjurCEPdFHX6mEngc3Ok+1o6ISIBA57GHUx9nPVjsDhboYuY3zctDEEKx0pM69RWeJ0bQ8c3jpixoNRC2LgNt2lK+FE/0zd7hUCD/FKkIYOW7h4Lcc1BEave4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630342; c=relaxed/simple;
	bh=40NKHJrLhW6GlGKNMWQA7jNDslCQR7ktMAFpyNRW6eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFcu+lQ7lItdJBP7QK/LNZMo0kgZrvinS492gob6ngSuSA+jIaJliTAwKoamGvkhavnasvcq+jtzffwI+tP1Nv6cacDZ7YZEWKw8LB0HIshWVctbfCiA+XLzIf/7r4/0M/MpPhCae0TOfu/AlBVQLlLzu40OOxMHFQLxPs1GDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4aUf+K4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4aUf+K4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784630340; x=1816166340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40NKHJrLhW6GlGKNMWQA7jNDslCQR7ktMAFpyNRW6eQ=;
  b=m4aUf+K402NYGW/jRnCmsc9Rb+8uQhyH00/g9gvVDIMPFUVitM7ezrsR
   tngW9NTMz12+8UXNLVeVTqC3KiBq0Z8VAajwA+LC1hr7u/i1iUc+SsB28
   gJUPOnYKuC/LDsSQVJPfnbOGJrAl5YfUze1j9S1AiceOgJYjU3wsAS90t
   If/TtviwftXE1E+q2nO7wEUVWxnntY0qMWFOUCe57hUP1djX21BVe5Mij
   O5IZZsCcriC4PfbUM6XV2S0+lRnHaeSvhtAx7FY5bb/hBms9WKdlIicEF
   oB21mbodEnY6IMq3kLz+CofTfuRugssECA1pGKXSdKoEb6uUbpHrV7pGs
   g==;
X-CSE-ConnectionGUID: uKNpoKxwR7qb8zpTYUz08g==
X-CSE-MsgGUID: dk0T/7/1S4W/GiXBd9l+tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85425118"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85425118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:39:00 -0700
X-CSE-ConnectionGUID: 2tbWG1odTYaOUwIHLYmJkA==
X-CSE-MsgGUID: ykcYyGzvSteV7uuab8J5Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="251402173"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:38:56 -0700
Date: Tue, 21 Jul 2026 13:38:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: add support for AD5710R/AD5711R
Message-ID: <al9MPk9HfI0rTDHY@ashevche-desk.local>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 04:47:13PM +0800, Kim Seer Paller wrote:
> Add support for the AD5710R/AD5711R, 8-channel 16-/12-bit configurable
> IDAC/VDAC parts. They share the AD3530R register map and access model,
> so fold them into this driver.
> 
> Each channel is configured as voltage or current output from its DT
> channel@N node via adi,ch-func, building the iio_chan_spec dynamically.
> Voltage channels enable VMODE_EN and report the reference-derived scale,
> current channels report the 50 mA internal Iref scale. The powerdown
> mode is read-only and derived from the channel's configured type.

...

>   * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
>   * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
>   * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
> + * AD5710R/AD5711R 8-channel, 16-/12-bit Configurable IDAC/VDAC Driver

In the above only a single data width is mentioned, maybe split this one?

...

>  #define AD3531R_MAX_CHANNELS			4
>  #define AD3532R_MAX_CHANNELS			16
> +#define AD5710R_NUM_CHANNELS			8

Why NUM and not MAX?

...

> +static int ad5710r_get_powerdown_mode(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD5710R_CHN_VMODE_EN, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !(val & AD5710R_CHN_VMODE_EN_BIT(chan->channel));

regmap_test_bits()

> +}

...

> +static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 char *buf)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_offset, ch_in_reg, reg, mode, mask;
> +	int ret;
> +
> +	reg_offset = chan->channel / AD3530R_CH_PER_REG;
> +	ch_in_reg = chan->channel % AD3530R_CH_PER_REG;
> +	reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> +	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> +
> +	ret = regmap_read(st->regmap, reg, &mode);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", !!(mode & mask));

Ditto.

> +}

...

> +static const struct regmap_config ad5710r_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_register = AD5710R_CHN_VMODE_EN,
> +};

No cache?

...

> +static int ad3530r_parse_channel_cfg(struct ad3530r_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct iio_chan_spec *channels;
> +	int ret, num_chan;

Why is 'num_chan' signed?


> +	int i = 0;

Signed? Also, split assignment and move it closer to its first user.

> +	u32 reg;
> +
> +	num_chan = device_get_child_node_count(dev);
> +	if (!num_chan)
> +		return dev_err_probe(dev, -ENODEV, "No channels configured\n");
> +
> +	channels = devm_kcalloc(dev, num_chan, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;


	i = 0;

> +	device_for_each_child_node_scoped(dev, child) {
> +		unsigned int reg_offset, ch_in_reg, mode_reg, mode_mask, ch_func;
> +		enum iio_chan_type chan_type;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read reg property of %pfwP\n",
> +					     child);
> +
> +		if (reg >= AD5710R_NUM_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg out of range in %pfwP\n",
> +					     child);
> +
> +		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing adi,ch-func property for %pfwP\n",
> +					     child);
> +
> +		switch (ch_func) {
> +		case CH_FUNC_VOLTAGE_OUTPUT:
> +			ret = regmap_set_bits(st->regmap, AD5710R_CHN_VMODE_EN,
> +					      AD5710R_CHN_VMODE_EN_BIT(reg));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to set voltage output for %pfwP\n",
> +						     child);
> +
> +			chan_type = IIO_VOLTAGE;
> +			break;
> +		case CH_FUNC_CURRENT_OUTPUT:
> +			chan_type = IIO_CURRENT;
> +			break;
> +		default:
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid adi,ch-func %u for %pfwP\n",
> +					     ch_func, child);
> +		}
> +
> +		channels[i] = ad5710r_channels[reg];
> +		channels[i].type = chan_type;
> +		i++;
> +
> +		reg_offset = reg / AD3530R_CH_PER_REG;
> +		ch_in_reg = reg % AD3530R_CH_PER_REG;
> +		mode_reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> +		mode_mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> +
> +		/* Enable the channel in normal operation mode */
> +		ret = regmap_update_bits(st->regmap, mode_reg, mode_mask,
> +					 field_prep(mode_mask, AD3530R_NORMAL_OP));
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to set normal operating mode for %pfwP\n",
> +					     child);
> +	}
> +
> +	st->channels = channels;
> +	st->num_channels = num_chan;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


