Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B6242D9B;
	Mon, 31 Aug 2026 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161961; cv=none; b=knndsQy6d3A+HvL7HsJ8JS5zSjgQelIxBKEVpIra62hCb7Tz6xJ4pnrUQzZXUQT/3qZZqwkktpLTVDt4q//GBAPC+nCWx9txevwWL1FAnU2oo76oPJULETlMBooXrbAvAPnZftcun2Efxjm59K5QA0tmdo9Yzi3NqwFOgAOoRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161961; c=relaxed/simple;
	bh=4aV+uNocUPu6ad3MUH6dQ4ZhLN5HpItl7d4/3/78rlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRr6YB7mQmIXkAGyPqHhMORH6CMsu1mAnxnOuiPIbggks2b7mNcKQXfxYrpdwJRBzFNiwpRL10gVWoe4CCpSN85PIAv/r0P7Gq/w7+xyL/A3Wam9QoKfF1ikDpPXEwGbk2WiyPcLi/KCiKURB36cr/ZDHv1AM4LXcKIx+N0uxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhRBBZIM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhRBBZIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788161959; x=1819697959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4aV+uNocUPu6ad3MUH6dQ4ZhLN5HpItl7d4/3/78rlI=;
  b=mhRBBZIM105OYCJz4FfGRemw90jDi5KnNxiuUb4I6xuosoSwGEqhuJuX
   gY1a0V3UIzBX4ZronnCTQrIqNaQCNynvGmbsEixXEewqUk1Pl08P+Qvu1
   K8ATL2Z+mGMLJCGO0SR54tlHRw4BADeQwp0ViUhs80jCO3AhYF3QwsJLr
   9xa7YQ4I7l94CA9SDsI5gJ6xgEjSAarBYCAdcUjt/4IY+qSzCtaupb+QV
   EFYe+RS1/uA7D7uhDaDNq1hPDOprDTaaLiLvFAoJWma3XV3sTaQdoihGV
   sZ7UItYVwXYfw1AzkQFVBENkJ7P2lB5xsTY02jE2iwks8Du6ZHJJkbEFJ
   A==;
X-CSE-ConnectionGUID: +nKOMRCmSda0zy3ANYGIGQ==
X-CSE-MsgGUID: Yc0dp/3lRjSq1hhzdtp90g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="105935986"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="105935986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:39:19 -0700
X-CSE-ConnectionGUID: Rd5aCz1uRAyziFJ0rCElqw==
X-CSE-MsgGUID: rc5eIhJjRay0KONvkcGa3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266915404"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:39:16 -0700
Date: Mon, 31 Aug 2026 10:39:13 +0300
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
Subject: Re: [PATCH v4 4/4] iio: dac: ad3530r: add support for AD5710R/AD5711R
Message-ID: <apUvod3OC6IcGcK1@ashevche-desk.local>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
 <20260829-iio-ad5710r-upstream-v4-4-8af3121c7d21@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829-iio-ad5710r-upstream-v4-4-8af3121c7d21@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 29, 2026 at 01:59:23PM +0800, Kim Seer Paller wrote:
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

> +static int ad3530r_parse_channel_cfg(struct iio_dev *indio_dev)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct iio_chan_spec *channels;
> +	unsigned int num_chan, i;
> +	int ret;
> +	u32 reg;
> +
> +	num_chan = device_get_child_node_count(dev);
> +	if (!num_chan)
> +		return dev_err_probe(dev, -ENOENT, "No channels configured\n");
> +
> +	channels = devm_kcalloc(dev, num_chan, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		unsigned int mode_reg, mode_mask, ch_func;
> +		enum iio_chan_type chan_type;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read reg property of %pfwP\n",
> +					     child);
> +
> +		if (reg >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,

-ECHRNG

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
> +		ad5710r_get_op_mode_reg(reg, &mode_reg, &mode_mask);
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
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_chan;
> +
> +	return 0;
> +}

...

And in case you are not using --histogram diff algo when preparing patches,
better to start using it. It might make patches more readable (for review).

-- 
With Best Regards,
Andy Shevchenko


