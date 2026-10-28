Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200006;
	b=YCzdDVW6yHpuMOYF80LdkVXWYnvN7EGdBHoUJ8wAsBYy95Z2A2e+BQ01cGNcsUCzFJM3
	 Uokr6mjcHbTBDPWgLpep35qDTk4gQzUktui2V+i1mKN8e0AUSQTx4XYgkRvIliYO3tO/e
	 Kpx8Rl/pwdqEdv6AaU8nHHrvWEa9uoK03w0G1ha73k0hT/1N7vm8e4LYS1rUkhBis8YcQ
	 NFxmqLvT9odFsXraoPHPv9u7prdm5MBY+amE59XNVOx9Mfusui/T9S7mYve8pp/x1dXKI
	 Su6/qQUbAXS2hFrT+Ry4GyzOAtnEazXJ7noc8wIbguE6+5HpsO2nhoMdbdmYI4z/FcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200006;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uiKZSIRSJQHNOWvR2widT0bS7uJgKV2tb0eLJFvK53A=;
	b=zojsEJEwHmPF5eS+JQiNw+PCMBz4hDdAZDhHyMDaDsVSxu89yOXqH+rWY/Xch4PxHN+S
	 LLA8J5kYn0PjOOz/RA+viN5+H7Vh9akQZedAMRCFPLBPhRntX7zV+LPEdanqJ6ytIIarX
	 5BLZSN+pdu59BFsf+7aMRXDvryzOSjV8IJweAFLi8WJFbCp6bvCa98OMTX1QmrvZ0kOnT
	 SvpTwzh0rxCYxvXswFV5fU20x7qcAtiVAxsAfNxp7g/yFeTRXs1gr+OiuUXHv9DL5f9yY
	 OVoF218NqEsZEfTFYv4dRq5fDsFuOWlZJ4gA+NQVx/UscbK/zE4APORYUoF4hUnzxVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XAFXYumc;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61163606A324;
	Wed, 28 Oct 2026 15:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61163606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XAFXYumc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793200006; x=1824736006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=naqtRwRoGxWxoGIhlK1a+9b9wgqXNXI30ZCs1V+Zn5Y=;
  b=XAFXYumc4C8aiRXRfFpYG/ftR6t0E9/tQUt4qjLvvtOzcUmTuproTli5
   5UX/V5GbnS+k/eWjfPdpvp+ELZssRQXFCGDFXJNJ6G6QTRxg8bKiq/CXe
   6yj7JluUA+ewhCEOer9Lt+XcjHFYxEjHjqkRLVVD8+XvNujlDcCPIxOOF
   j/7EB6XqnCz/ilN4ywPs/kQnuU9GswXb5MEA5DRnUPE+phfQ5vYhxezG5
   sTE26Jp6cfED/ekNfKIMFIlpew6fqXOhwgWZSKSVRlvaOs2JJtioO6zey
   AeIFLOmUBpYmnKKyL0O0a7Y9GlE+nUJTlv2engU5Mtz3/UOlpxBnjgVQZ
   g==;
X-CSE-ConnectionGUID: 2rF8vrreQ3Sw0GX/9sdN7A==
X-CSE-MsgGUID: /LoDobtzSR+thEVNaeTifw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1804390"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1804390"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:06:45 -0700
X-CSE-ConnectionGUID: OJt4tI4USrKqWLznSqxlAA==
X-CSE-MsgGUID: Bfc+8r4kQzWFjDJBoAZGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4852135"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:06:41 -0700
Date: Wed, 28 Oct 2026 17:06:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v4 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <auIPfwQII72aqyWA@ashevche-desk.local>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
 <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 02:19:06PM +0100, Neil Armstrong wrote:
> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power, accumulated average
> power and energy over an I2C/SMBUS serial interface.
> 
> The MAX34417 datasheet only specified on how to calculate the
> accumulated average power, but with the Sample Per Second rate
> we can easily get accumulated Energy in mJ.
> 
> By default the IIO driver only supports single-shot Voltage
> and Power sensing, but the accumulation can be enabled by
> enabling the Energy IIO channel which then enables the
> Continuous Accumulation Mode.
> 
> The counter is common to all channels, so when reading a single
> channel we will copy all accumulators to registers, so in order
> to permit reading individual channels we must accumulate the
> other channels in the driver when Continuous Accumulation Mode
> is enabled.

...

> +#define MAX34417_MIN_RSENSE		(1 * MILLI) /* 1000 microOhm */
> +#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100000 microOhm */
> +#define MAX34417_DEFAULT_RSENSE		(1 * MILLI) /* 1000 microOhm */

Add unit suffix. The comment versus MILLI multiplier is quite confusing.
What I read, it's milli-Ohms by value.

...

