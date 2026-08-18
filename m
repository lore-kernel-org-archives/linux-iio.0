Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6D3A5438;
	Tue, 18 Aug 2026 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067882; cv=none; b=suv5CxZMy2ciJYKmVfx4sBYP/qcKPYgWD5rOtiKdkb09mkt++KXtwJ95eYkc9uoqjuT379o4anQdwCzJtGikhsl6XJ44rGw1f7fj4aS6eCsVuhA6z5/PSn9cFMbRoQCIvUqkyTpYXY5z600+DDvSTvUiJsmma7vyxZqIYrn8UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067882; c=relaxed/simple;
	bh=kaZ/DCQFfukjqftzjjC/g3BE8SKxSNAEYhy6sSyxpbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIsVCwMKbW7KNpJi9uFC533zcaI6GYgW9+cJ8vIhVPK7kvg1YZkVQNBEAm4aX/V+eKCnlSezu0H/kdVBBMm/1QwWOEEczw0ky8bP6DppWDhhkrUVT3z6fu5kDS4AvDY4t25Wfdlb1RYxpUPo4O5B4+vFIg8vRP46/rh5391kf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyT63NIG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyT63NIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787067881; x=1818603881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaZ/DCQFfukjqftzjjC/g3BE8SKxSNAEYhy6sSyxpbY=;
  b=EyT63NIG5dF9LcwUJEU7j5wFJMiBVIAYG0g5frsIXQ0YWHnlLZsHzbBD
   yFzOeaxaErKY8A98xB0zp7qczR35b9MIXOMHYxqe0agIzMx0k8jbSfNrA
   4DMOQ0NhNR4ayu5URawbJcJas4GbCNobHRouNjsrvgOj9imrGzEk7nXS0
   Qr6hgxxZ9cLj6a6iBxk6eG6k0nHgJ0vlfGfUUP9+eee3N0WgJykB65JM+
   kI3j6P/1pkEJKQY52FEYzhw1jrTbUNZ2ZkCKTD1Zecrx7G+EcJPdrWLoc
   9AZkmC8nKtQVqWCJo456COhCt/k4mYvOGiJj+yPz6IMt9uhITXiwNjZus
   Q==;
X-CSE-ConnectionGUID: CvkKyoGzQ6Klxuq06KZfMw==
X-CSE-MsgGUID: eyYCNwqlSKaqfc7sPKH+vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91435161"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91435161"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:44:40 -0700
X-CSE-ConnectionGUID: S6wBh/QaTYqnxVViTraP0g==
X-CSE-MsgGUID: /7Sg5fy8QfS51mBLlSdbzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="263532406"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:44:36 -0700
Date: Tue, 18 Aug 2026 18:44:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, siratul.islam@linux.dev,
	u.kleine-koenig@baylibre.com, linux@roeck-us.net,
	joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <aoR94S2qknBVQrT3@ashevche-desk.local>
References: <20260818142928.8244-1-stefan.popa@analog.com>
 <20260818142928.8244-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818142928.8244-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 05:29:28PM +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
> 
> The driver operates in single-measurement mode: each raw read triggers
> an on-demand conversion via SMBus Quick Command and returns a matched
> current/voltage pair. This avoids the latency and complexity of the
> continuous FIFO mode while ensuring each read reflects the current
> state. The two selectable current-sense ranges are exposed through
> scale/scale_available.
> 
> Continuous FIFO buffering, threshold events and the alert interrupt are
> intentionally left out of this initial submission and may be added
> later.

...

>  endmenu
> +

Wrong placement for a new entry.

> +config MAX40080
> +	tristate "Analog Devices MAX40080 Current Sense Amplifier"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Analog Devices MAX40080
> +	  bidirectional current-sense amplifier with a 12-bit ADC and an I2C
> +	  interface.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max40080.

...

> obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_MAX40080) += max40080.o

Why is not ordered?

...

+ array_size.h

I think I repeated this three times already.

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/types.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +static int max40080_read_iv_once(struct max40080_state *st, u32 *iv)
> +{
> +	u8 buf[4];

Can this be __le32?

> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> +					    sizeof(buf), buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	*iv = get_unaligned_le32(buf);

In that case le32_to_cpu() from asm/byteorder.h may be used.

> +	return 0;
> +}

...

> +static void max40080_calc_current_scale(struct max40080_state *st)
> +{
> +	u64 numerator, denominator;
> +	u32 rem;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(max40080_csa_gain); i++) {
> +		numerator = 1ULL * MAX40080_INTER_VREF_mV * NANO * MICRO;
> +		denominator = 1ULL * BIT(MAX40080_ADC_RES_BITS) * max40080_csa_gain[i] *

Btw, this 1ULL * BIT() can be replaced with BIT_ULL().

> +			      st->shunt_resistor_uOhm;
> +		numerator = div64_u64(numerator, denominator);
> +		st->current_scale[i][0] = div_u64_rem(numerator, NANO, &rem);
> +		st->current_scale[i][1] = rem;
> +	}
> +}

...

> +static const struct iio_chan_spec max40080_channels[] = {
> +	{
> +		.type = IIO_CURRENT,
> +		.indexed = 1,

> +		.channel = 0,

No need

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,

> +		.channel = 0,

Same, it's default.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};

...

> +static int max40080_probe(struct i2c_client *client)
> +{
> +	const char *propname = "shunt-resistor-micro-ohms";

It's better to split and use when it's required.

> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max40080_state *st;
> +	int ret;
> +
> +	/*
> +	 * The device powers up with PEC enabled (CFG POR = 0x0060) and rejects
> +	 * unprotected transactions, so PEC support is mandatory, along with word
> +	 * access, the I2C block read used for the current/voltage pair, and the
> +	 * Quick Command used to trigger a conversion.
> +	 */
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK |
> +				     I2C_FUNC_SMBUS_PEC))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;

	propname = "shunt-resistor-micro-ohms";

> +	ret = device_property_read_u32(dev, propname, &st->shunt_resistor_uOhm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't read %s\n", propname);
> +	if (!st->shunt_resistor_uOhm)

> +		return dev_err_probe(dev, -EINVAL, "%s must be non-zero\n",
> +				     propname);

I would dare to put this on a single line.

> +	max40080_calc_current_scale(st);
> +
> +	/* Defaults: 50 mV range, no averaging. */
> +	st->range = MAX40080_CFG_RANGE_50mV;
> +	st->oversampling_ratio = 1;
> +
> +	indio_dev->name = "max40080";
> +	indio_dev->info = &max40080_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max40080_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max40080_channels);
> +
> +	ret = max40080_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


