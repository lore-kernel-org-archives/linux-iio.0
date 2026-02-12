Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85229CE9;
	Thu, 12 Feb 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907373; cv=none; b=XVkMuHzr6fSJqZR99W06SbljsnES2JYYMlNbnYUWWHHt3NvSAw2dSoi2sJFUBrBljMt/qJL2OCwV8a17XpsVS6IvvXWCsxFwOnImSOEU7JI0X7QunCdjv8thDvYNjiVnU7dTF7T9Qre3WC47sBDudZh7kejctiGHALN1hcuPqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907373; c=relaxed/simple;
	bh=Pr/tib4fASi/UYLbu6R6hoz2q1KHQakaSCHzu93cmsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf6o8XScigFuQohRa2yAKDvrmCh1sewkigtE/9RFc8pJzKxScK6CA0ykdtJtFmCye57c0EsSwyUrRjNbsG+2kNB3wKjHKroAvX/Vo9pbheMImEtpHkJNEBM0g+eZam21SJNCI9hcq9t34TB4qgrdTxwMwcpP/k6aewH4GvhU5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcY5sQdm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcY5sQdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770907371; x=1802443371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pr/tib4fASi/UYLbu6R6hoz2q1KHQakaSCHzu93cmsI=;
  b=ZcY5sQdmneZyPbnIsRp0wLKkZzaolLchfM9JgL1yB3CfEQ+F/clk2WyF
   tit5+INtquF/vRjBqC3m5GyK4iwQ74jjk49AkVzTvzmTmNW8RfxiKmE2V
   eXQMClie3Ov76OXB9GCaNrpXoWoh7P38fJcEolmaa+8q1LwI3yKkApBfs
   wKQ2u0hSo+1QNaIZ08GjM7eOwp/nw5tTX+8XcvdJzS8gn2MMBWrO5COiP
   pkQ2kvuvPbUk5S1ePdz4ipWhhVldRi3OKr3Js1sgcdyZU2iixnAdHKTjC
   rfMUlTwJg3E5EedTXNwuquv8C08aQ3fOVVN7IwVDG/nuj/SdWN7bqrtj1
   w==;
X-CSE-ConnectionGUID: ZEBJPWAXRluF+nNa2ezmMw==
X-CSE-MsgGUID: k6sk310rR1u250U1EkyVjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89663378"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="89663378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:42:50 -0800
X-CSE-ConnectionGUID: dNWECkuaRQupgcywimIsJg==
X-CSE-MsgGUID: fKzVznzxRVS2ZA5cob3lug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211428783"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:42:47 -0800
Date: Thu, 12 Feb 2026 16:42:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <aY3m5V05FOH5sut6@smile.fi.intel.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 02:48:35PM +0200, Ariana Lazar wrote:
> This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of buffered
> voltage output Digital-to-Analog Converters with nonvolatile or volatile
> memory and an SPI Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I would split this group...

> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +#include <linux/time64.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +

...to be here as other IIO drivers do.

...

> +/* Gain Control and I2C Slave Address Reguster fields */
> +#define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))

Just BIT(8 + (ch)) should suffice.

> +#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))

For the sake of consistency this may be also rewritten to

#define DAC_GAIN_VAL(ch, val)				((val) * BIT(8 + (ch)))

...

> +/**
> + * struct mcp48feb02_channel_data - channel configuration
> + * @ref_mode: chosen voltage for reference
> + * @use_2x_gain: output driver gain control
> + * @powerdown: is false if the channel is in normal operation mode
> + * @powerdown_mode: selected power-down mode
> + * @dac_data: dac value

DAC

> + */
> +struct mcp48feb02_channel_data {
> +	u8 ref_mode;
> +	bool use_2x_gain;
> +	bool powerdown;
> +	u8 powerdown_mode;
> +	u16 dac_data;

Wondering if the following arrangement is slightly better:

	u16 dac_data;
	u8 ref_mode;
	u8 powerdown_mode;
	bool powerdown;
	bool use_2x_gain;

> +};

...

