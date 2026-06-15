Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0A3FE665;
	Mon, 15 Jun 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533339; cv=none; b=dhDh94ug9fsehj1eJGnpItE2ruvVOZv9tgRLg00T6SJoUG+LlfrSvaXIgsa7DRlRDMyLD24m6+S07M9cl1DQfgohC4kxWzlMlD+k5aRZ+J782/Tg8BIynZzh94bO7jAJgOVclck/GZcvFs2U7/Buzfn7f2lOqQC12mZ1L+kcNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533339; c=relaxed/simple;
	bh=rapKQfvY7BS/GheUDnjjsSgmmAhWU2d4ZbsYD3s9r5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/FsZgTvS6k535uEnfqUw+atwG0fPWuuV9M3is05FEsJK4XhITA4VsvUuCDI7ZuvgSIfuVdY8XOPmel7EVZ4z7catL5aB6GSJ9TilU+DpiAVamnTPGVyRnyoqhP5Q0fpnboSDJXG/VKrO8Mz/rCwUqlv7k/sVtDlDXTbhXcjs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYMHhU2y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYMHhU2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781533336; x=1813069336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rapKQfvY7BS/GheUDnjjsSgmmAhWU2d4ZbsYD3s9r5I=;
  b=fYMHhU2yG4ci8jU6o6gghNB3Cd4uSaDUbgImjsUT79z25ePrgmwz+crw
   H9OMFyVKa+14pSayJckElYuTHgMIT9oiZEGWf+V2O8aeD+6E6lQwfP1xL
   K4RGFd+VD7eheDJ1gE8/cUUoBI7bYKo+qTu03/jW8WghYGuduTTuZjaVt
   lfsoCHO3sZco2LG/HbERWwMPQSpIgv7uSaG1SODsHxrVhTbmMj+Gce+oq
   eKs7GdebjVwJys8a82BamiJ1yokHFfFnSExPI51MKxuAYBvGre66dOE+K
   O9Srw+3N45qY7y+wf6Yki/DYsoMG/RRU3LPK1odPGj2NyDdbk8Gg0nO/r
   Q==;
X-CSE-ConnectionGUID: Fq2HfNZOTH6NPfhnsh+RTA==
X-CSE-MsgGUID: +uFXT2i9SAS9ko0bEFM5Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="85907404"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="85907404"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:22:16 -0700
X-CSE-ConnectionGUID: O0cEpdFKRzKVoZPC2wbP1Q==
X-CSE-MsgGUID: c9aEx9koQ3qruHpJDfxBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285596033"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:22:13 -0700
Date: Mon, 15 Jun 2026 17:22:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] iio: adc: add Versal SysMon driver
Message-ID: <ajAKkqMO5jdQjKgS@ashevche-desk.local>
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-3-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614233722.2603459-3-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:37:19AM +0100, Salih Erim wrote:
> Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
> System Monitor (SysMon) block.
> 
> The SysMon block resides in the platform management controller (PMC) and
> provides on-chip voltage and temperature monitoring through a 10-bit,
> 200 kSPS ADC. It can monitor up to 160 voltage channels and 64
> temperature satellites distributed across the SoC, with a consistent
> sample rate of 8 kSPS per channel regardless of how many channels are
> enabled.
> 
> The hardware also provides four aggregate temperature registers that
> are always present regardless of the device tree configuration: the
> current max and min across all active satellites, and the peak and
> trough values recorded since the last hardware reset.
> 
> The driver is split into two compilation units:
>   - versal-sysmon-core: Channel parsing, IIO registration, read_raw
>   - versal-sysmon: MMIO platform driver with custom regmap accessors
> 
> Voltage results are stored in a 19-bit modified floating-point format
> and converted to millivolts. Temperature results are stored in Q8.7
> signed fixed-point Celsius format and converted to millicelsius.
> 
> The MMIO regmap backend uses a custom reg_write accessor that
> automatically unlocks the NPI (NoC programming interface) lock
> register before each write, as required by the hardware. The regmap
> is configured with fast_io since the underlying MMIO accessors are
> safe to call from atomic context.

...

