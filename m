Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A33F412B;
	Tue, 13 Oct 2026 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903197; cv=none; b=YyOic1zXK0cTjVWaxlTizxgodqb35X/mzkRDU0F5kreW7B1nXLNu3RgJy7oZz6s5vqXg0kZjuQLh8QL2XGKsR93rsHHOWi/m7yCixlQfPEBLA79j6Yjun+nykgik5oNl3mEZDiIiiHBptnrkwi/DZdXVxEnibWVs1StCKJgiwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903197; c=relaxed/simple;
	bh=BVXhtHIZWs9oxiAVBwDWppeHWY0Joo6grmAQKjAVdtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDQcUKA2b3jTF1WuPETNofP8XZoiahAra1TrcAv9hR2P/QTO6aoa5tjpndtRwUCw3yiVFt0Vr1J1WyIkhKcvcvAWAUIQBHo2SVjyBwl2N7OVCjsSAaFv1JrxbzKU4Fqm9hYszm90Nrfrro+R5MaXV2mCV6bVucotohg9D/GD5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTMKRY6G; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTMKRY6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791903196; x=1823439196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BVXhtHIZWs9oxiAVBwDWppeHWY0Joo6grmAQKjAVdtI=;
  b=YTMKRY6GvPsVH2bCYXPpauzpzCTlBvER1fln1EncM+nnygOEpFGuiZ0S
   sSJZUv3vB07942sPKwudSPs4T61gMzW5JlCBwqA/RL0Pe3AUO5mmSsLeQ
   8Dy+OumeODStB5gc/m6AvJkDJyNUv4hEAg7Uh4HlmIAgdQYXmXNEIA9ri
   wNGG/XCU+wKP1EFklz+IYnTgAQ7OeQVzDX4KKQJtEKjq6mnv4114I5ZsE
   O1Czhzn9iq3a4kn82Xyeac3aCUePhYmkWnn8ymUnVnZ7jKHAsOrF+xMvX
   53syUMD0nfZzER06Qpz97xE2+dqQHqN03bDHfD/aSJHEx3ochzeyZmtfe
   w==;
X-CSE-ConnectionGUID: rFrzTKxLRaq1jzrDNRYK0g==
X-CSE-MsgGUID: 9esOkwE0RXqt1lGVh8Na3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="638086"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="638086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:53:16 -0700
X-CSE-ConnectionGUID: Dlnx3moDSjOtP/NCpGly7g==
X-CSE-MsgGUID: DxGGuWfhTG+efQuQ91p/1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1541351"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:53:13 -0700
Date: Tue, 13 Oct 2026 17:53:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <as5F1uZ3DnOPYoWV@ashevche-desk.local>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 04:07:13PM +0200, Neil Armstrong wrote:
> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power and accumulated average
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

> +#define MAX34417_MIN_RSENSE		(MILLI)	/* 1 milliOhm */

1 * MILLI

> +#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100 milliOhm */
> +#define MAX34417_DEFAULT_RSENSE		MAX34417_MIN_RSENSE

I would rather put the exact value here as well.

...

> +struct max34417_data {
> +	struct iio_dev *indio_dev;

> +	struct regmap *regmap;
> +	struct device *dev;

One of them seems redundant (I suppose the 'dev').

> +	struct mutex lock;
> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
> +	const char *input_label[MAX34417_CHANNEL_COUNT];
> +	bool cam_mode;
> +	u64 acc_power[MAX34417_CHANNEL_COUNT];
> +	u32 acc_count[MAX34417_CHANNEL_COUNT];
> +};
> +
> +static const struct regmap_config max34417_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= MAX34417_BULK_VOLTAGE_READOUT_REG,

No cache? All registers are volatile?

> +};

...

