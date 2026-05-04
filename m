Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B57212548;
	Mon,  4 May 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889938; cv=none; b=TvXmdJ2I8in1tsuh2gLZYAdP/2L2MpzkGmdfptgtAXhq8CIEKDZFtsEPd9/XTTQNpvjplqheuQhrisxfKyeHVMP34a8t65s9HWU3LvR0W2R6vet/LgDKUn9TpcYnobtot8bgrfsvhNlVx5bbX93KZxhaEPV+Es1EvZhtLPK1g3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889938; c=relaxed/simple;
	bh=MfqW51JtMJ67r9GG1AsdY0vX48ujiBVmEXYA49YFM3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvpmQ5nasnEApmui9bPyA9V2ynGv2Y1oZFQs66K6hJWmVY6fVaI6l91W70j4CApQryfXoTH3Vq02nz+mpIHLa/GoZsdhyKBV+KX7tcGBKTLr7hYm5jTNkgR35UB/DJnlZwmbugfNoeO/PEsXj2sAIJtV84mWUxMcP1dxA0LaNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiE5pVM9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiE5pVM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777889936; x=1809425936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MfqW51JtMJ67r9GG1AsdY0vX48ujiBVmEXYA49YFM3o=;
  b=hiE5pVM9+xBtgYc40cVnNo2pQEMifT+NLkV/fKR1zc4quoa2AbJlYpfO
   TpwH4C5gdXighQWV8GfHT6hJ+IY0WLxsyBQ9WJNST+/jIY8tPC+M1SVSC
   lHDIZgn8OY6Gzcf2j/uVeeSnt+3X6zYLV65sSFSoksiqHpdKdEQNsGLR1
   rq3zutKXd1CqDsPmX8ujtgjVC9l/toLRFK/H/e3yFoqBxoZJoWVk9i9K+
   4PtmJvMpko4FtjESawI5cOkDlZYqvxKdaLEI97lAJmQ6wS8EOJcQXKHE9
   JKZLsDiUitUEiFZ544GxMvltCt28p1Es/dEhiiUbUTnN2ouTnLKzab9fG
   A==;
X-CSE-ConnectionGUID: W2vHQUdXTe2vYZOe5NvjHQ==
X-CSE-MsgGUID: 2Z9+KgInSFiMVkjYtV9/Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78770063"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78770063"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:18:55 -0700
X-CSE-ConnectionGUID: 3t7R4yJXTIqKPNw2SMP61w==
X-CSE-MsgGUID: +7+te4ubTaeIATq9jQ7uRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234453383"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:18:51 -0700
Date: Mon, 4 May 2026 13:18:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
	conall.ogriofa@amd.com, erimsalih@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
Message-ID: <afhyiW_5embow_hx@ashevche-desk.local>
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-3-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502111951.538488-3-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 02, 2026 at 12:19:48PM +0100, Salih Erim wrote:
> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
> 
> The driver is split into a bus-agnostic core module
> (versal-sysmon-core) and a memory-mapped I/O platform driver
> (versal-sysmon). The core uses the regmap API so that different
> bus implementations can share the same IIO logic.
> 
> The core provides:
>   - Static temperature channels (current max/min, peak max/min)
>   - Supply voltage channels parsed from DT container nodes
>   - Temperature satellite channels parsed from DT container nodes
>   - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>   - read_label using the DT label property
> 
> The MMIO platform driver provides:
>   - Memory-mapped register access via custom regmap callbacks
>   - NPI unlock before every register write (platform management
>     controller may re-lock NPI unpredictably on Versal devices)
> 
> Threshold events, oversampling, and I2C bus support are added in
> subsequent patches.

...

IWYU please:

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

+ string.h
+ types.h

(and maybe more that I missed).


...

> +#define SYSMON_CHAN_TEMP(_chan, _address, _ext) {		\
> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\
> +	.address = _address,					\
> +	.channel = _chan,					\

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_PROCESSED),			\

It's better to use the following style:

	.info_mask_separate =					\
		BIT(IIO_CHAN_INFO_RAW) |			\
		BIT(IIO_CHAN_INFO_PROCESSED),			\


> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 15,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = _ext,					\
> +}

...

