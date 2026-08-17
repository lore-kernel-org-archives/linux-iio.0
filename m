Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7443BDB8;
	Mon, 17 Aug 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977178; cv=none; b=nEXi8wbsCg43Uc9/LIsVBmGZy5IWmFlyBsNc3v0Y3qRaw2PJn4mubg3omTchZgsRfZ+aTfeHUAfM8JCN5A43rkLXY/BfAs7uGj/4il1H8t/dKZgAHwyRLq/rbqVKidzOUyQgHJ/2HlgS6r+tDIlAogMsEZnILJJJ/kzV2cgLsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977178; c=relaxed/simple;
	bh=2YIr79g3S4FDHM/+DGKApCNIbS3UwBIwS1d05Hrdxuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq9JDkA3BGop3o5dlxvDqbUiNAgFfLY78qkAe+4HnkoFNko+h7RF4S5VnxGqKmTyRvlGnguWp5gy9Piz9ScBXrakHnxLhbx5n/24juUXmnq/8lryXQXoUCnT9DB+D+KEWG9u4R1iyuQu5vHFQ7R3k2SS7QWJksPmqV04VEFj/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVKJI2J3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVKJI2J3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786977177; x=1818513177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2YIr79g3S4FDHM/+DGKApCNIbS3UwBIwS1d05Hrdxuc=;
  b=EVKJI2J351as/8ifmNMuqsQmjFdP15RRgzd/Jqvc178yfIO/eKZrHMb5
   qcrJLPnY/FaaoVhl23jshZjXT3OOfhOvX5YCjH3JfixAPYcNBWbvoyo+6
   MGRwSw6ACSOwUbJFKt6LgsWGR/iMdpdEKqrM7V4JRe22Ex5OjBELytzQn
   XsyyjdqTa1vrZGix01b0yYPUd3dkXpS4nGUg7n8YUGBkEdAwOJM60yciW
   +1REVvhlBep+CQzDdcL2WNzqpzBBHqn//UyNvdSDRJHOiIPAvBgm1sqL6
   dQthTylSza++mfQFjceeEJ0KCOqqHu7AAb0ThaDGrYsnL5/g+zGnFXwK7
   w==;
X-CSE-ConnectionGUID: GBo+eGxYR72yQHB8l3Xq0w==
X-CSE-MsgGUID: z5lW8bzKSRWKqwGRA7WhaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87663710"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87663710"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 07:31:29 -0700
X-CSE-ConnectionGUID: d4ZpDT88Tr6JIje2pfFcnw==
X-CSE-MsgGUID: uoNp9Q5pS+KwH5COa1Gjtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="289736751"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 07:31:24 -0700
Date: Mon, 17 Aug 2026 17:31:22 +0300
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
Subject: Re: [PATCH v3 4/4] iio: dac: ad3530r: add support for AD5710R/AD5711R
Message-ID: <aoMbOhHJQOKyXyg0@ashevche-desk.local>
References: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
 <20260817-iio-ad5710r-upstream-v3-4-3a4bf7b9c78b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-iio-ad5710r-upstream-v3-4-3a4bf7b9c78b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 02:37:14PM +0800, Kim Seer Paller wrote:
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

> +static int ad5710r_get_powerdown_mode(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_test_bits(st->regmap, AD5710R_CHN_VMODE_EN,
> +			       AD5710R_CHN_VMODE_EN_BIT(chan->channel));
> +	if (ret < 0)
> +		return ret;

> +	return !ret;

I think this '!' requires for a comment.
	/* Negate the returned value as 0 represents ..., and 1 ... */

> +}

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
> +		return dev_err_probe(dev, -ENODEV, "No channels configured\n");

Optionally this can be -ENOENT, as we usually return in other APIs for
count == 0. (-ENODEV semantically seems also okay, but I just shared
an additional info for making a decision.)

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

-- 
With Best Regards,
Andy Shevchenko


