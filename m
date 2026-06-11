Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E323FD970;
	Thu, 11 Jun 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193644; cv=none; b=NqJti/iPDYgK+7NQA1N3+sfEekWRsVg4OPEwRRijJn6BhU5Uce8A8xJ1kB1xfCX/UQPP/vbWkoGDPENe3O9ZbQJSRtyUt/TRj4Vw4vJmydTBWlEZMtvdDQ23MJRwYuSostJ6QpHAcOWFgcJsl+dEn+0ac/Bf/zKvHFQiiB3zNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193644; c=relaxed/simple;
	bh=AlKBb1H/IzbvpJEcJWTZKScsssxjbYjwjVg+TosPSE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+trK4fDe3RRw1fwCc2FgM+Qp+Yola2XVwnRB8XQpmK5T5+7Wis21Z1W7r9bNJHh8WMQ9P2yp8Cf8kYaP7bRtNlVGsXZe9+HdzEDJ2dCIJBFAQMY574ezxxe7AyKxavWt1tiAi1Lo/EkQPFQA0lOO/+8dXsLXPAnZn2bveBKfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwRtnO/m; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwRtnO/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781193643; x=1812729643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AlKBb1H/IzbvpJEcJWTZKScsssxjbYjwjVg+TosPSE4=;
  b=IwRtnO/mEqCggDU0geBmQACOdm28R4VbyHtNt/xql/KolYIL8yt+TqRJ
   FJ/2P3KbqROKPmQpBcLgRBqfBzjTVp4G7ajMpCLyGg05Eaj8Ivq63jkKH
   BsC4lgG2X6kSXu0KVQGY91EClFNd+DgbhBRDEkk4myTEvZXI45LvN3lgp
   2fHm1qPenNqRNkcmNd/pET2DJJtBszoPoiOHzVLFrqy05V0YVkpTZINjt
   fXxN3cgHkgUpDAkT5u1qJeN1eMcNDMhTXij49nOHpHbBnEaZe60UbQ5JU
   +f0i/aKXiTn/yvUxNZbI7I7Od78AD9JKxdPzW9o9Jg1sFmpFhMrJYTBR3
   A==;
X-CSE-ConnectionGUID: ArkW4Yb/SqWAlGqzeKsQCg==
X-CSE-MsgGUID: N6YP1N4qREacsAo1GoZJyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93499349"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93499349"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:00:42 -0700
X-CSE-ConnectionGUID: 6f+Q3sbLTRK7APFlRH4PNQ==
X-CSE-MsgGUID: tIjP+JLnTsybdmrGIQgYaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246399315"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:00:39 -0700
Date: Thu, 11 Jun 2026 19:00:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nguyen Minh Tien <zizuzacker@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add TI ADS1220 driver
Message-ID: <airbpBUb6qHc7UYU@ashevche-desk.local>
References: <20260610151342.44274-1-zizuzacker@gmail.com>
 <20260610151342.44274-3-zizuzacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610151342.44274-3-zizuzacker@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 10:13:42PM +0700, Nguyen Minh Tien wrote:
> Add an IIO driver for the Texas Instruments ADS1220 24-bit delta-sigma
> SPI ADC. The driver supports single-ended and differential voltage
> channels described as device-tree child nodes, per-channel programmable
> gain (exposed through scale) and data rate (exposed through sampling
> frequency), the internal 2.048V reference, an external reference via a
> regulator, or the analog supply (AVDD) as a ratiometric reference,
> single-shot conversions and a DRDY-interrupt-driven triggered buffer.
> Conversions are gated either on the DRDY interrupt or, when no interrupt
> is wired, on a data-rate-derived delay. Runtime PM powers the device down
> between conversions.

...

+ array_size.h

> +#include <linux/bitfield.h>

> +#include <linux/bits.h>

Instead you should use bitops.h due to sign_extend32() and other calls.

> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>

> +#include <linux/log2.h>

+ math.h // DIV_ROUND_UP()

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>

+ types.h // bool, uXX

> +#include <linux/units.h>
> +#include <linux/unaligned.h>

...

> +/* Worst-case single conversion: 20 SPS => 50 ms, plus margin. */
> +#define ADS1220_CONV_TIMEOUT_MS	100
> +#define ADS1220_CONV_MARGIN_US	2000

2 * USEC_PER_MSEC (will need time.h to be included).

...


> +#define ADS1220_SUSPEND_DELAY_MS 2000

2 * MSEC_PER_SEC respectively.

...

> +static int ads1220_write_reg(struct ads1220_state *st, u8 reg, u8 val)
> +{
> +	st->tx[0] = ADS1220_CMD_WREG_REG(reg);
> +	st->tx[1] = val;
> +
> +	return spi_write(st->spi, st->tx, 2);

sizeof(st->tx) ?

> +}