> +/**
> + * struct mcp48feb02_data - chip configuration
> + * @chdata: options configured for each channel on the device
> + * @lock: prevents concurrent reads/writes to driver's state members
> + * @chip_features: pointer to features struct
> + * @scale_1: scales set on channels that are based on Vref1
> + * @scale: scales set on channels that are based on Vref/Vref0
> + * @active_channels_mask: enabled channels
> + * @regmap: regmap for directly accessing device register
> + * @labels: table with channels labels
> + * @phys_channels: physical channels on the device
> + * @vref1_buffered: Vref1 buffer is enabled
> + * @vref_buffered: Vref/Vref0 buffer is enabled
> + * @use_vref1: vref1-supply is defined
> + * @use_vref: vref-supply is defined
> + */
> +struct mcp48feb02_data {
> +	struct mcp48feb02_channel_data chdata[MCP48FEB02_MAX_CH];
> +	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
> +	const struct mcp48feb02_features *chip_features;
> +	int scale_1[2 * MCP48FEB02_MAX_SCALES_CH];
> +	int scale[2 * MCP48FEB02_MAX_SCALES_CH];

I would name it scale1 and scale0. This will increase readability to see that
the sizes are equal and that the first digit is the part of the name.

> +	unsigned long active_channels_mask;
> +	struct regmap *regmap;
> +	const char *labels[MCP48FEB02_MAX_CH];
> +	u16 phys_channels;
> +	bool vref1_buffered;
> +	bool vref_buffered;
> +	bool use_vref1;
> +	bool use_vref;
> +};

...

> +static int mcp48feb02_write_to_eeprom(struct mcp48feb02_data *data, unsigned int reg,
> +				      unsigned int val)
> +{
> +	int eewa_val, ret;

Is it okay that the eewa_val is signed?

> +	ret = regmap_read_poll_timeout(data->regmap, MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR,
> +				       eewa_val,
> +				       !(eewa_val & MCP48FEB02_GAIN_BIT_STATUS_EEWA_MASK),
> +				       USEC_PER_MSEC, USEC_PER_MSEC * 5);

I would rather put it as

				       1 * USEC_PER_MSEC, 5 * USEC_PER_MSEC);

This follows the natural (from physics) reading — 1ms, 5ms.

> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->regmap, reg, val);
> +}

...