> +static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
> +{
> +	*val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;

No casting is needed, just make the type s16 to begin with.

> +}

...

> +static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
> +{
> +	int mantissa, format, exponent;
> +
> +	mantissa = FIELD_GET(SYSMON_MANTISSA_MASK, raw_data);
> +	exponent = SYSMON_SUPPLY_MANTISSA_BITS - FIELD_GET(SYSMON_MODE_MASK, raw_data);
> +	format = FIELD_GET(SYSMON_FMT_MASK, raw_data);
> +	/*
> +	 * When format bit is set the mantissa is two's complement
> +	 * (per hardware spec); sign-extend to int for correct arithmetic.
> +	 */
> +	if (format)
> +		mantissa = (int)(s16)mantissa;

Potential user of FIELD_GET_SIGNED(), but for now just use explicit call to
sign_extend32().

> +	*val = (mantissa * SYSMON_MILLI) >> exponent;
> +}

...

> +static int sysmon_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)

Use logical split:

static int sysmon_read_raw(struct iio_dev *indio_dev,
			   struct iio_chan_spec const *chan, int *val, int *val2,
			   long mask)

OR (to be strict in 80 limit)

static int sysmon_read_raw(struct iio_dev *indio_dev,
			   struct iio_chan_spec const *chan,
			   int *val, int *val2, long mask)

> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW && mask != IIO_CHAN_INFO_PROCESSED)
> +		return -EINVAL;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		ret = regmap_read(sysmon->regmap, chan->address, &regval);
> +		if (ret)
> +			return ret;
> +		if (mask == IIO_CHAN_INFO_PROCESSED)
> +			sysmon_q8p7_to_millicelsius(regval, val);
> +		else
> +			*val = (int)regval;

Why casting?

