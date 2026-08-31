Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6063C2787;
	Mon, 31 Aug 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167078; cv=none; b=RMcmLaN2J3FGsKdHJxIrgeDfcvAoHXi0juIQT7puc/G/aj4NCEnzCALOQaQsihPac8pJtetj/ZwtWu0cFvfFBWMBq6Xe1jIuLFq+Lbjzyfq0iuCzLdOv7A3IUvm6Cr74aYk0oZJVMgjSi23uo4GYCX1PbY6GDlFMQD6CNnLcxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167078; c=relaxed/simple;
	bh=hKlBQiVu3b97q8FLZvxnf52CPweHCw+djY1KyyyhO/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctbtcmrf9bivijZ9n4xxQ65IwrmrftorQIkCSS60hjYMq0jZndYRmynB2tp5HG7PRUU/fsW9zQk9JZWRooiHcelkugrmKVuHL0Qc6kCjjEzyYibsHtVEK9Qv6e/0WVi+j9DHp2HCBpHUhtgR2PGTAgSkXzcwAVWIYhmkYy0b02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKoS+Kbp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKoS+Kbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788167076; x=1819703076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKlBQiVu3b97q8FLZvxnf52CPweHCw+djY1KyyyhO/8=;
  b=EKoS+KbpTmjRo/4Ux4+qm9bvtc2klXDfJhpEYB0o3Wqq46ZOQBpuHKTD
   pgSC5j3+GDa41gTe3Ec0xjYRLvswm1JhHGnDCCZGyUSylI0VwD5Zo1I87
   rfMwQKIjHX/shUI+IalmXVkL87fAW1ke8IDuQXCknid/FEPBfF5JCMt5L
   76179rNsGbOCXsmRXSE8S4stNvYXX49rpMTrU8kCeMdIxA/4Vmn1GIzQp
   ANdtmxwJlgvUTJhrUegm89GQCm30ol3sUQeJF6IYK/qlwSLAE9d9EbQzi
   J2eLwq9GL214TQqiif3BHbuwP4rMI4Ia9WP/cctwkQPE5VEKH4tbb1YMC
   g==;
X-CSE-ConnectionGUID: /+4gdmRiTqSkpijIDzMUjA==
X-CSE-MsgGUID: qwEN1gWFQf2vbml8n1tZlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99728886"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99728886"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 02:04:35 -0700
X-CSE-ConnectionGUID: Y6Thpoa9Qd2dWXCpeQFCow==
X-CSE-MsgGUID: LWZAyvHSSOupAwOQAiHsxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="274013695"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 02:04:29 -0700
Date: Mon, 31 Aug 2026 12:04:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 05/20] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <apVDm1O_NtD07-rw@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-5-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-5-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:28PM +0200, Janani Sunil wrote:
> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>

> +#include <linux/iio/types.h>

No need, it's assumed by iio/iio.h.

...

> +#define AD7768_REG_OFFSET(ch) \
> +	(AD7768_REG_OFFSET_BASE + (3 * (ch)))
> +#define AD7768_REG_GAIN(ch) \
> +	(AD7768_REG_GAIN_BASE + (3 * (ch)))
> +#define AD7768_REG_PHASE(ch) \
> +	((AD7768_REG_PHASE_BASE + (ch)))
> +#define __AD7768_4_REG_MAP(ch) \
> +	((ch) < 2 ? (ch) : ((ch) + 2))

I do not see why these can't be put on a single line(s).

> +struct ad7768_state {
> +	struct regmap *regmap;

> +	/* Protects device register access and configuration. */
> +	struct mutex lock;

Not used here. Add it when it will be in use.

> +	struct clk *mclk;
> +	unsigned int datalines;
> +	enum ad7768_clock_source clock_source;
> +	const struct ad7768_chip_info *chip_info;
> +	struct iio_backend *back;
> +	unsigned int vref_uV[2];
> +
> +	__be16 d16 __aligned(IIO_DMA_MINALIGN);
> +};

...

> +static const struct regmap_config ad7768_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,

> +	.use_single_read = true,
> +	.use_single_write = true,

I would add a comment explaining why we need these settings.

> +	.readable_reg = ad7768_readable_reg,
> +};
> +
> +static const struct regmap_config ad7768_4_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,
> +	.use_single_read = true,
> +	.use_single_write = true,

Ditto.

> +	.readable_reg = ad7768_4_readable_reg,
> +};

...

> +static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned long channel_mask;
> +	unsigned long standby_mask;
> +	int ret;
> +
> +	channel_mask = ad7768_all_standby_mask(st);
> +	standby_mask = channel_mask & ~*scan_mask;
> +
> +	/*
> +	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
> +	 * AD7768-4 to remain active.
> +	 */
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)

> +		standby_mask &= ~BIT(st->chip_info->num_channels / 2);

		__clear_bit()

> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +				 channel_mask, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int ad7768_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int vref_idx;
> +
> +	if (info != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	vref_idx = chan->channel >= st->chip_info->num_channels / 2;
> +	*val = 2 * st->vref_uV[vref_idx] / 1000;

(MICRO / MILLI)

> +	*val2 = chan->scan_type.realbits;
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}

Also this code seems to be shuffled in the following patches. Can you make
a helper that won't be modified during the same series?

Same Q for all similar pieces in the series.

...

> +static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
> +					      struct ad7768_precharge_config *precharge_cfg)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	u8 prebuf1_val, prebuf2_val;
> +	u16 prebuf_mask = 0;
> +	u8 refbufp_val = 0;
> +	u8 refbufn_val = 0;
> +	int ret;
> +
> +	for (u8 ch = 0; ch < indio_dev->num_channels; ch++) {

u8 works, but sounds a bit non-standard. Can be unsigned int?
(Usually we use uXX in the cases when it goes to HW or on the
 wire in general, otherwise C POD types are fine.)

> +		u8 channel = indio_dev->channels[ch].channel;
> +
> +		if (precharge_cfg[channel].prebufp_en)
> +			prebuf_mask |= AD7768_PREBUF_POS_EN(channel);
> +
> +		if (precharge_cfg[channel].prebufn_en)
> +			prebuf_mask |= AD7768_PREBUF_NEG_EN(channel);
> +
> +		if (precharge_cfg[channel].refbufp)
> +			refbufp_val |= ad7768_channel_mask(st, channel);
> +
> +		if (precharge_cfg[channel].refbufn)
> +			refbufn_val |= ad7768_channel_mask(st, channel);
> +	}
> +
> +	prebuf1_val = ad7768_precharge_buf1_mask(st, ~prebuf_mask);
> +	prebuf2_val = ad7768_precharge_buf2_mask(st, ~prebuf_mask);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF1, prebuf1_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF2, prebuf2_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_REFP_BUF, refbufp_val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
> +}

...

> +static int ad7768_configure_capture(struct ad7768_state *st)
> +{
> +	unsigned int dclk_div_reg;
> +	unsigned int mode_config;
> +	unsigned int dclk_div;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				 AD7768_POWER_MODE_POWER_MODE_MSK |
> +				 AD7768_POWER_MODE_MCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST) |
> +				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Start with the wideband filter and a decimation rate of 64. This
> +	 * supports every valid data-line configuration at the maximum MCLK.
> +	 */
> +	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
> +				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
> +	mode_config |= FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
> +				  AD7768_CH_MODE_DEC_RATE_64);

Can it be one assignment?

	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND) |
		      FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
				 AD7768_CH_MODE_DEC_RATE_64);

> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
> +				 AD7768_CH_MODE_FILTER_TYPE_MSK |
> +				 AD7768_CH_MODE_DEC_RATE_MSK,
> +				 mode_config);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
> +	if (ret)
> +		return ret;
> +
> +	dclk_div = 8 * st->datalines / st->chip_info->num_channels;

Does 8 represent BITS_PER_BYTE? Can BITS_TO_BYTES() be used?

> +	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +					    dclk_div_reg));
> +	if (ret)
> +		return ret;
> +
> +	return ad7768_sync(st);
> +}

...

> +static int ad7768_parse_config(struct iio_dev *indio_dev,
> +			       struct device *dev)
> +{
> +	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	const unsigned int *available_datalines;
> +	bool datalines_valid = false;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned int standby_mask;
> +	unsigned int len;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	num_channels = 0;
> +	device_for_each_named_child_node_scoped(dev, child, "channel")
> +		num_channels++;

There is counting API: device_get_named_child_node_count().

> +	if (!num_channels || num_channels > st->chip_info->num_channels)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid number of channels\n");

I would go with
	if (num_channels == 0)
		return dev_err_probe(dev, -ENOENT, "No channel specified\n");

	if (num_channels > st->chip_info->num_channels)
		return dev_err_probe(dev, -ENOSPC, "Invalid number of channels\n");

> +	chan = devm_kcalloc(indio_dev->dev.parent, num_channels,
> +			    sizeof(*chan), GFP_KERNEL);

Split logically

	chan = devm_kcalloc(indio_dev->dev.parent, num_channels, sizeof(*chan),
			    GFP_KERNEL);

And why not dev?

	chan = devm_kcalloc(dev, num_channels, sizeof(*chan), GFP_KERNEL);


> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +
> +	standby_mask = ad7768_all_standby_mask(st);
> +
> +	/*
> +	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
> +	 * AD7768-4 to remain active.
> +	 */
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> +		standby_mask &= ~BIT(st->chip_info->num_channels / 2);

__clear_bit()
(and again, this code seems shuffled, please, make it static over the series,
 so we will see the actual changes better).

> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		u32 channel;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to parse reg of %pfwP\n",
> +					     child);
> +
> +		if (channel >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,

-ECHRNG

> +					     "Invalid channel %u in firmware\n",
> +					     channel);
> +
> +		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +					BIT(channel));
> +		if (ret)
> +			return ret;
> +
> +		precharge_cfg[channel].prebufp_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-pos-enable");
> +		precharge_cfg[channel].prebufn_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-neg-enable");
> +		precharge_cfg[channel].refbufp =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-pos-enable");
> +		precharge_cfg[channel].refbufn =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-neg-enable");
> +
> +		chan[chan_idx] = (struct iio_chan_spec) {
> +			.type = IIO_VOLTAGE,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
> +			.indexed = 1,
> +			.channel = channel,
> +			.scan_index = channel,
> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 24,
> +				.storagebits = 32,
> +			},
> +		};
> +		chan_idx++;
> +	}
> +
> +	ret = ad7768_configure_precharge_buffers(indio_dev, precharge_cfg);
> +	if (ret)
> +		return ret;
> +
> +	available_datalines = st->chip_info->available_datalines;
> +	len = st->chip_info->num_datalines;
> +	st->datalines = available_datalines[len - 1];

