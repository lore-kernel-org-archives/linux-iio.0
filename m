Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521893EB0FD;
	Tue,  9 Jun 2026 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030658; cv=none; b=lq1pNe6Yt8nIfQd+Ay//GpmsPa6x+0I4SbjqgXYEiHtklfPC5IH1csuSyJBLZ6fAFx4MtpZrblqrMJtoCGi9BxUYkGw+PWqm1ARhRNeW8lhv/7uXBUxOFFBTT87zFxLTcRpsspnhHxzFP6FKQD5Pkrm1MWjFPNft4A3+OjpDEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030658; c=relaxed/simple;
	bh=o9mYv6YG5vNtKAfHCFG1zf+CG8nKAvHLLveqk1twVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAfdLTTXJqTUeeaj/pvbioFEAsPpOTZ8LAcHIGxdu4TmJ8eeZcDpM6sStDs8h5Tw9ObXZkO05POHCJLJBlj88iVg7sRWtTu58jDVkP1n60yPAtVh96kTEYyM4jFtY+x5TpngHB+I5wRAJ6hWL8ItaABw5mMfLEyZSTnu2olijwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHSatljv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHSatljv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781030657; x=1812566657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o9mYv6YG5vNtKAfHCFG1zf+CG8nKAvHLLveqk1twVgw=;
  b=OHSatljv9LsOqsjiZD75Azl1X1Vf7ZbflguFF8cCK22r2jUYoeHPngp/
   4eXRi+k5bcfYpXduD3NWBeuUAQrvdNYZTZxV6PU+N+YSEw/3lyuJDNK3d
   CGjnwNf3YemLZsCFnkA5M3FDTU+7lMaz4bilmCAz1wgeLU8/4AMyxBxYU
   OKFtcqDRuQxjGbGFRmM+8yN31dhwMUPSepnfe2OsTmVWvZveZiP9KnQYV
   pAfLZXEuEtbqcgzyhxDBaRDY8hGRiGzsSiZzKjMLPs+2SOZTjkIHNPv67
   WjTquBzrx/uMePo+GT+q3MdMdxLg+toMhZ8jubz+UocmEJOv5bswQadS4
   Q==;
X-CSE-ConnectionGUID: eDnRYrujTKCXP+88GHK9eA==
X-CSE-MsgGUID: /3L/eKjAR3GLIWatJL1q4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92125264"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92125264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:44:16 -0700
X-CSE-ConnectionGUID: 8oj2/cWVTzWbBJaL8tmR4Q==
X-CSE-MsgGUID: RBsB+jT2STWAoIEk1m610w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="249866193"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:44:11 -0700
Date: Tue, 9 Jun 2026 21:44:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: dac: Add AD5529R DAC driver support
Message-ID: <aihe-Hdb7-HDvt96@ashevche-desk.local>
References: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
 <20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 05:00:21PM +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter

Looks like half-dropped sentence...


> +static const struct regmap_range ad5529r_16bit_read_only_ranges[] = {
> +	regmap_reg_range(AD5529R_REG_DAC_DATA_READBACK_BASE,
> +			 (AD5529R_REG_DAC_DATA_READBACK_BASE + 15 * 2)),

Too many parentheses.

> +	regmap_reg_range(AD5529R_REG_TSENS_ALERT_FLAG, AD5529R_REG_TSENS_SHTD_FLAG),
> +	regmap_reg_range(AD5529R_REG_FUNC_BUSY, AD5529R_REG_FUNC_BUSY),
> +	regmap_reg_range(AD5529R_REG_INIT_CRC_ERR_STAT, AD5529R_REG_INIT_CRC_ERR_STAT),
> +};

...

> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret = reset_control_deassert(rst);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +				   AD5529R_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Wait 10 ms for digital initialization to complete.
> +	 * Per datasheet, Interface Status A register NOT_READY_ERR bit is
> +	 * set if SPI transactions are attempted before digital initialization
> +	 * completes.
> +	 */
> +	fsleep(10000);

10 * USEC_PER_MSEC

(needs time.h if not yet included).

> +	return regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +			    AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE |
> +			    AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION);
> +}

...

> +	case IIO_CHAN_INFO_OFFSET:
> +		range_idx = st->output_range_idx[chan->channel];
> +
> +		if (ad5529r_output_ranges_mv[range_idx][0] < 0)
> +			*val = -(1 << (st->model_data->resolution - 1));

From the C standard point of view this is problematic code in case
if resolution == 32, but I believe it won't happen IRL.

> +		else
> +			*val = 0;
> +
> +		return IIO_VAL_INT;

...

> +static int ad5529r_find_output_range(const s32 *vals)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_output_ranges_mv); i++) {
> +		if (vals[0] == ad5529r_output_ranges_mv[i][0] * 1000 &&
> +		    vals[1] == ad5529r_output_ranges_mv[i][1] * 1000)

Make suffix of the array _mV (yes, like in SI).

> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	int ret, range_idx;
> +	u32 ch;
> +	s32 vals[2];

Reversed xmas tree order.

> +	device_for_each_child_node_scoped(dev, child) {
> +		range_idx = AD5529R_RANGE_0V_5V;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing reg property in channel node\n");
> +
> +		if (ch >= 16)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid channel number: %u\n", ch);
> +
> +		/* Read u32 property into s32 to handle negative voltage ranges */
> +		if (!fwnode_property_read_u32_array(child,
> +						    "adi,output-range-microvolt",
> +						    (u32 *)vals, ARRAY_SIZE(vals))) {

Yeah... Do you know how negative numbers will look in DT? Just as regular
negative integers and DT compiler will take care to pack them in unsigned
variable?

> +			range_idx = ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						     "Invalid range [%d %d] for ch %u\n",
> +						     vals[0], vals[1], ch);
> +		}
> +
> +		st->output_range_idx[ch] = range_idx;
> +		ret = regmap_write(st->regmap_16bit,
> +				   AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure range for ch %u\n",
> +					     ch);
> +	}
> +
> +	return 0;
> +}

...

> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	bool external_vref;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +
> +	st->model_data = spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -EINVAL, "Failed to identify device variant\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
> +					     ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable regulators\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "hvss");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable hvss regulator\n");
> +
> +	/*
> +	 * The datasheet mentions a 4.096V external reference for correct
> +	 * operation.
> +	 */
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +
> +	external_vref = ret != -ENODEV;

This can be written as

	if (ret == -ENODEV)
		external_vref = false;
	else if (ret)
		return dev_err_probe(dev, ret,
				     "Failed to get and enable vref regulator\n");
	else
		external_vref = true;

> +	st->regmap_8bit = devm_regmap_init_spi(spi, &ad5529r_regmap_8bit_config);
> +	if (IS_ERR(st->regmap_8bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
> +				     "Failed to initialize 8-bit regmap\n");
> +
> +	st->regmap_16bit = devm_regmap_init_spi(spi, &ad5529r_regmap_16bit_config);
> +	if (IS_ERR(st->regmap_16bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
> +				     "Failed to initialize 16-bit regmap\n");
> +
> +	ret = ad5529r_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	ret = regmap_assign_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
> +				 AD5529R_REF_SEL_INTERNAL_REF,
> +				 external_vref ? 0 : AD5529R_REF_SEL_INTERNAL_REF);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure reference\n");
> +
> +	ret = ad5529r_parse_channel_ranges(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->model_data->model_name;
> +	indio_dev->info = &ad5529r_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->model_data->channels;
> +	indio_dev->num_channels = st->model_data->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