> +static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct mcp48feb02_data *data = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int i, val, val1, eewa_val;
> +	bool state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret)
> +		return ret;
> +
> +	if (!state)
> +		return 0;
> +
> +	/*
> +	 * Wait until the currently occurring EEPROM Write Cycle is completed.
> +	 * Only serial commands to the volatile memory are allowed.
> +	 */
> +	guard(mutex)(&data->lock);
> +
> +	/*
> +	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,
> +	 * writing to EEPROM is available.
> +	 */
> +	ret = regmap_read(data->regmap, MCP48FEB02_WIPERLOCK_STATUS_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val) {
> +		dev_err(dev, "DAC Wiper and DAC Configuration not are unlocked.\n");

"are not"

> +		return -EINVAL;
> +	}
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		ret = mcp48feb02_write_to_eeprom(data, NV_REG_ADDR(i),
> +						 data->chdata[i].dac_data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_VREF_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp48feb02_write_to_eeprom(data, MCP48FEB02_NV_VREF_REG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_POWER_DOWN_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp48feb02_write_to_eeprom(data, MCP48FEB02_NV_POWER_DOWN_REG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR, eewa_val,
> +				       !(eewa_val & MCP48FEB02_GAIN_BIT_STATUS_EEWA_MASK),
> +				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR, &val1);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp48feb02_write_to_eeprom(data, MCP48FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR,
> +					 (val1 & MCP48FEB02_GAIN_BITS_MASK) |
> +					 (val & MCP48FEB02_NV_I2C_SLAVE_ADDR_MASK));
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}

> +

Unneeded blank line.

> +static IIO_DEVICE_ATTR_WO(store_eeprom, 0);

...

> +static void mcp48feb02_init_scale(struct mcp48feb02_data *data, enum mcp48feb02_scale scale,
> +				  int vref_uV, int scale_avail[])
> +{
> +	u32 value_micro, value_int;
> +	u64 tmp;
> +
> +	/* vref_uV should not be negative */
> +	tmp = (u64)vref_uV * MILLI >> data->chip_features->resolution;

If vref_uV is guaranteed to be less than ~33V, this code can be transformed to
avoid 64-bit division. Hints: resolution is always great than 3; MILLI equals
to 2³*5³.

> +	value_int = div_u64_rem(tmp, MICRO, &value_micro);
> +	scale_avail[scale * 2] = value_int;
> +	scale_avail[scale * 2 + 1] = value_micro;
> +}

Since it's kinda a common stuff, perhaps one wants to add a helper
to include/linux/math.h.

...

> +static int mcp48feb02_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
> +				 const int **vals, int *type, int *length, long info)
> +{
> +	struct mcp48feb02_data *data = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (ch->type) {
> +		case IIO_VOLTAGE:
> +			if (data->phys_channels >= 4 && (ch->address % 2))
> +				*vals = data->scale_1;
> +			else
> +				*vals = data->scale;

Actually, if you put the scales as

	int scales[2][2 * MCP48FEB02_MAX_SCALES_CH];

this will become as simple as

			if (data->phys_channels >= 4)
				*vals = data->scales[ch->address];
			else
				*vals = data->scales[0];

OTOH, I am not sure if it can be always as

			*vals = data->scales[ch->address];

which would be the best approach.

> +			*length = 2 * MCP48FEB02_MAX_SCALES_CH;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static void mcp48feb02_get_scale(int ch, struct mcp48feb02_data *data, int *val, int *val2)
> +{
> +	enum mcp48feb02_scale current_scale;
> +
> +	if (data->chdata[ch].ref_mode == MCP48FEB02_VREF_VDD)
> +		current_scale = MCP48FEB02_SCALE_VDD;
> +	else if (data->chdata[ch].use_2x_gain)
> +		current_scale = MCP48FEB02_SCALE_GAIN_X2;
> +	else
> +		current_scale = MCP48FEB02_SCALE_GAIN_X1;
> +
> +	if (data->phys_channels >= 4 && (ch % 2)) {
> +		*val = data->scale_1[current_scale * 2];
> +		*val2 = data->scale_1[current_scale * 2 + 1];
> +	} else {
> +		*val = data->scale[current_scale * 2];
> +		*val2 = data->scale[current_scale * 2 + 1];
> +	}

Ditto. I.o.w. you can avoid (ch % 2) for good.

> +}

...

> +static int mcp48feb02_set_scale(struct mcp48feb02_data *data, int ch, int scale)
> +{
> +	int tmp_val, ret;

Why is 'tmp_val' signed?

> +	ret = mcp48feb02_ch_scale(data, ch, scale);
> +	if (ret)
> +		return ret;
> +
> +	if (scale == MCP48FEB02_SCALE_GAIN_X2)
> +		tmp_val = MCP48FEB02_GAIN_BIT_X2;
> +	else
> +		tmp_val = MCP48FEB02_GAIN_BIT_X1;
> +
> +	ret = regmap_update_bits(data->regmap, MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR,
> +				 DAC_GAIN_MASK(ch), DAC_GAIN_VAL(ch, tmp_val));
> +	if (ret)
> +		return ret;
> +
> +	data->chdata[ch].use_2x_gain = tmp_val;
> +
> +	return 0;
> +}

...

> +static int mcp48feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
> +				int val, int val2, long mask)
> +{
> +	struct mcp48feb02_data *data = iio_priv(indio_dev);
> +	int *tmp_scale, ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
> +		if (ret)
> +			return ret;
> +
> +		data->chdata[ch->address].dac_data = val;
> +		return 0;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (data->phys_channels >= 4 && (ch->address % 2))
> +			tmp_scale = data->scale_1;
> +		else
> +			tmp_scale = data->scale;

Same, (ch->address % 2) can be avoided.

> +		ret = mcp48feb02_check_scale(data, val, val2, tmp_scale);
> +		if (ret < 0)
> +			return ret;
> +
> +		return mcp48feb02_set_scale(data, ch->address, ret);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int mcp48feb02_parse_fw(struct iio_dev *indio_dev,
> +			       const struct mcp48feb02_features *chip_features)
> +{
> +	struct iio_chan_spec chanspec = mcp48febxx_ch_template;
> +	struct mcp48feb02_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	struct iio_chan_spec *channels;
> +	u32 num_channels;

> +	u8 chan_idx = 0;

Assignments like this are harder to maintain and prone to subtle mistakes in
case the variable gets reused. Please, split it...

> +	guard(mutex)(&data->lock);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > chip_features->phys_channels)
> +		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
> +
> +	if (!num_channels)

While this is standard pattern, I find == 0 is more explicit when we compare
counters, but it's up to you and maintainers.

> +		return dev_err_probe(dev, -EINVAL, "No channel specified in the devicetree.\n");
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;

...to be here as

	chan_idx = 0;

> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 reg = 0;

Redundant assignment. "reg" is a mandatory property AFAICS from the below code.

> +		int ret;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Invalid channel number\n");
> +
> +		if (reg >= chip_features->phys_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "The index of the channels does not match the chip\n");

> +		set_bit(reg, &data->active_channels_mask);

Is atomic bit operation required here?

> +		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
> +		if (ret)

> +			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
> +					     fwnode_get_name(child));

Something is really wrong here. Please, fix accordingly.

> +		chanspec.address = reg;
> +		chanspec.channel = reg;
> +		channels[chan_idx] = chanspec;
> +		chan_idx++;
> +	}
> +
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->channels = channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	data->phys_channels = chip_features->phys_channels;
> +
> +	data->vref_buffered = device_property_read_bool(dev, "microchip,vref-buffered");

