Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627830FF1D;
	Fri, 28 Aug 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904572; cv=none; b=BFkNKdfzj1ORC8wQHjB3g5QeC33eGVDjfuYuQcJfmbUzsnpHvxcVkbqNFQUr7e5uLVIuAKgZ4AnKwjJwzc5SKrxG5jyuuyXnM71TlW971nqw8l5jfuVXyC3IsNf1EoNsFllBXmjl4q3wHprfI9QiWBLorL26aNzaaYwXLRqj7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904572; c=relaxed/simple;
	bh=hnN/T3gvx0s9WO+rWPJBZldaRBt41IE9D/vXA+ppHi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6sXH5aSGRV4f2L0GTAU9Tr3RDtqZrMfAIS9KMFLnYUVih0NIvYTGYtuNXQys6eP9aShmn7cWNC/idS26WDs/O2mUBML55N0fShTwXzqCSea+Y2mVdZjtnzQQvy7E38kkdE2gR7SweHmKKuxNleZ+awbN3MYb70sVqgg7L6XCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLo4Fn2C; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLo4Fn2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787904571; x=1819440571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hnN/T3gvx0s9WO+rWPJBZldaRBt41IE9D/vXA+ppHi4=;
  b=KLo4Fn2C62xW3R+8R6anrrBnck8g0QQJkpJM3H2YVshfQUZt9SO9bPIu
   wxpIFLGOeBK44YU5q8TwqQvVRRkaVg9UQ1HSzTig7d70WLzx7em2GtGpZ
   kv8IdAeqvb2vWNu80s0kg+1dN/2JZZgO3Jp9At3yqi3gkKnnOXwuB2efl
   vNYLdtInLyAX8jKaBH+yfKqkLS2rBcunQk3/O0BLRVWyNeecjOQD84muj
   5mMh2PoErUyZRadDHq0S/L/mm0/NtnsVaH8mZ+4WfUWCcCO61JXP03joe
   4RikAvCBIt4jbvrYohdzR3M4tJkscCXPca+B5YI3Yx7AG+KezgJRLhxYa
   Q==;
X-CSE-ConnectionGUID: iJDdWwfrRNyyu3reWvzgmA==
X-CSE-MsgGUID: NgJ+XCPTSiitdc53gwqStA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99571087"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99571087"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:09:30 -0700
X-CSE-ConnectionGUID: ePNJRN1vS1mMz6p8zaYGow==
X-CSE-MsgGUID: l8kmGZ++QtGoAjv3QmZI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="264324764"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:09:26 -0700
Date: Fri, 28 Aug 2026 11:09:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
Message-ID: <apFCNNzhPfq0T6rn@ashevche-desk.local>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 01:38:18AM -0500, Kurt Borja wrote:
> Add the ti-ads1262 driver with initial support for the primary ADC
> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
> and interoperability considerations were taken into account.
> 
> Various features such as accurate timeout delays, per-channel reference
> sources, scale, offset, settling latency, excitation currents and
> diagnostics are intentionally left out for future support.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>

> +#include <linux/compiler_attributes.h>

This one is covered by types.h.

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/lockdep.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>

...

> +/*
> + * The power transition timing requirement is 65536 clock cycles, at the minimum
> + * clock frequency this is 65536 microseconds.
> + */
> +#define ADS1262_POWER_TRANS_USECS		65536

_US as a suffix is enough. It's how in plenty of cases we do in the Linux
kernel.

> +#define ADS1262_NOMINAL_CLK_RATE		7372800

And here perhaps _Hz? What is the unit for this value?

...

> +static int ads1262_dev_send_cmd(struct ads1262 *st, u8 opcode)
> +{
> +	guard(mutex)(&st->xfer_lock);
> +
> +	return spi_write_then_read(st->spi, &opcode, sizeof(opcode), NULL, 0);
> +}
> +
> +static int ads1262_dev_read_by_cmd(struct ads1262 *st, u8 cmd, __be32 *val)
> +{
> +	guard(mutex)(&st->xfer_lock);
> +
> +	return spi_write_then_read(st->spi, &cmd, sizeof(cmd), val, sizeof(*val));
> +}

How do these do not conflict or race with regmap SPI communication?

...

> +static int ads1262_dev_reset(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *reset_gpiod;
> +	int ret;
> +
> +	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpiod),
> +				     "failed to get reset GPIO\n");

> +

Unneeded blank line. But can you use reset-gpio driver instead?

> +	if (reset_gpiod) {
> +		/*
> +		 * Wait a power transition cycle to ensure we are in a
> +		 * powered-off state after acquiring the RESET GPIO.
> +		 */
> +		fsleep(ADS1262_POWER_TRANS_USECS);
> +
> +		ret = gpiod_set_value_cansleep(reset_gpiod, 0);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(ADS1262_POWER_TRANS_USECS);
> +	} else {
> +		ret = ads1262_dev_send_cmd(st, ADS1262_OPCODE_RESET);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The RESET timing requirement is 8 clock cycles, at the
> +		 * minimum clock rate this is 8 microseconds.
> +		 */
> +		fsleep(8);
> +	}
> +
> +	return 0;
> +}

...

