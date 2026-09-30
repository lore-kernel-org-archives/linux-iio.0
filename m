Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E73546F0;
	Wed, 30 Sep 2026 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759846; cv=none; b=W5O/P5XXxIbc1v+PIMwJPK+/CofIRUYAQWjtFw3lN69+JIuaozqoJhutz4XYExt0/74ky5Q4MyuSBryq/u9awwN0if198a4L5AL4iHJp3FEp8cAJHcqPy6ZTwNXXVxVeGcT84rOuVr/GUPVaB3FWOTzCptN0V0sIJBeet0XyeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759846; c=relaxed/simple;
	bh=Nk/5vCA1YYKvyQ+qRMCZROlFoMgTTXoIA0a8Wr2lKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGlgAeXQTN55enVCGGn85A/gbfjv5uz4j7vQLgRJRqi3Y68YxQHeHZaY/u58EYz9aAdzyfUJactLi7zD3voKiiNqwAX9tKzqlpTjX2Z7HWDcbnMfDZTsyK49Mjd5xtwfqQeAmf0QS01ADHtK3PYNADpKqCrEcF2SdruN/H90jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG4ZsZF8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG4ZsZF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790759845; x=1822295845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nk/5vCA1YYKvyQ+qRMCZROlFoMgTTXoIA0a8Wr2lKfw=;
  b=RG4ZsZF8RjBWbrNwNsPbxIAov2ob4FqdHfUg+tHFPIPgx0F82sbZimKk
   nwxI2j3xo/+lYmMoV8uRrT4vjjnYnmH6KGDgQlkjVpnAgg7tPLI3Xinyh
   4K+TupdxN033TWfh5DdQv0khGBcguDefL09jZ29CTZUOtIOs0CXCtyBhM
   3hnS5MYZcN8l4Tb+WFdHTOPmUjG8wrliqNPL/G764YT1zbHuuluRiYcng
   hxJq7okzXwxsU/QwTMDHAXk6zv29nYOX8353wwN853WG0Dp0niSHeO3q7
   kZvt6VmBXJwRJpdPnvBo8lQBiIsKKsHnbN9vvkdNtRGEVaVC2lXfjCeSC
   Q==;
X-CSE-ConnectionGUID: zV/J0PnpTyKlyeTkUr2BDg==
X-CSE-MsgGUID: OXoPOneUT960hkwnTUQW1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90709636"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90709636"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:17:24 -0700
X-CSE-ConnectionGUID: cSYNOYQpRwiKfHwNMgnFlQ==
X-CSE-MsgGUID: benoAbT9Rte70rV82o9MrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274831194"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:17:18 -0700
Date: Wed, 30 Sep 2026 12:17:16 +0300
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
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: dac: Add AD5529R DAC driver support
Message-ID: <arzTnOTaL97GudZM@ashevche-desk.local>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 01:41:08PM +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.

You haven't added a given tag, why?

In any case I have noticed that there are a number of (not so critical) issues
are still exists, so I have to withdraw my tag. But please, answer the above Q.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>

> +#include <linux/err.h>
> +#include <linux/errno.h>

The second one is not needed in this case.

> +#include <linux/iio/iio.h>

> +#include <linux/mod_devicetable.h>

No new code with this header. Uwe did some rework WRT this header.

> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +#define AD5529R_REG_INTERFACE_CONFIG_A		0x00

Use fixed-width values for all register offsets, e.g., here 0x000.

...

> +#define AD5529R_SPI_READ_FLAG			0x80

Isn't this a default in regmap SPI? Just asking, I don't remember by heart
the answer.

...

> +#define AD5529R_DAC_CHANNEL(chan) ((struct iio_chan_spec) {		\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.output = 1,							\
> +	.channel = (chan),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +})

Please, remove unneeded (outer) parentheses.

...

> +struct ad5529r_state {
> +	struct spi_device *spi;

Not used. And the device pointer may be derived from regmap, so drop this.

> +	const struct ad5529r_model_data *model_data;
> +	struct regmap *regmap_8bit;
> +	struct regmap *regmap_16bit;
> +	struct iio_chan_spec channels[16];
> +	unsigned int num_channels;
> +	enum ad5529r_output_range output_range_idx[16];
> +};

...

> +static int ad5529r_reset(struct ad5529r_state *st)
> +{

So, basically here you can

	struct regmap *map = ad5529r_get_regmap(st, AD5529R_REG_INTERFACE_CONFIG_A);
	struct device *dev = regmap_get_device(regmap);

> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret = reset_control_assert(rst);
> +		if (ret)
> +			return ret;
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

This is an unfinished review of some old submission. If anything, please check
it and update the driver either in a new round or consider followups.

-- 
With Best Regards,
Andy Shevchenko