> +static int sysmon_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		if (mask == IIO_CHAN_INFO_SCALE) {
> +			/* Q8.7 to millicelsius: raw * 1000 / 128 */
> +			*val = MILLI;

Since this is about temperature, wouldn't be better to use

	MILLIDEGREE_PER_DEGREE

here?

> +			*val2 = BIT(SYSMON_FRACTIONAL_SHIFT);
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		if (mask != IIO_CHAN_INFO_RAW)
> +			return -EINVAL;
> +
> +		ret = regmap_read(sysmon->regmap, chan->address, &regval);
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(regval, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_VOLTAGE:
> +		if (mask != IIO_CHAN_INFO_PROCESSED)
> +			return -EINVAL;
> +
> +		ret = regmap_read(sysmon->regmap,
> +				  chan->address * SYSMON_REG_STRIDE +
> +				  SYSMON_SUPPLY_BASE, &regval);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_rawtoprocessed(regval, val);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	unsigned int num_chan, idx, temp_chan_idx, volt_chan_idx;
> +	unsigned int num_supply, num_temp;
> +	struct iio_chan_spec *sysmon_channels;
> +	const char *label;
> +	u32 reg;
> +	int ret;
> +
> +	struct fwnode_handle *supply_node __free(fwnode_handle) =
> +		device_get_named_child_node(dev, "voltage-channels");
> +	num_supply = fwnode_get_child_node_count(supply_node);
> +
> +	struct fwnode_handle *temp_node __free(fwnode_handle) =
> +		device_get_named_child_node(dev, "temperature-channels");
> +	num_temp = fwnode_get_child_node_count(temp_node);
> +
> +	num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply));

+ overflow.h

> +	sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
> +	if (!sysmon_channels)
> +		return -ENOMEM;
> +
> +	/* Static temperature channels first */
> +	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
> +	idx = ARRAY_SIZE(temp_channels);
> +
> +	/* Supply channels from DT */
> +	fwnode_for_each_child_node_scoped(supply_node, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing reg for supply channel\n");
> +
> +		if (reg > SYSMON_SUPPLY_IDX_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "supply reg %u exceeds max %u\n",
> +					     reg, SYSMON_SUPPLY_IDX_MAX);
> +
> +		ret = fwnode_property_read_string(child, "label", &label);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing label for supply channel\n");
> +
> +		sysmon_channels[idx++] = (struct iio_chan_spec) {
> +			.type = IIO_VOLTAGE,
> +			.indexed = 1,
> +			.address = reg,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			.datasheet_name = label,
> +		};
> +	}
> +
> +	/* Temperature satellite channels from DT */
> +	fwnode_for_each_child_node_scoped(temp_node, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing reg for temp channel\n");
> +
> +		if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "temp reg %u out of range [1..%u]\n",
> +					     reg, SYSMON_TEMP_SAT_MAX);
> +
> +		ret = fwnode_property_read_string(child, "label", &label);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing label for temp channel\n");
> +
> +		sysmon_channels[idx++] = (struct iio_chan_spec) {
> +			.type = IIO_TEMP,
> +			.indexed = 1,
> +			.address = SYSMON_TEMP_SAT_BASE +
> +				   (reg - 1) * SYSMON_REG_STRIDE,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +			.datasheet_name = label,
> +		};
> +	}
> +
> +	indio_dev->num_channels = idx;
> +	indio_dev->info = &sysmon_iio_info;
> +
> +	/*
> +	 * Assign per-type sequential channel numbers.
> +	 * IIO sysfs uses type prefix (in_tempN, in_voltageN)
> +	 * so numbers only need to be unique within each type.
> +	 */
> +	temp_chan_idx = 0;
> +	volt_chan_idx = 0;
> +	for (unsigned int idx = 0; idx < indio_dev->num_channels; idx++) {
> +		if (sysmon_channels[idx].type == IIO_TEMP)
> +			sysmon_channels[idx].channel = temp_chan_idx++;
> +		else
> +			sysmon_channels[idx].channel = volt_chan_idx++;
> +	}
> +
> +	indio_dev->channels = sysmon_channels;
> +
> +	return 0;
> +}

...

> +/**
> + * sysmon_core_probe() - Initialize Versal SysMon core

It is managed, please name it accordingly: devm_sysmon_core_probe().

> + * @dev: Parent device
> + * @regmap: Register map for hardware access
> + *
> + * Return: 0 on success, negative errno on failure.
> + */

-- 
With Best Regards,
Andy Shevchenko