> +#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
> +	{							\
> +		.type = IIO_VOLTAGE,				\
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
> +					  BIT(IIO_CHAN_INFO_SCALE), \

Instead of broken indentation at the end, use different style for these type of
assignments, like

		.info_mask_separate =
			BIT(IIO_CHAN_INFO_RAW) |		\
			BIT(IIO_CHAN_INFO_SCALE),		\

Also do not use brokenly indented '=', just a space after the field is enough.


> +		.channel = (_index),				\
> +		.address = (_v_address),			\
> +		.indexed = 1,					\
> +	},							\
> +	{							\
> +		.type = IIO_POWER,				\
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
> +					  BIT(IIO_CHAN_INFO_SCALE), \
> +		.channel = (_index),				\
> +		.address = (_power_address),			\
> +		.indexed = 1,					\
> +	},							\
> +	{							\
> +		.type = IIO_ENERGY,				\
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
> +					  BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_ENABLE), \
> +		.channel = (_index),				\
> +		.address = (_power_address),			\
> +		.indexed = 1,					\
> +	}

...

> +static int max34417_reset_smm(struct max34417_data *max34417)
> +{
> +	u32 control;
> +	int rc;
> +
> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	/* Set SMM=0 to re-init the SMM mode */
> +	control &= ~(MAX34417_CONTROL_SMM);
> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
> +	if (rc)
> +		return rc;

regmap_update_bits() / regmap_clear_bits()?

> +	/* Reset accumulators after setting SMM=0 */
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;

regmap_set_bits() ?

> +	return 0;
> +}

...

Also check the rest of the code for the similar RMW cases.

...

> +	/*
> +	 * UPDATE commands should be no less than 1msec apart for reliable
> +	 * measurements.
> +	 */
> +	fsleep(1000);

1 * USEC_PER_MSEC

> +	u32 acc_count;
> +	int rc;
> +
> +	rc = max34417_read_acc_count(max34417, &acc_count);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {

'i' is not used outside of the loop AFAICS. Also why pre-increment?

	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {

> +		rc = max34417_read_acc_power(max34417, MAX34417_PWR_ACC_1_REG + i,
> +					     &acc_power);
> +		if (rc)
> +			return rc;
> +
> +		max34417->acc_power[i] += acc_power;
> +		max34417->acc_count[i] += acc_count;
> +	}

...

> +	/* Check for overflow */
> +	rc = max34417_check_ovf(max34417);
> +	if (rc)
> +		return rc;
> +
> +	return 0;

	return ..._check_ovf(...);

...

> +	/* Ignore byte0 */
> +	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]);
> +	voltage >>= 2;

The above comment is odd. Please, clarify, ideally with a reference to
the datasheet table / section / et cetera.

Also can be folded into a single expression:

	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]) >> 2;

...

> +		if (unlikely(acc_count == 0)) {

Why unlikely()? Is this a hot-path? What is the performance effect will it give?

> +			dev_warn(max34417->dev, "unexpected zero accumulator count\n");
> +
> +			*val = 0;
> +			*val2 = 0;
> +
> +			return IIO_VAL_INT_64;
> +		}

...

> +	/*
> +	 * Move the data to the SMBus registers
> +	 */

A single line comment.

...

