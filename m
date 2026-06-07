Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19825226CFE;
	Sun,  7 Jun 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819576; cv=none; b=r9ndvVuB24yjOHRl+/9X54KRwvia+uoYHDfq1ChUj8t6DIegFL2CrowVg327u3tLDAamADKdinq1/IIMpLeOReDXliA/sbAviiw4qm85+NOAauedjn7280BEtDTVwsQxL7+yIlwUVj7t5JGA9CJZ9ty4v4XK7YzmhJZxsLGWW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819576; c=relaxed/simple;
	bh=84jFY7sFy49AckbiggH2Y64z6Sg4I2WkeR40M7Qx8CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfkLEyxRMbKKXFe/unYWpnepWEaaD0rkQlJkuJgj4t+SYgHqYKcDkyw8WIINzwjtXK6clm9kaQeaBEgkFXQ6HbkUbU5FVu3/0D330NBcJTsklRMu4xyDnVraEXIIphZNDXL+bPozoL1v5QdYyquW1rZbu00csDRSYbGBavSohLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cakz39Uw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cakz39Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780819575; x=1812355575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=84jFY7sFy49AckbiggH2Y64z6Sg4I2WkeR40M7Qx8CY=;
  b=cakz39Uwxd+AcP6fIImYORCNdeIsZ0XLvtqCc5Y33HMN3dw9yb6Xs6O/
   iwEUWWMFjaSbywhF7tkKHkvtzxqRANtgSqP66AEEMV+B7huLpOE0zJ9+H
   Xajg/FjAUiekRMByYNA8CSdnOY7NZ73uC9r9J/xWAE8tDXyvW5sTns1d1
   4DNT3P6CwvRu0hJD0kUY5d98LjofPMcT8tQxzFRzevXVlkB++zNeB+kZ8
   iOm5CYWVqCZ1+l/yIwmF9J6cF8pQcm1qya0Aj/RP61Sz3PSj9SXl9uc4X
   bnITjfWi5sjUoQsPsVt+qd+gg5SPZtQXgsXyzJXeoFhq2ynlyyms6o7G7
   Q==;
X-CSE-ConnectionGUID: ljzJsHrVRfKIQm1pdCdKZg==
X-CSE-MsgGUID: uoTJuVoXReOISOnDiHJA+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="81768227"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="81768227"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 01:06:14 -0700
X-CSE-ConnectionGUID: 6B9Nar2kQnCQdxF2f3rK7w==
X-CSE-MsgGUID: g3T7BpbnS8WOAC79SEbPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="275436350"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.86])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 01:06:10 -0700
Date: Sun, 7 Jun 2026 11:06:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: adc: add Versal SysMon driver
Message-ID: <aiUmb0WMPHi0D6GH@ashevche-desk.local>
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-3-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606051707.535281-3-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 06:17:04AM +0100, Salih Erim wrote:
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
> The driver is split into three compilation units:
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

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>

+ err.h

> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "versal-sysmon.h"

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
> +			*val = (int)MILLI;

Casting is not required here.

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
> +		*val = (s16)regval;

Basically you want to use sign_extend32(regval, 15) for consistency.

> +		return IIO_VAL_INT;
> +
> +	case IIO_VOLTAGE:
> +		if (mask != IIO_CHAN_INFO_PROCESSED)
> +			return -EINVAL;
> +
> +		ret = regmap_read(sysmon->regmap,
> +				  (chan->address * SYSMON_REG_STRIDE) +

Unneeded parentheses.

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
> +	unsigned int num_supply = 0, num_temp = 0;
> +	unsigned int idx, temp_chan_idx, volt_chan_idx;
> +	struct iio_chan_spec *sysmon_channels;
> +	const char *label;
> +	u32 reg;
> +	int ret;
> +
> +	struct fwnode_handle *supply_node __free(fwnode_handle) =
> +		device_get_named_child_node(dev, "voltage-channels");

> +	if (supply_node)

Do you need this check? IIRC the below is NULL-aware.

> +		num_supply = fwnode_get_child_node_count(supply_node);
> +
> +	struct fwnode_handle *temp_node __free(fwnode_handle) =
> +		device_get_named_child_node(dev, "temperature-channels");
> +	if (temp_node)

Same Q here?

> +		num_temp = fwnode_get_child_node_count(temp_node);
> +
> +	sysmon_channels = devm_kcalloc(dev,
> +				       size_add(ARRAY_SIZE(temp_channels),
> +						num_supply + num_temp),

size_add() should be called twice.

> +				       sizeof(*sysmon_channels), GFP_KERNEL);
> +	if (!sysmon_channels)
> +		return -ENOMEM;

...

> +	/* Temperature satellite channels from DT */
> +	fwnode_for_each_child_node_scoped(temp_node, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret < 0)

Can fwnode APIs like this return positive? If so, what is the meaning of that
and why do we ignore it?

> +			return dev_err_probe(dev, ret,
> +					     "missing reg for temp channel\n");
> +
> +		if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "temp reg %u out of range [1..%u]\n",
> +					     reg, SYSMON_TEMP_SAT_MAX);
> +
> +		ret = fwnode_property_read_string(child, "label", &label);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "missing label for temp channel\n");
> +
> +		sysmon_channels[idx++] = (struct iio_chan_spec) {
> +			.type = IIO_TEMP,
> +			.indexed = 1,
> +			.address = SYSMON_TEMP_SAT_BASE +
> +				   ((reg - 1) * SYSMON_REG_STRIDE),

Too many parentheses.

> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.info_mask_shared_by_type =
> +				BIT(IIO_CHAN_INFO_SCALE),
> +			.datasheet_name = label,
> +		};
> +	}