> +	ret = device_property_read_u32(dev, "adi,data-lines-number",
> +				       &st->datalines);
> +	if (ret && ret != -EINVAL)
> +		return dev_err_probe(dev, ret,
> +				     "Invalid %s property\n",
> +				     "adi,data-lines-number");

We use approach with if (device_property_present(...)) { ... } else { ...default... }.


> +	for (unsigned int i = 0; i < len; i++) {
> +		if (available_datalines[i] == st->datalines) {
> +			datalines_valid = true;
> +			break;
> +		}
> +	}
> +
> +	if (!datalines_valid)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid data-lines-number %d for %s\n",
> +				     st->datalines, st->chip_info->name);
> +
> +	return ad7768_configure_capture(st);
> +}

...

> +static int ad7768_probe(struct spi_device *spi)
> +{
> +	unsigned int spi_readback, rev_id;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7768_state *st;
> +	const char *clock_name;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, st);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return dev_err_probe(dev, -ENODEV,

ENODATA

> +				     "Failed to get match data\n");

		return dev_err_probe(dev, -ENODATA, "Failed to get match data\n");

And it's fine on one line.

> +	ret = devm_regulator_get_enable_optional(dev, "avss");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable AVSS supply\n");

Hmm... What about

	ret = devm_regulator_get_enable_optional(dev, "avss");
	if (ret == -ENODEV)
		/* Do nothing, we may use dummy regulator here */
		// add more explanatory comment
	else if (ret)
		return dev_err_probe(dev, ret,
				     "Failed to enable AVSS supply\n");

?

> +	ret = devm_regulator_get_enable(dev, "avdd1");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable AVDD1 supply\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad7768_supply_names),
> +					     ad7768_supply_names);
> +	if (ret)
> +		return ret;

> +	for (unsigned int i = 0;
> +	     i < ARRAY_SIZE(ad7768_vref_supply_names); i++) {

One line.

> +		ret = ad7768_get_enable_vref(dev, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->vref_uV[i] = ret;
> +	}

> +	ret = device_property_match_property_string(dev, "clock-names",
> +						    ad7768_clock_names,
> +						    ARRAY_SIZE(ad7768_clock_names));
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Invalid clock source\n");
> +
> +	st->clock_source = ret;
> +	clock_name = ad7768_clock_names[st->clock_source];
> +
> +	/*
> +	 * The device must start on its internal clock. Keep the LVDS clock
> +	 * disabled until GPIO4 is driven low and the LVDS input is enabled in
> +	 * the power mode register.
> +	 */
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS)

Make the checks consistent. Here and below they are for different cases.

> +		st->mclk = devm_clk_get(dev, clock_name);
> +	else
> +		st->mclk = devm_clk_get_enabled(dev, clock_name);
> +
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get master clock\n");
> +
> +	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
> +				      st->chip_info->regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad7768_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard the reset response with a dummy SPI register read. */
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &spi_readback);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &rev_id);
> +	if (ret)
> +		return ret;
> +
> +	if (rev_id != AD7768_REV_ID_VAL)
> +		dev_info(dev, "Unexpected revision ID 0x%02x\n", rev_id);
> +
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL) {
> +		ret = ad7768_configure_xtal_clock(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure crystal clock\n");
> +	} else if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS) {
> +		ret = ad7768_enable_lvds_clock(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable LVDS clock\n");
> +	}
> +
> +	ret = ad7768_parse_config(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Hardware supports CRC every 4 or 16 samples; the backend supports only
> +	 * 4-sample CRC.
> +	 */
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				 AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +				 FIELD_PREP(AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +					    AD7768_INTERFACE_CFG_CRC_SELECT_4));
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7768_info;
> +	indio_dev->setup_ops = &ad7768_buffer_ops;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->datalines);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_crc_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