> +	if (chip_features->have_ext_vref1)
> +		data->vref1_buffered = device_property_read_bool(dev, "microchip,vref1-buffered");

Alternatively can be

	if (device_property_read_bool(dev, "microchip,vref1-buffered"))
		data->vref1_buffered = chip_features->have_ext_vref1;

the difference is that vref1_buffered can be filled with "false", but I don't see
if it can be true before that. You may stick with your variant to avoid this side
effect.

> +	return 0;
> +}

...

> +static int mcp48feb02_init_ctrl_regs(struct mcp48feb02_data *data)
> +{
> +	unsigned int i, vref_ch, gain_ch, pd_ch;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_VREF_REG_ADDR, &vref_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR, &gain_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_POWER_DOWN_REG_ADDR, &pd_ch);
> +	if (ret)
> +		return ret;
> +
> +	gain_ch = gain_ch & MCP48FEB02_GAIN_BITS_MASK;
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		struct device *dev = regmap_get_device(data->regmap);
> +		unsigned int pd_tmp;
> +
> +		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP48FEB02_DAC_CTRL_MASK;
> +		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP48FEB02_GAIN_BIT_MASK;
> +
> +		/*
> +		 * Inform the user that the current voltage reference read from the volatile
> +		 * register of the chip is different from the one specified in the device tree.
> +		 * Considering that the user cannot have an external voltage reference connected
> +		 * to the pin and select the internal Band Gap at the same time, in order to avoid
> +		 * miscofiguring the reference voltage, the volatile register will not be written.
> +		 * In order to overwrite the setting from volatile register with the one from the
> +		 * device tree, the user needs to write the chosen scale.
> +		 */
> +		switch (data->chdata[i].ref_mode) {
> +		case MCP48FEB02_INTERNAL_BAND_GAP:
> +			if (data->phys_channels >= 4 && (i % 2) && data->use_vref1) {
> +				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
> +				dev_dbg(dev, "ch[%u]: reference voltage set to VREF1", i);
> +				break;

> +			}
> +			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
> +			    data->use_vref) {

I don't see how these two conditionals can be run both.

> +				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
> +				dev_dbg(dev, "ch[%u]: reference voltage set to VREF", i);
> +				break;
> +			}