> +static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
> +{
> +	u32 control;
> +	int rc, i;
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	if (max34417->cam_mode && !val) {
> +		/* SMM and CAM modes should not be enabled at the same time */
> +		control &= ~(MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * If CAM mode must be set, the Control byte must be set to
> +		 * desired values with CAM = 0, then followed by an UPDATE
> +		 */
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +	} else if (!max34417->cam_mode && val) {
> +		/*
> +		 * After this, the CAM mode bit can be set and another
> +		 * UPDATE must be sent.
> +		 */
> +		control |= MAX34417_CONTROL_CAM;
> +		/* SMM and CAM modes should not be enabled at the same time */
> +		control &= ~(MAX34417_CONTROL_SMM);
> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
> +		if (rc)
> +			return rc;
> +
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +
> +		/* Reset counters and accumulators */
> +		for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {

		for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {

> +			max34417->acc_power[i] = 0;
> +			max34417->acc_count[i] = 0;
> +		}
> +	}
> +
> +	max34417->cam_mode = val;
> +
> +	return 0;
> +}

...

> +static int max34417_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return max34417_read_voltage(max34417, chan, val);
> +		case IIO_POWER:
> +			/* In default mode, we return a single measurement */
> +			if (max34417->cam_mode)
> +				return -EINVAL;
> +
> +			return max34417_read_power(max34417, chan, val, val2);
> +		case IIO_ENERGY:
> +			if (!max34417->cam_mode)
> +				return -EINVAL;
> +
> +			return max34417_read_energy(max34417, chan, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		if (chan->type != IIO_POWER)
> +			return -EINVAL;
> +
> +		/* In CAM mode, we return an average measurement */
> +		if (!max34417->cam_mode)
> +			return -EINVAL;
> +
> +		return max34417_read_power(max34417, chan, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE) {
> +			/* Scale to mV */
> +			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
> +			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_POWER) {
> +			/*
> +			 * Scale to mW
> +			 * (1000 * (Power Accumulation / Counter) * Correction) / 2^30
> +			 */
> +			*val = max34417->input_correction[chan->channel] * MILLI;

MILLIWATT_PER_WATT

> +			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_ENERGY) {
> +			/*
> +			 * Scale to mJ
> +			 * P=(1000 * (Power Accumulation / Counter) * Correction) / 2^30
> +			 * t=(Counter / Samples per Second)
> +			 * E=(P * t)
> +			 * Can be simplified to:
> +			 * (1000 * Power Accumulation * Correction) / (2^30 * SPS)
> +			 * The denominator doesn't fit in 32bit so scale down both terms.
> +			 */
> +			*val = max34417->input_correction[chan->channel];
> +			*val2 = ((u64)(1 << MAX34417_PWR_AVG_FULL_SCALE_BITS) *

Why not BIT_ULL() and drop that casting altogether? Also seems that it becomes
64-bit division. Does it compile on 32-bit?

> +				 MAX34417_FAST_SPS_CAM) / MILLI;
> +
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = max34417->cam_mode;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int max34417_read_label(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       char *label)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +	const char *input_label = max34417->input_label[chan->channel];
> +
> +	if (chan->type == IIO_VOLTAGE) {
> +		if (input_label)
> +			return sysfs_emit(label, "%s-voltage\n", input_label);
> +
> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
> +	}
> +
> +	if (chan->type == IIO_POWER) {
> +		if (input_label)
> +			return sysfs_emit(label, "%s-power\n", input_label);
> +
> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
> +	}
> +
> +	if (chan->type == IIO_ENERGY) {
> +		if (input_label)
> +			return sysfs_emit(label, "%s-energy\n", input_label);
> +
> +		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
> +	}
> +
> +	return 0;
> +}

This can be simplified, right?

	if (input_label) {
		switch (chan->type) {
		case IIO_VOLTAGE:
			return sysfs_emit(label, "%s-voltage\n", input_label);
		...
		default:
			return 0;
		}
	}

	switch (chan->type) {
	case IIO_VOLTAGE:
		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
	...
	default:
		return 0;
	}

...

> +	mutex_init(&max34417->lock);

Why not devm_mutex_init()?

...

> +	/* Set default input correction for all channels */
> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)

	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++)

> +		max34417->input_correction[i] =
> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);

...

> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +						      &rsense);

Name the variable with units, rsense_mOhm.

> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading shunt property of %pfwP\n",
> +						node);
> +
> +			if (!rsense || rsense < MAX34417_MIN_RSENSE ||
> +			    rsense > MAX34417_MAX_RSENSE)

Please, make it logically split

			// also == 0 is okay for the actual values
			// (which have not a semantic of pointer or error)
			if (rsense == 0 ||
			    rsense < MAX34417_MIN_RSENSE || rsense > MAX34417_MAX_RSENSE)

> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid shunt value %d of %pfwP\n",
> +						     rsense, node);
> +
> +			max34417->input_correction[index] =
> +				max34417_calc_input_correction(rsense);
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