...

> +static unsigned int ads1220_datarate_to_code(unsigned int datarate)

unsigned? See below why.

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1220_datarates); i++)

	for (unsigned int i = 0; i < ARRAY_SIZE(ads1220_datarates); i++)


> +		if (ads1220_datarates[i] == datarate)
> +			return i;
> +
> +	return 0;

This is wrong. It should return -ENOENT or so to be distinct with the 0 index.

> +}

...

> +static int ads1220_read_sample(struct ads1220_state *st, unsigned int datarate,
> +			       int *val)
> +{
> +	int ret;
> +
> +	if (st->spi->irq) {
> +		unsigned long timeout = msecs_to_jiffies(ADS1220_CONV_TIMEOUT_MS);
> +
> +		if (!wait_for_completion_timeout(&st->completion, timeout))
> +			return -ETIMEDOUT;
> +	} else {
> +		/*
> +		 * No DRDY interrupt: wait for the conversion to finish. In
> +		 * single-shot mode the result stays latched until the next
> +		 * START, so waiting longer than one conversion is harmless;
> +		 * wait two periods plus a margin to comfortably cover the
> +		 * oscillator start-up and its tolerance.
> +		 */
> +		fsleep(2 * DIV_ROUND_UP(MICRO, datarate) + ADS1220_CONV_MARGIN_US);

USEC_PER_SEC instead of MICRO?

> +	}
> +
> +	/*
> +	 * Once DRDY is low the result can be clocked out directly, MSB first,
> +	 * without an RDATA command (datasheet section 8.5.4).
> +	 */
> +	ret = spi_read(st->spi, st->rx, ADS1220_DATA_BYTES);
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(get_unaligned_be24(st->rx), ADS1220_DATA_BITS - 1);
> +
> +	return 0;
> +}

...

> +static int ads1220_single_conversion(struct ads1220_state *st,
> +				     const struct iio_chan_spec *chan,
> +				     int *val, bool calib_offset)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct ads1220_channel_config *cfg = &st->channels_cfg[chan->address];
> +	unsigned int mux = cfg->mux;
> +	bool single_ended = cfg->single_ended;
> +	int ret;
> +
> +	if (calib_offset) {
> +		mux = ADS1220_MUX_SHORTED;
> +		single_ended = false;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;

Use PM_ACQUIRE_*() macros instead.


> +	ret = ads1220_configure(st, mux, cfg->gain, cfg->datarate,
> +				single_ended, false);
> +	if (ret)
> +		goto out;
> +
> +	if (st->spi->irq)
> +		reinit_completion(&st->completion);
> +
> +	ret = ads1220_command(st, ADS1220_CMD_START);
> +	if (ret)
> +		goto out;
> +
> +	ret = ads1220_read_sample(st, cfg->datarate, val);
> +	if (ret)
> +		goto out;
> +
> +	ret = IIO_VAL_INT;
> +out:

> +	pm_runtime_mark_last_busy(dev);

Even without above this is not needed, it's implied by the below call.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}

...

> +static int ads1220_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct ads1220_channel_config *cfg = &st->channels_cfg[chan->address];
> +	unsigned int gain;


> +	int i;

Why signed? And why not to make it local to the loop?

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* The available scales are the gain reciprocals (e.g. 1/4). */
> +		if (val == 0 && val2 == 0)
> +			return -EINVAL;
> +
> +		gain = MICRO / (val * MICRO + val2);
> +		if (!is_power_of_2(gain) || gain > BIT(ADS1220_NUM_GAINS - 1))
> +			return -EINVAL;
> +		if (cfg->single_ended && gain > ADS1220_MAX_SE_GAIN)
> +			return -EINVAL;
> +
> +		cfg->gain = gain;
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:

> +		for (i = 0; i < ARRAY_SIZE(ads1220_datarates); i++) {
> +			if (ads1220_datarates[i] == val) {
> +				cfg->datarate = val;
> +				return 0;
> +			}
> +		}

Can't ads1220_datarate_to_code() be used?

> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ads1220_debugfs_reg_access(struct iio_dev *indio_dev,
> +				      unsigned int reg, unsigned int writeval,
> +				      unsigned int *readval)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	u8 val;
> +	int ret;

> +	if (reg > ADS1220_MAX_REG)
> +		return -EINVAL;

How is this not a dead code? Forgot to set .max_register in regmap configuration?

> +	if (readval) {
> +		ret = ads1220_read_reg(st, reg, &val);
> +		if (ret)
> +			return ret;
> +		*readval = val;
> +		return 0;
> +	}
> +
> +	return ads1220_write_reg(st, reg, writeval);
> +}