> +		return IIO_VAL_INT;
> +
> +	case IIO_VOLTAGE:
> +		ret = regmap_read(sysmon->regmap,
> +				  (chan->address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_BASE,
> +				  &regval);
> +		if (ret)
> +			return ret;
> +		if (mask == IIO_CHAN_INFO_PROCESSED)
> +			sysmon_supply_rawtoprocessed(regval, val);
> +		else
> +			*val = (int)regval;

Ditto.

> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +/**
> + * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
> + * @indio_dev: IIO device instance
> + * @dev: Parent device
> + *
> + * Reads supply-channels and temperature-channels container nodes from
> + * firmware and builds the IIO channel array. Static temperature channels
> + * are prepended, followed by supply and satellite channels from DT.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	unsigned int idx, temp_chan_idx, volt_chan_idx;
> +	struct fwnode_handle *supply_node, *temp_node;

> +	unsigned int num_supply = 0, num_temp = 0;

Better for maintenance to split these assignments and perform them when they
are really needed.

> +	struct iio_chan_spec *sysmon_channels;
> +	const char *label;
> +	u32 reg;
> +	int ret;

> +	supply_node = device_get_named_child_node(dev, "supply-channels");

Use what cleanup.h provides you,

> +	if (supply_node)
> +		num_supply = fwnode_get_child_node_count(supply_node);
> +
> +	temp_node = device_get_named_child_node(dev, "temperature-channels");
> +	if (temp_node)
> +		num_temp = fwnode_get_child_node_count(temp_node);

As per above.

> +	sysmon_channels = devm_kcalloc(dev,
> +				       ARRAY_SIZE(temp_channels) +
> +				       num_supply + num_temp,

Each of num_supply and num_temp may lead to overflow on 32-bit machines.

> +				       sizeof(*sysmon_channels), GFP_KERNEL);
> +	if (!sysmon_channels) {
> +		ret = -ENOMEM;
> +		goto err_put;
> +	}
> +
> +	/* Static temperature channels first (fixed indices) */
> +	idx = 0;
> +	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
> +	idx += ARRAY_SIZE(temp_channels);
> +
> +	/* Supply channels from DT */

> +	if (supply_node) {

Why? Do you expect the below loop to go on this being NULL?

> +		fwnode_for_each_child_node_scoped(supply_node, child) {
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
> +			if (ret < 0)
> +				goto err_put;
> +
> +			if (reg > SYSMON_SUPPLY_IDX_MAX) {
> +				ret = -EINVAL;
> +				dev_err(dev, "supply reg %u exceeds max %u\n",
> +					reg, SYSMON_SUPPLY_IDX_MAX);
> +				goto err_put;
> +			}
> +
> +			ret = fwnode_property_read_string(child, "label",
> +							  &label);
> +			if (ret < 0)
> +				goto err_put;
> +
> +			sysmon_channels[idx++] = (struct iio_chan_spec) {
> +				.type = IIO_VOLTAGE,
> +				.indexed = 1,
> +				.address = reg,
> +				.info_mask_separate =
> +					BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_PROCESSED),
> +				.scan_type = {
> +					.realbits = 19,
> +					.storagebits = 32,
> +					.endianness = IIO_CPU,
> +					.sign = fwnode_property_read_bool(child,
> +						"bipolar") ? 's' : 'u',
> +				},
> +				.datasheet_name = label,
> +			};
> +		}
> +		fwnode_handle_put(supply_node);
> +		supply_node = NULL;
> +	}
> +
> +	/* Temperature satellite channels from DT */
> +	if (temp_node) {

As per above.

> +		fwnode_for_each_child_node_scoped(temp_node, child) {
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
> +			if (ret < 0)
> +				goto err_put;
> +
> +			if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX) {
> +				ret = -EINVAL;
> +				dev_err(dev, "temp reg %u out of range [1..%u]\n",
> +					reg, SYSMON_TEMP_SAT_MAX);
> +				goto err_put;
> +			}
> +
> +			ret = fwnode_property_read_string(child, "label",
> +							  &label);
> +			if (ret < 0)
> +				goto err_put;
> +
> +			sysmon_channels[idx++] = (struct iio_chan_spec) {
> +				.type = IIO_TEMP,
> +				.indexed = 1,
> +				.address = SYSMON_TEMP_SAT_BASE +
> +					   ((reg - 1) * SYSMON_REG_STRIDE),
> +				.info_mask_separate =
> +					BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_PROCESSED),
> +				.scan_type = {
> +					.sign = 's',
> +					.realbits = 15,
> +					.storagebits = 16,
> +					.endianness = IIO_CPU,
> +				},
> +				.datasheet_name = label,
> +			};
> +		}
> +		fwnode_handle_put(temp_node);
> +		temp_node = NULL;
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
> +	for (idx = 0; idx < indio_dev->num_channels; idx++) {
> +		if (sysmon_channels[idx].type == IIO_TEMP)
> +			sysmon_channels[idx].channel = temp_chan_idx++;
> +		else
> +			sysmon_channels[idx].channel = volt_chan_idx++;
> +	}
> +
> +	indio_dev->channels = sysmon_channels;
> +
> +	return 0;
> +
> +err_put:
> +	fwnode_handle_put(supply_node);
> +	fwnode_handle_put(temp_node);
> +	return ret;
> +}

...

> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

As per above, please respect and follow IWYU principle.

...

> +static int sysmon_platform_probe(struct platform_device *pdev)
> +{
> +	struct sysmon_mmio *mmio;
> +	struct regmap *regmap;
> +	int irq;
> +
> +	mmio = devm_kzalloc(&pdev->dev, sizeof(*mmio), GFP_KERNEL);
> +	if (!mmio)
> +		return -ENOMEM;
> +
> +	mmio->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio->base))
> +		return PTR_ERR(mmio->base);
> +
> +	regmap = devm_regmap_init(&pdev->dev, NULL, mmio,

Using

	struct device *dev = &pdev->dev;

at the top of the function makes this code neater and probably a single line.

> +				  &sysmon_mmio_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	irq = platform_get_irq_optional(pdev, 0);
> +
> +	return sysmon_core_probe(&pdev->dev, regmap, irq);
> +}

...

> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>

Ditto for the header files, use and follow the IWYU principle.

...

> +/* Signed milli scale (MILLI from linux/units.h is unsigned long) */
> +#define SYSMON_MILLI			1000

I think you want a different approach. I already forgot how it's being used,
but there shouldn't be a new (re-)definition just because of this.

-- 
With Best Regards,
Andy Shevchenko


