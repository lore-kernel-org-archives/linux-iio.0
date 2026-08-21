Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF03AFD03;
	Fri, 21 Aug 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318210; cv=none; b=BDtGT8YDQ+il+mpspZwd32JC0AlO91f+9h37BUrr+iwrUUk0RO695exWLS6bk8CB3yg+AlNTfiWcgFk0Z9zqALhy7SYKY4NV7yEtawMuH2D+lAKze1gF/emRFS9IpAl95VeZ8R+es0XjkjShmH6zAIXHgfj0c6JKItr0YbkzwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318210; c=relaxed/simple;
	bh=mFQeiGUM9dHfF6xABuT1qe621J+n7EAwg91rA4n4YbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAQkWt/YfV1UyxNTt0JHtQtUWRP/PyWxDoVG3ANhYc1EgPMI7JSD9HXdI59YDfEBv1JUnMDjWoFhYBVyr7pyKfOnxp5dosELX+gq/Vuy85hY2LuEP32TgUPDesF76SEZAqrk327ztiHtKwn/8u/30xxxYh94IxJLzxuiBQ9hrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Js++vq7z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Js++vq7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787318198; x=1818854198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFQeiGUM9dHfF6xABuT1qe621J+n7EAwg91rA4n4YbY=;
  b=Js++vq7zLHAGAmfkrFYGnEvDYA2FU0RKz3Mf8LHFrAri3GMERSyf4D7Q
   ZgyGHMbxM6v2gILUMBR27pXI8A1Q7JQFr5mRx20swUf8PSuYw1AH5OVoU
   HrXxZNpFeJ1rnbzjOIrs+sCdPHKik98X8c0QYDeNONKAThOFLPf/wk2nb
   sww47lYhxQSFOqT6FmkimrCFGGgKVhS9OcUUBJXvRXAH+jNdIL2/wm5XY
   bx32BqBPYI5SAW/FkEf8AGzjBCwI0kp5extXWWKB3TL0t8FUD5u8YH+dN
   enDuD3yGRTaaeTZibNND3VgVHF3EcZ6Y4dWGt5w6xuEm+xIIE28GpPhCr
   Q==;
X-CSE-ConnectionGUID: gHuTiBIkT4Kyf+W7eqNdEg==
X-CSE-MsgGUID: pU7Flox0QM6tvJhmtozDcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91738959"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="91738959"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:16:30 -0700
X-CSE-ConnectionGUID: FyWoSdOVQMmJhrmTM8kHtA==
X-CSE-MsgGUID: wyLPXuhxSiO2w24PR3267A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271572530"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:16:23 -0700
Date: Fri, 21 Aug 2026 16:16:21 +0300
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <aohPpQRn5tOANk-c@ashevche-desk.local>
References: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
 <20260820-ad5529r-driver-v9-3-ba62e0b2a816@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-ad5529r-driver-v9-3-ba62e0b2a816@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 20, 2026 at 09:08:23AM +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.

...

> +enum ad5529r_output_range {
> +	AD5529R_RANGE_0V_5V,
> +	AD5529R_RANGE_0V_10V,
> +	AD5529R_RANGE_0V_20V,
> +	AD5529R_RANGE_0V_40V,
> +	AD5529R_RANGE_NEG5V_5V,
> +	AD5529R_RANGE_NEG10V_10V,
> +	AD5529R_RANGE_NEG15V_15V,
> +	AD5529R_RANGE_NEG20V_20V,

TBH I don't see the value in 'NEG'. It's kinda obvious that they are all ranges
and from -X volts to +Y volts. I don't expect to see the "range" out of an single
exclusive constant.

> +};

...

> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);

It seems having an 'spi' member in the state structure is overkill.
This all can be done here locally

	struct regmap *map = st->regmap_8bit;
	struct device *dev = regmap_get_device(map);

> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret = reset_control_assert(rst);
> +		if (ret)
> +			return ret;
> +
> +		/* Minimum reset low width (t_reset) is 20 ns per datasheet. */
> +		ndelay(20);
> +
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
> +	fsleep(10 * USEC_PER_MSEC);
> +
> +	return regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +			    AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE |
> +			    AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION);
> +}

...

> +static int ad5529r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ad5529r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_addr, reg_val_h;
> +	int ret, range_idx, span_mv;

_mV

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Read from DAC_INPUT_A register rather than DAC_DATA_READBACK.
> +		 * The DAC operates in transparent mode and directly reflects
> +		 * whatever value is written to the INPUT_A register.
> +		 */
> +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
> +		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val_h;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		range_idx = st->output_range_idx[chan->channel];
> +
> +		/*
> +		 * The datasheet specifies a 4.096 V external reference,
> +		 * matching the nominal output voltage of the internal
> +		 * reference.
> +		 */
> +		span_mv = ad5529r_output_ranges_mV[range_idx][1] -
> +			  ad5529r_output_ranges_mV[range_idx][0];
> +		*val = span_mv;
> +		*val2 = st->model_data->resolution;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		range_idx = st->output_range_idx[chan->channel];
> +
> +		if (ad5529r_output_ranges_mV[range_idx][0] < 0)
> +			*val = -(1 << (st->model_data->resolution - 1));