> +static int ads1262_wait_for_conversion(struct ads1262 *st)
> +{
> +	u64 max_lat_ms;
> +	long ret;
> +
> +	/*
> +	 * The first conversion latency is affected by the channel's data rate,
> +	 * filter, the configurable conversion delay and whether chop mode
> +	 * and/or IDAC rotation mode are enabled.
> +	 *
> +	 * The worst possible latency is calculated by taking the lowest data
> +	 * rate (2.5 SPS) and the sinc4 filter. This gives a latency of 1600 ms
> +	 * (Table 9-13). Then we scale it by the actual clock rate and multiply
> +	 * by 4 to account for chop and IDAC rotation modes (Equation 20).
> +	 */
> +	max_lat_ms = 4 * div_u64(1600ULL * ADS1262_NOMINAL_CLK_RATE, st->clk_rate);
> +	ret = wait_for_completion_interruptible_timeout(&st->drdy,
> +							msecs_to_jiffies(max_lat_ms));
> +	if (ret < 0)
> +		return ret;
> +	if (!ret)

In this case it's better to have number comparison as the semantics of 0 is
different to usual (success) code.

	if (ret == 0)

> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

...

> +static int ads1262_regmap_write(void *context, const void *data, size_t count)
> +{
> +	return ads1262_regmap_gather_write(context, data, 1, data + 1,
> +					   count - 1);

I would go for a single line of 82 characters.

> +}

...

> +static int ads1262_parse_channel_node(struct ads1262 *st,
> +				      struct iio_chan_spec *spec,
> +				      struct fwnode_handle *node)
> +{
> +	struct device *dev = &st->spi->dev;
> +	u32 pins[2];
> +	int ret;

Can this use the property names for 'single-channel' and 'diff-channels'?
This will deduplicate the same in a few places and reduce potential typos.

> +	if (fwnode_property_present(node, "single-channel")) {
> +		ret = fwnode_property_read_u32(node, "single-channel", &pins[0]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%pfwP: failed to read single-channel\n",
> +					     node);
> +
> +		pins[1] = ADS1262_INPMUX_AINCOM;
> +
> +		if (fwnode_property_present(node, "common-mode-channel")) {
> +			ret = fwnode_property_read_u32(node, "common-mode-channel", &pins[1]);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "%pfwP: failed to read common-mode-channel\n",
> +						     node);
> +		}
> +	} else if (fwnode_property_present(node, "diff-channels")) {
> +		ret = fwnode_property_read_u32_array(node, "diff-channels", pins,
> +						     ARRAY_SIZE(pins));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%pfwP: failed to read diff-channels\n",
> +					     node);
> +
> +		spec->differential = true;
> +	} else {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "%pfwP: one of single-channel or diff-channels is required\n",
> +				     node);
> +	}
> +
> +	if (pins[0] > ADS1262_INPMUX_AINCOM || pins[1] > ADS1262_INPMUX_AINCOM)
> +		return dev_err_probe(dev, -EINVAL, "%pfwP: input channels not in range\n", node);
> +
> +	spec->channel = pins[0];
> +	spec->channel2 = pins[1];
> +
> +	return 0;
> +}

...

> +static int ads1262_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *chan_specs;
> +	unsigned int num_fw_channels, num_specs;
> +	unsigned int i = 0;

Split assignment. Move it closer to the first user.

> +	u32 reg;
> +	int ret;
> +
> +	num_fw_channels = device_get_named_child_node_count(dev, "channel");
> +	if (num_fw_channels > ADS1262_FW_CHANNEL_COUNT)
> +		return dev_err_probe(dev, -EINVAL, "too many channels\n");
> +
> +	/* Account for the monitor channels and timestamp */
> +	num_specs = num_fw_channels + ADS1262_MON_CHANNEL_COUNT + 1;
> +	chan_specs = devm_kcalloc(dev, num_specs, sizeof(*chan_specs), GFP_KERNEL);
> +	if (!chan_specs)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, node, "channel") {
> +		struct iio_chan_spec *spec = &chan_specs[i];
> +
> +		ret = fwnode_property_read_u32(node, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%pfwP: failed to read channel reg\n", node);
> +		if (reg >= ADS1262_MONITOR_ADDR_OFFSET)
> +			return dev_err_probe(dev, -EINVAL, "%pfwP: reg out of range\n", node);
> +
> +		ret = ads1262_parse_channel_node(st, spec, node);
> +		if (ret)
> +			return ret;
> +
> +		spec->type = IIO_VOLTAGE;
> +		spec->indexed = true;
> +		spec->scan_index = i;
> +		spec->address = reg;
> +		spec->scan_type = (struct iio_scan_type) {
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = ADS1262_ADC1_RESOLUTION,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		};
> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +
> +		i++;
> +	}
> +
> +	memcpy(&chan_specs[i], ads1262_monitor_chan_specs,
> +	       sizeof(ads1262_monitor_chan_specs));
> +
> +	for (unsigned int mon = 0; mon < ADS1262_MON_CHANNEL_COUNT; mon++) {
> +		chan_specs[i].scan_index = i;
> +		i++;
> +	}
> +
> +	chan_specs[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
> +	i++;
> +
> +	indio_dev->channels = chan_specs;
> +	indio_dev->num_channels = i;
> +
> +	return 0;
> +}

...

> +	st->clk_rate = rate ? rate : ADS1262_NOMINAL_CLK_RATE;

Can use Elvis.

-- 
With Best Regards,
Andy Shevchenko


