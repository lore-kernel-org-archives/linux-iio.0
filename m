Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E812D6E64;
	Wed,  1 Apr 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055386; cv=none; b=QBvdXcGjGBSTMNh17MajnIME275yq/qODFjmACF7Ks0pSSFQky7SyVDTtFMXmDfl62Ms7AbcVVCEOZFvy0uQPcmlm93WwUP7l/NsqEb+DfDx+Mc6aymcZfMBJZ7TjDhmgMhWu18HU2K7Dv7d5FLwD2G5Qt7Dfsmj6ydfkRhrQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055386; c=relaxed/simple;
	bh=Na6QdVzB5X2Njts1Jk0JMdNAgFhIRwHXWM8X6NO+KEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyX1wEUTBpAyHYeLRvMgg8cWIGetYpRJgX0C4h9lTT4frmUeNAhnywwzvO+bfWQq1u17CKI4EAi7cDVUl9TqHjkFTmA6pQ4E4p9KrsrW4HebQDaDWynqFo8RKhBo2w9t4lEX3DIEg1w9wTFAKRcKBXoSQ+9NIVyI+gYhN4XV+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwQztQN0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwQztQN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775055384; x=1806591384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Na6QdVzB5X2Njts1Jk0JMdNAgFhIRwHXWM8X6NO+KEg=;
  b=MwQztQN04hfs5ff9Wl0VFRriFldhqv7+J1Otv5u1yikc5aoyiw5/AS4X
   KY+5qr0NU0jdmP0lfXqv2NbtmUbG7KZKk4G8NZHkMZpbR3QzjieJWUX+Y
   0Fm4Ca6C3JCnPWtPgI6sz8SEX+4Xiy1vs1BVYyjCearFzLh5iBRhjXWkp
   Ft2EOCe6l2x5XRx4KaZ9Qs4V9ReNguXyZujGD60ak330tY/K9c36x4aJb
   JWpyMPVmA1Foj6sPhyMYOShsEIWZ0tar1mNp60g4ZIhXMttmMo2wg4Fda
   B77MfQvHUNMEQ0pMCjD0z171QJl8B0b18TetjrSPebuwlQbtDdgCsI6Uv
   w==;
X-CSE-ConnectionGUID: 45DUvV8GQJanttY+OQM6rg==
X-CSE-MsgGUID: knTddtNhQ46xpeHxoV3bDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87554721"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87554721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:56:24 -0700
X-CSE-ConnectionGUID: yLmvNsUbT6ubf/xvDNtHvw==
X-CSE-MsgGUID: ZRnN5pVnQGavXQ8dqJC13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="228315258"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:56:20 -0700
Date: Wed, 1 Apr 2026 17:56:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <ac0yEfGzqsbkZh86@ashevche-desk.local>
References: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
 <20260401-dev_ad5706r-v4-2-a785184a8d53@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-dev_ad5706r-v4-2-a785184a8d53@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 06:20:04PM +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed

...

> ---
> Changes since v1:
>   - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
>   - Removed all custom ext_info sysfs attributes
>   - Simplified to basic raw read/write and read-only scale
>   - SPI read/write can handle multibyte registers
> ---

A bit confusing to have this changelog w/o having v3..v4 ones.

...

> +config AD5706R
> +	tristate "Analog Devices AD5706R DAC driver"
> +	depends on SPI

Shouldn't you select REGMAP?

> +	help
> +	  Say yes here to build support for Analog Devices AD5706R 4-channel,
> +	  16-bit current output DAC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5706r.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>

> +#include <linux/device.h>

Not used, but dev_printk.h is missing.

> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>

> +#include <linux/errno.h>

No need (in most cases) when err.h is included.

> +#include <linux/iio/iio.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

Based on the above comments, please revisit the header block.

...

> +struct ad5706r_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +
> +	u8 tx_buf[4] __aligned(ARCH_DMA_MINALIGN);

Don't we have specific IIO macro for that?

> +	u8 rx_buf[4];
> +};

...

> +static int ad5706r_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes;

Currently only 1 and 2 bytes are supported, right? Any updates are planned on
this in the future?

> +	u16 reg;
> +
> +	reg = get_unaligned_be16(data);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.len = num_bytes + 2,
> +	};
> +
> +	memcpy(st->tx_buf, data, count);
> +
> +	/* For single byte, copy the data to the correct position */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		st->tx_buf[2] = st->tx_buf[3];
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}
> +
> +static int ad5706r_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes;
> +	u16 reg, cmd;
> +	int ret;
> +
> +	reg = get_unaligned_be16(reg_buf);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	/* Full duplex, device responds immediately after command */
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +		.len = 2 + num_bytes,
> +	};
> +
> +	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> +	put_unaligned_be16(cmd, st->tx_buf);

> +	memset(st->tx_buf + 2, 0, num_bytes);

I would use &st->tx_buf[2] here and below for the sake of consistency with
put_unaligned_*().

> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Ignore the first two bytes (echo during command) */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		put_unaligned_be16(st->rx_buf[2], val_buf);

The comment wants to explain why it's required to put 2 bytes anyway.

> +	else
> +		memcpy(val_buf, st->rx_buf + 2, num_bytes);

However with the above question in mind, if it's all about 1 or 2 bytes, can't
we simply use the same approach everywhere, like put_unaligned_*()?

> +	return 0;
> +}

...

> +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)

Better to use logical split (here and elsewhere where appropriate)

static int ad5706r_read_raw(struct iio_dev *indio_dev,
			    struct iio_chan_spec const *chan,
			    int *val, int *val2, long mask)

...

> +	st->regmap = devm_regmap_init(&spi->dev, &ad5706r_regmap_bus,
> +				      st, &ad5706r_regmap_config);

Use

	struct device *dev = &spi->dev;

at the top of the function to make this look better.

> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +				     "Failed to init regmap");

Missing \n.

-- 
With Best Regards,
Andy Shevchenko