With that in mind, the above can be simplified a bit.

			if (data->use_vref && ((data->phys_channels >= 4 && !(i % 2)) ||
					       (data->phys_channels < 4))) {
				dev_dbg(dev, "ch[%u]: was configured to use internal band gap\n", i);
				dev_dbg(dev, "ch[%u]: reference voltage set to Vref\n", i);
			} else if (data->use_vref1 && data->phys_channels >= 4 && (i % 2)) {
				dev_dbg(dev, "ch[%u]: was configured to use internal band gap\n", i);
				dev_dbg(dev, "ch[%u]: reference voltage set to Vref1\n", i);
			}

The conditionals were reshuffled to make it shorter and easier to compare
(yes, there is a pair of unneeded parentheses for the sake of good looking
 code, a.k.a. readability).

Also note, the messages were missing trailing '\n'; I lowered REF --> ref
in them.

> +			break;
> +		case MCP48FEB02_EXTERNAL_VREF_UNBUFFERED:
> +		case MCP48FEB02_EXTERNAL_VREF_BUFFERED:
> +			if (data->phys_channels >= 4 && (i % 2) && !data->use_vref1) {
> +				dev_dbg(dev, "ch[%u]: was configured to use VREF1", i);
> +				dev_dbg(dev,
> +					"ch[%u]: reference voltage set to internal band gap", i);
> +				break;
> +			}
> +			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
> +			    !data->use_vref) {
> +				dev_dbg(dev, "ch[%u]: was configured to use VREF", i);
> +				dev_dbg(dev,
> +					"ch[%u]: reference voltage set to internal band gap", i);
> +				break;
> +			}
> +			break;

Ditto.

> +		}
> +
> +		pd_tmp = (pd_ch >> (2 * i)) & MCP48FEB02_DAC_CTRL_MASK;
> +		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
> +		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
> +	}
> +
> +	return 0;
> +}

...

> +static int mcp48feb02_probe(struct spi_device *spi)
> +{
> +	const struct mcp48feb02_features *chip_features;
> +	struct device *dev = &spi->dev;
> +	struct mcp48feb02_data *data;
> +	struct iio_dev *indio_dev;

> +	int vref1_uV = 0;
> +	int vref_uV = 0;

Please, split the assignments (the rationale was given somewhere above).

> +	int vdd_uV;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	chip_features = spi_get_device_match_data(spi);
> +	if (!chip_features)
> +		return -EINVAL;
> +
> +	data->chip_features = chip_features;
> +
> +	if (chip_features->have_eeprom) {
> +		data->regmap = devm_regmap_init_spi(spi, &mcp48feb02_regmap_config);
> +		indio_dev->info = &mcp48feb02_info;
> +	} else {
> +		data->regmap = devm_regmap_init_spi(spi, &mcp48fvb02_regmap_config);
> +		indio_dev->info = &mcp48fvb02_info;
> +	}
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing spi regmap\n");

SPI

> +	indio_dev->name = chip_features->name;
> +
> +	ret = mcp48feb02_parse_fw(indio_dev, chip_features);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return ret;
> +
> +	vdd_uV = ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret > 0) {
> +		vref_uV = ret;
> +		data->use_vref = true;
> +	} else {
> +		dev_dbg(dev, "using internal band gap as voltage reference.\n");
> +		dev_dbg(dev, "External Vref is unavailable.\n");
> +	}
> +
> +	if (chip_features->have_ext_vref1) {
> +		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> +		if (ret > 0) {
> +			vref1_uV = ret;
> +			data->use_vref1 = true;
> +		} else {
> +			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> +			dev_dbg(dev, "External Vref1 is unavailable.\n");
> +		}
> +	}
> +
> +	ret = mcp48feb02_init_ctrl_regs(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error initialising vref register\n");
> +
> +	ret = mcp48feb02_init_ch_scales(data, vdd_uV, vref_uV, vref1_uV);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


-- 
With Best Regards,
Andy Shevchenko