...

> +	for (idx = 0; idx < indio_dev->num_channels; idx++) {

	for (unsigned int idx = 0; idx < indio_dev->num_channels; idx++) {

?

> +		if (sysmon_channels[idx].type == IIO_TEMP)
> +			sysmon_channels[idx].channel = temp_chan_idx++;
> +		else
> +			sysmon_channels[idx].channel = volt_chan_idx++;
> +	}

...

> +/**
> + * sysmon_core_probe() - Initialize Versal SysMon core
> + * @dev: Parent device
> + * @regmap: Register map for hardware access
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int sysmon_core_probe(struct device *dev, struct regmap *regmap)

I'm wondering if the @regmap is the same as you can get from @dev via
respective API.

...

+ err.h // covers IS_ERR(), -Exxx

> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

+ types.h // covers NULL, __iomem

IWYU, please.

> +#include "versal-sysmon.h"
> +
> +struct sysmon_mmio {
> +	void __iomem *base;

__iomem is not defined in the above headers.

> +};

...

> +static int sysmon_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sysmon_mmio *mmio;
> +	struct regmap *regmap;
> +
> +	mmio = devm_kzalloc(dev, sizeof(*mmio), GFP_KERNEL);
> +	if (!mmio)
> +		return -ENOMEM;
> +
> +	mmio->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio->base))
> +		return PTR_ERR(mmio->base);

IS_ERR() is not provided in the headers included.

> +
> +	regmap = devm_regmap_init(dev, NULL, mmio, &sysmon_mmio_regmap_config);

NULL is not defined in the above headers.

> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return sysmon_core_probe(dev, regmap);
> +}

...

> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD Versal SysMon driver
> + *
> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _VERSAL_SYSMON_H_
> +#define _VERSAL_SYSMON_H_
> +
> +#include <linux/bits.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct device;
> +struct iio_dev;
> +struct regmap;
> +
> +/* Register offsets (sorted by address) */
> +#define SYSMON_NPI_LOCK			0x000C
> +#define SYSMON_ISR			0x0044
> +#define SYSMON_IDR			0x0050
> +#define SYSMON_TEMP_MAX			0x1030
> +#define SYSMON_TEMP_MIN			0x1034
> +#define SYSMON_SUPPLY_BASE		0x1040
> +#define SYSMON_TEMP_MIN_MIN		0x1F8C
> +#define SYSMON_TEMP_MAX_MAX		0x1F90
> +#define SYSMON_TEMP_SAT_BASE		0x1FAC
> +#define SYSMON_MAX_REG			0x24C0
> +
> +/* NPI unlock value written to SYSMON_NPI_LOCK */
> +#define SYSMON_NPI_UNLOCK_CODE		0xF9E8D7C6
> +
> +/* Register stride: 4 bytes per 32-bit register */
> +#define SYSMON_REG_STRIDE		4
> +
> +#define SYSMON_SUPPLY_IDX_MAX		159
> +#define SYSMON_TEMP_SAT_MAX		64
> +#define SYSMON_INTR_ALL_MASK		GENMASK(31, 0)
> +
> +/* Supply voltage conversion register fields */
> +#define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
> +#define SYSMON_FMT_MASK			BIT(16)
> +#define SYSMON_MODE_MASK		GENMASK(18, 17)
> +
> +/* Q8.7 fractional shift */
> +#define SYSMON_FRACTIONAL_SHIFT		7U
> +#define SYSMON_SUPPLY_MANTISSA_BITS	16
> +
> +/**
> + * struct sysmon - Driver data for Versal SysMon
> + * @regmap: register map for hardware access
> + * @lock: protects read-modify-write sequences on threshold registers
> + *        and cached state that spans multiple regmap calls
> + */
> +struct sysmon {
> +	struct regmap *regmap;
> +	/*
> +	 * Protects read-modify-write sequences on threshold registers
> +	 * and cached state (oversampling ratios, hysteresis values)
> +	 * that spans multiple regmap calls.
> +	 */
> +	struct mutex lock;
> +};
> +
> +int sysmon_core_probe(struct device *dev, struct regmap *regmap);
> +
> +#endif /* _VERSAL_SYSMON_H_ */
> -- 
> 2.48.1
> 

-- 
With Best Regards,
Andy Shevchenko