Hmm... Why not -BIT(st->model_data->resolution - 1)?

> +		else
> +			*val = 0;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	unsigned long channel_mask = 0;
> +	s32 vals[2];
> +	int ret, range_idx;
> +	u32 ch;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		if (st->num_channels == ARRAY_SIZE(st->channels))
> +			return dev_err_probe(dev, -EINVAL, "Too many channels\n");

Perhaps -ECHRNG?

> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing reg property in channel node\n");
> +
> +		if (ch >= AD5529R_MAX_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Channel %u exceeds maximum 15\n",
> +					     ch);
> +
> +		if (channel_mask & BIT(ch))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Duplicate channel %u\n", ch);
> +
> +		channel_mask |= BIT(ch);
> +
> +		if (fwnode_property_present(child, "output-range-microvolt")) {
> +			/*
> +			 * DT stores cells as raw 32-bit values; signed endpoints are
> +			 * encoded by dtc in two's-complement and then interpreted
> +			 * here as s32.
> +			 */
> +			ret = fwnode_property_read_u32_array(child,
> +							     "output-range-microvolt",
> +							     (u32 *)vals, ARRAY_SIZE(vals));
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to read range for ch %u\n",
> +						     ch);
> +
> +			range_idx = ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						     "Invalid range [%d %d] for ch %u\n",
> +						     vals[0], vals[1], ch);
> +		} else {
> +			range_idx = AD5529R_RANGE_0V_5V;
> +		}
> +
> +		st->output_range_idx[ch] = range_idx;
> +		ret = regmap_write(st->regmap_16bit,
> +				   AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure range for ch %u\n",
> +					     ch);
> +
> +		st->channels[st->num_channels++] = AD5529R_DAC_CHANNEL(ch);
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

> +	struct regmap_config regmap_8bit_cfg;
> +	struct regmap_config regmap_16bit_cfg;

Make them to be first in the list, it will follow reversed xmas tree order.

> +	bool external_vref;
> +	u32 dev_addr = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);

> +	st->spi = spi;

No need, the same is used when both regmap:s are initialised.

> +	st->model_data = spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -ENODATA,
> +				     "Failed to identify device variant\n");
> +
> +	device_property_read_u32(dev, "spi-device-addr", &dev_addr);
> +	if (dev_addr > 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "spi-device-addr %u out of range [0, 3]\n",
> +				     dev_addr);
> +
> +	regmap_8bit_cfg = (struct regmap_config) {
> +		.name = "ad5529r-8bit",
> +		.reg_bits = 16,
> +		.val_bits = 8,
> +		.max_register = AD5529R_8BIT_REG_MAX,
> +		.read_flag_mask = AD5529R_SPI_READ_FLAG,
> +		.rd_table = &ad5529r_8bit_readable_table,
> +		.wr_table = &ad5529r_8bit_writeable_table,
> +		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
> +	};
> +	regmap_16bit_cfg = (struct regmap_config) {
> +		.name = "ad5529r-16bit",
> +		.reg_bits = 16,
> +		.val_bits = 16,
> +		.max_register = AD5529R_MAX_REGISTER,
> +		.read_flag_mask = AD5529R_SPI_READ_FLAG,
> +		.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +		.rd_table = &ad5529r_16bit_readable_table,
> +		.wr_table = &ad5529r_16bit_writeable_table,
> +		.reg_stride = 2,
> +		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
> +	};
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
> +					     ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable regulators\n");

> +	for (i = 0; i < ARRAY_SIZE(ad5529r_vss_supply_names); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_vss_supply_names); i++) {

> +		ret = devm_regulator_get_enable_optional(dev,
> +							 ad5529r_vss_supply_names[i]);
> +		if (ret && ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get and enable %s regulator\n",
> +					     ad5529r_vss_supply_names[i]);
> +	}
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret == -ENODEV)
> +		external_vref = false;
> +	else if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +	else
> +		external_vref = true;
> +
> +	/* Wait 10 ms after power-up before the first SPI transaction. */
> +	fsleep(10 * USEC_PER_MSEC);
> +
> +	st->regmap_8bit = devm_regmap_init_spi(spi, &regmap_8bit_cfg);
> +	if (IS_ERR(st->regmap_8bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
> +				     "Failed to initialize 8-bit regmap\n");
> +
> +	st->regmap_16bit = devm_regmap_init_spi(spi, &regmap_16bit_cfg);
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
> +				 !external_vref);
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
> +	indio_dev->channels = st->channels;
> +	indio_dev->num_channels = st->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