...

> +static int ads1220_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct ads1220_channel_config *cfg;
> +	unsigned int index;
> +	int ret;
> +
> +	index = find_first_bit(indio_dev->active_scan_mask,
> +			       iio_get_masklength(indio_dev));
> +	cfg = &st->channels_cfg[index];

> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;

> +	ret = ads1220_configure(st, cfg->mux, cfg->gain, cfg->datarate,
> +				cfg->single_ended, true);
> +	if (ret)
> +		goto err;
> +
> +	ret = ads1220_command(st, ADS1220_CMD_START);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:

> +	pm_runtime_mark_last_busy(dev);

Dup.

> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}

...

> +static int ads1220_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;

> +	pm_runtime_mark_last_busy(dev);

Dup.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}

...

> +	static const u8 diff_mux[ADS1220_MAX_AIN][ADS1220_MAX_AIN] = {
> +		[0][1] = 0x0, [0][2] = 0x1, [0][3] = 0x2,
> +		[1][2] = 0x3, [1][3] = 0x4, [1][0] = 0x6,
> +		[2][3] = 0x5,
> +		[3][2] = 0x7,

Please, fill all the gaps to make this look nice tabulator.
Also you may drop the first _MAX_AIN, compiler will be able to get this.

> +	};

...

> +	const struct iio_chan_spec ads1220_channel = {

Why is this not static?

> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
> +						BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = ADS1220_DATA_BITS,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	};

...

> +	unsigned int num_channels, i = 0;

Split assignment and definition to avoid subtle mistakes in the future.
Move the assignment closer to it's first user
(device_for_each_child_node_scoped() loop AFAICS).

> +	int ret;
> +
> +	st->num_channels_cfg = device_get_child_node_count(dev);
> +	if (st->num_channels_cfg == 0 ||
> +	    st->num_channels_cfg > ADS1220_MAX_CHANNELS)

in_range() ?

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid channel count %u (max %u)\n",
> +				     st->num_channels_cfg, ADS1220_MAX_CHANNELS);

> +	/* One extra channel for the timestamp. */
> +	num_channels = st->num_channels_cfg + 1;

> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels),
> +				GFP_KERNEL);

I would leave it on a single line.

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		struct ads1220_channel_config *cfg = &st->channels_cfg[i];
> +		bool differential;
> +		u32 ain[2];
> +
> +		differential = fwnode_property_present(child, "diff-channels");
> +		if (differential)
> +			ret = fwnode_property_read_u32_array(child,
> +							     "diff-channels",
> +							     ain, 2);

ARRAY_SIZE()

> +		else
> +			ret = fwnode_property_read_u32(child, "single-channel",
> +						       &ain[0]);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read channel property\n");

> +		ret = ads1220_map_mux(dev, ain[0], ain[1], differential,

ain[1] may be uninitialised here. Why not supply the pointer to the array since
you anyway supply 'differential'?

> +				      &cfg->mux, &cfg->single_ended);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid input combination\n");
> +
> +		cfg->gain = 1;
> +		cfg->datarate = ads1220_datarates[0];
> +
> +		chan = &channels[i];
> +		*chan = ads1220_channel;
> +		chan->channel = ain[0];
> +		chan->address = i;
> +		chan->scan_index = i;
> +		if (differential) {
> +			chan->channel2 = ain[1];
> +			chan->differential = 1;
> +		}
> +
> +		i++;
> +	}

...

> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (st->vref_uV >= 0) {

Does Vref == 0 make any sense?

> +		st->vref_source = ADS1220_VREF_REFP0_REFN0;
> +	} else if (st->vref_uV != -ENODEV) {
> +		return dev_err_probe(dev, st->vref_uV, "Failed to get vref\n");
> +	} else if (device_property_read_bool(dev, "ti,vref-avdd")) {
> +		st->vref_source = ADS1220_VREF_AVDD;
> +		st->vref_uV = avdd_uV;
> +	} else {
> +		st->vref_source = ADS1220_VREF_INTERNAL;
> +		st->vref_uV = ADS1220_INTERNAL_VREF_uV;
> +	}

...

> +	if (spi->irq > 0) {
> +		ret = devm_request_irq(dev, spi->irq, ads1220_irq_handler,
> +				       IRQF_NO_THREAD, "ads1220", indio_dev);
> +		if (ret)

> +			return dev_err_probe(dev, ret,
> +					     "Failed to request irq\n");

No dup messages, just

			return ret;

here.

> +		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return -ENOMEM;
> +
> +		st->trig->ops = &ads1220_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to register trigger\n");
> +	}

...

> +static const struct spi_device_id ads1220_id[] = {
> +	{ "ads1220" },

Use C99 initialisers.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