> +struct max34417_data {
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
> +	const char *input_label[MAX34417_CHANNEL_COUNT];
> +	bool cam_mode;

Don't you have 4-byte gap here in some cases? Can you confirm the layout
with `pahole`? On top you can check binary size by running `bloat-o-meter`.

> +	u64 acc_power[MAX34417_CHANNEL_COUNT];
> +	u64 acc_count[MAX34417_CHANNEL_COUNT];
> +};

...

> +static bool max34417_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MAX34417_DID_REG:
> +		return false;
> +	default:
> +	/* MAX34417_CONTROL_REG field OVF is volatile */

Why not add a case instead of a comment?

> +		return true;
> +	}
> +}

...

> +static int max34417_reset_smm(struct max34417_data *max34417)
> +{
> +	int rc;
> +
> +	/* Set SMM=0 to re-init the SMM mode */
> +	rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
> +			       MAX34417_CONTROL_SMM);

With

	struct regmap *map = max34417->regmap;

this becomes a single line

	rc = regmap_clear_bits(map, MAX34417_CONTROL_REG, MAX34417_CONTROL_SMM);

Use this trick elsewhere where appropriate.

> +	if (rc)
> +		return rc;
> +
> +	/* Reset accumulators after setting SMM=0 */
> +	return regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +}

...

> +	*val = lower_32_bits(power);
> +	*val2 = upper_32_bits(power);

Have you included wordpart.h?

...

> +static int max34417_read_label(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       char *label)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +	const char *input_label = max34417->input_label[chan->channel];
> +
> +	if (input_label) {
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return sysfs_emit(label, "%s-voltage\n", input_label);

sysfs.h for sysfs_emit().

> +		case IIO_POWER:
> +			return sysfs_emit(label, "%s-power\n", input_label);
> +		case IIO_ENERGY:
> +			return sysfs_emit(label, "%s-energy\n", input_label);
> +		default:
> +			return 0;
> +		}
> +	}
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
> +	case IIO_POWER:
> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
> +	case IIO_ENERGY:
> +		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
> +	default:
> +		return 0;
> +	}
> +}

...

> +static unsigned int max34417_calc_input_correction(u32 rsense_microOhm)

rsense_uOhm is shorter

> +{
> +	/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */

Comment in this form is almost useless. Rather explain that we except
the result in the certain units or something like this.

> +	return (MAX34417_MAX_RSENSE * MAX34417_PWR_CORRECTION_SCALE) / rsense_microOhm;
> +}

...

> +static int max34417_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max34417_data *max34417;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;

*map is shorter

> +	int rc;
> +
> +	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap_init failed\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	rc = devm_regulator_get_enable(dev, "vdd");
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
> +
> +	rc = devm_regulator_get_enable(dev, "vio");
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
> +
> +	max34417 = iio_priv(indio_dev);
> +	max34417->regmap = regmap;
> +	max34417->indio_dev = indio_dev;
> +
> +	rc = devm_mutex_init(dev, &max34417->lock);
> +	if (rc)
> +		return rc;
> +
> +	/* Set default input correction for all channels */
> +	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++)
> +		max34417->input_correction[i] =
> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
> +
> +	device_for_each_child_node_scoped(dev, node) {
> +		u32 rsense_microOhm, index;

rsense_uOhm

> +		rc = fwnode_property_read_u32(node, "reg", &index);
> +		if (rc)
> +			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
> +					     node);
> +
> +		if (index >= MAX34417_CHANNEL_COUNT)
> +			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",

-ECHRNG

> +					     index, node);
> +
> +		if (fwnode_property_present(node, "label")) {
> +			rc = fwnode_property_read_string(node, "label",
> +							 &max34417->input_label[index]);
> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading label property of %pfwP\n",
> +						node);
> +		}
> +
> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +						      &rsense_microOhm);
> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading shunt property of %pfwP\n",
> +						node);
> +
> +			if (rsense_microOhm < MAX34417_MIN_RSENSE ||
> +			    rsense_microOhm > MAX34417_MAX_RSENSE)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid shunt value %d of %pfwP\n",
> +						     rsense_microOhm, node);
> +
> +			max34417->input_correction[index] =
> +				max34417_calc_input_correction(rsense_microOhm);
> +		}
> +	}
> +
> +	indio_dev->channels = max34417_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
> +	indio_dev->name = "max34417";
> +	indio_dev->info = &max34417_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * Reset mode and set accumulator width to Wide
> +	 *
> +	 * The MAX34407 variant could be supported by setting the
> +	 * MAX34417_CONTROL_MODE field to 0 and handling a smaller
> +	 * accumulator width.
> +	 */
> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);

You have local variable for regmap, use it.

> +	if (rc)
> +		return dev_err_probe(dev, rc, "Error writing control register\n");
> +
> +	/* Reset the accumulators */
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


